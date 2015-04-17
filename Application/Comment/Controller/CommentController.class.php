<?php

namespace Comment\Controller;

use User\Controller\UserbaseController;

class CommentController extends UserbaseController {
	protected $comments_model;
	function _initialize() {
		parent::_initialize ();
		$this->comments_model = D ( "Common/Comments" );
	}
	function index() {
		$uid = session ( 'user.id' );
		$where = array ("uid" => $uid );
		
		$count = $this->comments_model->where ( $where )->count ();
		
		$Page = new \Think\Page ( $count, 20 );
		$comments = $pv_Model->where ( $where )->order ( "createtime desc" )->limit ( $page->firstRow . ',' . $page->listRows )->select ();
		$this->assign ( "comments", $comments );
		$show = $Page->show (); // 分页显示输出
		$this->assign ( 'pager', $show ); // 赋值分页输出
		
		$this->display ( ":index" );
	}
	function post() {
		/*
		 * if($_SESSION['_verify_']['verify']!=I("post.verify")){
		 * $this->error("验证码错误！");
		 * }
		 */
		if (IS_POST) {
			
			$post_table = authcode ( I ( 'post.post_table' ) );
			
			$_POST ['post_table'] = $post_table;
			
			$url = parse_url ( urldecode ( $_POST ['url'] ) );
			$query = empty ( $url ['query'] ) ? "" : "?{$url['query']}";
			$url = "{$url['scheme']}://{$url['host']}{$url['path']}$query";
			
			$_POST ['url'] = get_relative_url ( $url );
			
			if (! empty ( session ( 'user' ) )) { // 用户已登陆,且是本站会员
				$uid = session ( 'user.id' );
				$_POST ['uid'] = $uid;
				$users_model = M ( 'Users' );
				$user = $users_model->field ( "user_login,user_email,user_nicename" )->where ( "id=$uid" )->find ();
				$username = $user ['user_login'];
				$user_nicename = $user ['user_nicename'];
				$email = $user ['user_email'];
				$_POST ['full_name'] = empty ( $user_nicename ) ? $username : $user_nicename;
				$_POST ['email'] = $email;
			}
			
			if (C ( "COMMENT_NEED_CHECK" )) {
				$_POST ['status'] = 0; // 评论审核功能开启
			} else {
				$_POST ['status'] = 1;
			}
			//$_POST ['createtime'] = date ( 'Y-m-d H:i:s' );
			if ($this->comments_model->create ()) {
				$this->check_last_action ( intval ( C ( "COMMENT_TIME_INTERVAL" ) ) );
				$result = $this->comments_model->add ();
				if ($result !== false) {
					
					// 评论计数
					$post_table = ucwords ( str_replace ( "_", " ", $post_table ) );
					$post_table = str_replace ( " ", "", $post_table );
					$post_table_model = M ( $post_table );
					$pk = $post_table_model->getPk ();
					
					$post_table_model->create ( array ("comment_count" => array ("exp","comment_count+1" ) ) );
					$post_table_model->where ( array ($pk => intval ( $_POST ['post_id'] ) ) )->save ();
					
					$post_table_model->create ( array ("last_comment" => time () ) );
					$post_table_model->where ( array ($pk => intval ( $_POST ['post_id'] ) ) )->save ();
					
					$this->ajaxReturn( array ("id" => $result ,'info' => "评论成功！" , 'status' => 1));exit;
				} else {
					$this->error ( "评论失败！" );
				}
			} else {
				$this->error ( $this->comments_model->getError () );
			}
		}
	}
}