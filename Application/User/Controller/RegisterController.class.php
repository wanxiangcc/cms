<?php

namespace User\Controller;

use Common\Controller\HomeBaseController;

class RegisterController extends HomeBaseController {
	public function index() {
		empty ( session ( 'register_http_referer' ) ) && session ( 'register_http_referer', I ( 'server.HTTP_REFERER' ) );
		$this->display ( 'register' );
	}
	
	public function resend_active(){
		$this->check_login();
		$this->_send_to_active(session('user'));
		$this->success('激活邮件发送成功，激活请重新登录！',U("User/Login/logout"));
	}
	
	
	/**
	 * 激活
	 */
	public function active(){
		$hash = I ( "get.hash");
		if (empty ( $hash )) {
			$this->error ( "激活码不存在" );
		}
		
		$users_model = M ( "Users" );
		$find_user = $users_model->where ( array ("user_activation_key" => $hash))->find ();
		
		if ($find_user) {
			$result = $users_model->where ( array (
					"user_activation_key" => $hash
			) )->save ( array (
					"user_activation_key" => "",
					"user_status" => 1
			) );
				
			if ($result) {
				$find_user ['user_status'] = 1;
				session('user' , $find_user);
				$this->success ( "用户激活成功，正在登录中...", __ROOT__ . "/" );
			} else {
				$this->error ( "用户激活失败!", U ( "User/Login/index" ) );
			}
		} else {
			$this->error ( "用户激活失败，激活码无效！", U ( "User/Login/index" ) );
		}
	}
	
	/**
	 * 注册
	 */
	public function doregister() {
		$verify = new \Think\Verify ();
		$result = $verify->check ( I ( 'post.verify' ), 'register' );
		if (! $result) {
			$this->error ( "验证码错误！" );
		}
		
		$users_model = M ( "Users" );
		$rules = array (
				// array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
				array('terms', 'require', '您未同意服务条款！', 1 ),
				array('username', 'require', '账号不能为空！', 1 ),
				array('email', 'require', '邮箱不能为空！', 1 ),
				array('password','require','密码不能为空！',1),
				array('repassword', 'require', '重复密码不能为空！', 1 ),
				array('repassword','password','确认密码不正确',0,'confirm'),
				array('email','email','邮箱格式不正确！',1), // 验证email字段格式是否正确
		);
		if ($users_model->validate ( $rules )->create () === false) {
			$this->error ( $users_model->getError () );
		}
		extract ( $_POST );
		// 用户名需过滤的字符的正则
		$stripChar = '?<*.>\'"';
		if (preg_match ( '/[' . $stripChar . ']/is', $username ) == 1) {
			$this->error ( '用户名中包含' . $stripChar . '等非法字符！' );
		}
		
		$banned_usernames = explode ( ",", get_cms_settings ( "banned_usernames" ) );
		
		if (in_array ( $username, $banned_usernames )) {
			$this->error ( "此用户名禁止使用！" );
		}
		
		if (strlen ( $password ) < 5 || strlen ( $password ) > 20) {
			$this->error ( "密码长度至少5位，最多20位！" );
		}
		
		$where ['user_login'] = $username;
		$where ['user_email'] = $email;
		$where ['_logic'] = 'OR';
		
		$users_model = D ( "Users" );
		$result = $users_model->where ( $where )->count ();
		if ($result) {
			$this->error ( "用户名或者该邮箱已经存在！" );
		} else {
			$need_email_active = C ( "MEMBER_EMAIL_ACTIVE" );
			$data = array (
					'user_login' => $username,
					'user_email' => $email,
					'user_nicename' => $username,
					'user_pass' => $users_model->password ( $password ),
					'last_login_ip' => get_client_ip (),
					'create_time' => date ( "Y-m-d H:i:s" ),
					'last_login_time' => date ( "Y-m-d H:i:s" ),
					'user_status' => $need_email_active ? 2 : 1,
					"user_type" => 2 
			);
			$rst = $users_model->add ( $data );
			if ($rst) {
				// 登入成功页面跳转
				$data ['id'] = $rst;
				
				// 发送激活邮件
				if ($need_email_active) {
					$this->_send_to_active ( $data );
					$this->success ( "注册成功，激活后才能使用！", U ( "User/Login/index" ) );
				} else {
					$this->success ( "注册成功！", __ROOT__ . "/" );
				}
			} else {
				$this->error ( "注册失败！", U ( "User/Register/index" ) );
			}
		}
	}
	
	
	
	/**
	 * 发送邮件
	 * @param unknown $user
	 */
	protected function _send_to_active($user = array()) {
		$option = M ( 'Options' )->where ( array (
				'option_name' => 'member_email_active' 
		) )->find ();
		if (! $option) {
			$this->error ( '网站未配置账号激活信息，请联系网站管理员' );
		}
		$options = json_decode ( $option ['option_value'], true );
		// 邮件标题
		$title = $options ['title'];
		$uid = $user ['id'];
		$username = $user ['user_login'];
		
		$activekey = md5 ( $uid . time () . uniqid () );
		$users_model = M ( "Users" );
		
		$result = $users_model->where ( array ("id" => $uid ) )->save ( array ("user_activation_key" => $activekey ) );
		if (! $result) {
			$this->error ( '激活码生成失败！' );
		}
		// 生成激活链接
		$url = U ( 'User/Register/active', array (
				"hash" => $activekey 
		), "", true );
		// 邮件内容
		$template = $options ['template'];
		$content = str_replace ( array (
				'http://#link#',
				'#username#' 
		), array (
				$url,
				$username 
		), $template );
		
		$send_result = send_email ($user ['user_email'], $title, $content );
		
		if ($send_result ['error']) {
			$this->error ( '激活邮件发送失败！' );
		}
	}
}