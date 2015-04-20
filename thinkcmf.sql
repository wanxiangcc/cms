/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50621
 Source Host           : localhost
 Source Database       : thinkcmf

 Target Server Type    : MySQL
 Target Server Version : 50621
 File Encoding         : utf-8

 Date: 04/20/2015 22:02:17 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `sp_ad`
-- ----------------------------
DROP TABLE IF EXISTS `sp_ad`;
CREATE TABLE `sp_ad` (
  `ad_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `ad_name` varchar(255) NOT NULL,
  `ad_content` text,
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  PRIMARY KEY (`ad_id`),
  KEY `ad_name` (`ad_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sp_asset`
-- ----------------------------
DROP TABLE IF EXISTS `sp_asset`;
CREATE TABLE `sp_asset` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL,
  `filename` varchar(50) DEFAULT NULL,
  `filesize` int(11) DEFAULT NULL,
  `filepath` varchar(200) NOT NULL,
  `uploadtime` int(11) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  `meta` text,
  `suffix` varchar(50) DEFAULT NULL,
  `download_times` int(6) NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sp_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `sp_auth_group`;
CREATE TABLE `sp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_auth_group`
-- ----------------------------
BEGIN;
INSERT INTO `sp_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '默认用户组', '1', '1,2,3,4,5'), ('12', 'admin', '1', 'ccc', 'cccc', '1', ''), ('11', 'admin', '1', 'ddd', 'ddd', '1', ''), ('10', 'admin', '1', 'cess', 'ssss', '1', ''), ('13', 'admin', '1', '111', '1111', '1', ''), ('14', 'admin', '1', '222', '2222', '1', ''), ('15', 'admin', '1', 'fff', 'ffff', '1', ''), ('16', 'admin', '1', 'fff', 'ffff', '1', ''), ('17', 'admin', '1', 'ggg', 'ggg', '1', ''), ('19', 'admin', '1', '44442211122', '4442211122', '1', '1,2,3,4,5,6,7');
COMMIT;

-- ----------------------------
--  Table structure for `sp_auth_group_user`
-- ----------------------------
DROP TABLE IF EXISTS `sp_auth_group_user`;
CREATE TABLE `sp_auth_group_user` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_auth_group_user`
-- ----------------------------
BEGIN;
INSERT INTO `sp_auth_group_user` VALUES ('1', '1'), ('3', '10');
COMMIT;

-- ----------------------------
--  Table structure for `sp_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `sp_auth_rule`;
CREATE TABLE `sp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` varchar(30) NOT NULL DEFAULT '1' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(255) DEFAULT NULL COMMENT '额外url参数',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COMMENT='权限规则表';

-- ----------------------------
--  Records of `sp_auth_rule`
-- ----------------------------
BEGIN;
INSERT INTO `sp_auth_rule` VALUES ('1', 'Admin', 'admin_url', 'admin/content/default', null, '内容管理', '1', ''), ('2', 'Api', 'admin_url', 'api/guestbookadmin/index', null, '所有留言', '1', ''), ('3', 'Api', 'admin_url', 'api/guestbookadmin/delete', null, '删除网站留言', '1', ''), ('4', 'Comment', 'admin_url', 'comment/commentadmin/index', null, '评论管理', '1', ''), ('5', 'Comment', 'admin_url', 'comment/commentadmin/delete', null, '删除评论', '1', ''), ('6', 'Comment', 'admin_url', 'comment/commentadmin/check', null, '评论审核', '1', ''), ('7', 'Portal', 'admin_url', 'portal/adminpost/index', null, '文章管理', '1', ''), ('8', 'Portal', 'admin_url', 'portal/adminpost/listorders', null, '文章排序', '1', ''), ('9', 'Portal', 'admin_url', 'portal/adminpost/top', null, '文章置顶', '1', ''), ('10', 'Portal', 'admin_url', 'portal/adminpost/recommend', null, '文章推荐', '1', ''), ('11', 'Portal', 'admin_url', 'portal/adminpost/move', null, '批量移动', '1', ''), ('12', 'Portal', 'admin_url', 'portal/adminpost/check', null, '文章审核', '1', ''), ('13', 'Portal', 'admin_url', 'portal/adminpost/delete', null, '删除文章', '1', ''), ('14', 'Portal', 'admin_url', 'portal/adminpost/edit', null, '编辑文章', '1', ''), ('15', 'Portal', 'admin_url', 'portal/adminpost/edit_post', null, '提交编辑', '1', ''), ('16', 'Portal', 'admin_url', 'portal/adminpost/add', null, '添加文章', '1', ''), ('17', 'Portal', 'admin_url', 'portal/adminpost/add_post', null, '提交添加', '1', ''), ('18', 'Portal', 'admin_url', 'portal/adminterm/index', null, '分类管理', '1', ''), ('19', 'Portal', 'admin_url', 'portal/adminterm/listorders', null, '文章分类排序', '1', ''), ('20', 'Portal', 'admin_url', 'portal/adminterm/delete', null, '删除分类', '1', ''), ('21', 'Portal', 'admin_url', 'portal/adminterm/edit', null, '编辑分类', '1', ''), ('22', 'Portal', 'admin_url', 'portal/adminterm/edit_post', null, '提交编辑', '1', ''), ('23', 'Portal', 'admin_url', 'portal/adminterm/add', null, '添加分类', '1', ''), ('24', 'Portal', 'admin_url', 'portal/adminterm/add_post', null, '提交添加', '1', ''), ('25', 'Portal', 'admin_url', 'portal/adminpage/index', null, '页面管理', '1', ''), ('26', 'Portal', 'admin_url', 'portal/adminpage/listorders', null, '页面排序', '1', ''), ('27', 'Portal', 'admin_url', 'portal/adminpage/delete', null, '删除页面', '1', ''), ('28', 'Portal', 'admin_url', 'portal/adminpage/edit', null, '编辑页面', '1', ''), ('29', 'Portal', 'admin_url', 'portal/adminpage/edit_post', null, '提交编辑', '1', ''), ('30', 'Portal', 'admin_url', 'portal/adminpage/add', null, '添加页面', '1', ''), ('31', 'Portal', 'admin_url', 'portal/adminpage/add_post', null, '提交添加', '1', ''), ('32', 'Admin', 'admin_url', 'admin/recycle/default', null, '回收站', '1', ''), ('33', 'Portal', 'admin_url', 'portal/adminpost/recyclebin', null, '文章回收', '1', ''), ('34', 'Portal', 'admin_url', 'portal/adminpost/restore', null, '文章还原', '1', ''), ('35', 'Portal', 'admin_url', 'portal/adminpost/clean', null, '彻底删除', '1', ''), ('36', 'Portal', 'admin_url', 'portal/adminpage/recyclebin', null, '页面回收', '1', ''), ('37', 'Portal', 'admin_url', 'portal/adminpage/clean', null, '彻底删除', '1', ''), ('38', 'Portal', 'admin_url', 'portal/adminpage/restore', null, '页面还原', '1', ''), ('39', 'Admin', 'admin_url', 'admin/extension/default', null, '扩展工具', '1', ''), ('40', 'Admin', 'admin_url', 'admin/backup/default', null, '备份管理', '1', ''), ('41', 'Admin', 'admin_url', 'admin/backup/restore', null, '数据还原', '1', ''), ('42', 'Admin', 'admin_url', 'admin/backup/index', null, '数据备份', '1', ''), ('43', 'Admin', 'admin_url', 'admin/backup/index_post', null, '提交数据备份', '1', ''), ('44', 'Admin', 'admin_url', 'admin/backup/download', null, '下载备份', '1', ''), ('45', 'Admin', 'admin_url', 'admin/backup/del_backup', null, '删除备份', '1', ''), ('46', 'Admin', 'admin_url', 'admin/backup/import', null, '数据备份导入', '1', ''), ('47', 'Admin', 'admin_url', 'admin/plugin/index', null, '插件管理', '1', ''), ('48', 'Admin', 'admin_url', 'admin/plugin/toggle', null, '插件启用切换', '1', ''), ('49', 'Admin', 'admin_url', 'admin/plugin/setting', null, '插件设置', '1', ''), ('50', 'Admin', 'admin_url', 'admin/plugin/setting_post', null, '插件设置提交', '1', ''), ('51', 'Admin', 'admin_url', 'admin/plugin/install', null, '插件安装', '1', ''), ('52', 'Admin', 'admin_url', 'admin/plugin/uninstall', null, '插件卸载', '1', ''), ('53', 'Admin', 'admin_url', 'admin/slide/default', null, '幻灯片', '1', ''), ('54', 'Admin', 'admin_url', 'admin/slide/index', null, '幻灯片管理', '1', ''), ('55', 'Admin', 'admin_url', 'admin/slide/listorders', null, '幻灯片排序', '1', ''), ('56', 'Admin', 'admin_url', 'admin/slide/toggle', null, '幻灯片显示切换', '1', ''), ('57', 'Admin', 'admin_url', 'admin/slide/delete', null, '删除幻灯片', '1', ''), ('58', 'Admin', 'admin_url', 'admin/slide/edit', null, '编辑幻灯片', '1', ''), ('59', 'Admin', 'admin_url', 'admin/slide/edit_post', null, '提交编辑', '1', ''), ('60', 'Admin', 'admin_url', 'admin/slide/add', null, '添加幻灯片', '1', ''), ('61', 'Admin', 'admin_url', 'admin/slide/add_post', null, '提交添加', '1', ''), ('62', 'Admin', 'admin_url', 'admin/slidecat/index', null, '幻灯片分类', '1', ''), ('63', 'Admin', 'admin_url', 'admin/slidecat/delete', null, '删除分类', '1', ''), ('64', 'Admin', 'admin_url', 'admin/slidecat/edit', null, '编辑分类', '1', ''), ('65', 'Admin', 'admin_url', 'admin/slidecat/edit_post', null, '提交编辑', '1', ''), ('66', 'Admin', 'admin_url', 'admin/slidecat/add', null, '添加分类', '1', ''), ('67', 'Admin', 'admin_url', 'admin/slidecat/add_post', null, '提交添加', '1', ''), ('68', 'Admin', 'admin_url', 'admin/ad/index', null, '网站广告', '1', ''), ('69', 'Admin', 'admin_url', 'admin/ad/toggle', null, '广告显示切换', '1', ''), ('70', 'Admin', 'admin_url', 'admin/ad/delete', null, '删除广告', '1', ''), ('71', 'Admin', 'admin_url', 'admin/ad/edit', null, '编辑广告', '1', ''), ('72', 'Admin', 'admin_url', 'admin/ad/edit_post', null, '提交编辑', '1', ''), ('73', 'Admin', 'admin_url', 'admin/ad/add', null, '添加广告', '1', ''), ('74', 'Admin', 'admin_url', 'admin/ad/add_post', null, '提交添加', '1', ''), ('75', 'Admin', 'admin_url', 'admin/link/index', null, '友情链接', '1', ''), ('76', 'Admin', 'admin_url', 'admin/link/listorders', null, '友情链接排序', '1', ''), ('77', 'Admin', 'admin_url', 'admin/link/toggle', null, '友链显示切换', '1', ''), ('78', 'Admin', 'admin_url', 'admin/link/delete', null, '删除友情链接', '1', ''), ('79', 'Admin', 'admin_url', 'admin/link/edit', null, '编辑友情链接', '1', ''), ('80', 'Admin', 'admin_url', 'admin/link/edit_post', null, '提交编辑', '1', ''), ('81', 'Admin', 'admin_url', 'admin/link/add', null, '添加友情链接', '1', ''), ('82', 'Admin', 'admin_url', 'admin/link/add_post', null, '提交添加', '1', ''), ('83', 'Api', 'admin_url', 'api/oauthadmin/setting', null, '第三方登陆', '1', ''), ('84', 'Api', 'admin_url', 'api/oauthadmin/setting_post', null, '提交设置', '1', ''), ('85', 'Admin', 'admin_url', 'admin/menu/default', null, '菜单管理', '1', ''), ('86', 'Admin', 'admin_url', 'admin/navcat/default1', null, '前台菜单', '1', ''), ('87', 'Admin', 'admin_url', 'admin/nav/index', null, '菜单管理', '1', ''), ('88', 'Admin', 'admin_url', 'admin/nav/listorders', null, '前台导航排序', '1', ''), ('89', 'Admin', 'admin_url', 'admin/nav/delete', null, '删除菜单', '1', ''), ('90', 'Admin', 'admin_url', 'admin/nav/edit', null, '编辑菜单', '1', ''), ('91', 'Admin', 'admin_url', 'admin/nav/edit_post', null, '提交编辑', '1', ''), ('92', 'Admin', 'admin_url', 'admin/nav/add', null, '添加菜单', '1', ''), ('93', 'Admin', 'admin_url', 'admin/nav/add_post', null, '提交添加', '1', ''), ('94', 'Admin', 'admin_url', 'admin/navcat/index', null, '菜单分类', '1', ''), ('95', 'Admin', 'admin_url', 'admin/navcat/delete', null, '删除分类', '1', ''), ('96', 'Admin', 'admin_url', 'admin/navcat/edit', null, '编辑分类', '1', ''), ('97', 'Admin', 'admin_url', 'admin/navcat/edit_post', null, '提交编辑', '1', ''), ('98', 'Admin', 'admin_url', 'admin/navcat/add', null, '添加分类', '1', ''), ('99', 'Admin', 'admin_url', 'admin/navcat/add_post', null, '提交添加', '1', ''), ('100', 'Admin', 'admin_url', 'admin/menu/index', null, '后台菜单', '1', ''), ('101', 'Admin', 'admin_url', 'admin/menu/add', null, '添加菜单', '1', ''), ('102', 'Admin', 'admin_url', 'admin/menu/add_post', null, '提交添加', '1', ''), ('103', 'Admin', 'admin_url', 'admin/menu/listorders', null, '后台菜单排序', '1', ''), ('104', 'Admin', 'admin_url', 'admin/menu/export_menu', null, '菜单备份', '1', ''), ('105', 'Admin', 'admin_url', 'admin/menu/edit', null, '编辑菜单', '1', ''), ('106', 'Admin', 'admin_url', 'admin/menu/edit_post', null, '提交编辑', '1', ''), ('107', 'Admin', 'admin_url', 'admin/menu/delete', null, '删除菜单', '1', ''), ('108', 'Admin', 'admin_url', 'admin/menu/lists', null, '所有菜单', '1', ''), ('109', 'Admin', 'admin_url', 'admin/setting/default', null, '设置', '1', ''), ('110', 'Admin', 'admin_url', 'admin/setting/userdefault', null, '个人信息', '1', ''), ('111', 'Admin', 'admin_url', 'admin/user/userinfo', null, '修改信息', '1', ''), ('112', 'Admin', 'admin_url', 'admin/user/userinfo_post', null, '修改信息提交', '1', ''), ('113', 'Admin', 'admin_url', 'admin/setting/password', null, '修改密码', '1', ''), ('114', 'Admin', 'admin_url', 'admin/setting/password_post', null, '提交修改', '1', ''), ('115', 'Admin', 'admin_url', 'admin/setting/site', null, '网站信息', '1', ''), ('116', 'Admin', 'admin_url', 'admin/setting/site_post', null, '提交修改', '1', ''), ('117', 'Admin', 'admin_url', 'admin/route/index', null, '路由列表', '1', ''), ('118', 'Admin', 'admin_url', 'admin/route/add', null, '路由添加', '1', ''), ('119', 'Admin', 'admin_url', 'admin/route/add_post', null, '路由添加提交', '1', ''), ('120', 'Admin', 'admin_url', 'admin/route/edit', null, '路由编辑', '1', ''), ('121', 'Admin', 'admin_url', 'admin/route/edit_post', null, '路由编辑提交', '1', ''), ('122', 'Admin', 'admin_url', 'admin/route/delete', null, '路由删除', '1', ''), ('123', 'Admin', 'admin_url', 'admin/route/ban', null, '路由禁止', '1', ''), ('124', 'Admin', 'admin_url', 'admin/route/open', null, '路由启用', '1', ''), ('125', 'Admin', 'admin_url', 'admin/route/listorders', null, '路由排序', '1', ''), ('126', 'Admin', 'admin_url', 'admin/mailer/default', null, '邮箱配置', '1', ''), ('127', 'Admin', 'admin_url', 'admin/mailer/index', null, 'SMTP配置', '1', ''), ('128', 'Admin', 'admin_url', 'admin/mailer/index_post', null, '提交配置', '1', ''), ('129', 'Admin', 'admin_url', 'admin/mailer/active', null, '邮件模板', '1', ''), ('130', 'Admin', 'admin_url', 'admin/mailer/active_post', null, '提交模板', '1', ''), ('131', 'Admin', 'admin_url', 'admin/setting/clearcache', null, '清除缓存', '1', ''), ('132', 'User', 'admin_url', 'user/indexadmin/default', null, '用户管理', '1', ''), ('133', 'User', 'admin_url', 'user/indexadmin/default1', null, '用户组', '1', ''), ('134', 'User', 'admin_url', 'user/indexadmin/index', null, '本站用户', '1', ''), ('135', 'User', 'admin_url', 'user/indexadmin/ban', null, '拉黑会员', '1', ''), ('136', 'User', 'admin_url', 'user/indexadmin/cancelban', null, '启用会员', '1', ''), ('137', 'User', 'admin_url', 'user/oauthadmin/index', null, '第三方用户', '1', ''), ('138', 'User', 'admin_url', 'user/oauthadmin/delete', null, '第三方用户解绑', '1', ''), ('139', 'User', 'admin_url', 'user/indexadmin/default3', null, '管理组', '1', ''), ('140', 'Admin', 'admin_url', 'admin/rbac/index', null, '角色管理', '1', ''), ('141', 'Admin', 'admin_url', 'admin/rbac/member', null, '成员管理', '1', ''), ('142', 'Admin', 'admin_url', 'admin/rbac/authorize', null, '权限设置', '1', ''), ('143', 'Admin', 'admin_url', 'admin/rbac/authorize_post', null, '提交设置', '1', ''), ('144', 'Admin', 'admin_url', 'admin/rbac/roleedit', null, '编辑角色', '1', ''), ('145', 'Admin', 'admin_url', 'admin/rbac/roleedit_post', null, '提交编辑', '1', ''), ('146', 'Admin', 'admin_url', 'admin/rbac/roledelete', null, '删除角色', '1', ''), ('147', 'Admin', 'admin_url', 'admin/rbac/roleadd', null, '添加角色', '1', ''), ('148', 'Admin', 'admin_url', 'admin/rbac/roleadd_post', null, '提交添加', '1', ''), ('149', 'Admin', 'admin_url', 'admin/user/index', null, '管理员', '1', ''), ('150', 'Admin', 'admin_url', 'admin/user/delete', null, '删除管理员', '1', ''), ('151', 'Admin', 'admin_url', 'admin/user/edit', null, '管理员编辑', '1', ''), ('152', 'Admin', 'admin_url', 'admin/user/edit_post', null, '编辑提交', '1', ''), ('153', 'Admin', 'admin_url', 'admin/user/add', null, '管理员添加', '1', ''), ('154', 'Admin', 'admin_url', 'admin/user/add_post', null, '添加提交', '1', ''), ('155', 'Admin', 'admin_url', 'admin/plugin/update', null, '插件更新', '1', '');
COMMIT;

-- ----------------------------
--  Table structure for `sp_comments`
-- ----------------------------
DROP TABLE IF EXISTS `sp_comments`;
CREATE TABLE `sp_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_table` varchar(100) NOT NULL COMMENT '评论内容所在表，不带表前缀',
  `post_id` int(11) unsigned NOT NULL DEFAULT '0',
  `url` varchar(255) DEFAULT NULL COMMENT '原文地址',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_uid` int(11) NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `full_name` varchar(50) DEFAULT NULL COMMENT '评论者昵称',
  `email` varchar(255) DEFAULT NULL COMMENT '评论者邮箱',
  `createtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `content` text NOT NULL COMMENT '评论内容',
  `type` smallint(1) NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `parentid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `path` varchar(500) DEFAULT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '状态，1已审核，0未审核',
  PRIMARY KEY (`id`),
  KEY `comment_post_ID` (`post_id`),
  KEY `comment_approved_date_gmt` (`status`),
  KEY `comment_parent` (`parentid`),
  KEY `table_id_status` (`post_table`,`post_id`,`status`),
  KEY `createtime` (`createtime`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_comments`
-- ----------------------------
BEGIN;
INSERT INTO `sp_comments` VALUES ('30', 'posts', '5', 'index.php?m=Home&amp;c=Post&amp;a=view&amp;id=5', '6', '0', 'admin22', '308243528@qq.com', '2015-04-13 21:43:24', 'dddd', '1', '0', '0-30', '1'), ('31', 'posts', '5', 'index.php?m=Home&amp;c=Post&amp;a=view&amp;id=5', '6', '6', 'admin22', '308243528@qq.com', '2015-04-13 21:43:34', 'dddddd', '1', '30', '0-30-31', '1'), ('32', 'posts', '5', 'index.php?m=Home&amp;c=Post&amp;a=view&amp;id=5', '6', '6', 'admin22', '308243528@qq.com', '2015-04-13 21:43:44', 'dddddd', '1', '31', '0-30-31-32', '1'), ('33', 'posts', '5', 'index.php?m=Home&amp;c=Post&amp;a=view&amp;id=5', '6', '6', 'admin22', '308243528@qq.com', '2015-04-13 21:47:21', 'kkkk', '1', '31', '0-30-31-33', '1'), ('34', 'posts', '5', 'index.php?m=Home&amp;c=Post&amp;a=view&amp;id=5', '6', '6', 'admin22', '308243528@qq.com', '2015-04-13 21:47:56', '9999', '1', '30', '0-30-34', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sp_common_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `sp_common_action_log`;
CREATE TABLE `sp_common_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` bigint(20) DEFAULT '0' COMMENT '用户id',
  `object` varchar(100) DEFAULT NULL COMMENT '访问对象的id,格式：不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) DEFAULT NULL COMMENT '操作名称；格式规定为：应用名+控制器+操作名；也可自己定义格式只要不发生冲突且惟一；',
  `count` int(11) DEFAULT '0' COMMENT '访问次数',
  `last_time` int(11) DEFAULT '0' COMMENT '最后访问的时间戳',
  `ip` varchar(15) DEFAULT NULL COMMENT '访问者最后访问ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user`,`object`,`action`),
  KEY `user_object_action_ip` (`user`,`object`,`action`,`ip`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_common_action_log`
-- ----------------------------
BEGIN;
INSERT INTO `sp_common_action_log` VALUES ('1', '1', 'posts1', 'Portal-Article-index', '1', '1428224612', '127.0.0.1'), ('2', '0', 'posts1', 'Portal-Article-index', '1', '1428288951', '0.0.0.0'), ('3', '1', 'posts1', 'Portal-Article-index', '4', '1428328002', '0.0.0.0'), ('4', '1', 'posts6', 'Portal-Article-do_like', '1', '1428306934', '0.0.0.0'), ('5', '0', 'posts6', 'Portal-Article-index', '7', '1428820360', '0.0.0.0'), ('6', '1', 'posts6', 'Portal-Article-index', '4', '1428327886', '0.0.0.0'), ('7', '1', 'posts5', 'Portal-Article-index', '5', '1428327885', '0.0.0.0'), ('8', '1', 'posts4', 'Portal-Article-index', '5', '1428327885', '0.0.0.0'), ('9', '1', 'posts3', 'Portal-Article-index', '3', '1428327884', '0.0.0.0'), ('10', '1', 'posts2', 'Portal-Article-index', '2', '1428327883', '0.0.0.0'), ('11', '0', 'posts5', 'Portal-Article-index', '2', '1428757567', '0.0.0.0'), ('12', '0', 'posts4', 'Portal-Article-index', '1', '1428757567', '0.0.0.0'), ('13', '0', 'posts3', 'Portal-Article-index', '3', '1428757712', '0.0.0.0'), ('14', null, 'posts6', 'Home-Post-view', '1', '1428845230', '0.0.0.0'), ('15', null, 'posts6', 'Home-Post-view', '1', '1428845446', '0.0.0.0'), ('16', null, 'posts6', 'Home-Post-view', '1', '1428845584', '0.0.0.0'), ('17', '6', 'posts6', 'Home-Post-do_like', '25', '1428848130', '0.0.0.0'), ('18', '6', 'posts6', 'Home-Post-view', '44', '1428933524', '0.0.0.0'), ('19', null, 'posts5', 'Home-Post-View', '1', '1428928412', '0.0.0.0'), ('20', null, 'posts4', 'Home-Post-View', '1', '1428928417', '0.0.0.0'), ('21', '6', 'posts4', 'Home-Post-View', '6', '1428930316', '0.0.0.0'), ('22', '6', 'posts4', 'Home-Post-do_like', '2', '1428928520', '0.0.0.0'), ('23', '6', 'posts5', 'Home-Post-View', '82', '1428933615', '0.0.0.0'), ('24', '6', 'posts5', 'Home-Post-do_like', '1', '1428929476', '0.0.0.0'), ('25', '6', 'posts2', 'Home-Post-view', '1', '1428930305', '0.0.0.0'), ('26', '6', 'posts6', 'Portal-Article-index', '3', '1428933127', '0.0.0.0'), ('27', '6', 'posts5', 'Portal-Article-index', '2', '1428933156', '0.0.0.0'), ('28', null, 'posts11', 'Home-Post-View', '1', '1429191055', '0.0.0.0'), ('29', null, 'posts11', 'Home-Post-View', '1', '1429191069', '0.0.0.0'), ('30', null, 'posts7', 'Home-Post-View', '1', '1429342425', '0.0.0.0');
COMMIT;

-- ----------------------------
--  Table structure for `sp_guestbook`
-- ----------------------------
DROP TABLE IF EXISTS `sp_guestbook`;
CREATE TABLE `sp_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL COMMENT '留言者姓名',
  `email` varchar(100) NOT NULL COMMENT '留言者邮箱',
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `msg` text NOT NULL COMMENT '留言内容',
  `createtime` datetime NOT NULL,
  `status` smallint(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sp_links`
-- ----------------------------
DROP TABLE IF EXISTS `sp_links`;
CREATE TABLE `sp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL COMMENT '友情链接地址',
  `link_name` varchar(255) NOT NULL COMMENT '友情链接名称',
  `link_image` varchar(255) DEFAULT NULL COMMENT '友情链接图标',
  `link_target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '友情链接打开方式',
  `link_description` text NOT NULL COMMENT '友情链接描述',
  `link_status` int(2) NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `link_rel` varchar(255) DEFAULT '',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_links`
-- ----------------------------
BEGIN;
INSERT INTO `sp_links` VALUES ('1', 'http://www.thinkcmf.com', 'ThinkCMF', '', '_blank', '', '1', '0', '', '0');
COMMIT;

-- ----------------------------
--  Table structure for `sp_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sp_menu`;
CREATE TABLE `sp_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `app` char(20) NOT NULL COMMENT '应用名称app',
  `model` char(20) NOT NULL COMMENT '控制器',
  `action` char(20) NOT NULL COMMENT '操作名称',
  `data` char(50) NOT NULL COMMENT '额外参数',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '菜单类型  1：权限认证+菜单；0：只作为菜单',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，1显示，0不显示',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parentid`),
  KEY `model` (`model`)
) ENGINE=MyISAM AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_menu`
-- ----------------------------
BEGIN;
INSERT INTO `sp_menu` VALUES ('1', '0', 'Admin', 'Content', 'default', '', '0', '1', '内容管理', 'th', '', '30'), ('2', '1', 'Api', 'Guestbookadmin', 'index', '', '1', '1', '所有留言', '', '', '0'), ('3', '2', 'Api', 'Guestbookadmin', 'delete', '', '1', '0', '删除网站留言', '', '', '0'), ('4', '1', 'Comment', 'Commentadmin', 'index', '', '1', '1', '评论管理', '', '', '0'), ('5', '4', 'Comment', 'Commentadmin', 'delete', '', '1', '0', '删除评论', '', '', '0'), ('6', '4', 'Comment', 'Commentadmin', 'check', '', '1', '0', '评论审核', '', '', '0'), ('7', '1', 'Portal', 'AdminPost', 'index', '', '1', '1', '文章管理', '', '', '1'), ('8', '7', 'Portal', 'AdminPost', 'listorders', '', '1', '0', '文章排序', '', '', '0'), ('9', '7', 'Portal', 'AdminPost', 'top', '', '1', '0', '文章置顶', '', '', '0'), ('10', '7', 'Portal', 'AdminPost', 'recommend', '', '1', '0', '文章推荐', '', '', '0'), ('11', '7', 'Portal', 'AdminPost', 'move', '', '1', '0', '批量移动', '', '', '1000'), ('12', '7', 'Portal', 'AdminPost', 'check', '', '1', '0', '文章审核', '', '', '1000'), ('13', '7', 'Portal', 'AdminPost', 'delete', '', '1', '0', '删除文章', '', '', '1000'), ('14', '7', 'Portal', 'AdminPost', 'edit', '', '1', '0', '编辑文章', '', '', '1000'), ('15', '14', 'Portal', 'AdminPost', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('16', '7', 'Portal', 'AdminPost', 'add', '', '1', '0', '添加文章', '', '', '1000'), ('17', '16', 'Portal', 'AdminPost', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('18', '1', 'Portal', 'AdminTerm', 'index', '', '0', '1', '分类管理', '', '', '2'), ('19', '18', 'Portal', 'AdminTerm', 'listorders', '', '1', '0', '文章分类排序', '', '', '0'), ('20', '18', 'Portal', 'AdminTerm', 'delete', '', '1', '0', '删除分类', '', '', '1000'), ('21', '18', 'Portal', 'AdminTerm', 'edit', '', '1', '0', '编辑分类', '', '', '1000'), ('22', '21', 'Portal', 'AdminTerm', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('23', '18', 'Portal', 'AdminTerm', 'add', '', '1', '0', '添加分类', '', '', '1000'), ('24', '23', 'Portal', 'AdminTerm', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('25', '1', 'Portal', 'AdminPage', 'index', '', '1', '1', '页面管理', '', '', '3'), ('26', '25', 'Portal', 'AdminPage', 'listorders', '', '1', '0', '页面排序', '', '', '0'), ('27', '25', 'Portal', 'AdminPage', 'delete', '', '1', '0', '删除页面', '', '', '1000'), ('28', '25', 'Portal', 'AdminPage', 'edit', '', '1', '0', '编辑页面', '', '', '1000'), ('29', '28', 'Portal', 'AdminPage', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('30', '25', 'Portal', 'AdminPage', 'add', '', '1', '0', '添加页面', '', '', '1000'), ('31', '30', 'Portal', 'AdminPage', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('32', '1', 'Admin', 'Recycle', 'default', '', '1', '1', '回收站', '', '', '4'), ('33', '32', 'Portal', 'AdminPost', 'recyclebin', '', '1', '1', '文章回收', '', '', '0'), ('34', '33', 'Portal', 'AdminPost', 'restore', '', '1', '0', '文章还原', '', '', '1000'), ('35', '33', 'Portal', 'AdminPost', 'clean', '', '1', '0', '彻底删除', '', '', '1000'), ('36', '32', 'Portal', 'AdminPage', 'recyclebin', '', '1', '1', '页面回收', '', '', '1'), ('37', '36', 'Portal', 'AdminPage', 'clean', '', '1', '0', '彻底删除', '', '', '1000'), ('38', '36', 'Portal', 'AdminPage', 'restore', '', '1', '0', '页面还原', '', '', '1000'), ('39', '0', 'Admin', 'Extension', 'default', '', '0', '1', '扩展工具', 'cloud', '', '40'), ('40', '39', 'Admin', 'Backup', 'default', '', '1', '1', '备份管理', '', '', '0'), ('41', '40', 'Admin', 'Backup', 'restore', '', '1', '1', '数据还原', '', '', '0'), ('42', '40', 'Admin', 'Backup', 'index', '', '1', '1', '数据备份', '', '', '0'), ('43', '42', 'Admin', 'Backup', 'index_post', '', '1', '0', '提交数据备份', '', '', '0'), ('44', '40', 'Admin', 'Backup', 'download', '', '1', '0', '下载备份', '', '', '1000'), ('45', '40', 'Admin', 'Backup', 'del_backup', '', '1', '0', '删除备份', '', '', '1000'), ('46', '40', 'Admin', 'Backup', 'import', '', '1', '0', '数据备份导入', '', '', '1000'), ('47', '39', 'Admin', 'Plugin', 'index', '', '1', '1', '插件管理', '', '', '0'), ('48', '47', 'Admin', 'Plugin', 'toggle', '', '1', '0', '插件启用切换', '', '', '0'), ('49', '47', 'Admin', 'Plugin', 'setting', '', '1', '0', '插件设置', '', '', '0'), ('50', '49', 'Admin', 'Plugin', 'setting_post', '', '1', '0', '插件设置提交', '', '', '0'), ('51', '47', 'Admin', 'Plugin', 'install', '', '1', '0', '插件安装', '', '', '0'), ('52', '47', 'Admin', 'Plugin', 'uninstall', '', '1', '0', '插件卸载', '', '', '0'), ('53', '39', 'Admin', 'Slide', 'default', '', '1', '1', '幻灯片', '', '', '1'), ('54', '53', 'Admin', 'Slide', 'index', '', '1', '1', '幻灯片管理', '', '', '0'), ('55', '54', 'Admin', 'Slide', 'listorders', '', '1', '0', '幻灯片排序', '', '', '0'), ('56', '54', 'Admin', 'Slide', 'toggle', '', '1', '0', '幻灯片显示切换', '', '', '0'), ('57', '54', 'Admin', 'Slide', 'delete', '', '1', '0', '删除幻灯片', '', '', '1000'), ('58', '54', 'Admin', 'Slide', 'edit', '', '1', '0', '编辑幻灯片', '', '', '1000'), ('59', '58', 'Admin', 'Slide', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('60', '54', 'Admin', 'Slide', 'add', '', '1', '0', '添加幻灯片', '', '', '1000'), ('61', '60', 'Admin', 'Slide', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('62', '53', 'Admin', 'Slidecat', 'index', '', '1', '1', '幻灯片分类', '', '', '0'), ('63', '62', 'Admin', 'Slidecat', 'delete', '', '1', '0', '删除分类', '', '', '1000'), ('64', '62', 'Admin', 'Slidecat', 'edit', '', '1', '0', '编辑分类', '', '', '1000'), ('65', '64', 'Admin', 'Slidecat', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('66', '62', 'Admin', 'Slidecat', 'add', '', '1', '0', '添加分类', '', '', '1000'), ('67', '66', 'Admin', 'Slidecat', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('68', '39', 'Admin', 'Ad', 'index', '', '1', '1', '网站广告', '', '', '2'), ('69', '68', 'Admin', 'Ad', 'toggle', '', '1', '0', '广告显示切换', '', '', '0'), ('70', '68', 'Admin', 'Ad', 'delete', '', '1', '0', '删除广告', '', '', '1000'), ('71', '68', 'Admin', 'Ad', 'edit', '', '1', '0', '编辑广告', '', '', '1000'), ('72', '71', 'Admin', 'Ad', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('73', '68', 'Admin', 'Ad', 'add', '', '1', '0', '添加广告', '', '', '1000'), ('74', '73', 'Admin', 'Ad', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('75', '39', 'Admin', 'Link', 'index', '', '0', '1', '友情链接', '', '', '3'), ('76', '75', 'Admin', 'Link', 'listorders', '', '1', '0', '友情链接排序', '', '', '0'), ('77', '75', 'Admin', 'Link', 'toggle', '', '1', '0', '友链显示切换', '', '', '0'), ('78', '75', 'Admin', 'Link', 'delete', '', '1', '0', '删除友情链接', '', '', '1000'), ('79', '75', 'Admin', 'Link', 'edit', '', '1', '0', '编辑友情链接', '', '', '1000'), ('80', '79', 'Admin', 'Link', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('81', '75', 'Admin', 'Link', 'add', '', '1', '0', '添加友情链接', '', '', '1000'), ('82', '81', 'Admin', 'Link', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('83', '39', 'Api', 'Oauthadmin', 'setting', '', '1', '1', '第三方登陆', 'leaf', '', '4'), ('84', '83', 'Api', 'Oauthadmin', 'setting_post', '', '1', '0', '提交设置', '', '', '0'), ('85', '0', 'Admin', 'Menu', 'default', '', '1', '1', '菜单管理', 'list', '', '20'), ('86', '85', 'Admin', 'Navcat', 'default1', '', '1', '1', '前台菜单', '', '', '0'), ('87', '86', 'Admin', 'Nav', 'index', '', '1', '1', '菜单管理', '', '', '0'), ('88', '87', 'Admin', 'Nav', 'listorders', '', '1', '0', '前台导航排序', '', '', '0'), ('89', '87', 'Admin', 'Nav', 'delete', '', '1', '0', '删除菜单', '', '', '1000'), ('90', '87', 'Admin', 'Nav', 'edit', '', '1', '0', '编辑菜单', '', '', '1000'), ('91', '90', 'Admin', 'Nav', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('92', '87', 'Admin', 'Nav', 'add', '', '1', '0', '添加菜单', '', '', '1000'), ('93', '92', 'Admin', 'Nav', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('94', '86', 'Admin', 'Navcat', 'index', '', '1', '1', '菜单分类', '', '', '0'), ('95', '94', 'Admin', 'Navcat', 'delete', '', '1', '0', '删除分类', '', '', '1000'), ('96', '94', 'Admin', 'Navcat', 'edit', '', '1', '0', '编辑分类', '', '', '1000'), ('97', '96', 'Admin', 'Navcat', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('98', '94', 'Admin', 'Navcat', 'add', '', '1', '0', '添加分类', '', '', '1000'), ('99', '98', 'Admin', 'Navcat', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('100', '85', 'Admin', 'Menu', 'index', '', '1', '1', '后台菜单', '', '', '0'), ('101', '100', 'Admin', 'Menu', 'add', '', '1', '0', '添加菜单', '', '', '0'), ('102', '101', 'Admin', 'Menu', 'add_post', '', '1', '0', '提交添加', '', '', '0'), ('103', '100', 'Admin', 'Menu', 'listorders', '', '1', '0', '后台菜单排序', '', '', '0'), ('104', '100', 'Admin', 'Menu', 'export_menu', '', '1', '0', '菜单备份', '', '', '1000'), ('105', '100', 'Admin', 'Menu', 'edit', '', '1', '0', '编辑菜单', '', '', '1000'), ('106', '105', 'Admin', 'Menu', 'edit_post', '', '1', '0', '提交编辑', '', '', '0'), ('107', '100', 'Admin', 'Menu', 'delete', '', '1', '0', '删除菜单', '', '', '1000'), ('108', '100', 'Admin', 'Menu', 'lists', '', '1', '0', '所有菜单', '', '', '1000'), ('109', '0', 'Admin', 'Setting', 'default', '', '0', '1', '设置', 'cogs', '', '0'), ('110', '109', 'Admin', 'Setting', 'userdefault', '', '0', '1', '个人信息', '', '', '0'), ('111', '110', 'Admin', 'User', 'userinfo', '', '1', '1', '修改信息', '', '', '0'), ('112', '111', 'Admin', 'User', 'userinfo_post', '', '1', '0', '修改信息提交', '', '', '0'), ('113', '110', 'Admin', 'Setting', 'password', '', '1', '1', '修改密码', '', '', '0'), ('114', '113', 'Admin', 'Setting', 'password_post', '', '1', '0', '提交修改', '', '', '0'), ('115', '109', 'Admin', 'Setting', 'site', '', '1', '1', '网站信息', '', '', '0'), ('116', '115', 'Admin', 'Setting', 'site_post', '', '1', '0', '提交修改', '', '', '0'), ('117', '115', 'Admin', 'Route', 'index', '', '1', '0', '路由列表', '', '', '0'), ('118', '115', 'Admin', 'Route', 'add', '', '1', '0', '路由添加', '', '', '0'), ('119', '118', 'Admin', 'Route', 'add_post', '', '1', '0', '路由添加提交', '', '', '0'), ('120', '115', 'Admin', 'Route', 'edit', '', '1', '0', '路由编辑', '', '', '0'), ('121', '120', 'Admin', 'Route', 'edit_post', '', '1', '0', '路由编辑提交', '', '', '0'), ('122', '115', 'Admin', 'Route', 'delete', '', '1', '0', '路由删除', '', '', '0'), ('123', '115', 'Admin', 'Route', 'ban', '', '1', '0', '路由禁止', '', '', '0'), ('124', '115', 'Admin', 'Route', 'open', '', '1', '0', '路由启用', '', '', '0'), ('125', '115', 'Admin', 'Route', 'listorders', '', '1', '0', '路由排序', '', '', '0'), ('126', '109', 'Admin', 'Mailer', 'default', '', '1', '1', '邮箱配置', '', '', '0'), ('127', '126', 'Admin', 'Mailer', 'index', '', '1', '1', 'SMTP配置', '', '', '0'), ('128', '127', 'Admin', 'Mailer', 'index_post', '', '1', '0', '提交配置', '', '', '0'), ('129', '126', 'Admin', 'Mailer', 'active', '', '1', '1', '邮件模板', '', '', '0'), ('130', '129', 'Admin', 'Mailer', 'active_post', '', '1', '0', '提交模板', '', '', '0'), ('131', '109', 'Admin', 'Setting', 'clearcache', '', '1', '1', '清除缓存', '', '', '1'), ('132', '0', 'User', 'Indexadmin', 'default', '', '1', '1', '用户管理', 'group', '', '10'), ('133', '132', 'User', 'Indexadmin', 'default1', '', '1', '1', '用户组', '', '', '0'), ('134', '133', 'User', 'Indexadmin', 'index', '', '1', '1', '本站用户', 'leaf', '', '0'), ('135', '134', 'User', 'Indexadmin', 'ban', '', '1', '0', '拉黑会员', '', '', '0'), ('136', '134', 'User', 'Indexadmin', 'cancelban', '', '1', '0', '启用会员', '', '', '0'), ('137', '133', 'User', 'Oauthadmin', 'index', '', '1', '1', '第三方用户', 'leaf', '', '0'), ('138', '137', 'User', 'Oauthadmin', 'delete', '', '1', '0', '第三方用户解绑', '', '', '0'), ('139', '132', 'User', 'Indexadmin', 'default3', '', '1', '1', '管理组', '', '', '0'), ('140', '139', 'Admin', 'Rbac', 'index', '', '1', '1', '角色管理', '', '', '0'), ('141', '140', 'Admin', 'Rbac', 'member', '', '1', '0', '成员管理', '', '', '1000'), ('142', '140', 'Admin', 'Rbac', 'authorize', '', '1', '0', '权限设置', '', '', '1000'), ('143', '142', 'Admin', 'Rbac', 'authorize_post', '', '1', '0', '提交设置', '', '', '0'), ('144', '140', 'Admin', 'Rbac', 'roleedit', '', '1', '0', '编辑角色', '', '', '1000'), ('145', '144', 'Admin', 'Rbac', 'roleedit_post', '', '1', '0', '提交编辑', '', '', '0'), ('146', '140', 'Admin', 'Rbac', 'roledelete', '', '1', '1', '删除角色', '', '', '1000'), ('147', '140', 'Admin', 'Rbac', 'roleadd', '', '1', '1', '添加角色', '', '', '1000'), ('148', '147', 'Admin', 'Rbac', 'roleadd_post', '', '1', '0', '提交添加', '', '', '0'), ('149', '139', 'Admin', 'User', 'index', '', '1', '1', '管理员', '', '', '0'), ('150', '149', 'Admin', 'User', 'delete', '', '1', '0', '删除管理员', '', '', '1000'), ('151', '149', 'Admin', 'User', 'edit', '', '1', '0', '管理员编辑', '', '', '1000'), ('152', '151', 'Admin', 'User', 'edit_post', '', '1', '0', '编辑提交', '', '', '0'), ('153', '149', 'Admin', 'User', 'add', '', '1', '0', '管理员添加', '', '', '1000'), ('154', '153', 'Admin', 'User', 'add_post', '', '1', '0', '添加提交', '', '', '0'), ('155', '47', 'Admin', 'Plugin', 'update', '', '1', '0', '插件更新', '', '', '0'), ('156', '39', 'Admin', 'Storage', 'index', '', '1', '1', '文件存储', '', '', '0'), ('157', '156', 'Admin', 'Storage', 'setting_post', '', '1', '0', '文件存储设置提交', '', '', '0');
COMMIT;

-- ----------------------------
--  Table structure for `sp_nav`
-- ----------------------------
DROP TABLE IF EXISTS `sp_nav`;
CREATE TABLE `sp_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `parentid` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `target` varchar(50) DEFAULT NULL,
  `href` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  `listorder` int(6) DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_nav`
-- ----------------------------
BEGIN;
INSERT INTO `sp_nav` VALUES ('1', '1', '0', '首页', '', 'home', '', '1', '0', '0-1'), ('2', '1', '0', '列表演示', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"1\";}}', '', '1', '0', '0-2'), ('3', '1', '0', '瀑布流', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"2\";}}', '', '1', '0', '0-3'), ('5', '1', '4', 'dddd', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"2\";}}', '', '1', '0', '0-2-4-5');
COMMIT;

-- ----------------------------
--  Table structure for `sp_nav_cat`
-- ----------------------------
DROP TABLE IF EXISTS `sp_nav_cat`;
CREATE TABLE `sp_nav_cat` (
  `navcid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` int(1) NOT NULL DEFAULT '1',
  `remark` text,
  PRIMARY KEY (`navcid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_nav_cat`
-- ----------------------------
BEGIN;
INSERT INTO `sp_nav_cat` VALUES ('1', '主导航', '1', '主导航');
COMMIT;

-- ----------------------------
--  Table structure for `sp_oauth_user`
-- ----------------------------
DROP TABLE IF EXISTS `sp_oauth_user`;
CREATE TABLE `sp_oauth_user` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `from` varchar(20) NOT NULL COMMENT '用户来源key',
  `name` varchar(30) NOT NULL COMMENT '第三方昵称',
  `head_img` varchar(200) NOT NULL COMMENT '头像',
  `uid` int(20) NOT NULL COMMENT '关联的本站用户id',
  `create_time` datetime NOT NULL COMMENT '绑定时间',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(16) NOT NULL COMMENT '最后登录ip',
  `login_times` int(6) NOT NULL COMMENT '登录次数',
  `status` tinyint(2) NOT NULL,
  `access_token` varchar(60) NOT NULL,
  `expires_date` int(12) NOT NULL COMMENT 'access_token过期时间',
  `openid` varchar(40) NOT NULL COMMENT '第三方用户id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sp_options`
-- ----------------------------
DROP TABLE IF EXISTS `sp_options`;
CREATE TABLE `sp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_options`
-- ----------------------------
BEGIN;
INSERT INTO `sp_options` VALUES ('1', 'member_email_active', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1'), ('2', 'site_options', '{\"site_name\":\"\\u4e00\\u7c73\\u9633\\u5149\\u3002\",\"site_host\":\"http:\\/\\/127.0.0.1\\/cmf\\/\",\"site_root\":\"\\/\",\"site_tpl\":\"simplebootx\",\"site_adminstyle\":\"flat\",\"site_icp\":\"\",\"site_admin_email\":\"admin@qq.com\",\"site_tongji\":\"\",\"site_copyright\":\"\",\"site_seo_title\":\"\\u4e00\\u7c73\\u9633\\u5149\\u3002\",\"site_seo_keywords\":\"\",\"site_seo_description\":\"all\",\"urlmode\":\"0\",\"html_suffix\":\"\",\"comment_time_interval\":60}', '1'), ('3', 'cmf_settings', '{\"banned_usernames\":\"\"}', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sp_plugins`
-- ----------------------------
DROP TABLE IF EXISTS `sp_plugins`;
CREATE TABLE `sp_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) NOT NULL COMMENT '插件名，英文',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '插件名称',
  `description` text COMMENT '插件描述',
  `type` tinyint(2) DEFAULT '0' COMMENT '插件类型, 1:网站；8;微信',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态；1开启；',
  `config` text COMMENT '插件配置',
  `hooks` varchar(255) DEFAULT NULL COMMENT '实现的钩子;以“，”分隔',
  `has_admin` tinyint(2) DEFAULT '0' COMMENT '插件是否有后台管理界面',
  `author` varchar(50) DEFAULT '' COMMENT '插件作者',
  `version` varchar(20) DEFAULT '' COMMENT '插件版本号',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `listorder` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
--  Records of `sp_plugins`
-- ----------------------------
BEGIN;
INSERT INTO `sp_plugins` VALUES ('1', 'Snow', '圣诞雪花', '圣诞雪花特效', '0', '1', '{\"snow\":\"\\u2744\"}', 'footer_end', '0', 'ThinkCMF', '1.0', '0', '0'), ('2', 'Demo', '插件演示', '插件演示', '0', '1', '{\"text\":\"hello,ThinkCMF!\",\"password\":\"\",\"select\":\"1\",\"checkbox\":1,\"radio\":\"1\",\"textarea\":\"\\u8fd9\\u91cc\\u662f\\u4f60\\u8981\\u586b\\u5199\\u7684\\u5185\\u5bb9\"}', 'footer', '1', 'ThinkCMF', '1.0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `sp_posts`
-- ----------------------------
DROP TABLE IF EXISTS `sp_posts`;
CREATE TABLE `sp_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned DEFAULT '0' COMMENT '发表者id',
  `post_keywords` varchar(150) NOT NULL COMMENT 'seo keywords',
  `post_date` datetime DEFAULT '0000-00-00 00:00:00' COMMENT 'post创建日期，永久不变，一般不显示给用户',
  `post_content` longtext COMMENT 'post内容',
  `post_title` text COMMENT 'post标题',
  `post_excerpt` text COMMENT 'post摘要',
  `post_status` int(2) DEFAULT '1' COMMENT 'post状态，1已审核，0未审核',
  `comment_status` int(2) DEFAULT '1' COMMENT '评论状态，1允许，0不允许',
  `post_modified` datetime DEFAULT '0000-00-00 00:00:00' COMMENT 'post更新时间，可在前台修改，显示给用户',
  `post_content_filtered` longtext,
  `post_parent` bigint(20) unsigned DEFAULT '0' COMMENT 'post的父级post id,表示post层级关系',
  `post_type` int(2) DEFAULT NULL,
  `post_mime_type` varchar(100) DEFAULT '',
  `comment_count` bigint(20) DEFAULT '0',
  `smeta` text COMMENT 'post的扩展字段，保存相关扩展属性，如缩略图；格式为json',
  `post_hits` int(11) DEFAULT '0' COMMENT 'post点击数，查看数',
  `post_like` int(11) DEFAULT '0' COMMENT 'post赞数',
  `istop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶 1置顶； 0不置顶',
  `recommended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐 1推荐 0不推荐',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`id`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `post_date` (`post_date`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_posts`
-- ----------------------------
BEGIN;
INSERT INTO `sp_posts` VALUES ('1', '1', '', '2015-04-05 16:59:37', '<p>事实上</p>', '测试', '测试', '1', '1', '2015-04-05 16:59:28', null, '0', null, '', '0', '{\"thumb\":\"\"}', '29', '0', '0', '0'), ('2', '1', '222', '2015-04-06 12:26:39', '<p>222222</p>', '2222', '222', '1', '1', '2015-04-06 12:26:31', null, '0', null, '', '0', '{\"thumb\":\"\"}', '2', '0', '0', '0'), ('3', '1', '3333', '2015-04-06 12:26:45', '<p>3333</p>', '3333', '3333', '1', '1', '2015-04-06 12:26:40', null, '0', null, '', '0', '{\"thumb\":\"\"}', '2', '0', '0', '0'), ('4', '1', '4444', '2015-04-06 12:26:52', '<p>4444</p>', '4444', '44444', '1', '1', '2015-04-06 12:26:47', null, '0', null, '', '0', '{\"thumb\":\"\"}', '4', '1', '0', '0'), ('5', '1', '55555', '2015-04-06 12:26:59', '<p>5555</p>', '55555', '5555', '1', '1', '2015-04-06 12:26:53', null, '0', null, '', '32', '{\"thumb\":\"\"}', '5', '1', '0', '0'), ('6', '1', '66666', '2015-04-06 12:27:10', '<p>66666666</p>', '66666', '66666', '1', '1', '2015-04-06 12:27:00', null, '0', null, '', '2', '{\"thumb\":\"\"}', '29', '2', '0', '0'), ('7', '1', ' 测试1', '2015-04-14 21:20:51', '<p>&nbsp;测试1</p>', ' 测试1', ' 测试1', '1', '1', '2015-04-14 21:20:32', null, '0', null, '', '0', '{\"thumb\":\"\"}', '1', '0', '0', '0'), ('8', '1', ' 测试2', '2015-04-14 21:21:04', '<p>&nbsp;测试2</p>', ' 测试2', ' 测试2', '1', '1', '2015-04-14 21:20:52', null, '0', null, '', '0', '{\"thumb\":\"552d17a68c997.jpg\"}', '0', '0', '0', '0'), ('9', '1', ' 测试3', '2015-04-14 21:21:47', '<p>&nbsp;测试3</p>', ' 测试3', ' 测试3', '1', '1', '2015-04-14 21:21:05', null, '0', null, '', '0', '{\"thumb\":\"552d179ada74a.jpg\"}', '0', '0', '0', '0'), ('10', '1', ' 测试4', '2015-04-14 21:21:57', '<p>&nbsp;测试4</p>', ' 测试4', ' 测试4', '1', '1', '2015-04-14 21:21:48', null, '0', null, '', '0', '{\"thumb\":\"552d178d42502.jpg\"}', '0', '0', '0', '0'), ('11', '1', '魅族 阿里', '2015-04-14 21:22:11', '<p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"word-wrap: break-word; line-height: 1.8em;\"><strong style=\"word-wrap: break-word;\"><span style=\"color: rgb(128, 0, 0); word-wrap: break-word;\">干货1：Flyme powered by YunOS，Flyme的操作界面不变，但向右滑增加了YunOS特有的卡片式应用</span></strong></span></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">此前魅族副总裁李楠在向虎嗅君剧透时介绍，在经过一番博弈之后，不会再有纯粹搭载YunOS 3.0的MX 4，而是YunOS底层加一层Flyme。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">在今天的发布会上，这样的合作方式有了官方表述：“Flyme powered by YunOS”。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">这次发布会确定的第一件事：Flyme powered by YunOS的交互操作与此前基于android的Flyme并无不同。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">魅族的粉丝应该可以松口气了。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">但另一方面，YunOS也没有甘当底层，在昨天YunOS 3.0发布会上被重点介绍的“卡片式应用”也被引入了Flyme powered by YunOS。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">向右滑动，最左一屏，就是YunOS 3.0最看重的卡片应用。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\"><strong style=\"word-wrap: break-word;\"><span style=\"color: rgb(128, 0, 0); word-wrap: break-word;\">干货2：<span style=\"word-wrap: break-word; line-height: 25.2000007629395px;\">Flyme powered by YunOS还能刷回基于android的Flyme</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"word-wrap: break-word; line-height: 25.2000007629395px;\">Flyme powered by YunOS还能刷回基于android的Flyme吗？</span></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"word-wrap: break-word; line-height: 25.2000007629395px;\"><br style=\"word-wrap: break-word;\"/></span></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">双方在发布会上也没有交代这一点。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">但会后李楠告诉虎嗅君：可以。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\"><strong style=\"word-wrap: break-word;\"><span style=\"color: rgb(128, 0, 0); word-wrap: break-word;\">干货3：反击小米模式，魅族借助阿里提供的可分享移动互联网入口</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">小米似乎成了国产手机绕不开的一个存在。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">这次魅族似乎也不准备再绕了：此前MX 4发布会上，小米尚且被戏称为“友商”，而在这次发布会上，魅族已经直言不讳，要联合阿里反击“小米模式”。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">李楠在发布会上回顾了互联网手机的经典套路：流量——渠道——手机——系统（又产生导流）——增值收入。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; word-wrap: break-word; background-color: rgb(255, 255, 255);\"><a href=\"http://img.huxiu.com/portal/201410/21/191906vvzisvrvbrwzars9.jpg\" target=\"_blank\" style=\"color: rgb(0, 136, 204); text-decoration: none; word-wrap: break-word;\"><img src=\"http://localhost/cmf/data/upload/ueditor/20150414/552d1e23264b5.jpg\" data-bd-imgshare-binded=\"1\" style=\"height: auto !important; max-width: 537px; vertical-align: middle; border: 0px; word-wrap: break-word;\"/></a></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; word-wrap: break-word; background-color: rgb(255, 255, 255);\"><span style=\"word-wrap: break-word; line-height: 1.8em;\">但能完成这个经典套路的似乎只有小米，小米已经建立起了自成一体的完整闭环，自己占据了这个闭环上的几乎全部利润。</span></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">这次魅族和阿里的合作，可以看成阿里提供了流量和渠道，魅族解决了手机，而魅族和阿里又合力开发了系统，共同完成了这个互联网手机的经典模式。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">其他的手机厂商也可以像魅族一样，与阿里合作，借助阿里提供的流量和渠道，完成互联网手机的经典闭环。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">至于系统导流的流量分成问题，李楠称魅族还在与阿里协商。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\"><strong style=\"word-wrap: break-word;\"><span style=\"color: rgb(128, 0, 0); word-wrap: break-word;\">悬念1：Flyme账户与阿里账户最终会打通吗？</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">虎嗅君上次问过李楠这个问题，他当时的答复是：“账号的事情21号说”。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">但这次发布会上，对魅族和阿里对打通账户一事，双方并没有特别说明。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">会后李楠在接受虎嗅君采访时说介绍，目前的Flyme powered by YunOS是个融合版系统，用户在系统中使用Flyme服务的时候，应登录Flyme账户，在使用阿里服务的时候，应登录阿里的账户。<span style=\"word-wrap: break-word; line-height: 1.8em;\">至于两家的账户会不会最终打通，李楠的回应是：“</span>阿里涉及支付，难度比较大，但不是不可能<span style=\"word-wrap: break-word; line-height: 1.8em;\">”。</span></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"word-wrap: break-word; line-height: 1.8em;\"><strong style=\"word-wrap: break-word;\"><span style=\"color: rgb(128, 0, 0); word-wrap: break-word;\">悬念2：阿里到底有没有注资魅族？</span></strong></span></p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">这是最大的悬念，在场的、不在场的，都想知道一个明确的答案。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">这也是最容易解决的悬念，一句话就够了。</p><p style=\"margin-top: 0px; margin-bottom: 10px; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; white-space: normal; background-color: rgb(255, 255, 255);\">但发布会上，<strong style=\"word-wrap: break-word;\">双方对资本运作一事，只字未提</strong>。</p><p><br/></p>', '魅族阿里战略发布会，3点干货和两个悬念', '众人期待的阿里魅族战略发布会刚刚结束，虎嗅君当然也在现场。\r\n\r\n现在，虎嗅君决定抛开情怀和故事，也把看不见、摸不着的参数、安全暂且放在一边。\r\n\r\n让我们先来看看此次发布会上的公布3点干货，还有留存的两个悬念。', '1', '1', '2015-04-14 21:21:58', null, '0', null, '', '0', '{\"thumb\":\"http:\\/\\/demo.thinkcmfx.com\\/data\\/upload\\/ueditor\\/201410220923295447071152e07.jpg\"}', '2', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `sp_route`
-- ----------------------------
DROP TABLE IF EXISTS `sp_route`;
CREATE TABLE `sp_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `full_url` varchar(255) DEFAULT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `url` varchar(255) DEFAULT NULL COMMENT '实际显示的url',
  `listorder` int(5) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sp_slide`
-- ----------------------------
DROP TABLE IF EXISTS `sp_slide`;
CREATE TABLE `sp_slide` (
  `slide_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slide_cid` bigint(20) NOT NULL,
  `slide_name` varchar(255) NOT NULL,
  `slide_pic` varchar(255) DEFAULT NULL,
  `slide_url` varchar(255) DEFAULT NULL,
  `slide_des` varchar(255) DEFAULT NULL,
  `slide_content` text,
  `slide_status` int(2) NOT NULL DEFAULT '1',
  `listorder` int(10) DEFAULT '0',
  PRIMARY KEY (`slide_id`),
  KEY `slide_cid` (`slide_cid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sp_slide_cat`
-- ----------------------------
DROP TABLE IF EXISTS `sp_slide_cat`;
CREATE TABLE `sp_slide_cat` (
  `cid` bigint(20) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(255) NOT NULL,
  `cat_idname` varchar(255) NOT NULL,
  `cat_remark` text,
  `cat_status` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cid`),
  KEY `cat_idname` (`cat_idname`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_slide_cat`
-- ----------------------------
BEGIN;
INSERT INTO `sp_slide_cat` VALUES ('1', '首页', 'portal_index', '', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sp_term_relationships`
-- ----------------------------
DROP TABLE IF EXISTS `sp_term_relationships`;
CREATE TABLE `sp_term_relationships` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`tid`),
  KEY `term_taxonomy_id` (`term_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_term_relationships`
-- ----------------------------
BEGIN;
INSERT INTO `sp_term_relationships` VALUES ('1', '1', '2', '0', '1'), ('2', '2', '2', '0', '1'), ('3', '3', '2', '0', '1'), ('4', '4', '2', '0', '1'), ('5', '5', '2', '0', '1'), ('6', '6', '2', '0', '1'), ('7', '7', '2', '0', '1'), ('8', '8', '2', '0', '1'), ('9', '9', '2', '0', '1'), ('10', '10', '2', '0', '1'), ('11', '11', '2', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sp_terms`
-- ----------------------------
DROP TABLE IF EXISTS `sp_terms`;
CREATE TABLE `sp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
  `slug` varchar(200) DEFAULT '',
  `taxonomy` varchar(32) DEFAULT NULL COMMENT '分类类型',
  `description` longtext COMMENT '分类描述',
  `parent` bigint(20) unsigned DEFAULT '0' COMMENT '分类父id',
  `count` bigint(20) DEFAULT '0' COMMENT '分类文章数',
  `path` varchar(500) DEFAULT NULL COMMENT '分类层级关系路径',
  `seo_title` varchar(500) DEFAULT NULL,
  `seo_keywords` varchar(500) DEFAULT NULL,
  `seo_description` varchar(500) DEFAULT NULL,
  `list_tpl` varchar(50) DEFAULT NULL COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT NULL COMMENT '分类文章页模板',
  `listorder` int(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`term_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_terms`
-- ----------------------------
BEGIN;
INSERT INTO `sp_terms` VALUES ('1', '列表演示', '', 'article', '', '0', '0', '0-1', '', '', '', 'list', 'article', '0', '1'), ('2', '瀑布流', '', 'article', '', '0', '0', '0-2', '', '', '', 'list_masonry', 'article', '0', '1'), ('3', 'ces', '', 'article', '', '1', '0', '0-1-3', '', '', '', 'list', 'article', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sp_user_favorites`
-- ----------------------------
DROP TABLE IF EXISTS `sp_user_favorites`;
CREATE TABLE `sp_user_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '收藏内容的标题',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) DEFAULT NULL COMMENT '收藏内容的描述',
  `table` varchar(50) DEFAULT NULL COMMENT '收藏实体以前所在表，不带前缀',
  `object_id` int(11) DEFAULT NULL COMMENT '收藏内容原来的主键id',
  `createtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_user_favorites`
-- ----------------------------
BEGIN;
INSERT INTO `sp_user_favorites` VALUES ('1', '1', '测试', '/cmf/index.php?g=portal&amp;m=article&amp;a=index&amp;id=1', null, 'posts', '1', '1428291901'), ('2', '1', '66666', '/cmf/index.php?g=portal&amp;m=article&amp;a=index&amp;id=6', null, 'posts', '6', '1428306944'), ('3', '6', '55555', '/tptest/index.php?m=Home&amp;c=Post&amp;a=view&amp;id=5', null, 'posts', '5', '1428929433'), ('4', '1', ' 测试6', '/tptest/index.php?m=Home&amp;c=Post&amp;a=view&amp;id=11', null, 'posts', '11', '1429019976');
COMMIT;

-- ----------------------------
--  Table structure for `sp_users`
-- ----------------------------
DROP TABLE IF EXISTS `sp_users`;
CREATE TABLE `sp_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `user_nicename` varchar(50) NOT NULL DEFAULT '' COMMENT '用户美名',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网站',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像，相对于upload/avatar目录',
  `sex` smallint(1) DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `signature` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `last_login_ip` varchar(16) NOT NULL COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后登录时间',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '注册时间',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `user_status` int(11) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `user_type` smallint(1) DEFAULT '1' COMMENT '用户类型，1:admin ;2:会员',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sp_users`
-- ----------------------------
BEGIN;
INSERT INTO `sp_users` VALUES ('1', 'admin', 'c535018ee946e10adc3949ba59abbe56e057f20f883e89af', 'admin', 'admin@qq.com', '', null, '0', null, null, '0.0.0.0', '2015-04-20 20:49:01', '2015-04-04 09:52:07', '', '1', '0', '1'), ('6', 'admin22', 'c535018ee946e10adc3949ba59abbe56e057f20f883e89af', 'admin22', '308243528@qq.com', '', null, '0', null, null, '0.0.0.0', '2015-04-13 20:39:05', '2015-04-07 21:33:14', '', '1', '0', '2');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
