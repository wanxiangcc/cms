<?php

/**
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class PublicController extends AdminbaseController {
	function _initialize() {
		//parent::_initialize();
	}
	
	// 后台登陆界面
	public function login() {
		if (isset ( $_SESSION ['ADMIN_ID'] )) { // 已经登录
			$this->success ( L ( 'LOGIN_SUCCESS' ), U ( "Admin/Index/index" ) );
		} else {
			$this->display ( ":login" );
		}
	}
	public function logout() {
		session ( 'ADMIN_ID', null );
		session ( 'name', null );
		session ( "roleid", null );
		$this->redirect ( "Admin/Public/login" );
	}
	public function dologin() {
		$name = I ( "post.username" );
		if (empty ( $name )) {
			$this->error ( L ( 'USERNAME_OR_EMAIL_EMPTY' ) );
		}
		$pass = I ( "post.password" );
		if (empty ( $pass )) {
			$this->error ( L ( 'PASSWORD_REQUIRED' ) );
		}
		$verrify = I ( "post.verify" );
		if (empty ( $verrify )) {
			$this->error ( L ( 'CAPTCHA_REQUIRED' ) );
		}
		// 验证码
		$verify = new \Think\Verify ();
		$result = $verify->check ( I ( 'post.verify' ), 'admin_login' );
		if (! $result) {
			$this->error ( L ( 'CAPTCHA_NOT_RIGHT' ) );
		} else {
			$user = D ( "Common/Users" );
			if (strpos ( $name, "@" ) > 0) { // 邮箱登陆
				$where ['user_email'] = $name;
			} else {
				$where ['user_login'] = $name;
			}
			
			$result = $user->where ( $where )->find ();
			if ($result != null && $result ['user_type'] == 1) {
				if ($result ['user_pass'] == $user->password ( $pass )) {
					// 登入成功页面跳转
					session ( 'ADMIN_ID', $result ["id"] );
					session ( 'name', $result ["user_login"] );
					session ( "roleid", $result ['role_id'] );
					$result ['last_login_ip'] = get_client_ip ();
					$result ['last_login_time'] = date ( "Y-m-d H:i:s" );
					$user->save ( $result );
					setcookie ( "admin_username", $name, time () + 30 * 24 * 3600, "/" );
					$this->success ( L ( 'LOGIN_SUCCESS' ), U ( "Admin/Index/index" ) );
					//$this->ajaxReturn(array('info' => L ( 'LOGIN_SUCCESS' ),'url' => U ( "Admin/Index/index" ) ,'status' => 1));
				} else {
					$this->error ( L ( 'PASSWORD_NOT_RIGHT' ) );
				}
			} else {
				$this->error ( L ( 'USERNAME_NOT_EXIST' ) );
			}
		}
	}
}

