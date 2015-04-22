<?php

/*
 * 系统权限配置，用户角色管理
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class RbacController extends AdminbaseController {
	protected $Auth_group;
	function _initialize() {
		parent::_initialize ();
		$this->Auth_group = D ( "AuthGroup" );
	}
	
	/**
	 * 角色管理，有add添加，edit编辑，delete删除
	 */
	public function index() {
		$data = $this->Auth_group->order ( array ("id" => "desc" ) )->select ();
		$this->assign ( "authgroups", $data );
		$this->display ();
	}
	
	/**
	 * 添加角色
	 */
	public function roleadd() {
		$this->display ();
	}
	
	/**
	 * 添加角色
	 */
	public function roleadd_post() {
		if (IS_POST) {
			if ($this->Auth_group->create ()) {
				if ($this->Auth_group->add () !== false) {
					$this->success ( "添加角色成功", U ( "Admin/Rbac/index" ) );
				} else {
					$this->error ( "添加失败！" );
				}
			} else {
				$this->error ( $this->Auth_group->getError () );
			}
		}
	}
	
	/**
	 * 删除角色
	 */
	public function roledelete() {
		$agu = D ( "AuthGroupUser" );
		$id = intval ( I ( "get.id" ) );
		if ($id == 1) {
			$this->error ( "超级管理员角色不能被删除！" );
		}
		$count = $agu->where ( "group_id=$id" )->count ();
		if ($count) {
			$this->error ( "该角色已经有用户，不能删除，请先解除用户绑定！" );
		} else {
			$status = $this->Auth_group->delete ( $id );
			if ($status !== false) {
				$this->success ( "删除成功！", U ( 'Rbac/index' ) );
			} else {
				$this->error ( "删除失败！" );
			}
		}
	}
	
	/**
	 * 编辑角色
	 */
	public function roleedit() {
		$id = intval ( I ( "get.id" ) );
		if ($id == 0) {
			$id = intval ( I ( "post.id" ) );
		}
		if ($id == 1) {
			$this->error ( "超级管理员角色不能被修改！" );
		}
		$data = $this->Auth_group->where ( array ("id" => $id ) )->find ();
		if (! $data) {
			$this->error ( "该角色不存在！" );
		}
		$this->assign ( "data", $data );
		$this->display ();
	}
	
	/**
	 * 编辑角色
	 */
	public function roleedit_post() {
		$id = intval ( I ( "get.id" ) );
		if ($id == 0) {
			$id = intval ( I ( "post.id" ) );
		}
		if ($id == 1) {
			$this->error ( "超级管理员角色不能被修改！" );
		}
		if (IS_POST) {
			$data = $this->Auth_group->create ();
			if ($data) {
				if ($this->Auth_group->save ( $data ) !== false) {
					$this->success ( "修改成功！", U ( 'Rbac/index' ) );
				} else {
					$this->error ( "修改失败！" );
				}
			} else {
				$this->error ( $this->Auth_group->getError () );
			}
		}
	}
	
	/**
	 * 角色授权
	 */
	public function authorize() {
		$model = D ( "AuthRule" );
		// 角色ID
		$group_id = intval ( I ( "get.id" ) );
		if (! $group_id) {
			$this->error ( "参数错误！" );
		}
		$group = $this->Auth_group->where ( 'id=' . $group_id )->find ();
		
		$select_urls = array();
		if ($group['rules']) {
			$map ['id'] = array ('IN',$group['rules'] );
			$map ['status'] = array ('EQ',1 );
			$priv_data = $model->where ( $map )->select (); // 获取权限表数据
			foreach ($priv_data as $k => $v){
				$select_urls[] = $v['name'];
			}
		}
		$result = $this->initMenu();
		
		$result_n = array();
		foreach ( $result as $k => $v ) {
			$this_url = strtolower($v['app'].'/'.$v['model'].'/'.$v['action']);
			$select = in_array($this_url, $select_urls) ? true : false;
			$result_n[] = array(
					'id' => $v['id'] , 
					'pId' => $v['parentid'] , 
					'name' => $v['name'] ,
					'url' => $this_url,
					'checked' => $select,
					'open' => $select
			);
		}
		
		foreach ( $result as $n => $t ) {
			$result [$n] ['checked'] = ($this->_is_checked ( $t, $roleid, $priv_data )) ? ' checked' : '';
		}
		
		$this->assign ( "menulist", json_encode($result_n) );
		$this->assign ( "group_id", $group_id );
		$this->display ();
	}
	
	/**
	 * 角色授权
	 */
	public function authorize_post() {
		if (IS_POST) {
			$group_id = intval ( I ( "post.group_id" ) );
			if (! $group_id) {
				$this->error ( "需要授权的角色不存在！" );
			}
			$ck_ids = I ( "post.ck_ids" );
			if (!empty ( $ck_ids ) ) {
				$menu_model = M ( "Menu" );
				$auth_rule_model = M ( "AuthRule" );
				$menulist = $menu_model->where ( array ("id" => array( 'in' , $ck_ids) ) )->field ( "id,app,model,action" )->select ();
				$rules_id = array();
				foreach ( $menulist as $menu ) {
					if ($menu) {
						$app = $menu ['app'];
						$model = $menu ['model'];
						$action = $menu ['action'];
						$name = strtolower ( "$app/$model/$action" );
						$auth_rule = $auth_rule_model->where(array('name' => $name ))->find();
						$rules_id[$auth_rule['id']] = $auth_rule['id'];
					}
				}
				if($rules_id) { 
					$this->Auth_group->where( array ("id" => $group_id ))->save(array('rules' => implode(',', $rules_id)));
				}
				$this->success ( "授权成功！", U ( "Rbac/index" ) );
			} else {
				// 当没有数据时，清除当前角色授权
				$this->Auth_group->where( array ("id" => $group_id ))->save(array('rules' => ''));
				$this->error ( "没有接收到数据，执行清除授权成功！" );
			}
		}
	}
	/**
	 * 检查指定菜单是否有权限
	 *
	 * @param array $menu
	 *        	menu表中数组
	 * @param int $roleid
	 *        	需要检查的角色ID
	 */
	private function _is_checked($menu, $roleid, $priv_data) {
		$app = $menu ['app'];
		$model = $menu ['model'];
		$action = $menu ['action'];
		$name = strtolower ( "$app/$model/$action" );
		if ($priv_data) {
			if (in_array ( $name, $priv_data )) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	/**
	 * 获取菜单深度
	 *
	 * @param
	 *        	$id
	 * @param
	 *        	$array
	 * @param
	 *        	$i
	 */
	protected function _get_level($id, $array = array(), $i = 0) {
		if ($array [$id] ['parentid'] == 0 || empty ( $array [$array [$id] ['parentid']] ) || $array [$id] ['parentid'] == $id) {
			return $i;
		} else {
			$i ++;
			return $this->_get_level ( $array [$id] ['parentid'], $array, $i );
		}
	}
	public function member() {
		// TODO 添加角色成员管理
	}
}

