<?php
namespace Common\Model;
use Think\Model\RelationModel;
class TermRelationshipsModel extends RelationModel {
	protected $_link = array(
		'Posts' => array(//根据id查询post信息
			'mapping_type'      =>  self::BELONGS_TO,
			'class_name'        =>  'Posts',//要关联的模型类名
			'foreign_key'       =>  'object_id',
			'condition'			=>	'post_status=1'
		),
			
	);

}