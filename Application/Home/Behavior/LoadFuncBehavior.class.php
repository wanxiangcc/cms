<?php
namespace Home\Behavior;

use Think\Behavior;

class LoadFuncBehavior extends Behavior {
	   
	// 行为扩展的执行入口必须是run
	public function run(&$params) {
		//class 不用引入 直接调用
		include_once C('COMMON_PATH').'Func.php';
	}
}
?>