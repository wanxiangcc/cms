<?php

namespace User\Controller;

use Common\Controller\HomeBaseController;

class UserbaseController extends HomeBaseController {
	function _initialize() {
		parent::_initialize ();
		
		$this->check_login ();
		$this->check_user ();
	}
}