<?php

/**
 * 后台Controller
 */
namespace Common\Controller;

use Common\Controller\AppframeController;

class AdminbaseController extends AppframeController {
	public function __construct() {
		parent::__construct ();
		$time = time ();
		$this->assign ( "js_debug", APP_DEBUG ? "?v=$time" : "" );
	}
	function _initialize() {
		parent::_initialize ();
		$admin_id = session ( 'ADMIN_ID' );
		if (! empty ( $admin_id )) {
			$users_obj = M ( "Users" );
			$user = $users_obj->where ( "id=$admin_id" )->find ();
			if (! $this->check_access ( $admin_id )) {
				$this->error ( "您没有访问权限！" );
				exit ();
			}
			$this->assign ( "admin", $user );
		} else {
			if (IS_AJAX) {
				$this->error ( "您还没有登录！", U ( "Admin/Public/login" ) );
			} else {
				header ( "Location:" . U ( "Admin/Public/login" ) );
				exit ();
			}
		}
	}
	
	// 扩展方法，当用户没有权限操作，用于记录日志的扩展方法
	public function _ErrorLog() {
	}
	
	/**
	 * 初始化后台菜单
	 */
	public function initMenu() {
		$Menu = F ( "Menu" );
		if (! $Menu) {
			$Menu = D ( "Common/Menu" )->menu_cache ();
		}
		return $Menu;
	}
	
	/**
	 * 排序 排序字段为listorders数组 POST 排序字段为：listorder
	 */
	protected function _listorders($model) {
		if (! is_object ( $model )) {
			return false;
		}
		$pk = $model->getPk (); // 获取主键名称
		$ids = I ( 'post.listorders' );
		foreach ( $ids as $key => $r ) {
			$data ['listorder'] = $r;
			$model->where ( array ($pk => $key ) )->save ( $data );
		}
		return true;
	}
	
	/**
	 * 获取菜单导航
	 *
	 * @param type $app        	
	 * @param type $model        	
	 * @param type $action        	
	 */
	public static function getMenu() {
		$menuid = I ( 'get.menuid', 0, 'int' );
		$menuid = $menuid ? $menuid : cookie ( "menuid", "", array ("prefix" => "" ) );
		// cookie("menuid",$menuid);
		
		$db = D ( "Common/Menu" );
		$info = $db->cache ( true, 60 )->where ( array ("id" => $menuid ) )->getField ( "id,action,app,model,parentid,data,type,name" );
		$find = $db->cache ( true, 60 )->where ( array ("parentid" => $menuid,"status" => 1 ) )->getField ( "id,action,app,model,parentid,data,type,name" );
		
		if ($find) {
			array_unshift ( $find, $info [$menuid] );
		} else {
			$find = $info;
		}
		foreach ( $find as $k => $v ) {
			$find [$k] ['data'] = $find [$k] ['data'] . "&menuid=$menuid";
		}
		
		return $find;
	}
	private function check_access($uid) {
		
		// 如果用户角色是1，则无需判断
		if ($uid == 1) {
			return true;
		}
		if (MODULE_NAME . CONTROLLER_NAME . ACTION_NAME != "AdminIndexindex") {
			return auth_check ( $uid );
		} else {
			return true;
		}
	}
}

