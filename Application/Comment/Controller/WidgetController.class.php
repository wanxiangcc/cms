<?php

namespace Comment\Controller;

use Think\Controller;

class WidgetController extends Controller {
	function index($table, $post_id) {
		$comment_model = D ( "Common/Comments" );
		$comments = $comment_model->where ( array ("post_table" => $table,"post_id" => $post_id,"status" => 1 ) )->order ( "createtime ASC" )->select ();
		
		$new_comments = array ();
		
		$parent_comments = array ();
		
		if (! empty ( $comments )) {
			foreach ( $comments as $m ) {
				if ($m ['parentid'] == 0) {
					$new_comments [$m ['id']] = $m;
				} else {
					$path = explode ( "-", $m ['path'] );
					$new_comments [$path [1]] ['children'] [] = $m;
				}
				
				$parent_comments [$m ['id']] = $m;
			}
		}
		
		$data ['post_table'] = authencode ( $table );
		$data ['post_id'] = $post_id;
		$this->assign ( $data );
		$this->assign ( "comments", $new_comments );
		$this->assign ( "parent_comments", $parent_comments );
		$tpl = "Comment@Widget:comment";
		return $this->fetch ( T ( $tpl ) );
	}
}