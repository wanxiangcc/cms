<?php
namespace Common\Model;
use Common\Model\CommonModel;
class UsersModel extends CommonModel
{
	protected $tableName = 'users';
	protected $_validate = array(
			//array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
			array('user_login', 'require', '用户名称不能为空！', 1, 'regex', CommonModel:: MODEL_INSERT  ),
			array('user_pass', 'require', '密码不能为空！', 1, 'regex', CommonModel:: MODEL_INSERT ),
			array('user_login', 'require', '用户名称不能为空！', 0, 'regex', CommonModel:: MODEL_UPDATE  ),
			array('user_pass', 'require', '密码不能为空！', 0, 'regex', CommonModel:: MODEL_UPDATE  ),
			array('user_login','','用户名已经存在！',0,'unique',CommonModel:: MODEL_BOTH ), // 验证user_login字段是否唯一
			array('user_email','','邮箱帐号已经存在！',0,'unique',CommonModel:: MODEL_BOTH ), // 验证user_email字段是否唯一
			array('user_email','email','邮箱格式不正确！',0,'',CommonModel:: MODEL_BOTH ), // 验证user_email字段格式是否正确
	);
	protected $_map = array(
			'user_login' =>'user_name', // 把表单中user_login映射到数据表的user_name字段
	);
	protected $_auto = array (
			array('user_pass','password',3,'function') , // 对password字段在新增和编辑的时候使md5函数处理
			array('last_login_time','time',2,'function'), // 对last_login_time字段在更新的时候写入当前时间戳
	);
	
	function password($pw) {
		$decor = md5 ( C ( 'DB_PREFIX' ) );
		$mi = md5 ( $pw );
		return substr ( $decor, 0, 12 ) . $mi . substr ( $decor, - 4, 4 );
	}
	
}

