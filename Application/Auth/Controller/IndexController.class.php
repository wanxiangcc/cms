<?php
/**
 * 后台主页 需要认证  通过 才可访问
 *
 */
 
class IndexController extends AdminController {
            
    public function index(){ 
    
		$this->display();
	}
	 
}