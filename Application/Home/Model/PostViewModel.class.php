<?php

namespace Home\Model;

use Think\Model\ViewModel;

class PostViewModel extends ViewModel {
	public $viewFields = array (
			'TermRelationships' => array (
					//'title' => 'category_name',
					'tid',
					'_as' => 'tr',
					'_type'=>'LEFT',//对下一个定义生效的join方式
			),
			'Posts' => array (
					'*',
					'id' => 'post_id',
					'_as' => 'p',
					'_on' => 'p.id = tr.object_id'
			),
			/*
			'UserFavorites' => array (
					//'name' => 'username',
					'id' => 'ufid',
					'_type'=>'LEFT',
					'_as' => 'uf',
					'_on' => " (p.id = uf.object_id AND uf.table = 'posts')"
			)*/
	);
}
