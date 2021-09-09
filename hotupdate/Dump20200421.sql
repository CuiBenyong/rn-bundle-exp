CREATE DATABASE  IF NOT EXISTS `hotupdate` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hotupdate`;
-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: hotupdate
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hotupdate_bundles`
--

DROP TABLE IF EXISTS `hotupdate_bundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotupdate_bundles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bundle_name` varchar(45) NOT NULL COMMENT '业务包的名称',
  `version` varchar(45) NOT NULL COMMENT '业务全量包版本',
  `bsdiff_version` varchar(45) NOT NULL DEFAULT '' COMMENT '业务增量包版本',
  `subversion` varchar(45) NOT NULL COMMENT '业务全量包子版本（打包时间）',
  `bsdiff_subversion` varchar(45) NOT NULL DEFAULT '' COMMENT '业务增量包子版本（打包时间）',
  `url` varchar(255) NOT NULL COMMENT '业务全量包下载地址',
  `bsdiff_url` varchar(45) DEFAULT NULL COMMENT '业务增量包下载地址',
  `gray` text NOT NULL COMMENT '灰度规则： 需要灰度的手机尾号或手机号； 使用|分割；如： 1|2|1888888888',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '更新状态：0 关闭更新； 1 开启正常更新； 2 强制回滚更新； ',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotupdate_bundles`
--

LOCK TABLES `hotupdate_bundles` WRITE;
/*!40000 ALTER TABLE `hotupdate_bundles` DISABLE KEYS */;
INSERT INTO `hotupdate_bundles` VALUES (7,'Position','v1.0','','20200421185721','','/upload/3d/f8d9c690d0462ea24980099085a9dd.zip?attname=Position-v1.0-20200421185721.zip',NULL,'1',1,'2020-04-21 18:57:49','2020-04-21 18:57:49',0),(8,'Position','v1.0','','20200421190451','','/upload/16/9592380c03d0d65b796335a9ba7f7d.zip?attname=Position-v1.0-20200421190451.zip',NULL,'1',1,'2020-04-21 19:05:01','2020-04-21 19:05:01',0);
/*!40000 ALTER TABLE `hotupdate_bundles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_auth`
--

DROP TABLE IF EXISTS `system_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_auth` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '权限名称',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注说明',
  `sort` bigint unsigned DEFAULT '0' COMMENT '排序权重',
  `status` tinyint unsigned DEFAULT '1' COMMENT '权限状态(1使用,0禁用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_auth_title` (`title`) USING BTREE,
  KEY `idx_system_auth_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-权限';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_auth`
--

LOCK TABLES `system_auth` WRITE;
/*!40000 ALTER TABLE `system_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_auth_node`
--

DROP TABLE IF EXISTS `system_auth_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_auth_node` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `auth` bigint unsigned DEFAULT '0' COMMENT '角色',
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '节点',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_auth_auth` (`auth`) USING BTREE,
  KEY `idx_system_auth_node` (`node`(191)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-授权';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_auth_node`
--

LOCK TABLES `system_auth_node` WRITE;
/*!40000 ALTER TABLE `system_auth_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_auth_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_config`
--

DROP TABLE IF EXISTS `system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_config` (
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '分类',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '配置名',
  `value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '配置值',
  KEY `idx_system_config_type` (`type`) USING BTREE,
  KEY `idx_system_config_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_config`
--

LOCK TABLES `system_config` WRITE;
/*!40000 ALTER TABLE `system_config` DISABLE KEYS */;
INSERT INTO `system_config` VALUES ('base','site_name','ThinkAdmin'),('base','site_icon','https://v6.thinkadmin.top/upload/f47b8fe06e38ae99/08e8398da45583b9.png'),('base','site_copy','©版权所有 2019-2020 楚才科技'),('base','app_name','ThinkAdmin'),('base','app_version','v6.0'),('base','miitbeian','粤ICP备16006642号-2'),('storage','qiniu_http_protocol','http'),('storage','type','local'),('storage','allow_exts','doc,gif,icon,jpg,mp3,mp4,p12,pem,png,rar,xls,xlsx,zip'),('storage','qiniu_region','华东'),('storage','qiniu_bucket',''),('storage','qiniu_http_domain',''),('storage','qiniu_access_key',''),('storage','qiniu_secret_key',''),('wechat','type','api'),('wechat','token',''),('wechat','appid',''),('wechat','appsecret',''),('wechat','encodingaeskey',''),('wechat','thr_appid',''),('wechat','thr_appkey',''),('wechat','mch_id',''),('wechat','mch_key',''),('wechat','mch_ssl_type','pem'),('wechat','mch_ssl_p12',''),('wechat','mch_ssl_key',''),('wechat','mch_ssl_cer',''),('storage','alioss_http_protocol','http'),('storage','alioss_point','oss-cn-hangzhou.aliyuncs.com'),('storage','alioss_bucket',''),('storage','alioss_http_domain',''),('storage','alioss_access_key',''),('storage','alioss_secret_key',''),('storage','link_type','full'),('storage','local_http_protocol','path');
/*!40000 ALTER TABLE `system_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_data`
--

DROP TABLE IF EXISTS `system_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '配置名',
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '配置值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_data_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_data`
--

LOCK TABLES `system_data` WRITE;
/*!40000 ALTER TABLE `system_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_menu`
--

DROP TABLE IF EXISTS `system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_menu` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint unsigned DEFAULT '0' COMMENT '上级ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单图标',
  `node` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '节点代码',
  `url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '链接节点',
  `params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '_self' COMMENT '打开方式',
  `sort` int unsigned DEFAULT '0' COMMENT '排序权重',
  `status` tinyint unsigned DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_menu_node` (`node`) USING BTREE,
  KEY `idx_system_menu_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_menu`
--

LOCK TABLES `system_menu` WRITE;
/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
INSERT INTO `system_menu` VALUES (2,0,'系统管理','','','#','','_self',100,1,'2018-09-05 10:04:52'),(3,4,'系统菜单管理','layui-icon layui-icon-layouts','','admin/menu/index','','_self',1,1,'2018-09-05 10:05:26'),(4,2,'系统配置','','','#','','_self',20,1,'2018-09-05 10:07:17'),(5,12,'系统用户管理','layui-icon layui-icon-username','','admin/user/index','','_self',1,1,'2018-09-06 03:10:42'),(7,12,'访问权限管理','layui-icon layui-icon-vercode','','admin/auth/index','','_self',2,1,'2018-09-06 07:17:14'),(11,4,'系统参数配置','layui-icon layui-icon-set','','admin/config/index','','_self',4,1,'2018-09-06 08:43:47'),(12,2,'权限管理','','','#','','_self',10,1,'2018-09-06 10:01:31'),(27,4,'系统任务管理','layui-icon layui-icon-log','','admin/queue/index','','_self',3,1,'2018-11-29 03:13:34'),(49,4,'系统日志管理','layui-icon layui-icon-form','','admin/oplog/index','','_self',2,1,'2019-02-18 04:56:56'),(56,0,'微信管理','','','#','','_self',200,0,'2019-12-09 03:00:37'),(57,56,'微信管理','','','#','','_self',0,0,'2019-12-09 05:56:58'),(58,57,'微信接口配置','layui-icon layui-icon-set','','wechat/config/options','','_self',0,0,'2019-12-09 05:57:28'),(59,57,'微信支付配置','layui-icon layui-icon-rmb','','wechat/config/payment','','_self',0,0,'2019-12-09 05:58:42'),(60,56,'微信定制','','','#','','_self',0,0,'2019-12-09 10:35:16'),(61,60,'微信粉丝管理','layui-icon layui-icon-username','','wechat/fans/index','','_self',0,0,'2019-12-09 10:35:37'),(62,60,'微信图文管理','layui-icon layui-icon-template-1','','wechat/news/index','','_self',0,0,'2019-12-09 10:43:51'),(63,60,'微信菜单配置','layui-icon layui-icon-cellphone','','wechat/menu/index','','_self',0,0,'2019-12-09 14:49:28'),(64,60,'回复规则管理','layui-icon layui-icon-engine','','wechat/keys/index','','_self',0,0,'2019-12-14 06:09:04'),(65,60,'关注回复配置','layui-icon layui-icon-senior','','wechat/keys/subscribe','','_self',0,0,'2019-12-14 06:10:31'),(66,60,'默认回复配置','layui-icon layui-icon-util','','wechat/keys/defaults','','_self',0,0,'2019-12-14 06:11:18'),(67,0,'热更新管理','layui-icon layui-icon-transfer','','#','','_self',0,1,'2020-04-21 03:18:55'),(68,67,'热更新列表','layui-icon layui-icon-template-1','','admin/hotupdate/index','','_self',0,1,'2020-04-21 03:19:40');
/*!40000 ALTER TABLE `system_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_oplog`
--

DROP TABLE IF EXISTS `system_oplog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_oplog` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `geoip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `action` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作行为名称',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作内容描述',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_oplog`
--

LOCK TABLES `system_oplog` WRITE;
/*!40000 ALTER TABLE `system_oplog` DISABLE KEYS */;
INSERT INTO `system_oplog` VALUES (1,'admin/login/index','127.0.0.1','用户登录','登录系统后台成功','admin','2020-04-21 02:39:32'),(2,'admin/login/index','127.0.0.1','用户登录','登录系统后台成功','admin','2020-04-21 04:18:43'),(3,'admin/login/index','127.0.0.1','用户登录','登录系统后台成功','admin','2020-04-21 06:39:48'),(4,'admin/login/index','127.0.0.1','用户登录','登录系统后台成功','admin','2020-04-21 09:40:00'),(5,'admin/login/index','127.0.0.1','用户登录','登录系统后台成功','admin','2020-04-21 10:43:56');
/*!40000 ALTER TABLE `system_oplog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_queue`
--

DROP TABLE IF EXISTS `system_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_queue` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务编号',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `command` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行指令',
  `exec_pid` bigint DEFAULT '0' COMMENT '执行进程',
  `exec_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '执行参数',
  `exec_time` bigint DEFAULT '0' COMMENT '执行时间',
  `exec_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行描述',
  `enter_time` decimal(20,4) DEFAULT '0.0000' COMMENT '开始时间',
  `outer_time` decimal(20,4) DEFAULT '0.0000' COMMENT '结束时间',
  `loops_time` bigint DEFAULT '0' COMMENT '循环时间',
  `attempts` bigint DEFAULT '0' COMMENT '执行次数',
  `rscript` tinyint(1) DEFAULT '1' COMMENT '任务类型(0单例,1多例)',
  `status` tinyint(1) DEFAULT '1' COMMENT '任务状态(1新任务,2处理中,3成功,4失败)',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_queue_code` (`code`) USING BTREE,
  KEY `idx_system_queue_title` (`title`) USING BTREE,
  KEY `idx_system_queue_status` (`status`) USING BTREE,
  KEY `idx_system_queue_rscript` (`rscript`) USING BTREE,
  KEY `idx_system_queue_create_at` (`create_at`) USING BTREE,
  KEY `idx_system_queue_exec_time` (`exec_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_queue`
--

LOCK TABLES `system_queue` WRITE;
/*!40000 ALTER TABLE `system_queue` DISABLE KEYS */;
INSERT INTO `system_queue` VALUES (1,'Q202004212859769','优化数据库所有数据表','xadmin:dbOptimize',0,'[]',1587446159,'',0.0000,0.0000,0,0,0,1,'2020-04-21 05:15:59');
/*!40000 ALTER TABLE `system_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_user`
--

DROP TABLE IF EXISTS `system_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户昵称',
  `headimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `authorize` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '权限授权',
  `contact_qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系QQ',
  `contact_mail` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系邮箱',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系手机',
  `login_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地址',
  `login_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录时间',
  `login_num` bigint DEFAULT '0' COMMENT '登录次数',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注说明',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态(0禁用,1启用)',
  `sort` bigint DEFAULT '0' COMMENT '排序权重',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '删除(1删除,0未删)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_user_username` (`username`) USING BTREE,
  KEY `idx_system_user_deleted` (`is_deleted`) USING BTREE,
  KEY `idx_system_user_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user`
--

LOCK TABLES `system_user` WRITE;
/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
INSERT INTO `system_user` VALUES (10000,'admin','21232f297a57a5a743894a0e4a801fc3','系统管理员','','','','','','127.0.0.1','2020-04-21 18:43:56',1062,'',1,0,0,'2015-11-13 07:14:22');
/*!40000 ALTER TABLE `system_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_fans`
--

DROP TABLE IF EXISTS `wechat_fans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wechat_fans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '公众号APPID',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '粉丝unionid',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '粉丝openid',
  `tagid_list` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '粉丝标签id',
  `is_black` tinyint unsigned DEFAULT '0' COMMENT '是否为黑名单状态',
  `subscribe` tinyint unsigned DEFAULT '0' COMMENT '关注状态(0未关注,1已关注)',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户昵称',
  `sex` tinyint unsigned DEFAULT '0' COMMENT '用户性别(1男性,2女性,0未知)',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户所在国家',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户所在省份',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户所在城市',
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户的语言(zh_CN)',
  `headimgurl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户头像',
  `subscribe_time` bigint unsigned DEFAULT '0' COMMENT '关注时间',
  `subscribe_at` datetime DEFAULT NULL COMMENT '关注时间',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `subscribe_scene` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '扫码关注场景',
  `qr_scene` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '二维码场景值',
  `qr_scene_str` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '二维码场景内容',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_wechat_fans_openid` (`openid`) USING BTREE,
  KEY `index_wechat_fans_unionid` (`unionid`) USING BTREE,
  KEY `index_wechat_fans_is_back` (`is_black`) USING BTREE,
  KEY `index_wechat_fans_subscribe` (`subscribe`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='微信-粉丝';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_fans`
--

LOCK TABLES `wechat_fans` WRITE;
/*!40000 ALTER TABLE `wechat_fans` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_fans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_fans_tags`
--

DROP TABLE IF EXISTS `wechat_fans_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wechat_fans_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '公众号APPID',
  `name` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签名称',
  `count` bigint unsigned DEFAULT '0' COMMENT '总数',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  KEY `index_wechat_fans_tags_id` (`id`) USING BTREE,
  KEY `index_wechat_fans_tags_appid` (`appid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='微信-标签';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_fans_tags`
--

LOCK TABLES `wechat_fans_tags` WRITE;
/*!40000 ALTER TABLE `wechat_fans_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_fans_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_keys`
--

DROP TABLE IF EXISTS `wechat_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wechat_keys` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appid` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '公众号APPID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '类型(text,image,news)',
  `keys` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关键字',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '文本内容',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '图片链接',
  `voice_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '语音链接',
  `music_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '音乐标题',
  `music_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '音乐链接',
  `music_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '缩略图片',
  `music_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '音乐描述',
  `video_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '视频标题',
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '视频URL',
  `video_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '视频描述',
  `news_id` bigint unsigned DEFAULT NULL COMMENT '图文ID',
  `sort` bigint unsigned DEFAULT '0' COMMENT '排序字段',
  `status` tinyint unsigned DEFAULT '1' COMMENT '状态(0禁用,1启用)',
  `create_by` bigint unsigned DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_wechat_keys_appid` (`appid`) USING BTREE,
  KEY `index_wechat_keys_type` (`type`) USING BTREE,
  KEY `index_wechat_keys_keys` (`keys`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='微信-关键字';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_keys`
--

LOCK TABLES `wechat_keys` WRITE;
/*!40000 ALTER TABLE `wechat_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_media`
--

DROP TABLE IF EXISTS `wechat_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wechat_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '公众号ID',
  `md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件md5',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '媒体类型',
  `media_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '本地文件链接',
  `media_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '远程图片链接',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_wechat_media_appid` (`appid`) USING BTREE,
  KEY `index_wechat_media_md5` (`md5`) USING BTREE,
  KEY `index_wechat_media_type` (`type`) USING BTREE,
  KEY `index_wechat_media_media_id` (`media_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='微信-素材';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_media`
--

LOCK TABLES `wechat_media` WRITE;
/*!40000 ALTER TABLE `wechat_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_news`
--

DROP TABLE IF EXISTS `wechat_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wechat_news` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `media_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '永久素材外网URL',
  `article_id` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '关联图文ID(用英文逗号做分割)',
  `is_deleted` tinyint unsigned DEFAULT '0' COMMENT '删除状态(0未删除,1已删除)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_wechat_news_artcle_id` (`article_id`) USING BTREE,
  KEY `index_wechat_news_media_id` (`media_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='微信-图文';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_news`
--

LOCK TABLES `wechat_news` WRITE;
/*!40000 ALTER TABLE `wechat_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_news_article`
--

DROP TABLE IF EXISTS `wechat_news_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wechat_news_article` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '素材标题',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '永久素材显示URL',
  `show_cover_pic` tinyint unsigned DEFAULT '0' COMMENT '显示封面(0不显示,1显示)',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文章作者',
  `digest` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '摘要内容',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '图文内容',
  `content_source_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '原文地址',
  `read_num` bigint unsigned DEFAULT '0' COMMENT '阅读数量',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='微信-文章';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_news_article`
--

LOCK TABLES `wechat_news_article` WRITE;
/*!40000 ALTER TABLE `wechat_news_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_news_article` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-21 19:17:33
