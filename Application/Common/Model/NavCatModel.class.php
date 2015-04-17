<?php
namespace Common\Model;
use Think\Model\RelationModel;
class NavCatModel extends RelationModel {
	
	//自动验证
	protected $_validate = array(
			//array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
			array('name', 'require', '分类名称不能为空！', 1, 'regex', self:: MODEL_BOTH ),
	);
	protected $_link = array(
			'Nav'=>array(
					'mapping_type'      => self::HAS_MANY,
					'class_name'        => 'Nav',
					'foreign_key'		=> 'cid',
					'condition'			=> 'status = 1',
					'mapping_order'		=> 'listorder ASC',
			),
	);
}