<?php
namespace Common\Model;
use Think\Model\RelationModel;
class SlideCatModel extends  RelationModel{
	
	//自动验证
	protected $_validate = array(
			//array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
			array('cat_name', 'require', '分类名称不能为空！', 1, 'regex', 3),
			array('cat_idname', 'require', '分类标识不能为空！', 1, 'regex', 3),
	);
	protected $_link = array(
			'Slide'=>array(
					'mapping_type'      => self::HAS_MANY,
					'class_name'        => 'Slide',
					//'mapping_name'		=> 'Slide',
					'foreign_key'		=> 'slide_cid',
					'condition'			=> 'slide_status = 1',
					//'relation_foreign_key' => '',
					'mapping_limit'		=> 5,
					'mapping_order'		=> 'listorder ASC',
			),
	);
	
	
}