<?php

namespace Home\Controller;

use Common\Controller\HomeBaseController;

class UserController extends HomeBaseController {
	public function index() {
	}
	
	/**
	 * 初始化执行的方法
	 */
	protected function _initialize() {
		parent::_initialize ();
		// B('Home\Behavior\Nobody');
	}
	public function save() {
		$Users = D ( 'Users' );
		$Users->user_id = 5;
		$Users->user_name = 'test1112';
		$Users->password = md5 ( '123456' );
		$Users->reg_time = time ();
		echo $Users->where ( array (
				'user_id' => 5 
		) )->save ();
		// save 更新，默认where为主键，设置where后则用where
		// add 新增
	}
	public function test($id) {
		// $model = C('URL_MODEL');
		// $this->show('hello,world!');
		// C('TEST_PARAM',1);
		// tag('test_behavior');
		// print_r($id);
		// echo I('param.id');
		$Users = M ( 'Users' );
		// print_r($Users->where(array('user_id' => $id))->select());//条件查找
		// print_r($Users->find($id));//主键查找
		// print_r($Users->scope('xxxoo')->select());//使用scope必须用D方法，M不会调用自定义的模型类
		// ->fetchSql(true) 返回sql
		// print_r($Users->getDbFields());//查询字段
		print_r ( $Users->getByUser_name ( 'wanxiang' ) );
	}
}