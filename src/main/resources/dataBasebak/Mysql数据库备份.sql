/*
Navicat MySQL Data Transfer

Source Server         : 120.76.137.88
Source Server Version : 50173
Source Host           : 120.76.137.88:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-01-10 16:30:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(128) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` int(2) DEFAULT NULL COMMENT '1:菜单组  2:菜单项',
  `permission` varchar(128) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `parent_id` varchar(128) DEFAULT NULL,
  `menu_order` int(3) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '1', null, null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('ccdb2a78-d2b0-4f2d-9a5a-3255c5fb0c7f', '权限管理', '2', '6', '/sys/permission', '1', '3', '');
INSERT INTO `sys_menu` VALUES ('3957d919-4c36-443a-865f-a7c96da1ebea', '角色管理', '2', '3407a0df-088a-46d3-b7b9-0f4aae363e13', '/sys/role', '1', '2', '1234');
INSERT INTO `sys_menu` VALUES ('66ccf32c-0619-4cbb-b7aa-2e22e5726e5b', '用户管理', '2', '3', '/sys/user', '1', '1', '');
INSERT INTO `sys_menu` VALUES ('0', '项目', '0', 'sys:menu', null, null, null, null);
INSERT INTO `sys_menu` VALUES ('60b2a3c7-d33c-4c52-b8d6-46676d7fcfd9', '菜单管理', '2', '3ca98c84-f557-43f2-8fc3-bfb9703b4dc1', '/sys/menu', '1', '4', '');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` varchar(128) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `parent_id` varchar(128) DEFAULT NULL,
  `is_delete` varchar(2) DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `code` varchar(200) DEFAULT NULL,
  `type` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('c199ca13-b325-4b25-bede-efee2514ac22', '角色删除', '', '3407a0df-088a-46d3-b7b9-0f4aae363e13', null, '', 'role:del', '3');
INSERT INTO `sys_permission` VALUES ('1', '用户数据查询', null, '3', null, null, 'user:query', '3');
INSERT INTO `sys_permission` VALUES ('60ec28a9-7d51-43d4-86c6-2efd776b6ddd', '角色新增', '', '3407a0df-088a-46d3-b7b9-0f4aae363e13', null, '', 'role:add', '3');
INSERT INTO `sys_permission` VALUES ('8', '权限更新', null, '6', null, null, 'permission:update', '3');
INSERT INTO `sys_permission` VALUES ('cc52480a-405f-4483-b4c3-b73ea2e72d32', '角色更新', '', '3407a0df-088a-46d3-b7b9-0f4aae363e13', null, '', 'role:update', '3');
INSERT INTO `sys_permission` VALUES ('2', '系统管理', '', '0', null, '', 'sys:mp', '2');
INSERT INTO `sys_permission` VALUES ('6', '权限管理', '/sys/permission', '2', null, '', 'sys:pmp', '2');
INSERT INTO `sys_permission` VALUES ('4', '用户删除', null, '3', null, null, 'user:del', '3');
INSERT INTO `sys_permission` VALUES ('5', '用户更新', null, '3', null, null, 'user:update', '3');
INSERT INTO `sys_permission` VALUES ('3407a0df-088a-46d3-b7b9-0f4aae363e13', '角色管理', '/sys/role', '2', null, '', 'sysmgp:role', '2');
INSERT INTO `sys_permission` VALUES ('0', '项目名称', '', '', null, '', 'sys:sysmgp', '1');
INSERT INTO `sys_permission` VALUES ('3', '用户管理', '/sys/user', '2', null, '', 'sys:usermgp', '2');
INSERT INTO `sys_permission` VALUES ('7', '权限新增', null, '6', null, null, 'permission:add', '3');
INSERT INTO `sys_permission` VALUES ('17b8c11c-da09-46e3-ace1-f3a3fb87c0ca', '用户新增', '', '3', null, '', 'user:add', '3');
INSERT INTO `sys_permission` VALUES ('0115bb96-c0bb-4538-a0fa-723317913991', '菜单新建', '/sys/menu/add', '3ca98c84-f557-43f2-8fc3-bfb9703b4dc1', null, '', 'sysmenu:add', '3');
INSERT INTO `sys_permission` VALUES ('3ca98c84-f557-43f2-8fc3-bfb9703b4dc1', '菜单管理', '/sys/menu', '2', null, '', 'sys:menu', '2');
INSERT INTO `sys_permission` VALUES ('62a7bea1-40c8-4b91-9f80-5bf5b8f6d3df', '菜单删除', '/sys/menu/delete', '3ca98c84-f557-43f2-8fc3-bfb9703b4dc1', null, '', 'sysmenu:del', '3');
INSERT INTO `sys_permission` VALUES ('7445e521-dfef-4aa4-aeb1-d0ff472dbad8', '菜单更新', '/sys/menu/update', '3ca98c84-f557-43f2-8fc3-bfb9703b4dc1', null, '', 'sysmenu:update', '3');
INSERT INTO `sys_permission` VALUES ('f640c6cd-f97f-48ee-a46e-a43a5bf77070', '权限删除', '/sys/permission/delete', '6', null, '', 'permission:del', '3');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(128) NOT NULL,
  `rolename` varchar(45) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'sys', '系统管理员权限(用户/角色/权限 的维护)');
INSERT INTO `sys_role` VALUES ('4d857666-8669-4902-a4c6-3e73d1b46161', 'menu_role', '菜单维护');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `permission_id` varchar(128) DEFAULT NULL,
  `role_id` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('2', '1');
INSERT INTO `sys_role_permission` VALUES ('3ca98c84-f557-43f2-8fc3-bfb9703b4dc1', '1');
INSERT INTO `sys_role_permission` VALUES ('0115bb96-c0bb-4538-a0fa-723317913991', '1');
INSERT INTO `sys_role_permission` VALUES ('62a7bea1-40c8-4b91-9f80-5bf5b8f6d3df', '1');
INSERT INTO `sys_role_permission` VALUES ('7445e521-dfef-4aa4-aeb1-d0ff472dbad8', '1');
INSERT INTO `sys_role_permission` VALUES ('6', '1');
INSERT INTO `sys_role_permission` VALUES ('7', '1');
INSERT INTO `sys_role_permission` VALUES ('8', '1');
INSERT INTO `sys_role_permission` VALUES ('3', '1');
INSERT INTO `sys_role_permission` VALUES ('17b8c11c-da09-46e3-ace1-f3a3fb87c0ca', '1');
INSERT INTO `sys_role_permission` VALUES ('4', '1');
INSERT INTO `sys_role_permission` VALUES ('1', '1');
INSERT INTO `sys_role_permission` VALUES ('5', '1');
INSERT INTO `sys_role_permission` VALUES ('3407a0df-088a-46d3-b7b9-0f4aae363e13', '1');
INSERT INTO `sys_role_permission` VALUES ('60ec28a9-7d51-43d4-86c6-2efd776b6ddd', '1');
INSERT INTO `sys_role_permission` VALUES ('c199ca13-b325-4b25-bede-efee2514ac22', '1');
INSERT INTO `sys_role_permission` VALUES ('cc52480a-405f-4483-b4c3-b73ea2e72d32', '1');
INSERT INTO `sys_role_permission` VALUES ('2', '4d857666-8669-4902-a4c6-3e73d1b46161');
INSERT INTO `sys_role_permission` VALUES ('3ca98c84-f557-43f2-8fc3-bfb9703b4dc1', '4d857666-8669-4902-a4c6-3e73d1b46161');
INSERT INTO `sys_role_permission` VALUES ('0115bb96-c0bb-4538-a0fa-723317913991', '4d857666-8669-4902-a4c6-3e73d1b46161');
INSERT INTO `sys_role_permission` VALUES ('62a7bea1-40c8-4b91-9f80-5bf5b8f6d3df', '4d857666-8669-4902-a4c6-3e73d1b46161');
INSERT INTO `sys_role_permission` VALUES ('7445e521-dfef-4aa4-aeb1-d0ff472dbad8', '4d857666-8669-4902-a4c6-3e73d1b46161');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(128) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `salt` varchar(16) DEFAULT NULL,
  `loginname` varchar(255) DEFAULT NULL,
  `dept` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '超级管理员', '74682ec506b25cadf1da4fcd37ec7cf227d5919d', '6042ef4277a7c58f', 'admin', null, '');
INSERT INTO `sys_user` VALUES ('7623fb2f-7d3f-4430-b34d-5153237e0999', '我只能维护菜单', '1a60d428e5c81b50d1b56bf7d78831fbaa69d206', 'a2646f1849c6c18d', 'test1', null, '');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(128) DEFAULT NULL,
  `role_id` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('7623fb2f-7d3f-4430-b34d-5153237e0999', '4d857666-8669-4902-a4c6-3e73d1b46161');
INSERT INTO `sys_user_role` VALUES ('1', '1');

-- ----------------------------
-- Function structure for queryChildren
-- ----------------------------
DROP FUNCTION IF EXISTS `queryChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `queryChildren`(areaId VARCHAR(1000)) RETURNS varchar(4000) CHARSET utf8
BEGIN
DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);

SET sTemp = '$';
SET sTempChd = cast(areaId as char);

WHILE sTempChd is not NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT group_concat(id) INTO sTempChd FROM sys_menu where FIND_IN_SET(parent_Id,sTempChd)>0;
END WHILE;
return sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for queryParent
-- ----------------------------
DROP FUNCTION IF EXISTS `queryParent`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `queryParent`(areaId VARCHAR(1000)) RETURNS varchar(4000) CHARSET utf8
BEGIN
DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);

SET sTemp = '$';
SET sTempChd = cast(areaId as char);

WHILE sTempChd is not NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT group_concat(parent_Id) INTO sTempChd FROM sys_menu where FIND_IN_SET(id,sTempChd)>0;
END WHILE;
return sTemp;
END
;;
DELIMITER ;
