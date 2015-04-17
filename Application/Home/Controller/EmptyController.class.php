<?php
/**
 * 如果请求未定义的Controller 则会转到这里
 */
namespace Home\Controller;
use Think\Controller;
class EmptyController extends Controller{
	public function index(){
		//根据当前控制器名来判断要执行那个城市的操作
		//$cityName = CONTROLLER_NAME;
		//$this->city($cityName);
		$this->redirect('Home/index/index','',5);
	}
}
