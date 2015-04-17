<?php

namespace Common\Controller;

use Think\Controller;

class HomeBaseController extends Controller {
	public function __construct() {
		parent::__construct ();
	}
	protected function _initialize() {
		//parent::_initialize ();
		tag ( 'load_func' );
		$site_options = get_site_options ();
		$this->assign ( $site_options );
		$user = $this->get_session_user ();
		$this->assign ( 'user', $user );
		$nav_list = get_nav ( 1 );
		$this->assign ( 'nav_list', $nav_list );
	}
	protected function check_login() {
		$value = session ( 'user' );
		if (empty ( $value )) {
			$this->error ( '您还没有登录！', U ( 'User/Login/index' ) );
		}
	}
	protected function check_user() {
		if (session ( 'user.user_status' ) == 2) {
			$this->error ( '您还没有激活账号，请激活后再使用！', U ( "User/Login/active" ) );
		}
		if (session ( 'user.user_status' ) == 0) {
			$this->error ( '此账号已经被禁止使用，请联系管理员！', __ROOT__ . "/" );
		}
	}
	protected function get_session_user() {
		$user = session ( 'user' );
		$user = ! empty ( $user ) ? $user : array ('id' => 0,'user_name' => '' );
		return $user;
	}
	protected function ip_area() {
		$Ip = new \Org\Net\IpLocation ( 'UTFWry.dat' );
		return $area = $Ip->getlocation ();
	}
}