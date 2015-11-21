/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50620
 Source Host           : 127.0.0.1
 Source Database       : system-manage

 Target Server Type    : MySQL
 Target Server Version : 50620
 File Encoding         : utf-8

 Date: 02/07/2015 06:42:05 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `acc_role`
-- ----------------------------
DROP TABLE IF EXISTS `acc_role`;
CREATE TABLE `acc_role` (
  `acc_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`acc_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `acc_role`
-- ----------------------------
BEGIN;
INSERT INTO `acc_role` VALUES ('1', '1'), ('1', '2'), ('1', '3'), ('33', '3'), ('34', '2'), ('34', '3'), ('35', '3'), ('37', '1'), ('37', '2'), ('37', '3'), ('40', '3');
COMMIT;

-- ----------------------------
--  Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `accountName` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `accountType` varchar(20) DEFAULT NULL,
  `description` varchar(20) DEFAULT NULL,
  `state` varchar(3) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deletestatus` int(1) DEFAULT '0' COMMENT '逻辑删除状态0:存在1:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `account`
-- ----------------------------
BEGIN;
INSERT INTO `account` VALUES ('1', 'root', 'Y6nw6nu5gFB5a2SehUgYRQ==', '0', '根账号', '1', '2014-04-15 16:17:03', '0'), ('33', '00', 'KcPuo/MF1rgj9WKsS+NSFw==', null, '00', '1', '2014-04-15 16:41:57', '0'), ('34', 'test', '4QrcOUm6Wau+VuBX8g+IPg==', null, 'test', '1', '2014-04-16 11:42:41', '0'), ('35', 'hujihong', 'GvQFzpVbQgE6qjlXRWUxgg==', null, 'hujihong', '1', '2015-02-07 03:44:39', '0');
COMMIT;

-- ----------------------------
--  Table structure for `dic`
-- ----------------------------
DROP TABLE IF EXISTS `dic`;
CREATE TABLE `dic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dicTypeId` int(11) DEFAULT NULL,
  `dicKey` varchar(20) DEFAULT NULL,
  `dicName` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `dic`
-- ----------------------------
BEGIN;
INSERT INTO `dic` VALUES ('1', '1', 'res_directory', '目录', '目录'), ('2', '1', 'res_menu', '菜单', '菜单'), ('3', '1', 'res_btn', '按扭', '按扭');
COMMIT;

-- ----------------------------
--  Table structure for `dic_type`
-- ----------------------------
DROP TABLE IF EXISTS `dic_type`;
CREATE TABLE `dic_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dicTypeKey` varchar(20) DEFAULT NULL,
  `dicTypeName` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `dic_type`
-- ----------------------------
BEGIN;
INSERT INTO `dic_type` VALUES ('1', 'res_type', '菜单类型', '菜单类型是目录,菜单,按扭,'), ('2', '2', '2', '2');
COMMIT;

-- ----------------------------
--  Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `module` varchar(30) DEFAULT NULL,
  `action` varchar(30) DEFAULT NULL,
  `actionTime` varchar(30) DEFAULT NULL,
  `userIP` varchar(30) DEFAULT NULL,
  `operTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2780 DEFAULT CHARSET=utf8;


-- ----------------------------
--  Table structure for `ly_role`
-- ----------------------------
DROP TABLE IF EXISTS `ly_role`;
CREATE TABLE `ly_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `enable` int(10) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `roleKey` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `ly_role`
-- ----------------------------
BEGIN;
INSERT INTO `ly_role` VALUES ('1', '1', '根账号', 'root', '拥有所有权限1'), ('2', '1', '管理员', 'admin', '管理系统权限'), ('3', '1', '普通角色', 'simple', '普通角色');
COMMIT;

-- ----------------------------
--  Table structure for `res_roles`
-- ----------------------------
DROP TABLE IF EXISTS `res_roles`;
CREATE TABLE `res_roles` (
  `role_id` int(11) NOT NULL,
  `resc_id` int(11) NOT NULL,
  PRIMARY KEY (`resc_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `res_roles`
-- ----------------------------
BEGIN;
INSERT INTO `res_roles` VALUES ('1', '1'), ('4', '7'), ('4', '8'), ('4', '10'), ('4', '12'), ('4', '13'), ('4', '14'), ('4', '15'), ('4', '16'), ('4', '17'), ('4', '18'), ('4', '19'), ('4', '20'), ('4', '31'), ('4', '32'), ('4', '33'), ('4', '34'), ('3', '35'), ('4', '35'), ('3', '36'), ('4', '36'), ('3', '37'), ('4', '37'), ('3', '38');
COMMIT;

-- ----------------------------
--  Table structure for `resources`
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `resKey` varchar(50) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `resUrl` varchar(200) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `resources`
-- ----------------------------
BEGIN;
INSERT INTO `resources` VALUES ('1', '系统基础管理', '0', 'system', '0', 'system', '0', '系统基础管理'), ('2', '账号管理', '1', 'account', '1', '/background/account/list.html', '1', '账号管理'), ('3', '角色管理', '1', 'role', '1', '/background/role/list.html', '5', '角色管理'), ('4', '菜单管理', '1', 'resources', '1', '/background/resources/list.html', '10', '菜单查询'), ('5', '新增账号', '2', 'account_add', '2', '/background/account/addUI.html', '2', '新增账号'), ('6', '修改账号', '2', 'account_edit', '2', '/background/account/editUI.html', '3', '修改账号'), ('7', '删除账号', '2', 'account_delete', '2', '/background/account/deleteById.html', '4', '删除账号'), ('8', '新增角色', '3', 'role_add', '2', '/background/role/addUI.html', '6', '部门/科组的新增'), ('9', '修改角色', '3', 'role_edit', '2', '/background/role/editUI.html', '7', '部门/科组的修改'), ('10', '删除角色', '3', 'role_delete', '2', '/background/role/delete.html', '8', '部门/科组的删除'), ('11', '角色授权', '3', 'role_perss', '2', '/background/menu/permissions.html', '9', '菜单授权'), ('12', '数据字典管理', '0', 'dic_manager', '0', 'dic_manager', '22', '数据字典管理'), ('13', '字典类型', '12', 'dic_type', '1', '/background/dicType/list.html', '26', '字典类型'), ('14', '字典维护', '12', 'dic', '1', '/background/dic/list.html', '23', '字典维护'), ('16', '修改字典', '14', 'dic_edit', '2', '/background/dic/editUI.html', '24', '修改字典'), ('17', '删除字典', '14', 'dic_delete', '2', '/background/dic/delete.html', '25', '删除字典'), ('18', '新增字典类型', '13', 'dicType_add', '2', '/background/dicType/addUI.html', '27', '新增字典类型'), ('19', '修改字典类型', '13', 'dicType_edit', '2', '/background/dicType/editUI.html', '28', '修改字典类型'), ('20', '删除字典类型', '13', 'dicType_delete', '2', '/background/dicType/delete.html', '29', '删除字典类型'), ('31', '服务器配置管理', '0', 'server', '0', 'server', '14', '服务器配置管理'), ('32', '预警设置', '31', 'ser_warn', '1', '/background/serverInfo/forecast.html', '15', '预警设置'), ('33', '状态列表', '31', 'ser_list', '1', '/background/serverInfo/list.html', '16', '状态列表'), ('34', '服务器状态', '31', 'ser_statu', '1', '/background/serverInfo/show.html', '17', '服务器状态'), ('35', '登陆信息管理', '0', 'login', '0', 'login', '18', '登陆信息管理'), ('36', '用户登录记录', '35', 'log_list', '1', '/background/userLoginList/query.html', '19', '用户登录记录'), ('37', '操作日志管理', '0', 'log', '0', 'log', '20', '操作日志管理'), ('38', '日志查询', '37', 'log', '1', '/background/log/list.html', '21', '日志查询'), ('39', '新增菜单资源', '4', 'resources_add', '2', '/background/resources/addUI.html', '11', '新增菜单资源'), ('40', '修改菜单资源', '4', 'resources_edit', '2', '/background/resources/editUI.html', '12', '修改菜单资源'), ('41', '删除菜单资源', '4', 'resources_delete', '2', '/background/resources/delete.html', '13', '删除菜单资源');
COMMIT;

-- ----------------------------
--  Table structure for `server_info`
-- ----------------------------
DROP TABLE IF EXISTS `server_info`;
CREATE TABLE `server_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cpuUsage` varchar(255) DEFAULT NULL,
  `setCpuUsage` varchar(255) DEFAULT NULL,
  `jvmUsage` varchar(255) DEFAULT NULL,
  `setJvmUsage` varchar(255) DEFAULT NULL,
  `ramUsage` varchar(255) DEFAULT NULL,
  `setRamUsage` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `operTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `mark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;


-- ----------------------------
--  Table structure for `userloginlist`
-- ----------------------------
DROP TABLE IF EXISTS `userloginlist`;
CREATE TABLE `userloginlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `loginTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `loginIP` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_userloginlist` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8;


SET FOREIGN_KEY_CHECKS = 1;
