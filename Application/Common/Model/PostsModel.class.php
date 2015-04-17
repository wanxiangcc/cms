<?php
namespace Common\Model;
use Think\Model\RelationModel;
class PostsModel extends RelationModel {
	/*
	 * 表结构
	 * id:post的自增id
	 * post_author:用户的id
	 * post_date:发布时间
	 * post_content
	 * post_title
	 * post_excerpt:发表内容的摘录
	 * post_status:发表的状态,可以有多个值,分别为publish->发布,delete->删除,...
	 * comment_status:
	 * post_password
	 * post_name
	 * post_modified:更新时间
	 * post_content_filtered
	 * post_parent:为父级的post_id,就是这个表里的ID,一般用于表示某个发表的自动保存，和相关媒体而设置
	 * post_type:可以为多个值,image->表示某个post的附件图片;audio->表示某个post的附件音频;video->表示某个post的附件视频;...
	 */
	//post_type,post_status注意变量定义格式;
	
	protected $_auto = array (
		array ('post_date', 'time', 1, 'callback' ), 	// 增加的时候调用回调函数
		//array ('post_modified', 'mGetDate', 2, 'callback' ) 
	);
	protected $_link = array(
		//Terms key可以自定义，class_name或者mapping_name必须和表明一致
		'Terms' => array(
			
		    'mapping_type'      =>  self::MANY_TO_MANY,
		    'class_name'        =>  'Terms',//要关联的模型类名
		    //'mapping_name'      =>  'Terms',//关联的映射名称，用于获取数据用(一般不用定义)。该名称不要和当前模型(如这里Posts)的字段有重复，否则会导致关联数据获取的冲突。
		    								  //与_link索引一致，用于结果数组中取值的下标,如$posts['Terms']
											  //mapping_name没有定义的话，会取class_name的定义作为mapping_name。
											  //如果class_name也没有定义，则以数组的索引作为mapping_name。
		    'foreign_key'       =>  'object_id',
		    'relation_foreign_key'  =>  'term_id',
		    'relation_table'    =>  'sp_term_relationships' //此处应显式定义中间表名称，且不能使用C函数读取表前缀
		),
		'users' => array(
				
		)
	);
}