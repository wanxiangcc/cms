<?php

namespace Home\Controller;

use Common\Controller\HomeBaseController;

class PostController extends HomeBaseController {
	public function view($id = 0) {
		if (empty ( $id ))
			$this->error ( '参数错误' );
		$model = D ( 'TermRelationships' );
		$tr = $model->relation ( 'Posts' )->where ( array ('tid' => $id ) )->find ();
		
		if (empty ( $tr ))
			$this->error ( '访问的记录不见啦' );
		
		$post = $tr ['Posts'];
		if (empty ( $post ))
			$this->error ( '访问的文章不见啦' );
		
		$post_id = $tr ['object_id'];
		$termid = $tr ['term_id'];
		$post_date = $post ['post_modified'];
		
		$should_change_post_hits = check_user_action ( "posts$post_id", 1, true );
		if ($should_change_post_hits) {
			$posts_model = M ( "Posts" );
			$posts_model->save ( array ("id" => $post_id,"post_hits" => array ("exp","post_hits+1" ) ) );
		}
		
		$user_model = M ( 'Users' );
		$user = $user_model->field ( 'user_nicename,user_login' )->where ( array ('id' => $post ['post_author'] ) )->find ();
		$post = array_merge ( $post, $user );
		
		$join = C ( 'DB_PREFIX' ) . 'posts as b on a.object_id =b.id';
		
		$next = $model->alias ( "a" )->join ( $join )->where ( array ("post_modified" => array ("egt",$post_date ),"tid" => array ('neq',$id ),"status" => 1,'term_id' => $termid ) )->order ( "post_modified asc" )->find ();
		$prev = $model->alias ( "a" )->join ( $join )->where ( array ("post_modified" => array ("elt",$post_date ),"tid" => array ('neq',$id ),"status" => 1,'term_id' => $termid ) )->order ( "post_modified desc" )->find ();
		
		$smeta = json_decode ( $post ['smeta'], true );
		
		// $this->assign ( "page", $content_data ['page'] );
		$this->assign ( $post );
		$this->assign ( "smeta", $smeta );
		// $this->assign ( "term", $term );
		$this->assign ( "post_id", $post_id );
		
		// R("Comment/Widget/index",array('posts',$article_id));
		
		$hot_posts = $this->get_posts ( $termid );
		$last_posts = $this->get_posts ( $termid, array ('order' => 'listorder asc' ) );
		$last_comments = $this->get_last_comments ();
		$last_users = $this->get_last_users ();
		
		$this->assign ( 'hot_posts', $hot_posts );
		$this->assign ( 'last_posts', $last_posts );
		$this->assign ( 'last_comments', $last_comments );
		$this->assign ( 'last_users', $last_users );
		
		$this->assign ( 'favorite_key', authencode ( C ( 'AUTHCODE' ) . " posts " . $post_id ) );
		
		$this->display ( "posts" );
	}
	
	/**
	 * 点赞
	 */
	public function do_like() {
		$this->check_login ();
		
		$id = intval ( I ( 'get.id' ) ); // posts表中id
		
		$posts_model = M ( "Posts" );
		
		$can_like = check_user_action ( "posts$id", 1 );
		
		if ($can_like) {
			$posts_model->save ( array ("id" => $id,"post_like" => array ("exp","post_like+1" ) ) );
			$this->success ( "赞好啦！" );
		} else {
			$this->error ( "您已赞过啦！" );
		}
	}
	/**
	 * 文章列表
	 *
	 * @param number $id        	
	 */
	public function index($id = 0) {
		if (empty ( $id ))
			$this->error ( '参数错误' );
		$terms_model = D ( 'Terms' );
		$terms = $terms_model->where ( array ('term_id' => $id,'status' => 1 ) )->find ();
		if ($terms == null)
			$this->error ( '分类不存在' );
		$tpl = empty ( $terms ['list_tpl'] ) ? 'list' : $terms ['list_tpl'];
		$list = $this->list_post ( $id );
		
		if ($tpl == 'list') {
			$hot_posts = $this->get_posts ( $id );
			$last_posts = $this->get_posts ( $id, array ('order' => 'listorder asc' ) );
			$last_comments = $this->get_last_comments ();
			$last_users = $this->get_last_users ();
			
			$this->assign ( 'hot_posts', $hot_posts );
			$this->assign ( 'last_posts', $last_posts );
			$this->assign ( 'last_comments', $last_comments );
			$this->assign ( 'last_users', $last_users );
		}
		if (IS_AJAX) {
			$this->assign ( 'list', $list );
			$this->ajaxReturn ( array ('page' => $this->page,'html' => $this->fetch ( $tpl . '_data' ),'status' => 'ok' ) );
		} else {
			$this->assign ( 'terms', $terms );
			$this->assign ( 'list', $list );
			$this->display ( $tpl );
		}
	}
	
	/**
	 * 获取分类文章列表
	 *
	 * @param unknown $id        	
	 * @return unknown
	 */
	protected function list_post($id, $page_size = 10) {
		$pv_Model = D ( "PostView" );
		$where = array ('tr.term_id' => $id,'p.post_status' => 1 );
		$count = $pv_Model->where ( $where )->count ();
		$Page = new \Think\Page ( $count, $page_size ); // 实例化分页类 传入总记录数和每页显示的记录数(10)
		$result = $pv_Model->where ( $where )->order ( 'p.id DESC' )->limit ( $Page->firstRow . ',' . $Page->listRows )->select ();
		// $result = $pv_Model->where ( $where )->order ( 'p.id DESC' )->page ( I('get.p') . ',' . $Page->listRows )->select ();
		// $result = $pv_Model->where ( $where )->order ( 'p.id DESC' )->limit( $Page->listRows )->page ( I('get.p') )->select ();
		foreach ( $result as $k => $v ) {
			$result [$k] ['favorite_key'] = authencode ( C ( 'AUTHCODE' ) . " posts " . $v ['post_id'] );
		}
		$show = $Page->show (); // 分页显示输出
		$this->assign ( 'page', $show ); // 赋值分页输出
		return $result;
	}
	/**
	 * 获取用户
	 *
	 * @return unknown
	 */
	protected function get_last_users() {
		$where = array ();
		$field = '*';
		$limit = '5';
		$order = 'create_time desc';
		
		// 根据参数生成查询条件
		$mwhere ['user_status'] = array ('eq',1 );
		$mwhere ['user_type'] = array ('eq',2 ); // default user
		
		if (is_array ( $where )) {
			$where = array_merge ( $mwhere, $where );
		} else {
			$where = $mwhere;
		}
		
		$users_model = M ( "Users" );
		
		$users = $users_model->field ( $field )->where ( $where )->order ( $order )->limit ( $limit )->select ();
		return $users;
	}
	
	/**
	 * 获取最新评论
	 *
	 * @return unknown
	 */
	protected function get_last_comments() {
		$comments_model = M ( "Comments" );
		$comments = $comments_model->field ( '*' )->where ( 'status=1' )->order ( 'createtime desc' )->limit ( 5 )->select ();
		return $comments;
	}
	/**
	 * 获取热门文章
	 *
	 * @return unknown
	 */
	protected function get_posts($id = '', $arr = array()) {
		$field = ! empty ( $arr ['field'] ) ? $arr ['field'] : 'tid,post_title,post_excerpt,smeta';
		$order = ! empty ( $arr ['order'] ) ? $arr ['order'] : 'post_hits desc';
		$limit = ! empty ( $arr ['limit'] ) ? $arr ['limit'] : 5;
		$where = array ();
		// 根据参数生成查询条件
		$mwhere ['post_status'] = array ('eq',1 );
		
		if (isset ( $arr ['where'] ) && is_array ( $arr ['where'] )) {
			$where = array_merge ( $mwhere, $arr ['where'] );
		} else {
			$where = $mwhere;
		}
		if (! empty ( $id )) {
			$where ['term_id'] = array ('in',$id );
		}
		$model = M ( 'TermRelationships' );
		$join = "" . C ( 'DB_PREFIX' ) . 'posts as b on a.object_id =b.id';
		$join2 = "" . C ( 'DB_PREFIX' ) . 'users as c on b.post_author = c.id';
		$result = $model->alias ( "a" )->join ( $join )->join ( $join2 )->field ( $field )->where ( $where )->order ( $order )->limit ( $limit )->select ();
		return $result;
	}
}