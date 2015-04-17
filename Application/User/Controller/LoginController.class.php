<?php

namespace User\Controller;

use Common\Controller\HomeBaseController;

class LoginController extends HomeBaseController {
	public function index() {
		empty ( session ( 'login_http_referer' ) ) && session ( 'login_http_referer', I ( 'server.HTTP_REFERER' ) );
		$this->display ( 'login' );
	}
	/**
	 * 登录
	 */
	public function dologin() {
		$verify = new \Think\Verify ();
		$result = $verify->check ( I ( 'post.verify' ), 'login' );
		if ($result) {
			$users_model = M ( "Users" );
			$rules = array (
					// array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
					array('terms', 'require', '您未同意服务条款！', 1 ),
					array('username', 'require', '用户名或者邮箱不能为空！', 1 ),
					array('password','require','密码不能为空！',1),
			);
			if ($users_model->validate ( $rules )->create () === false) {
				$this->error ( $users_model->getError () );
			}
			if (strpos ( I ( 'post.username' ), "@" ) > 0) { // 邮箱登陆
				$where ['user_email'] = I ( 'post.username' );
			} else {
				$where ['user_login'] = I ( 'post.username' );
			}
			$users_model = D ( 'Users' );
			$result = $users_model->where ( $where )->find ();
			if ($result) {
				if ($result ['user_pass'] == $users_model->password ( I ( 'post.password' ) )) {
					//if($result['user_status'] == 2){
					//	$this->error ( "账户尚未激活！" ,U('User/Login/active'));
					//}
					session ( 'user', $result );
					$data = array (
							'last_login_time' => date ( "Y-m-d H:i:s" ),
							'last_login_ip' => get_client_ip () 
					);
					$users_model->where ( "id=" . $result ["id"] )->save ( $data );
					$redirect = empty ( session ( 'login_http_referer' ) ) ? __ROOT__ . "/" : session ( 'login_http_referer' );
					session ( 'login_http_referer', null );
					$this->success ( "登录成功", $redirect );
				} else {
					$this->error ( "密码错误！" );
				}
			} else {
				$this->error ( "用户名不存在！" );
			}
		} else {
			$this->error ( '验证码错误' );
		}
	}
	/**
	 * 激活页面
	 */
	public function active(){
		$this->display ( 'active' );
	}
	/**
	 * 退出
	 */
	public function logout() {
		session ( "user", null ); // 只有前台用户退出
		redirect ( __ROOT__ . "/" );
	}

}