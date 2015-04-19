<?php
/**
 * Admin分组登录 不要继承CommonAction
 * 为了简单起见，直接模拟用户id为1和 id 为 3 的用户  真正要使用的话需要访问数据库（think_member 表）验证用户密码
 */
 
class PublicController extends Think\Controller {
    public function login($username = null, $password = null, $verify = null){
        if(IS_POST){  
            
            // admin   的 UID 设为 1
            //另外一个测试用的  test03  的UID值为 3
            //  UID 为2 的用户能登录，但没有访问权限 ，用户名为 test02
            //其他用户系统会提示，用户名或者密码不正确
            if ($username == 'admin'){
                $user = array();  
                $user ['uid'] = 1 ;
                $user ['username'] = 'admin' ;
                
            } else if ($username == 'test02'){
                $user = array();  
                $user ['uid'] = 2 ;
                $user ['username'] = 'test02' ;
                
            } else if ($username == 'test03'){
                $user = array();  
                $user ['uid'] = 3 ;
                $user ['username'] = 'test03' ;
                
            }  
            
            if(is_array($user)  ){ 
                //登录成功            
                //记录登录SESSION 
                $auth = array(
                    'uid'             => $user['uid'],
                    'username'        => $user['username'] 
                ); 
                session('user_auth', $auth);      
                $this->success('登录成功！', U('Index/index')); 
            } else {
                $this->error('用户不存在或被禁用！'); 
            }             
        } else {  
                $this->display();
           
        }
    }
	
    //退出登录 ,清除 session
    public function logout(){ 
        session('user_auth', null);
        session('[destroy]');
        $this->success('退出成功！', U('login')); 
    }
}