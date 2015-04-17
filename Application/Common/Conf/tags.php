<?php
return array (
		'test_behavior' => array (
				'Home\Behavior\NobodyBehavior' 
		),
		'load_func' => array (
				//'Home\Behavior\LoadFuncBehavior'
				//已修改为config.php中LOAD_EXT_FILE调用
		),
		'footer' => '',
		'app_begin' => array('Behavior\CheckLangBehavior'),
);