<?php
namespace Home\Controller;
use Think\Controller;
use Common\Controller\HomeBaseController;
class IndexController extends HomeBaseController {
	
    public function index(){
    	$posts =  D('Posts');
    	//$r = $posts->relation('Terms')->find();
    	//print_r($posts->relation(true)->select());
    	//print_R($r);//exit;
    	$newpost_list = $posts->where('post_status=1')->order('post_date DESC')->limit(5)->select();
    	$this->assign('lastnews' , $newpost_list);
    	$this->display("index");
    	//$model = C('URL_MODEL');
        //$this->show('hello,world!');
        //C('TEST_PARAM',1);
        //tag('test_behavior');
        //print_r($id);
        //echo I('param.id');
        //$user = D('Users');
        //print_r($user->where(array('user_id' => $id))->select());//条件查找
        //print_r($user->find($id));//主键查找
        //print_r($user->fetchSql(true)->scope('latest')->select());
        //print_r($user->getDbFields());//查询字段
    }
   
  
    
}