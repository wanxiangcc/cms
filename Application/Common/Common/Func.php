<?php
/**
 * 获取菜单列表
 * @param unknown $id
 * @return Ambigous <mixed, string, number, multitype:Ambigous <multitype:, boolean, multitype:multitype: > >
 */
function get_nav($id) {
	$nav_list = F ( 'site_nav_' . $id );
	if (empty ( $nav_list )) {
		$navCat = D ( 'NavCat' );
		$list = $navCat->where ( 'navcid=' . $id )->relation ( 'Nav' )->find ();
		// print_r($list);
		$navs = $list ['Nav'];
		foreach ( $navs as $key => $nav ) {
			$href = htmlspecialchars_decode ( $nav ['href'] );
			$hrefold = $href;
			
			if (strpos ( $hrefold, "{" )) { // 序列化的数据
				$href = unserialize ( stripslashes ( $nav ['href'] ) );
				$default_app = strtolower ( C ( "DEFAULT_MODULE" ) );
				$href = strtolower ( U ( $href ['action'], $href ['param'] ) );
				$g = C ( "VAR_MODULE" );
				$href = preg_replace ( "/\/$default_app\//", "/", $href );
				$href = preg_replace ( "/$g=$default_app&/", "", $href );
			} else {
				if ($hrefold == "home") {
					$href = __ROOT__ . "/";
				} else {
					$href = $hrefold;
				}
			}
			$nav ['href'] = $href;
			$navs [$key] = $nav;
		}
		$tree = new \Org\Util\Tree ();
		$tree->init ( $navs );
		$nav_list = $tree->get_tree_array ( 0 );
		F ( 'site_nav_' . $id, $nav_list );
	}
	return $nav_list;
}
/**
 * 获取配置信息
 *
 * @return mixed
 */
function get_site_options() {
	$site_options = S ( "site_options" );
	if (empty ( $site_options )) {
		$options_obj = M ( "Options" );
		$option = $options_obj->where ( "option_name='site_options'" )->find ();
		if ($option) {
			$site_options = ( array ) json_decode ( $option ['option_value'] );
		} else {
			$site_options = array ();
		}
		// F ( "site_options", $site_options );
		S ( 'site_options', $site_options, array ('expire' => 60 * 60 * 24 ) );
	}
	$site_options ['site_tongji'] = htmlspecialchars_decode ( $site_options ['site_tongji'] );
	return $site_options;
}
/**
 * 获取设置信息
 *
 * @param string $key        	
 * @return Ambigous <>|Ambigous <multitype:, mixed>
 */
function get_cms_settings($key = "") {
	$cms_settings = F ( "cms_settings" );
	if (empty ( $cmf_settings )) {
		$options_obj = M ( "Options" );
		$option = $options_obj->where ( "option_name='cms_settings'" )->find ();
		if ($option) {
			$cms_settings = json_decode ( $option ['option_value'], true );
		} else {
			$cms_settings = array ();
		}
		F ( "cms_settings", $cms_settings );
	}
	if (! empty ( $key )) {
		return $cms_settings [$key];
	}
	return $cms_settings;
}
/**
 * 获取滚动图标地方
 *
 * @param unknown $slide        	
 */
function get_slide($slide) {
	$slideCat = D ( 'SlideCat' );
	$list = $slideCat->where ( array ('cat_idname' => $slide ) )->relation ( 'Slide' )->find ();
	if (empty ( $list ['Slide'] )) {
		$default_home_slides = array (array ("slide_name" => "Test","slide_pic" => __ROOT__ . "/Public/images/demo/1.jpg","slide_url" => "" ),array ("slide_name" => "Test","slide_pic" => __ROOT__ . "/Public/images/demo/2.jpg","slide_url" => "" ),
				array ("slide_name" => "Test","slide_pic" => __ROOT__ . "/Public/images/demo/3.jpg","slide_url" => "" ) );
	} else {
		$default_home_slides = $list ['Slide'];
	}
	return $default_home_slides;
}

/**
 * 获取用户头像相对网站根目录的地址
 *
 * @param unknown $avatar        	
 * @return unknown
 */
function get_user_avatar_url($avatar) {
	if ($avatar) {
		if (strpos ( $avatar, "http" ) === 0) {
			return $avatar;
		} else {
			return get_asset_upload_path ( "avatar/" . $avatar );
		}
	} else {
		return $avatar;
	}
}
/**
 * 获取附件上传地址
 *
 * @param unknown $file        	
 * @param string $withhost        	
 * @return unknown|string
 */
function get_asset_upload_path($file, $withhost = false) {
	if (strpos ( $file, "http" ) === 0) {
		return $file;
	} else if (strpos ( $file, "/" ) === 0) {
		return $file;
	} else {
		$filepath = __ROOT__ . C ( "TMPL_PARSE_STRING.__UPLOAD__" ) . $file;
		if ($withhost) {
			if (strpos ( $filepath, "http" ) !== 0) {
				$http = 'http://';
				$http = is_ssl () ? 'https://' : $http;
				$filepath = $http . I ( 'server.HTTP_HOST' ) . $filepath;
			}
		}
		return $filepath;
	}
}

/**
 * 检查用户对某个url,内容的可访问性，用于记录如是否赞过，是否访问过等等;开发者可以自由控制，对于没有必要做的检查可以不做，以减少服务器压力
 * 
 * @param number $object
 *        	访问对象的id,格式：不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录;如果object为空，表示只检查对某个url访问的合法性
 * @param number $count_limit
 *        	访问次数限制,如1，表示只能访问一次
 * @param boolean $ip_limit
 *        	ip限制,false为不限制，true为限制
 * @param number $expire
 *        	距离上次访问的最小时间单位s，0表示不限制，大于0表示最后访问$expire秒后才可以访问
 * @return true 可访问，false不可访问
 */
function check_user_action($object = "", $count_limit = 1, $ip_limit = false, $expire = 0) {
	$common_action_log_model = M ( "CommonActionLog" );
	$action = MODULE_NAME . "-" . CONTROLLER_NAME . "-" . ACTION_NAME;
	$userid = session ( 'user.id' );
	
	$ip = get_client_ip ();
	
	$where = array ("user" => $userid,"action" => $action,"object" => $object );
	if ($ip_limit) {
		$where ['ip'] = $ip;
	}
	
	$find_log = $common_action_log_model->where ( $where )->find ();
	
	$time = time ();
	if ($find_log) {
		$common_action_log_model->where ( $where )->save ( array ("count" => array ("exp","count+1" ),"last_time" => $time,"ip" => $ip ) );
		if ($find_log ['count'] >= $count_limit) {
			return false;
		}
		
		if ($expire > 0 && ($time - $find_log ['last_time']) < $expire) {
			return false;
		}
	} else {
		$common_action_log_model->add ( array ("user" => $userid,"action" => $action,"object" => $object,"count" => array ("exp","count+1" ),"last_time" => $time,"ip" => $ip ) );
	}
	
	return true;
}

/**
 * 检查权限
 * 
 * @param
 *        	uid int 认证用户的id
 * @param
 *        	name string|array 需要验证的规则列表,支持逗号分隔的权限规则或索引数组
 * @param
 *        	relation string 如果为 'or' 表示满足任一条规则即通过验证;如果为 'and'则表示需满足所有规则才能通过验证
 * @return boolean 通过验证返回true;失败返回false
 */
function auth_check($uid, $name = null, $relation = 'or') {
	if(session('ADMIN_ID') == 1) return true;
	$auth_obj = new \Think\Auth();
	if (empty ( $name )) {
		$name = strtolower ( MODULE_NAME . "/" . CONTROLLER_NAME . "/" . ACTION_NAME );
	}
	$result =  $auth_obj->check ( $name , $uid, 'admin_url' , $relation );
	return $result;
}
?>