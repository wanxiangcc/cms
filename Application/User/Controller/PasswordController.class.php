<?php

namespace User\Controller;

use Common\Controller\HomeBaseController;

class PasswordController extends HomeBaseController {
	public function index() {
	}
	public function reset() {
		$this->assign ( 'hash', I ( 'get.hash' ) );
		$this->display ( 'reset' );
	}
	function doreset() {
		if (IS_POST) {
			$verify = new \Think\Verify ();
			$result = $verify->check ( I ( 'post.verify' ), 'reset_password' );
			if (! $result) {
				$this->error ( "验证码错误!" );
			}
			$users_model = D ( "Users" );
			$rules = array (
					// array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
					array ('password','require','密码不能为空！',1 ),
					array ('repassword','require','重复密码不能为空！',1 ),
					array ('repassword','password','确认密码不正确',0,'confirm' ),
					array ('hash','require','激活码不能空！',1 ) );
			if ($users_model->validate ( $rules )->create () === false) {
				$this->error ( $users_model->getError () );
			} else {
				$password = $users_model->password ( I ( "post.password" ) );
				$hash = I ( "post.hash" );
				$result = $users_model->where ( array ("user_activation_key" => $hash ) )->save ( array ("user_pass" => $password,"user_activation_key" => "" ) );
				if ($result) {
					$this->success ( "密码重置成功，请登录！", U ( "User/Login/index" ) );
				} else {
					$this->error ( "密码重置失败，重置码无效！" );
				}
			}
		}
	}
	/**
	 * 忘记密码
	 */
	public function forgot() {
		$this->display ( 'forgot' );
	}
	/**
	 * 忘记密码验证
	 */
	public function doforgot() {
		if (IS_POST) { // 判断是否POST
			$verify = new \Think\Verify ();
			$result = $verify->check ( I ( 'post.verify' ), 'forgot_password' );
			if (! $result) {
				$this->error ( "验证码错误!" );
			}
			$users_model = M ( "Users" );
			$rules = array (
					// array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
					array ('email','require','邮箱不能为空！',1 ),array ('email','email','邮箱格式不正确！',1 ) ); // 验证email字段格式是否正确
			
			if ($users_model->validate ( $rules )->create () === false) {
				$this->error ( $users_model->getError () );
			} else {
				$email = I ( "post.email" );
				$find_user = $users_model->where ( array ("user_email" => $email ) )->find ();
				if ($find_user) {
					$this->_send_to_resetpass ( $find_user );
					$this->success ( "密码重置邮件发送成功！", __ROOT__ . "/" );
				} else {
					$this->error ( "账号不存在！" );
				}
			}
		}
	}
	
	/**
	 * 发送重置邮件
	 *
	 * @param unknown $user        	
	 */
	protected function _send_to_resetpass($user) {
		$options = get_site_options ();
		// 邮件标题
		$title = $options ['site_name'] . "密码重置";
		$uid = $user ['id'];
		$username = $user ['user_login'];
		
		$activekey = md5 ( $uid . time () . uniqid () );
		$users_model = M ( "Users" );
		
		$result = $users_model->where ( array ("id" => $uid ) )->save ( array ("user_activation_key" => $activekey ) );
		if (! $result) {
			$this->error ( '密码重置激活码生成失败！' );
		}
		// 生成激活链接
		$url = U ( 'User/Password/reset', array ("hash" => $activekey ), "", true );
		// 邮件内容
		$template = <<<hello
		#username#，你好！<br>
		请点击或复制下面链接进行密码重置：<br>
		<a href="http://#link#">http://#link#</a>
hello;
		$content = str_replace ( array ('http://#link#','#username#' ), array ($url,$username ), $template );
		
		$send_result = send_email ( $user ['user_email'], $title, $content );
		
		if ($send_result ['error']) {
			$this->error ( '密码重置邮件发送失败！' );
		}
	}
}