<?php

/**
 * 后台首页
 */
namespace Admin\Controller;

use Common\Controller\AdminbaseController;

class IndexController extends AdminbaseController {
	public function _initialize() {
		parent::_initialize ();
		$this->initMenu ();
	}
	// 后台框架首页
	public function index() {
		$this->assign ( "SUBMENU_CONFIG", D ( "Common/Menu" )->get_tree ( 0 ) );
		$this->display ();
	}
}

