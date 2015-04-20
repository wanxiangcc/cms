<?php
return array(
	//'配置项'=>'配置值'
    
    'URL_MODEL'=>3,
    
    //Auth权限设置
    'AUTH_CONFIG' => array(
        'AUTH_ON' => true,  // 认证开关
        'AUTH_TYPE' => 1, // 认证方式，1为实时认证；2为登录认证。
        'AUTH_GROUP' => 'auth_group', // 用户组数据表名
        'AUTH_GROUP_ACCESS' => 'auth_group_access', // 用户-用户组关系表
        'AUTH_RULE' => 'auth_rule', // 权限规则表
        'AUTH_USER' => 'users', // 用户信息表
    ),   
    
   
    /* 调试配置 */
    'SHOW_PAGE_TRACE' => true,
    
    //应用类库不再需要使用命名空间
    'APP_USE_NAMESPACE'    =>    false, 
    
);