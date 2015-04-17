<?php
return array (
		// 'TMPL_FILE_DEPR' => '_', // User_add.html，可以通过设置 TMPL_FILE_DEPR 参数来配置简化模板的目录层次
		'LOAD_EXT_CONFIG' => 'db,tags,mail',
		'LOAD_EXT_FILE' => 'Func',//加载自定义公有函数
		'TMPL_PARSE_STRING' => array (
				// '__RESOURCE__' => '/Public/', // 增加新的JS类库路径替换规则
				// 增加新的上传路径替换规则,
				'__UPLOAD__' => '/Uploads/' 
		),
		'COMMON_PATH' => APP_PATH . 'Common/Common/' ,
		/*
		'SHOW_RUN_TIME'    => true, // 运行时间显示
		'SHOW_ADV_TIME'    => true, // 显示详细的运行时间
		'SHOW_DB_TIMES'    => true, // 显示数据库查询和写入次数
		'SHOW_CACHE_TIMES' => true, // 显示缓存操作次数
		'SHOW_USE_MEM'     => true, // 显示内存开销
		'SHOW_LOAD_FILE'   => true, // 显示加载文件数
		'SHOW_FUN_TIMES'   => true, // 显示函数调用次数
		*/
		'SHOW_PAGE_TRACE' => true, // 页面调试
		'DEFAULT_MODULE' => 'Home', // 默认模块
		                            // 注册是否发送激活邮件
		'MEMBER_EMAIL_ACTIVE' => true ,
		'AUTHCODE' => 'wx', //加密字符串
		'COMMENT_TIME_INTERVAL' => 10,//评论间隔时间
		'COMMENT_NEED_CHECK' => 0,
		
		'LANG_SWITCH_ON' => true,   // 开启语言包功能
		'LANG_AUTO_DETECT' => true, // 自动侦测语言 开启多语言功能后有效
		'LANG_LIST'        => 'zh-cn', // 允许切换的语言列表 用逗号分隔
		'VAR_LANGUAGE'     => 'l', // 默认语言切换变量
		
); 

