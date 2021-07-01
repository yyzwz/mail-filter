-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.30-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 nhcj 的数据库结构
DROP DATABASE IF EXISTS `nhcj`;
CREATE DATABASE IF NOT EXISTS `nhcj` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci */;
USE `nhcj`;

-- 导出  表 nhcj.act_evt_log 结构
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE IF NOT EXISTS `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_evt_log 的数据：~0 rows (大约)
DELETE FROM `act_evt_log`;
/*!40000 ALTER TABLE `act_evt_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_evt_log` ENABLE KEYS */;

-- 导出  表 nhcj.act_ge_bytearray 结构
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE IF NOT EXISTS `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ge_bytearray 的数据：~0 rows (大约)
DELETE FROM `act_ge_bytearray`;
/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;

-- 导出  表 nhcj.act_ge_property 结构
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE IF NOT EXISTS `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ge_property 的数据：~3 rows (大约)
DELETE FROM `act_ge_property`;
/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES
	('next.dbid', '1', 1),
	('schema.history', 'create(5.22.0.0)', 1),
	('schema.version', '5.22.0.0', 1);
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_actinst 结构
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE IF NOT EXISTS `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_actinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_actinst`;
/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_attachment 结构
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE IF NOT EXISTS `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_attachment 的数据：~0 rows (大约)
DELETE FROM `act_hi_attachment`;
/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_comment 结构
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE IF NOT EXISTS `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_comment 的数据：~0 rows (大约)
DELETE FROM `act_hi_comment`;
/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_detail 结构
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE IF NOT EXISTS `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_detail 的数据：~0 rows (大约)
DELETE FROM `act_hi_detail`;
/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_identitylink 结构
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE IF NOT EXISTS `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_identitylink 的数据：~0 rows (大约)
DELETE FROM `act_hi_identitylink`;
/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_procinst 结构
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE IF NOT EXISTS `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_procinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_procinst`;
/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_taskinst 结构
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE IF NOT EXISTS `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_taskinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_taskinst`;
/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;

-- 导出  表 nhcj.act_hi_varinst 结构
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE IF NOT EXISTS `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_hi_varinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_varinst`;
/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;

-- 导出  表 nhcj.act_id_group 结构
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE IF NOT EXISTS `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_id_group 的数据：~0 rows (大约)
DELETE FROM `act_id_group`;
/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;

-- 导出  表 nhcj.act_id_info 结构
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE IF NOT EXISTS `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_id_info 的数据：~0 rows (大约)
DELETE FROM `act_id_info`;
/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;

-- 导出  表 nhcj.act_id_membership 结构
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE IF NOT EXISTS `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_id_membership 的数据：~0 rows (大约)
DELETE FROM `act_id_membership`;
/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;

-- 导出  表 nhcj.act_id_user 结构
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE IF NOT EXISTS `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_id_user 的数据：~0 rows (大约)
DELETE FROM `act_id_user`;
/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;

-- 导出  表 nhcj.act_procdef_info 结构
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE IF NOT EXISTS `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_procdef_info 的数据：~0 rows (大约)
DELETE FROM `act_procdef_info`;
/*!40000 ALTER TABLE `act_procdef_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_procdef_info` ENABLE KEYS */;

-- 导出  表 nhcj.act_re_deployment 结构
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE IF NOT EXISTS `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_re_deployment 的数据：~0 rows (大约)
DELETE FROM `act_re_deployment`;
/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;

-- 导出  表 nhcj.act_re_model 结构
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE IF NOT EXISTS `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_re_model 的数据：~0 rows (大约)
DELETE FROM `act_re_model`;
/*!40000 ALTER TABLE `act_re_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_model` ENABLE KEYS */;

-- 导出  表 nhcj.act_re_procdef 结构
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE IF NOT EXISTS `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_re_procdef 的数据：~0 rows (大约)
DELETE FROM `act_re_procdef`;
/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;

-- 导出  表 nhcj.act_ru_event_subscr 结构
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE IF NOT EXISTS `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ru_event_subscr 的数据：~0 rows (大约)
DELETE FROM `act_ru_event_subscr`;
/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;

-- 导出  表 nhcj.act_ru_execution 结构
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE IF NOT EXISTS `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ru_execution 的数据：~0 rows (大约)
DELETE FROM `act_ru_execution`;
/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;

-- 导出  表 nhcj.act_ru_identitylink 结构
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE IF NOT EXISTS `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ru_identitylink 的数据：~0 rows (大约)
DELETE FROM `act_ru_identitylink`;
/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;

-- 导出  表 nhcj.act_ru_job 结构
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE IF NOT EXISTS `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ru_job 的数据：~0 rows (大约)
DELETE FROM `act_ru_job`;
/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;

-- 导出  表 nhcj.act_ru_task 结构
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE IF NOT EXISTS `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ru_task 的数据：~0 rows (大约)
DELETE FROM `act_ru_task`;
/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;

-- 导出  表 nhcj.act_ru_variable 结构
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE IF NOT EXISTS `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  nhcj.act_ru_variable 的数据：~0 rows (大约)
DELETE FROM `act_ru_variable`;
/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;

-- 导出  表 nhcj.app_member 结构
DROP TABLE IF EXISTS `app_member`;
CREATE TABLE IF NOT EXISTS `app_member` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `platform` tinyint(1) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `vip_end_time` datetime(6) DEFAULT NULL,
  `vip_start_time` datetime(6) DEFAULT NULL,
  `permissions` varchar(255) DEFAULT NULL,
  `vip_status` tinyint(1) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `invite_code` varchar(255) DEFAULT NULL,
  `grade` int(11) unsigned DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `invite_by` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  UNIQUE KEY `invite_code` (`invite_code`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.app_member 的数据：~3 rows (大约)
DELETE FROM `app_member`;
/*!40000 ALTER TABLE `app_member` DISABLE KEYS */;
INSERT INTO `app_member` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `avatar`, `email`, `mobile`, `nickname`, `password`, `platform`, `sex`, `status`, `type`, `username`, `vip_end_time`, `vip_start_time`, `permissions`, `vip_status`, `birth`, `address`, `invite_code`, `grade`, `position`, `invite_by`, `description`) VALUES
	(255227305549369344, '', '2020-03-25 21:14:32.000000', 0, 'admin', '2020-04-27 17:20:45.307000', 'https://i.loli.net/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059031', '187****9031', NULL, -1, '', 0, 1, '1251014922381430800', '2030-04-30 00:00:00.000000', '2020-04-01 00:00:00.000000', 'MEMBER', 1, NULL, '中国 北京市 北京市 朝阳区 酒仙桥路 3号 电子城．国际电子总部', '12N3VE6CK440G', 0, '30.5681733200,104.0666198700', '', NULL),
	(1251783645962833920, 'admin', '2020-04-19 16:04:12.000000', 0, 'admin', '2020-04-27 17:24:23.091000', 'https://i.loli.net/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059092', '187****9092', NULL, 1, '', 0, 1, '1251783646004776960', '2020-04-07 00:00:00.000000', '2020-04-01 00:00:00.000000', 'MEMBER', 2, NULL, '中国 北京市 北京市 朝阳区 酒仙桥路 3号 电子城．国际电子总部', '12NPQJ01S4400', 0, '30.5681733200,104.0666198700', '1251014922381430800', NULL),
	(1251783729291071489, 'admin', '2020-04-19 16:04:32.000000', 0, 'admin', '2020-04-27 22:03:48.509000', 'https://i.loli.net/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059033', '187****9093', NULL, 2, '', 0, 0, '1251783729303654400', NULL, NULL, 'MEMBER', 0, NULL, '中国 北京市 北京市 朝阳区 酒仙桥路 3号 电子城．国际电子总部', '12NPQLDKC4400', 0, '30.5681733200,104.0666198700', '1251014922381430800', NULL);
/*!40000 ALTER TABLE `app_member` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_blob_triggers 结构
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_blob_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_blob_triggers`;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_calendars 结构
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE IF NOT EXISTS `qrtz_calendars` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_calendars 的数据：~0 rows (大约)
DELETE FROM `qrtz_calendars`;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_cron_triggers 结构
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `CRON_EXPRESSION` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_cron_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_cron_triggers`;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_fired_triggers 结构
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `ENTRY_ID` varchar(95) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_croatian_ci DEFAULT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_croatian_ci DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_fired_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_fired_triggers`;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_job_details 结构
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE IF NOT EXISTS `qrtz_job_details` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `DESCRIPTION` varchar(250) COLLATE utf8_croatian_ci DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) COLLATE utf8_croatian_ci NOT NULL,
  `IS_DURABLE` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_job_details 的数据：~0 rows (大约)
DELETE FROM `qrtz_job_details`;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_locks 结构
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE IF NOT EXISTS `qrtz_locks` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `LOCK_NAME` varchar(40) COLLATE utf8_croatian_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_locks 的数据：~0 rows (大约)
DELETE FROM `qrtz_locks`;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
INSERT INTO `qrtz_locks` (`SCHED_NAME`, `LOCK_NAME`) VALUES
	('quartzScheduler', 'TRIGGER_ACCESS');
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_paused_trigger_grps 结构
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE IF NOT EXISTS `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_paused_trigger_grps 的数据：~0 rows (大约)
DELETE FROM `qrtz_paused_trigger_grps`;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_scheduler_state 结构
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE IF NOT EXISTS `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_scheduler_state 的数据：~0 rows (大约)
DELETE FROM `qrtz_scheduler_state`;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_simple_triggers 结构
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_simple_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_simple_triggers`;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_simprop_triggers 结构
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `STR_PROP_1` varchar(512) COLLATE utf8_croatian_ci DEFAULT NULL,
  `STR_PROP_2` varchar(512) COLLATE utf8_croatian_ci DEFAULT NULL,
  `STR_PROP_3` varchar(512) COLLATE utf8_croatian_ci DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_simprop_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_simprop_triggers`;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;

-- 导出  表 nhcj.qrtz_triggers 结构
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `DESCRIPTION` varchar(250) COLLATE utf8_croatian_ci DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) COLLATE utf8_croatian_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) COLLATE utf8_croatian_ci DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.qrtz_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_triggers`;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;

-- 导出  表 nhcj.t_act_business 结构
DROP TABLE IF EXISTS `t_act_business`;
CREATE TABLE IF NOT EXISTS `t_act_business` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `proc_def_id` varchar(255) DEFAULT NULL,
  `proc_inst_id` varchar(255) DEFAULT NULL,
  `result` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `table_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_act_business 的数据：~0 rows (大约)
DELETE FROM `t_act_business`;
/*!40000 ALTER TABLE `t_act_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_business` ENABLE KEYS */;

-- 导出  表 nhcj.t_act_category 结构
DROP TABLE IF EXISTS `t_act_category`;
CREATE TABLE IF NOT EXISTS `t_act_category` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_act_category 的数据：~0 rows (大约)
DELETE FROM `t_act_category`;
/*!40000 ALTER TABLE `t_act_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_category` ENABLE KEYS */;

-- 导出  表 nhcj.t_act_model 结构
DROP TABLE IF EXISTS `t_act_model`;
CREATE TABLE IF NOT EXISTS `t_act_model` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `model_key` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `version` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_act_model 的数据：~0 rows (大约)
DELETE FROM `t_act_model`;
/*!40000 ALTER TABLE `t_act_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_model` ENABLE KEYS */;

-- 导出  表 nhcj.t_act_node 结构
DROP TABLE IF EXISTS `t_act_node`;
CREATE TABLE IF NOT EXISTS `t_act_node` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `node_id` varchar(255) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `relate_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_act_node 的数据：~0 rows (大约)
DELETE FROM `t_act_node`;
/*!40000 ALTER TABLE `t_act_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_node` ENABLE KEYS */;

-- 导出  表 nhcj.t_act_process 结构
DROP TABLE IF EXISTS `t_act_process`;
CREATE TABLE IF NOT EXISTS `t_act_process` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `deployment_id` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `diagram_name` varchar(255) DEFAULT NULL,
  `latest` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `process_key` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `xml_name` varchar(255) DEFAULT NULL,
  `business_table` varchar(255) DEFAULT NULL,
  `route_name` varchar(255) DEFAULT NULL,
  `all_user` bit(1) DEFAULT NULL,
  `category_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_act_process 的数据：~0 rows (大约)
DELETE FROM `t_act_process`;
/*!40000 ALTER TABLE `t_act_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_process` ENABLE KEYS */;

-- 导出  表 nhcj.t_act_starter 结构
DROP TABLE IF EXISTS `t_act_starter`;
CREATE TABLE IF NOT EXISTS `t_act_starter` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `process_def_id` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_act_starter 的数据：~0 rows (大约)
DELETE FROM `t_act_starter`;
/*!40000 ALTER TABLE `t_act_starter` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_starter` ENABLE KEYS */;

-- 导出  表 nhcj.t_admin_look_arch 结构
DROP TABLE IF EXISTS `t_admin_look_arch`;
CREATE TABLE IF NOT EXISTS `t_admin_look_arch` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `open_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_admin_look_arch 的数据：~2 rows (大约)
DELETE FROM `t_admin_look_arch`;
/*!40000 ALTER TABLE `t_admin_look_arch` DISABLE KEYS */;
INSERT INTO `t_admin_look_arch` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `mobile`, `name`, `open_id`, `remark`) VALUES
	('1380429259801235457', 'admin', '2021-04-09 15:55:57.000000', 0, 'admin', '2021-04-11 15:01:56.426000', '17857054386', '郑某人', 'o7coV5cPxcPbBkSmKUA-tTwxXw9s', ''),
	('1382883767785492481', 'admin', '2021-04-16 10:29:17.635000', 0, NULL, '2021-04-21 18:59:41.738000', '158885433071', 'XXX', 'o7coV5QfEfHkUvrNz8sblt02jxk01', '');
/*!40000 ALTER TABLE `t_admin_look_arch` ENABLE KEYS */;

-- 导出  表 nhcj.t_assessment_line 结构
DROP TABLE IF EXISTS `t_assessment_line`;
CREATE TABLE IF NOT EXISTS `t_assessment_line` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `line_duty` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `line_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `line_remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `line_type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sort_number` int(11) NOT NULL,
  `grade` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_assessment_line 的数据：~23 rows (大约)
DELETE FROM `t_assessment_line`;
/*!40000 ALTER TABLE `t_assessment_line` DISABLE KEYS */;
INSERT INTO `t_assessment_line` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `line_duty`, `line_name`, `line_remark`, `line_type`, `sort_number`, `grade`) VALUES
	('1376055106562297857', 'admin', '2021-03-28 14:14:37.938000', 0, NULL, NULL, '陈英杰', '综合工作', '', '常规工作', 1, '10'),
	('1376055196844691456', 'admin', '2021-03-28 14:14:59.457000', 0, NULL, NULL, '周亚伟', '人大工作', '', '常规工作', 2, '5'),
	('1376055267174780929', 'admin', '2021-03-28 14:15:16.225000', 0, NULL, NULL, '王莫', '组织工作', '', '常规工作', 3, '10'),
	('1376055361924108288', 'admin', '2021-03-28 14:15:38.815000', 0, NULL, NULL, '胡建丹', '纪检工作', '', '常规工作', 4, '10'),
	('1376055423685234688', 'admin', '2021-03-28 14:15:53.540000', 0, NULL, NULL, '丁玲丹', '宣传工作', '', '常规工作', 5, '10'),
	('1376055498255765504', 'admin', '2021-03-28 14:16:11.320000', 0, NULL, NULL, '陈中靖', '统战工作', '', '常规工作', 6, '10'),
	('1376055559643598848', 'admin', '2021-03-28 14:16:25.955000', 0, NULL, NULL, '郑武栋', '综治工作', '', '常规工作', 7, '10'),
	('1376055627377414144', 'admin', '2021-03-28 14:16:42.103000', 0, NULL, NULL, '陈中靖', '武装工作', '', '常规工作', 8, '10'),
	('1376055692636590081', 'admin', '2021-03-28 14:16:57.662000', 0, NULL, NULL, '陈英杰 王李敏 葛亚植', '群团工作', '', '常规工作', 9, '5'),
	('1376055764153667584', 'admin', '2021-03-28 14:17:14.714000', 0, NULL, NULL, '应凯', '食药环保', '', '常规工作', 10, '5'),
	('1376055816355975169', 'admin', '2021-03-28 14:17:27.159000', 0, NULL, NULL, '叶伟华', '农业农村工作', '', '常规工作', 11, '10'),
	('1376055873146851329', 'admin', '2021-03-28 14:17:40.699000', 0, NULL, NULL, '季增强', '社会事务工作', '', '常规工作', 12, '10'),
	('1376055927039463424', 'admin', '2021-03-28 14:17:53.547000', 0, NULL, NULL, '苏海利', '村镇建设工作', '', '常规工作', 13, '10'),
	('1376055986367893505', 'admin', '2021-03-28 14:18:07.694000', 0, NULL, NULL, '葛松松', '便民工作', '', '常规工作', 14, '10'),
	('1376056061106196480', 'admin', '2021-03-28 14:18:25.512000', 0, NULL, NULL, '王雷', '应急工作', '', '常规工作', 15, '10'),
	('1376056353117835265', 'admin', '2021-03-28 14:19:35.137000', 0, NULL, NULL, '王雷', '重大项目', '', '重要工作', 16, '无'),
	('1376056424781713409', 'admin', '2021-03-28 14:19:52.219000', 0, NULL, NULL, '应凯', '工业工作', '', '重要工作', 17, '无'),
	('1376056487633358848', 'admin', '2021-03-28 14:20:07.204000', 0, NULL, NULL, '陈英杰', '人才工作', '', '重要工作', 18, '无'),
	('1376056537973395457', 'admin', '2021-03-28 14:20:19.206000', 0, NULL, NULL, '丁玲丹', '旅游工作', '', '重要工作', 19, '无'),
	('1376056590121177088', 'admin', '2021-03-28 14:20:31.640000', 0, NULL, NULL, '无', '信访', '', '重要工作', 20, '无'),
	('1376056934603558912', 'admin', '2021-03-28 14:21:53.770000', 0, NULL, NULL, '陈英杰 其他领导', '加分项', '', '加分项', 21, '无'),
	('1376057004744904705', 'admin', '2021-03-28 14:22:10.493000', 0, NULL, NULL, '陈英杰 其他领导', '扣分情况', '', '扣分项', 22, '无'),
	('1376057045131857920', 'admin', '2021-03-28 14:22:20.122000', 0, NULL, NULL, '陈英杰 其他领导', '否决项', '', '否决项', 23, '无');
/*!40000 ALTER TABLE `t_assessment_line` ENABLE KEYS */;

-- 导出  表 nhcj.t_assessment_line_item 结构
DROP TABLE IF EXISTS `t_assessment_line_item`;
CREATE TABLE IF NOT EXISTS `t_assessment_line_item` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `item_title` varchar(4096) COLLATE utf8_croatian_ci DEFAULT NULL,
  `line_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `line_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sort_level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_assessment_line_item 的数据：~131 rows (大约)
DELETE FROM `t_assessment_line_item`;
/*!40000 ALTER TABLE `t_assessment_line_item` DISABLE KEYS */;
INSERT INTO `t_assessment_line_item` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `item_title`, `line_id`, `remark`, `line_name`, `sort_level`) VALUES
	('1376058976256528384', 'admin', '2021-03-28 14:30:00.568000', 0, NULL, NULL, '村干部缺席各类会议和活动每人次扣0.1分，无故迟到或早退每人次扣0.1分。', '1376055106562297857', '', '综合工作', 1),
	('1376059104619008001', 'admin', '2021-03-28 14:30:31.149000', 0, NULL, NULL, '未按要求完成镇党委政府布置的工作的每起扣1分，经催办后仍未落实的加倍扣分。', '1376055106562297857', '', '综合工作', 2),
	('1376059427060322305', 'admin', '2021-03-28 14:31:48.022000', 0, NULL, NULL, '镇代表无故不参加人大会议、活动的每次扣0.5分；', '1376055196844691456', '', '人大工作', 1),
	('1376059459620704257', 'admin', '2021-03-28 14:31:55.784000', 0, NULL, NULL, '代表建议涉及权限不配合落实的，酌情扣0.5－2分。', '1376055196844691456', '', '人大工作', 2),
	('1376059516751319040', 'admin', '2021-03-28 14:32:09.406000', 0, NULL, NULL, '在县、镇人大代表选举工作不支持、不配合的，酌情扣1－3分，存在破坏选举行为的，扣5分。', '1376055196844691456', '', '人大工作', 3),
	('1376059552214159361', 'admin', '2021-03-28 14:32:17.860000', 0, NULL, NULL, '党建亮显党徽、党语、村干部值班表、联村干部亮相台、党员形象栏、共产党员户、联户网格等缺失不完善的，每项扣0.5分。', '1376055267174780929', '', '组织工作', 1),
	('1376059577723916288', 'admin', '2021-03-28 14:32:23.942000', 0, NULL, NULL, '村社班子挂牌、党员活动室三要素等悬挂不规范的，每项扣0.5分。', '1376055267174780929', '', '组织工作', 2),
	('1376059608560439296', 'admin', '2021-03-28 14:32:31.295000', 0, NULL, NULL, '村班子不团结，公开散布不团结言行的，班子内相互信访的，每例扣2分，造成严重影响和不良后果的，每例加扣2分。', '1376055267174780929', '', '组织工作', 3),
	('1376059640953049088', 'admin', '2021-03-28 14:32:39.017000', 0, NULL, NULL, '村社主职干部违法违纪被处理的，或被司法机关处罚的，每例扣3分；存在被评为不合格村社干部、歇职教育、免职等情形的，每例扣5分。其他干部存在上述情况的，减半扣分。', '1376055267174780929', '', '组织工作', 4),
	('1376059669512065025', 'admin', '2021-03-28 14:32:45.826000', 0, NULL, NULL, '在县镇党代表、县政协委员选举工作中不配合、不支持的，每例酌情扣0.5－3分，存在破坏选举行为的，每例扣5分。', '1376055267174780929', '', '组织工作', 5),
	('1376059699115462656', 'admin', '2021-03-28 14:32:52.885000', 0, NULL, NULL, '未严格落实周二联合办公、村干部坐班值班的，每例扣0.5分。', '1376055267174780929', '', '组织工作', 6),
	('1376059721013923841', 'admin', '2021-03-28 14:32:58.105000', 0, NULL, NULL, '支部标准化规范化建设不到位，“三会一课”未落实的，每例扣0.5分；主题党日不规范的，每例扣0.5分。会议记录不规范、党员会议到会率未达到80%的，每项每次扣0.5分。', '1376055267174780929', '', '组织工作', 7),
	('1376059758540361729', 'admin', '2021-03-28 14:33:07.053000', 0, NULL, NULL, '锋领指数考评、组织生活会、党员民主评议等县镇规定工作未完成的，每项扣0.5分。', '1376055267174780929', '', '组织工作', 8),
	('1376059820293099521', 'admin', '2021-03-28 14:33:21.776000', 0, NULL, NULL, '两委班子中无大专及以上学历的，扣0.5分；无35周岁及以下干部的，扣0.5分。', '1376055267174780929', '', '组织工作', 9),
	('1376059857932783617', 'admin', '2021-03-28 14:33:30.750000', 0, NULL, NULL, '未落实村级后备干部培育措施的，扣1分。', '1376055267174780929', '', '组织工作', 10),
	('1376059881945174017', 'admin', '2021-03-28 14:33:36.476000', 0, NULL, NULL, '党费收缴不规范，每例扣0.5分。', '1376055267174780929', '', '组织工作', 11),
	('1376059924987121664', 'admin', '2021-03-28 14:33:46.000000', 0, 'admin', '2021-03-28 14:33:59.943000', '党员发展各项指标未完成的每项扣1分；三年以上未发展党员的，扣5分，每多一年加扣1分；无35周岁及以下党员村社未销号的，扣2分；每村2名入党积极分子要求未达标的，扣2分，积极分子达到5人以上的，每增加1人加0.5分，最高加2分。', '1376055267174780929', '', '组织工作', 12),
	('1376060032587796480', 'admin', '2021-03-28 14:34:12.390000', 0, NULL, NULL, '新发展党员年龄低于35周岁的，每例加0.5分；新发展高中学历党员，每例扣0.5分，初中及以下学历党员，每例扣1分。', '1376055267174780929', '', '组织工作', 13),
	('1376060078158909441', 'admin', '2021-03-28 14:34:23.255000', 0, NULL, NULL, '党员除名、党组织关系迁移教育整转支部的，每例扣1分。', '1376055267174780929', '', '组织工作', 14),
	('1376060104704659456', 'admin', '2021-03-28 14:34:29.583000', 0, NULL, NULL, '党务未按时公开的，每次扣1分；公开内容不全面，程序不到位，张贴不规范的，每次扣0.5分。', '1376055267174780929', '', '组织工作', 15),
	('1376060129836929025', 'admin', '2021-03-28 14:34:35.575000', 0, NULL, NULL, '被评为二星级及以下党组织的，分别扣1－2分。', '1376055267174780929', '', '组织工作', 16),
	('1376060167719882753', 'admin', '2021-03-28 14:34:44.608000', 0, NULL, NULL, '后进村党组织未按期完成整转的，每例扣2分。', '1376055267174780929', '', '组织工作', 17),
	('1376060198791286785', 'admin', '2021-03-28 14:34:52.016000', 0, NULL, NULL, '项目党建助推中心工作有力，被确立为县级竞赛项目的，每例加0.5分，百村立功竞赛获评县级优秀项目一、二、三等奖的，每例加3－1分。', '1376055267174780929', '', '组织工作', 18),
	('1376060237970280449', 'admin', '2021-03-28 14:35:01.357000', 0, NULL, NULL, '新建党建联盟实效明显，现有党建联盟扩面提质的，每例酌情加1－2分；现有党建联盟未实际运转的，每例酌情扣1－2分。', '1376055267174780929', '', '组织工作', 19),
	('1376060270518079489', 'admin', '2021-03-28 14:35:09.117000', 0, NULL, NULL, '党员联户落实到位，党员在助推基层治理、乡村振兴等工作中发挥作用较好的，酌情加1－5分。', '1376055267174780929', '', '组织工作', 20),
	('1376060314029789185', 'admin', '2021-03-28 14:35:19.491000', 0, NULL, NULL, '按要求参与并完成村5A级党群服务中心创建的，加3分，未完成的，扣3分。', '1376055267174780929', '', '组织工作', 21),
	('1376060349370994689', 'admin', '2021-03-28 14:35:27.917000', 0, NULL, NULL, '申请中央资金扶持项目但未按时完成的，扣2分。', '1376055267174780929', '', '组织工作', 22),
	('1376060384590565376', 'admin', '2021-03-28 14:35:36.314000', 0, NULL, NULL, '配合上级部门参加党建活动，或迎接县级以上检查并通过的，每次加0.5分。', '1376055267174780929', '', '组织工作', 23),
	('1376060414193963009', 'admin', '2021-03-28 14:35:43.373000', 0, NULL, NULL, '党建工作有亮点，被县级以上平台报道的，每项加1分。', '1376055267174780929', '', '组织工作', 24),
	('1376060459832184832', 'admin', '2021-03-28 14:35:54.253000', 0, NULL, NULL, '违反村级权力清单三十六条相关规定的，每例扣1分。', '1376055361924108288', '', '纪检工作', 1),
	('1376060486377934848', 'admin', '2021-03-28 14:36:00.582000', 0, NULL, NULL, '村内党员受到党内警告、党内严重警告处分的每人扣0.5分，受撤销职务、留党察看处分的每人扣1分，开除党籍的每人扣2分。', '1376055361924108288', '', '纪检工作', 2),
	('1376060531529617408', 'admin', '2021-03-28 14:36:11.347000', 0, NULL, NULL, '违反农村基层党风廉政建设有关制度规定，每项扣1分。', '1376055361924108288', '', '纪检工作', 3),
	('1376060566497529857', 'admin', '2021-03-28 14:36:19.686000', 0, NULL, NULL, '村班子不支持村务监督委员会工作的，每例扣1分；村务监督委员会工作开展不正常的，每例扣1分。', '1376055361924108288', '', '纪检工作', 4),
	('1376060602967003136', 'admin', '2021-03-28 14:36:28.379000', 0, NULL, NULL, '审计发现问题移交县级部门的，每例扣3分，移交镇纪委的，每例扣1分。', '1376055361924108288', '', '纪检工作', 5),
	('1376060655127367681', 'admin', '2021-03-28 14:36:40.815000', 0, NULL, NULL, '未严格落实意识形态工作责任制扣1分，反馈问题未及时整改到位，党员、村干部言行引发网络意识形态问题的，每项扣1分，产生重大影响的，加扣1分。', '1376055423685234688', '', '宣传工作', 1),
	('1376060688363032577', 'admin', '2021-03-28 14:36:48.739000', 0, NULL, NULL, '学习强国平台注册量完成党员数、活跃度高于全县平均水平加0.5分，未完成、活跃度低于全县平均的，各扣1分;未在规定时间内完成年度党报党刊征订工作，扣1分。', '1376055423685234688', '', '宣传工作', 2),
	('1376060818252238849', 'admin', '2021-03-28 14:37:19.708000', 0, NULL, NULL, '农村文化礼堂未配备专职文化管理员，未能按时正常开放，每项扣1分；全年上报甬礼堂5次以上，每少一次扣1分；建成乡村书吧并开放的，加0.5分；未按上级部门标准建有文化、广播、图书等设施，每项扣0.5分；群众文艺团队不足2支的，扣0.5分；创成四、五星级文化礼堂，加0.5－1分；积极参加上级组织的各类赛事、送戏下乡、百姓大舞台等文化活动，每次加0.5分；全年开展各类文化活动等5次以上，每少一次扣0.5分；建有农村文化礼堂基金（公益金），加1分；有一首“村歌”，加1分。未每月巡查报送平台“扫黄打非”2次以上，扣1分。发生重大文物安全事故、文化相关违法事件、节庆活动重大安全事故、文化单位重大安全事故，每例扣5分。', '1376055423685234688', '', '宣传工作', 3),
	('1376060877278679041', 'admin', '2021-03-28 14:37:33.781000', 0, NULL, NULL, '创城工作未达标或整改不到位的，每次扣5分。省级测评出现严重问题的，每项扣5分。未按要求完成新时代文明实践站工作的，扣1分；全年完成新时代文明实践志愿服务（必须穿红马甲）8次，每少一次扣0.5分。创成县级、市级、省级文明村，成效明显的分别加1－3分，在上级各项检查、评定工作中被要求整改的每次扣1分，整改不到位或被摘牌的，扣2分。有力推进县“三美乡村”精品村建设，加1分。组织开展扣好“人生第一粒扣子”主题教育实践活动、“我们的节日”主题活动、“春泥计划”实施工作，每次加1分，最多不超过3分。推荐好人的，每例加1分；被评为宁海好人、宁波好人、浙江好人、中国好人，分别加1－4分。推进志愿服务规范化，在宁波WE志愿平台完成发布、认领等经常性工作，每年50%的活跃度，未达标扣1－3分。', '1376055423685234688', '', '宣传工作', 4),
	('1376060920299655169', 'admin', '2021-03-28 14:37:44.038000', 0, NULL, NULL, '成立村乡贤议事会，加2分；经常性开展工作，加1分。', '1376055498255765504', '', '统战工作', 1),
	('1376060977153445889', 'admin', '2021-03-28 14:37:57.592000', 0, NULL, NULL, '宗教场所和民间信仰场所每合并（削减）1处的，加2分；出现新增违建、大型涉宗露天造像的，每处扣2分；消防安全隐患未及时整改到位的，每处扣1分；特殊时期未按上级要求开放或关闭的，每次每处扣1分。已整治民间信仰点、私设聚会点出现回潮的，每处扣2分；容留僧尼和游僧常住或参与管理民间信仰场所的，每处扣2分。大型宗教和民间信仰活动未按规定事前报批的，每例扣2分，造成重大影响的，加扣2分。', '1376055498255765504', '', '统战工作', 2),
	('1376061009416032257', 'admin', '2021-03-28 14:38:05.284000', 0, NULL, NULL, '关工委办公场所未落实的，扣0.5分；制度未上墙的，扣0.5分；工作开展不正常的，扣0.5分；创成县级以上五好关工委的加1－2分。', '1376055498255765504', '', '统战工作', 3),
	('1376061041162719233', 'admin', '2021-03-28 14:38:12.853000', 0, NULL, NULL, '隐瞒、谎报、缓报、漏报或者授意他人隐瞒、谎报、缓报涉稳信息、信访信息的，每件扣1分，造成严重后果的，加扣1分。', '1376055559643598848', '', '综治工作', 1),
	('1376061096108101633', 'admin', '2021-03-28 14:38:25.953000', 0, NULL, NULL, '未及时上报每月《矛盾纠纷和不稳定因素排摸月报表》的，每次扣0.5分；遇有紧急情况或重大节点期间，未根据有关要求开展排查工作并上报的，每次扣1分。', '1376055559643598848', '', '综治工作', 2),
	('1376061136792850433', 'admin', '2021-03-28 14:38:35.655000', 0, NULL, NULL, '流动人口管理服务工作落地不到位，包括流动人口居住登记、居住信息准确率、居住房屋出租登记，每次扣0.5分。', '1376055559643598848', '', '综治工作', 3),
	('1376061175086845952', 'admin', '2021-03-28 14:38:44.782000', 0, NULL, NULL, '单个到县、市、省、京上访的每例扣0.5、1、2、5分，集体访加倍扣分；集体访涉及多个村群众参与的按单个分别计算，有效参与劝返处置工作的酌情减免；重点维稳人员管控不力，到县去市赴省进京扰序滋事，每人每次加扣1分；发生越级访、集体访、重复访的，每次加扣1分；因村工作不力，导致信访件不满意的，或导致信访件被上级抽查不通过的，导致信访人重复上访的，每例分别扣1分，造成较大影响的扣2分。', '1376055559643598848', '', '综治工作', 4),
	('1376061219991064576', 'admin', '2021-03-28 14:38:55.489000', 0, NULL, NULL, '未及时化解双联中心推送的纠纷警情或处理后仍未有效化解，每起扣0.5分。', '1376055559643598848', '', '综治工作', 5),
	('1376061252010381313', 'admin', '2021-03-28 14:39:03.123000', 0, NULL, NULL, '严重精神障碍患者监管工作不力，肇事肇祸的，每例扣1分；预防青少年违法犯罪工作不到位，扣1分。', '1376055559643598848', '', '综治工作', 6),
	('1376061292879679489', 'admin', '2021-03-28 14:39:12.866000', 0, NULL, NULL, '未配合犬类整治工作，造成无主犬类多次伤人而未捕杀，每例扣0.5分。', '1376055559643598848', '', '综治工作', 7),
	('1376061323561013249', 'admin', '2021-03-28 14:39:20.183000', 0, NULL, NULL, '未积极开展平安创建工作，每月平安巡防志愿者活动未达2次，扣1分；平安宣传工作落实不力，扣0.5分；未按要求开展道路交通安全隐患排摸，扣1分，引发安全意外死亡，每例扣2分；', '1376055559643598848', '', '综治工作', 8),
	('1376061362677092353', 'admin', '2021-03-28 14:39:29.510000', 0, NULL, NULL, '不履行网格长工作职责，造成网格工作运行流转不畅的，扣1分；根据镇指挥中心每月通报，扣除e宁波系统不达标网格0.5分；', '1376055559643598848', '', '综治工作', 9),
	('1376061401042391041', 'admin', '2021-03-28 14:39:38.655000', 0, NULL, NULL, '对本村发生的各类纠纷情况不清、底子不明，导致矛盾纠纷出村的，每例扣0.5分；未及时调解村内发生的各类纠纷或未按规定上报至镇矛调中心，导致矛盾纠纷反映至县级以上有关单位，每例扣2分；因矛盾纠纷调处不及时，发生治安案件、刑事案件的，每件分别扣2分、3分。', '1376055559643598848', '', '综治工作', 10),
	('1376061446621892608', 'admin', '2021-03-28 14:39:49.522000', 0, NULL, NULL, '未落实社区矫正帮教管控及刑满释放人员安置帮教措施的，扣0.5分；因此导致社区矫正对象及刑满释放人员重新犯罪的，每例加扣1分；不配合镇普法办开展乡村法治讲座、法治宣传进文化礼堂等活动的，每例扣1分。', '1376055559643598848', '', '综治工作', 11),
	('1376061481715634176', 'admin', '2021-03-28 14:39:57.889000', 0, NULL, NULL, '其他事项需要加扣分项。', '1376055559643598848', '', '综治工作', 12),
	('1376061518331908097', 'admin', '2021-03-28 14:40:06.618000', 0, NULL, NULL, '兵役登记率未达到100%的，扣1分。', '1376055627377414144', '', '武装工作', 1),
	('1376061578058797057', 'admin', '2021-03-28 14:40:20.859000', 0, NULL, NULL, '征兵工作应征青年体检率未达到100%，按每下降5%扣0.5分。', '1376055627377414144', '', '武装工作', 2),
	('1376061625668341761', 'admin', '2021-03-28 14:40:32.210000', 0, NULL, NULL, '配合征兵工作，动员应征青年光荣入伍，每出兵1例加0.5分，为大学毕业生的，每例再加0.5分。', '1376055627377414144', '', '武装工作', 3),
	('1376061669565927425', 'admin', '2021-03-28 14:40:42.676000', 0, NULL, NULL, '未按规定落实民兵连长换届的，扣1分。', '1376055627377414144', '', '武装工作', 4),
	('1376061708296130561', 'admin', '2021-03-28 14:40:51.000000', 0, 'admin', '2021-03-28 14:41:08.093000', '民兵连部规范化建设首次达标的，加1分；受到县级或县级以上参观的，加1分。', '1376055627377414144', '', '武装工作', 5),
	('1376061822972596224', 'admin', '2021-03-28 14:41:19.250000', 0, NULL, NULL, '民兵连预设党支部未建立的，扣1分。', '1376055627377414144', '', '武装工作', 6),
	('1376061860708749313', 'admin', '2021-03-28 14:41:28.249000', 0, NULL, NULL, '有出动民兵参加执行重大任务或抢险救灾的，酌情加0.5－1分。', '1376055627377414144', '', '武装工作', 7),
	('1376061909106823169', 'admin', '2021-03-28 14:41:39.787000', 0, NULL, NULL, '悬挂光荣牌未落实到位的，每遗落1人扣0.5分。', '1376055627377414144', '', '武装工作', 8),
	('1376061972549865473', 'admin', '2021-03-28 14:41:54.912000', 0, NULL, NULL, '八一、春节未开展大走访大慰问活动的，扣1分（以慰问照片或打电话抽查为准）。', '1376055627377414144', '', '武装工作', 9),
	('1376062008096591873', 'admin', '2021-03-28 14:42:03.388000', 0, NULL, NULL, '建成全国示范型退役军人服务站的，加3分，建成“枫桥式”退役军人服务站的，加1.5分。', '1376055627377414144', '', '武装工作', 10),
	('1376062044457013249', 'admin', '2021-03-28 14:42:12.057000', 0, NULL, NULL, '落实退役军人轮值站长制度和每月8日学习制度不力的，分别酌情扣1－2分。', '1376055627377414144', '', '武装工作', 11),
	('1376062123402203137', 'admin', '2021-03-28 14:42:30.879000', 0, NULL, NULL, '发挥退役军人作用明显，积极组织退役军人志愿队服务社会发展的，加1分。', '1376055627377414144', '', '武装工作', 12),
	('1376062172903378944', 'admin', '2021-03-28 14:42:42.683000', 0, NULL, NULL, '因工作不到位，造成退役军人到县级或县级以上单位非法上访的，每人每例扣1分。', '1376055627377414144', '', '武装工作', 13),
	('1376062219527262209', 'admin', '2021-03-28 14:42:53.797000', 0, NULL, NULL, '日常工作配合不积极的，扣0.5－3分。', '1376055692636590081', '', '群团工作', 1),
	('1376062269368176641', 'admin', '2021-03-28 14:43:05.680000', 0, NULL, NULL, '成功创建县级以上有关项目的，加1－3分。', '1376055692636590081', '', '群团工作', 2),
	('1376062317824970753', 'admin', '2021-03-28 14:43:17.233000', 0, NULL, NULL, '未按要求及时排摸、反馈所在村的食品、药品等公共安全协管工作相关信息的，每例扣0.5分；导致出现较大影响公共安全问题的，酌情加扣1－3分。', '1376055764153667584', '', '食药环保', 1),
	('1376062339652128769', 'admin', '2021-03-28 14:43:22.437000', 0, NULL, NULL, '未按要求开展网格内环境保护方面问题巡查监督工作的，每例扣1分；巡查中发现建筑工地扬尘污染、垃圾焚烧及农业农村废弃物焚烧以及畜禽养殖污染等环境问题，未及时进行制止并上报的，每例扣1分；出现更为严重的环境问题的，酌情加扣1－3分。', '1376055764153667584', '', '食药环保', 2),
	('1376062443607953409', 'admin', '2021-03-28 14:43:47.222000', 0, NULL, NULL, '完成水利工程项目，水环境工程、小流域整治工程、高标准农田项目等，每个加0.5分。', '1376055816355975169', '', '农业农村工作', 1),
	('1376062482858250240', 'admin', '2021-03-28 14:43:56.580000', 0, NULL, NULL, '违反财务制度的，每例酌情扣2－4分。', '1376055816355975169', '', '农业农村工作', 2),
	('1376062522238570497', 'admin', '2021-03-28 14:44:05.969000', 0, NULL, NULL, '建设美丽新农村，打造小集镇式中心村的，加1.5分；打造美丽乡村示范村的，加1分；完成乡村梳理式改造的，加0.5分；市级以上的另加1、2、3分。', '1376055816355975169', '', '农业农村工作', 3),
	('1376062553456775169', 'admin', '2021-03-28 14:44:13.412000', 0, NULL, NULL, '完成森林防灭火工作，发生违规野外用火案件的，每例扣1分；完成市级以上公益林生态保护管理工作的，加1分；完成两株及以上散生古树名木或一个群及以上保护管理工作的，加0.5分。', '1376055816355975169', '', '农业农村工作', 4),
	('1376062588886061057', 'admin', '2021-03-28 14:44:21.860000', 0, NULL, NULL, '完成农村综合改革（村级公益事业建设）项目，市级加2分，县级加1分。', '1376055816355975169', '', '农业农村工作', 5),
	('1376062618451709953', 'admin', '2021-03-28 14:44:28.908000', 0, NULL, NULL, '农调队农业调查未完成的，扣1分。', '1376055816355975169', '', '农业农村工作', 6),
	('1376062667336323072', 'admin', '2021-03-28 14:44:40.563000', 0, NULL, NULL, '未落实定人联船制度的，扣1分。', '1376055816355975169', '', '农业农村工作', 7),
	('1376062696696451072', 'admin', '2021-03-28 14:44:47.562000', 0, NULL, NULL, '未完成年度五水共治工作任务的，扣1分；未落实河长制被通报的，每例扣0.5分。', '1376055816355975169', '', '农业农村工作', 8),
	('1376062731429482497', 'admin', '2021-03-28 14:44:55.844000', 0, NULL, NULL, '未完成上级交办其他工作的，每项扣1分。', '1376055816355975169', '', '农业农村工作', 9),
	('1376062800148959233', 'admin', '2021-03-28 14:45:12.228000', 0, NULL, NULL, '计划生育工作按照《长街镇联村干部、村干部计划生育工作考核办法》执行，达不到要求的，酌情扣0.5－2分。', '1376055873146851329', '', '社会事务工作', 1),
	('1376062842683396096', 'admin', '2021-03-28 14:45:22.371000', 0, NULL, NULL, '未完成年度无偿献血任务的，酌情扣0.5－2分。', '1376055873146851329', '', '社会事务工作', 2),
	('1376062868021186561', 'admin', '2021-03-28 14:45:28.410000', 0, NULL, NULL, '未完成各级卫生村复查和创建任务的，酌情扣0.5－2分。', '1376055873146851329', '', '社会事务工作', 3),
	('1376062899549769728', 'admin', '2021-03-28 14:45:35.927000', 0, NULL, NULL, '在国家卫生城镇创建中，涉及村工作达不到要求的，酌情扣0.5－2分。', '1376055873146851329', '', '社会事务工作', 4),
	('1376062926678528001', 'admin', '2021-03-28 14:45:42.395000', 0, NULL, NULL, '健康宣传栏维护达不到要求的，扣0.5分。', '1376055873146851329', '', '社会事务工作', 5),
	('1376062959905804289', 'admin', '2021-03-28 14:45:50.317000', 0, NULL, NULL, '未完成家庭医生签约任务的，未完成的，酌情扣0.5－1分。', '1376055873146851329', '', '社会事务工作', 6),
	('1376062990947848193', 'admin', '2021-03-28 14:45:57.719000', 0, NULL, NULL, '根据《长街镇农村环境卫生和垃圾分类工作考核办法》，经第三方考核年度汇总，结果为优秀的，加2分；结果为良好的，加1分；结果为不合格的，酌情扣1－2分。', '1376055873146851329', '', '社会事务工作', 7),
	('1376063027480236033', 'admin', '2021-03-28 14:46:06.428000', 0, NULL, NULL, '各级体育项目建设、维护和管理工作达不到要求的，酌情扣0.5－1分；', '1376055873146851329', '', '社会事务工作', 8),
	('1376063072376066049', 'admin', '2021-03-28 14:46:17.132000', 0, NULL, NULL, '不能按要求组队参加县、镇各级体育赛事活动的，酌情扣0.5－1分。', '1376055873146851329', '', '社会事务工作', 9),
	('1376063114679816193', 'admin', '2021-03-28 14:46:27.219000', 0, NULL, NULL, '学生防溺水工作达不到要求的，扣0.5分，发生有关事故的，酌情加扣0.5－1分。', '1376055873146851329', '', '社会事务工作', 10),
	('1376063144828473345', 'admin', '2021-03-28 14:46:34.407000', 0, NULL, NULL, '未按要求做好居家健康观察人员硬隔离工作的，每例扣0.5分，造成重大影响的，酌情加扣0.5－2分。', '1376055873146851329', '', '社会事务工作', 11),
	('1376063177766342657', 'admin', '2021-03-28 14:46:42.260000', 0, NULL, NULL, '防疫工作不到位，未按防疫要求做好乡村码登记工作的，酌情扣0.5－2分。', '1376055873146851329', '', '社会事务工作', 12),
	('1376063221923975168', 'admin', '2021-03-28 14:46:52.789000', 0, NULL, NULL, '未做好甬行码扫码工作的，按镇通报次数多少，酌情扣0.5－2分。', '1376055873146851329', '', '社会事务工作', 13),
	('1376063265385353217', 'admin', '2021-03-28 14:47:03.150000', 0, NULL, NULL, '出现“两违”行为且处理未到位的，每例扣1分。', '1376055927039463424', '', '村镇建设工作', 1),
	('1376063323451297793', 'admin', '2021-03-28 14:47:16.993000', 0, NULL, NULL, '煽动群众阻扰镇政府及有关部门拆违行动的，每例扣2分；农村建房纠纷未在村内调处解决，上交至镇政府及有关部门的，镇政府及有关部门调处解决农村建房纠纷时，村方不予配合或进行阻扰的，每项每例扣1分；未按规定程序进行农村建房审批，出现未批先建行为的，农村建房选址未按村庄规划要求开展，出现擅自建设行为的，未根据土地利用总体规划擅自建设的，每项每例扣1分；公共资源交易出现“应招未招”情况的，每例扣1分。', '1376055927039463424', '', '村镇建设工作', 2),
	('1376063363095859201', 'admin', '2021-03-28 14:47:26.446000', 0, NULL, NULL, '分拆项目规避招标行为的，每例扣2分。', '1376055927039463424', '', '村镇建设工作', 3),
	('1376063401612152833', 'admin', '2021-03-28 14:47:35.629000', 0, NULL, NULL, '村级项目实施中出现安全事故，每例扣1分，引起较大社会影响的，每例加扣1分；村级项目实施未能按期开展，每例扣1分，工期滞后严重且造成重大影响的，每例加扣1分；在村级项目结算过程中出现农民工讨薪事件的，每例扣1分。', '1376055927039463424', '', '村镇建设工作', 4),
	('1376063487859625985', 'admin', '2021-03-28 14:47:56.191000', 0, NULL, NULL, '城乡居民基本养老保险参保率未达到97%的，酌情扣0.5－1分；城乡居民基本养老保险到龄人员未及时参保的，每例扣0.5分；失土保险对象未严格审核的，每例扣0.5分。', '1376055986367893505', '', '便民工作', 1),
	('1376063520763940865', 'admin', '2021-03-28 14:48:04.037000', 0, NULL, NULL, '城乡居民基本医疗保险参保率未达99.5%的，扣0.5－1分，未按规定时间上报参保名单的，扣0.5分，未及时缴纳医保资金的，扣1分。', '1376055986367893505', '', '便民工作', 2),
	('1376063555199176704', 'admin', '2021-03-28 14:48:12.246000', 0, NULL, NULL, '殡葬管理工作未按要求落实的，每例扣0.5分；低保对象未严格审核的，每例扣0.5分；在取消低保、低边、五保户过程中未积极配合的，每例扣0.5分；村级居家养老服务站未达AA级的，扣0.5分，创建达AAA级的，加0.5分。', '1376055986367893505', '', '便民工作', 3),
	('1376063592868220929', 'admin', '2021-03-28 14:48:21.228000', 0, NULL, NULL, '配合残疾人动态调查不积极的，扣0.5分；配合开展残疾人“两项补贴”不积极的，扣0.5分。', '1376055986367893505', '', '便民工作', 4),
	('1376063631585841153', 'admin', '2021-03-28 14:48:30.459000', 0, NULL, NULL, '未完成慈善募捐任务的，酌情扣0.5－1分。', '1376055986367893505', '', '便民工作', 5),
	('1376063666214014977', 'admin', '2021-03-28 14:48:38.714000', 0, NULL, NULL, '未配合“两个满意度”调查的，扣0.5分；政务和“最多跑一次”涉及便民服务事项落实不到位的，扣0.5分。', '1376055986367893505', '', '便民工作', 6),
	('1376063719389401089', 'admin', '2021-03-28 14:48:51.393000', 0, NULL, NULL, '未严格落实镇三防指挥部指令的，每例扣1分；发生“三防”事故，每例扣2分。', '1376056061106196480', '', '应急工作', 1),
	('1376063785202225153', 'admin', '2021-03-28 14:49:07.084000', 0, NULL, NULL, '未严格按照镇森林防火要求设卡、设点的，扣1分；发生火警，每例扣0.5分；发生森林火灾，每例扣1分，特别严重的，加扣1分。', '1376056061106196480', '', '应急工作', 2),
	('1376063818563719168', 'admin', '2021-03-28 14:49:15.040000', 0, NULL, NULL, '开展村内防灾减灾应急演习的，加0.5-1分；开展避灾安置点规范化建设的，加0.5分。', '1376056061106196480', '', '应急工作', 3),
	('1376063867871956992', 'admin', '2021-03-28 14:49:26.795000', 0, NULL, NULL, '未落实安全生产责任制的，扣0.5分；未落实安全生产网格员制度的，扣0.5分；非法售卖烟花爆竹的，每例扣0.5分；发生一般安全事故的，每例扣0.5分；发生村庄火灾的，每例扣0.5－1分。', '1376056061106196480', '', '应急工作', 4),
	('1376063912952336384', 'admin', '2021-03-28 14:49:37.542000', 0, NULL, NULL, '发生较大事故以上扣10分。', '1376056061106196480', '', '应急工作', 5),
	('1376063966589095937', 'admin', '2021-03-28 14:49:50.330000', 0, NULL, NULL, '其他事项需要加扣分的内容。', '1376056061106196480', '', '应急工作', 6),
	('1376064014592905217', 'admin', '2021-03-28 14:50:01.775000', 0, NULL, NULL, '重大决策落实和重点工作推进不力的，每例酌情扣1－10分。', '1376056353117835265', '', '重大项目', 1),
	('1376064060583448576', 'admin', '2021-03-28 14:50:12.739000', 0, NULL, NULL, '配合完成镇及以上重点工程、重大项目落地政策处理的，每例酌情加1-10分。配合推进不力的，每例酌情扣1－10分。', '1376056353117835265', '', '重大项目', 2),
	('1376064138501033985', 'admin', '2021-03-28 14:50:31.318000', 0, NULL, NULL, '协助引进规（限）上内资企业加1分；引进外资企业加2分；实到外资每增加100万美元加1分。村民引进隶属长街镇企业的参照执行。', '1376056424781713409', '', '工业工作', 1),
	('1376064179752013825', 'admin', '2021-03-28 14:50:41.154000', 0, NULL, NULL, '协助申报甬江引才计划团队、人员，每个加1分，申报成功的，加2分。', '1376056487633358848', '', '人才工作', 1),
	('1376064208122286080', 'admin', '2021-03-28 14:50:47.915000', 0, NULL, NULL, '协助引进高层次人才团队，每个加1分。', '1376056487633358848', '', '人才工作', 2),
	('1376064259544453120', 'admin', '2021-03-28 14:51:00.176000', 0, NULL, NULL, '新建省市旅游基地的，加0.5分；新建通过文旅部门评定的A级旅游厕所的，加0.5分，最高加1分；文化和旅游资源各项普查工作配合不积极的，扣0.5分。', '1376056537973395457', '', '旅游工作', 1),
	('1376064444416790529', 'admin', '2021-03-28 14:51:44.254000', 0, NULL, NULL, '被评为省AAA级、AA级、A级景区村庄的，分别加2分、1分、0.5分，同一行政村不重复累计；年度通过验收认定新增民宿床位20张（含）以上的，加1分，超过50张（含）的，加2分，新增白金宿、金宿、银宿的，每家分别加3分、2分、1分，同一民宿不重复累计，最高加3分；新建成游客中心、停车场、游步道、标识系统等乡村旅游基础设施，每个加0.5分，最高加2分。', '1376056537973395457', '', '旅游工作', 2),
	('1376064475609829377', 'admin', '2021-03-28 14:51:51.690000', 0, NULL, NULL, '积极参加上级文旅部门组织的旅游交易会及推介会的，加0.5分；有效配合做好“5·19”徐霞客开游节相关活动的，加0.5分；举办镇级节庆活动的，每例加1分，成效显著的，再加1分；举办的文旅节事活动获上级主管部门嘉奖的，加1分。', '1376056537973395457', '', '旅游工作', 3),
	('1376064501807452161', 'admin', '2021-03-28 14:51:57.936000', 0, NULL, NULL, '在上级各项检查、暗访、复核、评定工作中被通报、摘牌或整改不到位的，酌情扣1－3分。', '1376056537973395457', '', '旅游工作', 4),
	('1376064634565562369', 'admin', '2021-03-28 14:52:29.588000', 0, NULL, NULL, '实行信访“四无村”考核，无到县级及以上信访、无群体访、无信访滋事扰序事件、无信访舆论炒作事件；连续1－5年无到县级以上单位信访，且无到镇集体访，存在到镇信访但由村劝回的，分别奖励1、3、5、7、9万元。', '1376056590121177088', '', '信访', 1),
	('1376064684570054657', 'admin', '2021-03-28 14:52:41.509000', 0, NULL, NULL, '有关工作获镇党委政府，县、市、省级部门通报表扬的，分别加2、4、6、10分；工作有创新，先进经验被镇、县、市、省推广的，分别加4、8、12、20分；同一项目，就高加分。', '1376056934603558912', '', '加分项', 1),
	('1376064716715200513', 'admin', '2021-03-28 14:52:49.174000', 0, NULL, NULL, '凡行政村当年被评为镇、县、市、省、国家级综合先进的，分别加2、4、8、12、24分，同一项目就高加分。', '1376056934603558912', '', '加分项', 2),
	('1376064741449011201', 'admin', '2021-03-28 14:52:55.071000', 0, NULL, NULL, '经镇党委会研究决定给予加分的情形。', '1376056934603558912', '', '加分项', 3),
	('1376064788546850817', 'admin', '2021-03-28 14:53:06.300000', 0, NULL, NULL, '有关工作被镇通报的，每例扣1分，被县级部门通报的，每例扣2分，被县委县政府及办公室通报的，每例扣4分，市级以上通报的分类分级加倍扣分。（单线另行规定的除外）', '1376057004744904705', '', '扣分情况', 1),
	('1376064852547735553', 'admin', '2021-03-28 14:53:21.560000', 0, NULL, NULL, '本人被司法机关处理的。', '1376057045131857920', '', '否决项', 1),
	('1376064881954000897', 'admin', '2021-03-28 14:53:28.570000', 0, NULL, NULL, '连续3年未发展党员。', '1376057045131857920', '', '否决项', 2),
	('1376064906188689408', 'admin', '2021-03-28 14:53:34.348000', 0, NULL, NULL, '县、镇党代表、人大代表、县政协委员选举不支持、不配合的。', '1376057045131857920', '', '否决项', 3),
	('1376064945497706497', 'admin', '2021-03-28 14:53:43.721000', 0, NULL, NULL, '所在村本年度发生审计移送县级部门案件的。', '1376057045131857920', '', '否决项', 4),
	('1376064974128025601', 'admin', '2021-03-28 14:53:50.546000', 0, NULL, NULL, '食品药品安全和环保网格监管发生重大事故以上实行“一票否决”（因不可抗力因素除外）。', '1376057045131857920', '', '否决项', 5),
	('1376065014322040833', 'admin', '2021-03-28 14:54:00.128000', 0, NULL, NULL, '发生较大事故以上实行“一票否决”。', '1376057045131857920', '', '否决项', 6),
	('1376065052322435073', 'admin', '2021-03-28 14:54:09.210000', 0, NULL, NULL, '民宗出现政治问题、安全问题和重大违建问题实行一票否决。', '1376057045131857920', '', '否决项', 7),
	('1376065086585704449', 'admin', '2021-03-28 14:54:17.358000', 0, NULL, NULL, '防疫工作执行不到位被县级以上通报或导致重大事故的。', '1376057045131857920', '', '否决项', 8),
	('1376065120848973825', 'admin', '2021-03-28 14:54:25.528000', 0, NULL, NULL, '县里有另行规定的其他情况。', '1376057045131857920', '', '否决项', 9);
/*!40000 ALTER TABLE `t_assessment_line_item` ENABLE KEYS */;

-- 导出  表 nhcj.t_assessment_time 结构
DROP TABLE IF EXISTS `t_assessment_time`;
CREATE TABLE IF NOT EXISTS `t_assessment_time` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `is_run` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `time_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `time_remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sort_level` int(11) NOT NULL,
  `end_cuo` bigint(20) NOT NULL,
  `end_date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `start_cuo` bigint(20) NOT NULL,
  `start_date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_assessment_time 的数据：~0 rows (大约)
DELETE FROM `t_assessment_time`;
/*!40000 ALTER TABLE `t_assessment_time` DISABLE KEYS */;
INSERT INTO `t_assessment_time` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `is_run`, `time_name`, `time_remark`, `sort_level`, `end_cuo`, `end_date`, `start_cuo`, `start_date`) VALUES
	('1376067966306750464', 'admin', '2021-03-28 15:05:43.942000', 0, NULL, NULL, NULL, '2021年3月考核期', '', 1, 0, '2021-04-01', 1617206400, '2021-03-01');
/*!40000 ALTER TABLE `t_assessment_time` ENABLE KEYS */;

-- 导出  表 nhcj.t_car 结构
DROP TABLE IF EXISTS `t_car`;
CREATE TABLE IF NOT EXISTS `t_car` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `address_hu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `address_zhu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `bao_xian` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `gu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `is_jia` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `jia` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `jia_number` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `owner_idcard` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `pai_hao` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `piao_photo` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `pin_pai` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re2` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sell_date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `seller_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `seller_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `xing_hao` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `file_id` int(11) NOT NULL,
  `sh` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `car_photo` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_car 的数据：~20 rows (大约)
DELETE FROM `t_car`;
/*!40000 ALTER TABLE `t_car` DISABLE KEYS */;
INSERT INTO `t_car` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `address_hu`, `address_zhu`, `bao_xian`, `gu`, `is_jia`, `jia`, `jia_number`, `mobile`, `name`, `owner_idcard`, `pai_hao`, `piao_photo`, `pin_pai`, `re1`, `re2`, `remark`, `sell_date`, `seller_id`, `seller_name`, `type`, `xing_hao`, `file_id`, `sh`, `car_photo`) VALUES
	('1385474202722766849', 'admin', '2021-04-23 14:02:45.484000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组134号', '浙江省宁海县长街镇大祝村1组134号', '2021-04-23', '', NULL, '', NULL, '', '吴威平', '330226196106167035', '长街10-0001', '0cd432271e564755afd8d81bfc04afbc.IMG_20210416_074251.jpg', '轻铃', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '', '', 1, '1', '4fe19ce333764943b9b13134bb1a33f9.IMG_20210416_074438.jpg'),
	('1385474853909434369', 'admin', '2021-04-23 14:05:20.722000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组29号', '浙江省宁海县长街镇大祝村1组29号', '2021-04-23', '', NULL, '', NULL, '', '徐金凤', '330226194509177044', '长街10-0002', '2b987ae2e0b94221aa35bdd0194c8dde.5.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 2, '1', 'c14ea0c10cb44c548e125ef595be7ba7.6.jpg'),
	('1385475186408689665', 'admin', '2021-04-23 14:06:39.997000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组10号', '浙江省宁海县长街镇大祝村1组10号', '', '', NULL, '', NULL, '', '王锡军', '33022619630907703X', '长街10-0003', '545355fa913b47cbb74afb1f51b6b3a5.IMG_20210416_080622.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 3, '1', '398a9a62440849c78b8bd66c9fcc0a8e.IMG_20210416_080733.jpg'),
	('1385475700043157505', 'admin', '2021-04-23 14:08:42.457000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组33号', '浙江省宁海县长街镇大祝村1组33号', '2021-04-23', '', NULL, '', NULL, '', '胡杏花', '330226195105147046', '长街10-0005', '71ab5227b932400d99da437a58318404.IMG_20210416_081059.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 4, '1', '011582b41d404d3699b176e324bda25a.IMG_20210416_081227.jpg'),
	('1385476140642209793', 'admin', '2021-04-23 14:10:27.503000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组86号', '浙江省宁海县长街镇大祝村1组86号', '2021-04-23', '', NULL, '', NULL, '', '祝立方', '330226194301157052', '长街10-0006', '803f76c1dbce4f40ad8c4013939a2efd.IMG_20210416_081541.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '汽油三轮车', '', 5, '1', '76c09a22e96645a8ab504a669dc687ff.IMG_20210416_081650.jpg'),
	('1385476432960032769', 'admin', '2021-04-23 14:11:37.198000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组8号', '浙江省宁海县长街镇大祝村1组8号', '2021-04-23', '', NULL, '', NULL, '', '范二妹', '330226195006137045', '长街10-0007', '94f60d59db4c483e8533de90dd4a8b58.IMG_20210416_082233.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 6, '1', '3ca9814208c84497a3f9b00d1a8994b1.IMG_20210416_082244.jpg'),
	('1385476740528345088', 'admin', '2021-04-23 14:12:50.522000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组52号', '浙江省宁海县长街镇大祝村1组52号', '2021-04-23', '', NULL, '', NULL, '', '祝良基', '330226195305067032', '长街10-0008', '5a3083dea1b443f3a601db0504e117c3.IMG_20210416_082628.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 7, '1', 'ba7f5ed155854cf1b5e5fd9d02f4dd6d.IMG_20210416_082637.jpg'),
	('1385476959324213249', 'admin', '2021-04-23 14:13:42.677000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组122号', '浙江省宁海县长街镇大祝村1组122号', '2021-04-23', '', NULL, '', NULL, '', '祝良满', '330226196101087052', '长街10-0009', '2b6a68c4b24648dd9fc4b4c2d7567cc5.IMG_20210416_083038.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 8, '1', 'ffb7147b2fc94efbb20f1f689eba3ecc.IMG_20210416_083257.jpg'),
	('1385477241131110401', 'admin', '2021-04-23 14:14:49.880000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组41号', '浙江省宁海县长街镇大祝村1组41号', '2021-04-23', '', NULL, '', NULL, '', '祝元明', '330226194703047032', '长街10-0010', '94216556d1e24dd6b9df00453fc5bf9f.IMG_20210416_083038.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 9, '1', 'd951dc389f0942f094fbffc38cd4da0c.IMG_20210416_083257.jpg'),
	('1385477569440256001', 'admin', '2021-04-23 14:16:08.156000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组32号', '浙江省宁海县长街镇大祝村1组32号', '2021-04-23', '', NULL, '', NULL, '', '胡小振', '330226195708307037', '长街10-0011', 'c7f6c66715b3442aa751aa3247ec501c.IMG_20210416_083843.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 10, '1', '2317db2e866c42edb8ae136e462a1c55.IMG_20210416_084016.jpg'),
	('1385477842632052737', 'admin', '2021-04-23 14:17:13.290000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组22号', '浙江省宁海县长街镇大祝村1组22号', '2021-04-23', '', NULL, '', NULL, '', '祝立义', '330226193811017071', '长街10-0012', 'b1fcd9aaa31a4fe4bf4db97cd6422ff7.IMG_20210416_084458.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 11, '1', '7508e1f7d86e4baba6a8e54cde24aebb.IMG_20210416_084810.jpg'),
	('1385478087340331009', 'admin', '2021-04-23 14:18:11.617000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组15号', '浙江省宁海县长街镇大祝村1组15号', '2021-04-23', '', NULL, '', NULL, '', '柳小钱', '330226194705087038', '长街10-0013', 'eb9e4ff9e7374077b7815043616fd425.IMG_20210416_085044.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 12, '1', '57d1cad213d14ea7a56b68e0a78b822b.IMG_20210416_085108.jpg'),
	('1385478551196798977', 'admin', '2021-04-23 14:20:02.224000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组136号', '浙江省宁海县长街镇大祝村1组136号', '2021-04-23', '', NULL, '', NULL, '', '祝元昌', '330226195310187039', '长街10-0015', '151ac29dbd3246d8b43f08b0e868fef8.IMG_20210416_085333.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '汽油三轮车', '', 13, '1', '9f3aac67115349c589ec5b3e8296ac9e.IMG_20210416_085340.jpg'),
	('1385478868751749121', 'admin', '2021-04-23 14:21:17.935000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组96号', '浙江省宁海县长街镇大祝村1组96号', '2021-04-23', '', NULL, '', NULL, '', '王雪芬', '330226197210267049', '长街10-0016', 'f59226d5b8af4555a69f3cc8a3d6094a.IMG_20210416_085740.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '汽油三轮车', '', 14, '1', 'da33a45a88c44c1aa8089b2b94add73c.IMG_20210416_085800.jpg'),
	('1385479075828731905', 'admin', '2021-04-23 14:22:07.306000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组122号', '浙江省宁海县长街镇大祝村1组122号', '2021-04-23', '', NULL, '', NULL, '', '祝良满', '330226196101087052', '长街10-0017', 'f85f25b8ceda4707ad0d1ac10a4e679f.IMG_20210416_090416.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '汽油三轮车', '', 15, '1', '9930007892c247f7baea598262c339de.IMG_20210416_090428.jpg'),
	('1385479305785643009', 'admin', '2021-04-23 14:23:02.132000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组111号', '浙江省宁海县长街镇大祝村1组111号', '2021-04-23', '', NULL, '', NULL, '', '祝绍进', '330226197812037697', '长街10-0018', '7587d48631fd43e0896d821dbf05a488.IMG_20210416_084056.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 16, '1', '655ef697fdfd4531a4b5f57198a5b488.IMG_20210416_084406.jpg'),
	('1385479550183542785', 'admin', '2021-04-23 14:24:00.402000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组105号', '浙江省宁海县长街镇大祝村1组105号', '2021-04-23', '', NULL, '', NULL, '', '祝良西', '330226195605137039', '长街10-0019', 'af8c05b576ca47d2abaeb4c6df0d6025.IMG_20210416_091102.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 17, '1', '88f6b0f22e194219a00ed1e5000aedd8.IMG_20210416_091113.jpg'),
	('1385479775350558720', 'admin', '2021-04-23 14:24:54.070000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组131号', '浙江省宁海县长街镇大祝村1组131号', '2021-04-23', '', NULL, '', NULL, '', '吴威岳', '330226195107017034', '长街10-0020', '644465337cd8401a88d4d42a7f693d8c.2.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 18, '1', 'e64b9a24f1b84a14b09f25d69e544804.3.jpg'),
	('1385480027369508865', 'admin', '2021-04-23 14:25:54.156000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组42号', '浙江省宁海县长街镇大祝村1组42号', '2021-04-23', '', NULL, '', NULL, '', '胡全利', '330226195311137033', '长街10-0021', 'e042b5fad84943ac82c94bf2e767e7a1.IMG_20210416_092558.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '电动三轮车', '', 19, '1', '9768fa81ff76414bb46c55040f790fe8.IMG_20210416_092604.jpg'),
	('1385480245251018753', 'admin', '2021-04-23 14:26:46.119000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组174号', '浙江省宁海县长街镇大祝村1组174号', '2021-04-23', '', NULL, '', NULL, '', '祝婷婷', '330226198401197041', '长街10-0022', 'fcdbd307418a4759bcdbc320c25cd10a.IMG_20210416_092558.jpg', '', NULL, NULL, '', '', '1385394385809707009', '虚拟店铺', '汽油三轮车', '', 20, '1', 'd75fa6e301774c03a20dc057dbbd159a.IMG_20210416_092604.jpg');
/*!40000 ALTER TABLE `t_car` ENABLE KEYS */;

-- 导出  表 nhcj.t_car_owner 结构
DROP TABLE IF EXISTS `t_car_owner`;
CREATE TABLE IF NOT EXISTS `t_car_owner` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `address_hu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `address_zhu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `is_jia` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `jia_number` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `owner_idcard` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re2` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_car_owner 的数据：~19 rows (大约)
DELETE FROM `t_car_owner`;
/*!40000 ALTER TABLE `t_car_owner` DISABLE KEYS */;
INSERT INTO `t_car_owner` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `address_hu`, `address_zhu`, `is_jia`, `jia_number`, `mobile`, `name`, `owner_idcard`, `re1`, `re2`) VALUES
	('1385470604240621570', 'admin', '2021-04-23 13:48:27.523000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村一组134号', '浙江省宁海县长街镇大祝村一组134号', NULL, NULL, '', '吴威平', '330226196106167035', NULL, NULL),
	('1385471002301042690', 'admin', '2021-04-23 13:50:02.427000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组29号', '浙江省宁海县长街镇大祝村1组29号', NULL, NULL, '', '徐金凤', '330226194509177044', NULL, NULL),
	('1385475186408689666', 'admin', '2021-04-23 14:06:39.981000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组10号', '浙江省宁海县长街镇大祝村1组10号', NULL, NULL, '', '王锡军', '33022619630907703X', NULL, NULL),
	('1385475700043157506', 'admin', '2021-04-23 14:08:42.457000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组33号', '浙江省宁海县长街镇大祝村1组33号', NULL, NULL, '', '胡杏花', '330226195105147046', NULL, NULL),
	('1385476140642209794', 'admin', '2021-04-23 14:10:27.503000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组86号', '浙江省宁海县长街镇大祝村1组86号', NULL, NULL, '', '祝立方', '330226194301157052', NULL, NULL),
	('1385476432960032770', 'admin', '2021-04-23 14:11:37.198000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组8号', '浙江省宁海县长街镇大祝村1组8号', NULL, NULL, '', '范二妹', '330226195006137045', NULL, NULL),
	('1385476740536733696', 'admin', '2021-04-23 14:12:50.517000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组52号', '浙江省宁海县长街镇大祝村1组52号', NULL, NULL, '', '祝良基', '330226195305067032', NULL, NULL),
	('1385476959324213250', 'admin', '2021-04-23 14:13:42.677000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组122号', '浙江省宁海县长街镇大祝村1组122号', NULL, NULL, '', '祝良满', '330226196101087052', NULL, NULL),
	('1385477241131110402', 'admin', '2021-04-23 14:14:49.880000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组41号', '浙江省宁海县长街镇大祝村1组41号', NULL, NULL, '', '祝元明', '330226194703047032', NULL, NULL),
	('1385477569440256002', 'admin', '2021-04-23 14:16:08.156000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组32号', '浙江省宁海县长街镇大祝村1组32号', NULL, NULL, '', '胡小振', '330226195708307037', NULL, NULL),
	('1385477842632052738', 'admin', '2021-04-23 14:17:13.274000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组22号', '浙江省宁海县长街镇大祝村1组22号', NULL, NULL, '', '祝立义', '330226193811017071', NULL, NULL),
	('1385478087340331010', 'admin', '2021-04-23 14:18:11.617000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组15号', '浙江省宁海县长街镇大祝村1组15号', NULL, NULL, '', '柳小钱', '330226194705087038', NULL, NULL),
	('1385478551196798978', 'admin', '2021-04-23 14:20:02.209000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组136号', '浙江省宁海县长街镇大祝村1组136号', NULL, NULL, '', '祝元昌', '330226195310187039', NULL, NULL),
	('1385478868751749122', 'admin', '2021-04-23 14:21:17.935000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组96号', '浙江省宁海县长街镇大祝村1组96号', NULL, NULL, '', '王雪芬', '330226197210267049', NULL, NULL),
	('1385479305785643010', 'admin', '2021-04-23 14:23:02.132000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组111号', '浙江省宁海县长街镇大祝村1组111号', NULL, NULL, '', '祝绍进', '330226197812037697', NULL, NULL),
	('1385479550183542786', 'admin', '2021-04-23 14:24:00.402000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组105号', '浙江省宁海县长街镇大祝村1组105号', NULL, NULL, '', '祝良西', '330226195605137039', NULL, NULL),
	('1385479775350558721', 'admin', '2021-04-23 14:24:54.070000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组131号', '浙江省宁海县长街镇大祝村1组131号', NULL, NULL, '', '吴威岳', '330226195107017034', NULL, NULL),
	('1385480027369508866', 'admin', '2021-04-23 14:25:54.156000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组42号', '浙江省宁海县长街镇大祝村1组42号', NULL, NULL, '', '胡全利', '330226195311137033', NULL, NULL),
	('1385480245251018754', 'admin', '2021-04-23 14:26:46.103000', 0, NULL, NULL, '浙江省宁海县长街镇大祝村1组174号', '浙江省宁海县长街镇大祝村1组174号', NULL, NULL, '', '祝婷婷', '330226198401197041', NULL, NULL);
/*!40000 ALTER TABLE `t_car_owner` ENABLE KEYS */;

-- 导出  表 nhcj.t_client 结构
DROP TABLE IF EXISTS `t_client`;
CREATE TABLE IF NOT EXISTS `t_client` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `home_uri` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `redirect_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_client 的数据：~0 rows (大约)
DELETE FROM `t_client`;
/*!40000 ALTER TABLE `t_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_client` ENABLE KEYS */;

-- 导出  表 nhcj.t_department 结构
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE IF NOT EXISTS `t_department` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_department 的数据：~11 rows (大约)
DELETE FROM `t_department`;
/*!40000 ALTER TABLE `t_department` DISABLE KEYS */;
INSERT INTO `t_department` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `parent_id`, `sort_order`, `status`, `title`, `is_parent`) VALUES
	(40322777781112832, '', '2018-08-10 20:40:40', 0, '', '2018-08-11 00:03:06', 0, 1.00, 0, '总部', b'1'),
	(40322811096469504, '', '2018-08-10 20:40:48', 0, '', '2018-08-11 00:27:05', 40322777781112832, 1.00, 0, '技术部', b'1'),
	(40322852833988608, '', '2018-08-10 20:40:58', 0, '', '2018-08-11 01:29:42', 40322811096469504, 1.00, 0, '研发中心', NULL),
	(40327204755738624, '', '2018-08-10 20:58:15', 0, '', '2018-08-10 22:02:15', 40322811096469504, 2.00, 0, '大数据', NULL),
	(40327253309001728, '', '2018-08-10 20:58:27', 0, '', '2018-08-11 17:26:38', 40322811096469504, 3.00, -1, '人工智障', NULL),
	(40343262766043136, '', '2018-08-10 22:02:04', 0, '', '2018-08-11 00:02:53', 0, 2.00, 0, '成都分部', b'1'),
	(40344005342400512, '', '2018-08-10 22:05:01', 0, '', '2018-08-11 17:48:44', 40343262766043136, 2.00, 0, 'Vue', NULL),
	(40389030113710080, '', '2018-08-11 01:03:56', 0, '', '2018-08-11 17:50:04', 40343262766043136, 1.00, 0, 'JAVA', b'0'),
	(40652270295060480, '', '2018-08-11 18:29:57', 0, '', '2018-08-12 18:45:01', 0, 3.00, 0, '人事部', b'1'),
	(40652338142121984, NULL, '2018-08-11 18:30:13', 0, NULL, '2018-08-11 18:30:13', 40652270295060480, 1.00, 0, '游客', b'0'),
	(40681289119961088, '', '2018-08-11 20:25:16', 0, '', '2018-08-11 22:47:48', 40652270295060480, 2.00, 0, 'VIP', b'0');
/*!40000 ALTER TABLE `t_department` ENABLE KEYS */;

-- 导出  表 nhcj.t_department_header 结构
DROP TABLE IF EXISTS `t_department_header`;
CREATE TABLE IF NOT EXISTS `t_department_header` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_department_header 的数据：~0 rows (大约)
DELETE FROM `t_department_header`;
/*!40000 ALTER TABLE `t_department_header` DISABLE KEYS */;
INSERT INTO `t_department_header` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `department_id`, `type`, `user_id`) VALUES
	(1254427833757995008, 'admin', '2020-04-26 23:11:16', 0, 'admin', '2020-04-26 23:11:16', 40322777781112832, 0, 682265633886208);
/*!40000 ALTER TABLE `t_department_header` ENABLE KEYS */;

-- 导出  表 nhcj.t_dict 结构
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE IF NOT EXISTS `t_dict` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_dict 的数据：~9 rows (大约)
DELETE FROM `t_dict`;
/*!40000 ALTER TABLE `t_dict` DISABLE KEYS */;
INSERT INTO `t_dict` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `title`, `type`, `sort_order`) VALUES
	(75135930788220928, 'admin', '2018-11-14 22:15:43', 0, 'admin', '2018-11-27 01:39:06', '', '性别', 'sex', 0.00),
	(75383353938808832, 'admin', '2018-11-15 14:38:53', 0, 'admin', '2018-11-27 01:39:15', '', '消息类型', 'message_type', 1.00),
	(75388696739713024, 'admin', '2018-11-15 15:00:07', 0, 'admin', '2018-11-27 01:39:22', '', '按钮权限类型', 'permission_type', 2.00),
	(75392985935646720, 'admin', '2018-11-15 15:17:10', 0, 'admin', '2018-11-27 01:39:29', '', '腾讯云对象存储区域', 'tencent_bucket_region', 3.00),
	(79717732567748608, 'admin', '2018-11-27 13:42:10', 0, 'admin', '2018-11-27 13:42:10', '', '流程节点类型', 'process_node_type', 4.00),
	(81843858882695168, 'admin', '2018-12-03 10:30:38', 0, 'admin', '2018-12-03 10:30:49', '', '优先级', 'priority', 5.00),
	(82236987314016256, 'admin', '2018-12-04 12:32:47', 0, 'admin', '2018-12-04 12:32:47', '', '业务表', 'business_table', 6.00),
	(82236987314016257, 'admin', '2018-12-04 12:32:47', 0, 'admin', '2018-12-04 12:32:47', '', '业务表单路由', 'business_form', 7.00),
	(99020862912466944, 'admin', '2019-01-19 20:05:54', 0, 'admin', '2019-01-19 20:06:10', '', '请假类型', 'leave_type', 8.00);
/*!40000 ALTER TABLE `t_dict` ENABLE KEYS */;

-- 导出  表 nhcj.t_dict_data 结构
DROP TABLE IF EXISTS `t_dict_data`;
CREATE TABLE IF NOT EXISTS `t_dict_data` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dict_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_dict_data 的数据：~55 rows (大约)
DELETE FROM `t_dict_data`;
/*!40000 ALTER TABLE `t_dict_data` DISABLE KEYS */;
INSERT INTO `t_dict_data` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `dict_id`, `sort_order`, `status`, `title`, `value`) VALUES
	(75158227712479232, 'admin', '2018-11-14 23:44:19', 0, 'admin', '2019-04-01 23:53:13', '', 75135930788220928, 0.00, 0, '男', '男'),
	(75159254272577536, 'admin', '2018-11-14 23:48:24', 0, 'admin', '2019-04-01 23:53:17', '', 75135930788220928, 1.00, 0, '女', '女'),
	(75159898425397248, 'admin', '2018-11-14 23:50:57', 0, 'admin', '2019-04-01 23:53:22', '', 75135930788220928, 2.00, -1, '保密', '保密'),
	(75385648017575936, 'admin', '2018-11-15 14:48:00', 0, 'admin', '2019-04-02 00:10:36', '', 75383353938808832, 0.00, 0, '系统公告', '系统公告'),
	(75385706913992704, 'admin', '2018-11-15 14:48:14', 0, 'admin', '2019-04-02 00:10:32', '', 75383353938808832, 1.00, 0, '提醒', '提醒'),
	(75385774274514944, 'admin', '2018-11-15 14:48:30', 0, 'admin', '2019-04-02 00:10:28', '', 75383353938808832, 2.00, 0, '私信', '私信'),
	(75390787835138048, 'admin', '2018-11-15 15:08:26', 0, 'admin', '2018-11-15 15:08:26', '', 75388696739713024, 0.00, 0, '查看操作(view)', 'view'),
	(75390886501945344, 'admin', '2018-11-15 15:08:49', 0, 'admin', '2018-11-15 15:08:57', '', 75388696739713024, 1.00, 0, '添加操作(add)', 'add'),
	(75390993939042304, 'admin', '2018-11-15 15:09:15', 0, 'admin', '2018-11-15 15:09:15', '', 75388696739713024, 2.00, 0, '编辑操作(edit)', 'edit'),
	(75391067532300288, 'admin', '2018-11-15 15:09:32', 0, 'admin', '2018-11-15 15:09:32', '', 75388696739713024, 3.00, 0, '删除操作(delete)', 'delete'),
	(75391126902673408, 'admin', '2018-11-15 15:09:46', 0, 'admin', '2018-11-15 15:09:46', '', 75388696739713024, 4.00, 0, '清空操作(clear)', 'clear'),
	(75391192883269632, 'admin', '2018-11-15 15:10:02', 0, 'admin', '2018-11-15 15:10:02', '', 75388696739713024, 5.00, 0, '启用操作(enable)', 'enable'),
	(75391251024711680, 'admin', '2018-11-15 15:10:16', 0, 'admin', '2018-11-15 15:10:16', '', 75388696739713024, 6.00, 0, '禁用操作(disable)', 'disable'),
	(75391297124306944, 'admin', '2018-11-15 15:10:27', 0, 'admin', '2018-11-15 15:10:27', '', 75388696739713024, 7.00, 0, '搜索操作(search)', 'search'),
	(75391343379091456, 'admin', '2018-11-15 15:10:38', 0, 'admin', '2018-11-15 15:10:38', '', 75388696739713024, 8.00, 0, '上传文件(upload)', 'upload'),
	(75391407526776832, 'admin', '2018-11-15 15:10:53', 0, 'admin', '2018-11-15 15:10:53', '', 75388696739713024, 9.00, 0, '导出操作(output)', 'output'),
	(75391475042488320, 'admin', '2018-11-15 15:11:09', 0, 'admin', '2018-11-15 15:11:09', '', 75388696739713024, 10.00, 0, '导入操作(input)', 'input'),
	(75391522182270976, 'admin', '2018-11-15 15:11:21', 0, 'admin', '2018-11-15 15:11:21', '', 75388696739713024, 11.00, 0, '分配权限(editPerm)', 'editPerm'),
	(75391576364290048, 'admin', '2018-11-15 15:11:34', 0, 'admin', '2018-11-15 15:11:34', '', 75388696739713024, 12.00, 0, '设为默认(setDefault)', 'setDefault'),
	(75391798033256448, 'admin', '2018-11-15 15:12:26', 0, 'admin', '2018-11-15 15:12:26', '', 75388696739713024, 13.00, 0, '其他操作(other)', 'other'),
	(75393605291741184, 'admin', '2018-11-15 15:19:37', 0, 'admin', '2018-11-15 15:19:37', '', 75392985935646720, 0.00, 0, '北京一区（华北）', 'ap-beijing-1'),
	(75393681254780928, 'admin', '2018-11-15 15:19:55', 0, 'admin', '2018-11-15 15:19:55', '', 75392985935646720, 1.00, 0, '北京', 'ap-beijing'),
	(75393767619694592, 'admin', '2018-11-15 15:20:16', 0, 'admin', '2018-11-15 15:20:16', '', 75392985935646720, 2.00, 0, '上海（华东）', 'ap-shanghai'),
	(75393851484803072, 'admin', '2018-11-15 15:20:36', 0, 'admin', '2018-11-15 15:20:36', '', 75392985935646720, 3.00, 0, '广州（华南）', 'ap-guangzhou'),
	(75393961887272960, 'admin', '2018-11-15 15:21:02', 0, 'admin', '2018-11-15 15:21:02', '', 75392985935646720, 4.00, 0, '成都（西南）', 'ap-chengdu'),
	(75394053969022976, 'admin', '2018-11-15 15:21:24', 0, 'admin', '2018-11-15 15:21:24', '', 75392985935646720, 5.00, 0, '重庆', 'ap-chongqing'),
	(75394122474590208, 'admin', '2018-11-15 15:21:41', 0, 'admin', '2018-11-15 15:21:41', '', 75392985935646720, 6.00, 0, '新加坡', 'ap-singapore'),
	(75394186202845184, 'admin', '2018-11-15 15:21:56', 0, 'admin', '2018-11-15 15:21:56', '', 75392985935646720, 7.00, 0, '香港', 'ap-hongkong'),
	(75394254255427584, 'admin', '2018-11-15 15:22:12', 0, 'admin', '2018-11-15 15:22:12', '', 75392985935646720, 8.00, 0, '多伦多', 'na-toronto'),
	(75394309125312512, 'admin', '2018-11-15 15:22:25', 0, 'admin', '2018-11-15 15:22:25', '', 75392985935646720, 9.00, 0, '法兰克福', 'eu-frankfurt'),
	(75394367044456448, 'admin', '2018-11-15 15:22:39', 0, 'admin', '2018-11-15 15:22:39', '', 75392985935646720, 10.00, 0, '孟买', 'ap-mumbai'),
	(75394448523005952, 'admin', '2018-11-15 15:22:58', 0, 'admin', '2018-11-15 15:22:58', '', 75392985935646720, 11.00, 0, '首尔', 'ap-seoul'),
	(75394604765024256, 'admin', '2018-11-15 15:23:36', 0, 'admin', '2018-11-15 15:23:36', '', 75392985935646720, 12.00, 0, '硅谷', 'na-siliconvalley'),
	(75394659299364864, 'admin', '2018-11-15 15:23:49', 0, 'admin', '2018-11-15 15:23:49', '', 75392985935646720, 13.00, 0, '弗吉尼亚', 'na-ashburn'),
	(75394705700950016, 'admin', '2018-11-15 15:24:00', 0, 'admin', '2018-11-15 15:24:00', '', 75392985935646720, 14.00, 0, '曼谷', 'ap-bangkok'),
	(75394759287377920, 'admin', '2018-11-15 15:24:12', 0, 'admin', '2018-11-15 15:24:12', '', 75392985935646720, 15.00, 0, '莫斯科', 'eu-moscow'),
	(79717808262352896, 'admin', '2018-11-27 13:42:28', 0, 'admin', '2018-11-27 13:42:28', '', 79717732567748608, 0.00, 0, '开始节点', '0'),
	(79717858308788224, 'admin', '2018-11-27 13:42:40', 0, 'admin', '2018-11-27 13:42:40', '', 79717732567748608, 1.00, 0, '审批节点', '1'),
	(79717920061526016, 'admin', '2018-11-27 13:42:54', 0, 'admin', '2018-12-08 20:35:39', '', 79717732567748608, 2.00, 0, '结束节点', '2'),
	(81843987719131136, 'admin', '2018-12-03 10:31:08', 0, 'admin', '2018-12-03 10:31:08', '', 81843858882695168, 0.00, 0, '普通', '0'),
	(81844044015079424, 'admin', '2018-12-03 10:31:22', 0, 'admin', '2018-12-03 10:31:22', '', 81843858882695168, 1.00, 0, '重要', '1'),
	(81844100705292288, 'admin', '2018-12-03 10:31:35', 0, 'admin', '2018-12-03 10:31:35', '', 81843858882695168, 2.00, 0, '紧急', '2'),
	(82237106587439104, 'admin', '2018-12-04 12:33:15', 0, 'admin', '2018-12-04 12:33:15', '', 82236987314016256, 0.00, 0, '请假申请表', 't_leave'),
	(82237106587439105, 'admin', '2018-12-04 12:33:15', 0, 'admin', '2018-12-04 12:33:15', '', 82236987314016257, 0.00, 0, '请假申请表', 'leave'),
	(99020985985929216, 'admin', '2019-01-19 20:06:23', 0, 'admin', '2019-04-01 23:55:48', '', 99020862912466944, 0.00, 0, '年假', '年假'),
	(99021020739932160, 'admin', '2019-01-19 20:06:32', 0, 'admin', '2019-04-01 23:55:52', '', 99020862912466944, 1.00, 0, '事假', '事假'),
	(99021195566911488, 'admin', '2019-01-19 20:07:13', 0, 'admin', '2019-04-01 23:55:56', '', 99020862912466944, 2.00, 0, '病假', '病假'),
	(99021242476007424, 'admin', '2019-01-19 20:07:24', 0, 'admin', '2019-04-01 23:56:01', '', 99020862912466944, 3.00, 0, '调休', '调休'),
	(99021300730695680, 'admin', '2019-01-19 20:07:38', 0, 'admin', '2019-04-01 23:56:05', '', 99020862912466944, 4.00, 0, '产假', '产假'),
	(99021341889400832, 'admin', '2019-01-19 20:07:48', 0, 'admin', '2019-04-01 23:56:10', '', 99020862912466944, 5.00, 0, '陪产假', '陪产假'),
	(99021382393794560, 'admin', '2019-01-19 20:07:58', 0, 'admin', '2019-04-01 23:56:14', '', 99020862912466944, 6.00, 0, '婚假', '婚假'),
	(99021437171404800, 'admin', '2019-01-19 20:08:11', 0, 'admin', '2019-04-01 23:56:18', '', 99020862912466944, 7.00, 0, '例假', '例假'),
	(99021497724571648, 'admin', '2019-01-19 20:08:25', 0, 'admin', '2019-04-01 23:56:23', '', 99020862912466944, 8.00, 0, '丧假', '丧假'),
	(99021556704874496, 'admin', '2019-01-19 20:08:39', 0, 'admin', '2019-04-01 23:56:27', '', 99020862912466944, 9.00, 0, '哺乳假', '哺乳假'),
	(125170157323554816, 'admin', '2019-04-01 23:53:52', 0, 'admin', '2019-04-01 23:53:52', '', 75383353938808832, 3.00, 0, '工作流', '工作流');
/*!40000 ALTER TABLE `t_dict_data` ENABLE KEYS */;

-- 导出  表 nhcj.t_file 结构
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE IF NOT EXISTS `t_file` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `f_key` varchar(255) DEFAULT NULL,
  `location` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_file 的数据：~0 rows (大约)
DELETE FROM `t_file`;
/*!40000 ALTER TABLE `t_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_file` ENABLE KEYS */;

-- 导出  表 nhcj.t_leave 结构
DROP TABLE IF EXISTS `t_leave`;
CREATE TABLE IF NOT EXISTS `t_leave` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `duration` int(11) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_leave 的数据：~0 rows (大约)
DELETE FROM `t_leave`;
/*!40000 ALTER TABLE `t_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_leave` ENABLE KEYS */;

-- 导出  表 nhcj.t_log 结构
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE IF NOT EXISTS `t_log` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cost_time` int(11) unsigned DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `ip_info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `request_param` longtext,
  `request_type` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `log_type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_log 的数据：~67 rows (大约)
DELETE FROM `t_log`;
/*!40000 ALTER TABLE `t_log` DISABLE KEYS */;
INSERT INTO `t_log` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `cost_time`, `ip`, `ip_info`, `name`, `request_param`, `request_type`, `request_url`, `username`, `log_type`) VALUES
	(1372739328547098624, NULL, '2021-03-19 10:38:55', 0, NULL, '2021-03-19 10:38:55', 212, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"OD9M","saveLogin":"true","captchaId":"9f4ea01092684e89b58920314aca9b93","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1373076092772028416, NULL, '2021-03-20 08:57:06', 0, NULL, '2021-03-20 08:57:06', 210, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"TNZ3","saveLogin":"true","captchaId":"8d6f1f3dcf264c8badb26552f526e303","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1373142882566934528, NULL, '2021-03-20 13:22:30', 0, NULL, '2021-03-20 13:22:30', 47, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"vsh7","saveLogin":"true","captchaId":"b4941e6c3a514a1bab0eff83022cf9a5","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1374172055209119744, NULL, '2021-03-23 09:32:04', 0, NULL, '2021-03-23 09:32:04', 47, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"OXQY","saveLogin":"true","captchaId":"5987475066b1463ca294654a971af78e","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1374269797788946432, NULL, '2021-03-23 16:00:27', 0, NULL, '2021-03-23 16:00:27', 214, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"DSHQ","saveLogin":"true","captchaId":"8812626cdaa5487a955aeedd52df1c73","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1374301449558822912, NULL, '2021-03-23 18:06:14', 0, NULL, '2021-03-23 18:06:14', 32, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"CLTC","saveLogin":"true","captchaId":"0800d6b1237c4f7eb612cda71c1268ac","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1374309878025293824, NULL, '2021-03-23 18:39:43', 0, NULL, '2021-03-23 18:39:43', 217, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"ozno","saveLogin":"true","captchaId":"38cd54a91a7243cab76b372843f3196e","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375263199460462592, NULL, '2021-03-26 09:47:53', 0, NULL, '2021-03-26 09:47:53', 238, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"VM2R","saveLogin":"true","captchaId":"5d54c3de65024739a695f6a7e470c456","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375264066540539904, NULL, '2021-03-26 09:51:19', 0, NULL, '2021-03-26 09:51:19', 167, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"ZJEB","saveLogin":"true","captchaId":"7c7cbd0279f440118422059858f46aef","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375264682616688640, NULL, '2021-03-26 09:53:46', 0, NULL, '2021-03-26 09:53:46', 45, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"GZUO","saveLogin":"true","captchaId":"4018f4ae81d84cd7a81e2b7c84e72f07","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375265446055514112, NULL, '2021-03-26 09:56:48', 0, NULL, '2021-03-26 09:56:48', 205, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"YDQP","saveLogin":"true","captchaId":"8ed1bc544c22476ca6f7153ee8b5aee5","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375266615666544640, NULL, '2021-03-26 10:01:27', 0, NULL, '2021-03-26 10:01:27', 40, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"ZVVU","saveLogin":"true","captchaId":"7806a912f3324e3598953138242099b5","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375266897024651264, NULL, '2021-03-26 10:02:34', 0, NULL, '2021-03-26 10:02:34', 26, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"4zzr","saveLogin":"true","captchaId":"a3c3958570d64484bee544e54651259a","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375267260675002368, NULL, '2021-03-26 10:04:01', 0, NULL, '2021-03-26 10:04:01', 24, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"dbww","saveLogin":"true","captchaId":"ca566d4f6a63455e865ebb6163622604","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375371338637774848, NULL, '2021-03-26 16:57:36', 0, NULL, '2021-03-26 16:57:36', 1530, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"AWUQ","saveLogin":"true","captchaId":"1657a4e4c6834622a0ead1b1c1e74d0f","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1375810781320450048, NULL, '2021-03-27 22:03:46', 0, NULL, '2021-03-27 22:03:46', 48, '122.227.194.137', '未知', '登录系统', '{"password":"你是看不见我的","code":"T9PU","saveLogin":"true","captchaId":"4422274b226b43a7b83087accb156fc7","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376050602043379712, NULL, '2021-03-28 13:56:44', 0, NULL, '2021-03-28 13:56:44', 38, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"O4WR","saveLogin":"true","captchaId":"8f1aac157e5249e99bcbb7311744eeca","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376087384604676096, NULL, '2021-03-28 16:22:54', 0, NULL, '2021-03-28 16:22:54', 214, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"tije","saveLogin":"true","captchaId":"f8e3c043374340f1846195456e339c7f","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376101778688446464, NULL, '2021-03-28 17:20:05', 0, NULL, '2021-03-28 17:20:05', 37, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"BGN4","saveLogin":"true","captchaId":"6d8fa3e3325f4c51a91dcac9ee7407d4","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376103487519199232, NULL, '2021-03-28 17:26:53', 0, NULL, '2021-03-28 17:26:53', 24, '221.12.47.179', '未知', '登录系统', '{"password":"你是看不见我的","code":"gQra","saveLogin":"true","captchaId":"21a0144f31cd47188ebcd0a9113f4349","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376132936155402240, NULL, '2021-03-28 19:23:54', 0, NULL, '2021-03-28 19:23:54', 41, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"YPIP","saveLogin":"true","captchaId":"cfd0200df9f340eaad170695d5ecf782","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376138590475653120, NULL, '2021-03-28 19:46:22', 0, NULL, '2021-03-28 19:46:22', 40, '221.12.47.179', '未知', '登录系统', '{"password":"你是看不见我的","code":"O8JK","saveLogin":"true","captchaId":"218ed509319241b18fe7db3ed9b3b3af","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376397428135170048, NULL, '2021-03-29 12:54:54', 0, NULL, '2021-03-29 12:54:54', 44, '218.205.55.16', '未知', '登录系统', '{"password":"你是看不见我的","code":"Z1ZS","saveLogin":"true","captchaId":"0b34d4f2877a4507a9d4ebacbf68bf9e","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1376419583669440512, NULL, '2021-03-29 14:22:56', 0, NULL, '2021-03-29 14:22:56', 37, '221.12.47.179', '未知', '登录系统', '{"password":"你是看不见我的","code":"GA2E","saveLogin":"true","captchaId":"d2b0daeaca924678bfd1c513dcb30d6f","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1377081998249693184, NULL, '2021-03-31 10:15:08', 0, NULL, '2021-03-31 10:15:08', 43, '60.180.153.199', '未知', '登录系统', '{"password":"你是看不见我的","code":"NC7D","saveLogin":"true","captchaId":"0ecccf2c393c4c31942bff1c7d5aeff4","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1377172369055027200, NULL, '2021-03-31 16:14:14', 0, NULL, '2021-03-31 16:14:14', 42, '221.12.47.179', '未知', '登录系统', '{"password":"你是看不见我的","code":"Z57P","saveLogin":"true","captchaId":"f0e50ddff59c4715b5b370fb75dab006","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1377524206396379136, NULL, '2021-04-01 15:32:19', 0, NULL, '2021-04-01 15:32:19', 35, '124.89.235.82', '未知', '登录系统', '{"password":"你是看不见我的","code":"VBY2","saveLogin":"true","captchaId":"0b704b4a48554f83808372a1e76ee895","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1377629353730510848, NULL, '2021-04-01 22:30:08', 0, NULL, '2021-04-01 22:30:08', 34, '122.227.194.137', '未知', '登录系统', '{"password":"你是看不见我的","code":"qg8v","saveLogin":"true","captchaId":"3898008c45894faeb4787e512b19ae60","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1377826106945703936, NULL, '2021-04-02 11:31:57', 0, NULL, '2021-04-02 11:31:57', 35, '123.152.207.205', '未知', '登录系统', '{"password":"你是看不见我的","code":"LQVV","saveLogin":"true","captchaId":"a4f75d8de3e94d76bdbd70a47135e529","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1378906658952056832, NULL, '2021-04-05 11:05:42', 0, NULL, '2021-04-05 11:05:42', 780, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"MSMW","saveLogin":"true","captchaId":"6cae2de7e51f46a18cc35d56e6eef35f","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1379994101029670912, NULL, '2021-04-08 11:06:47', 0, NULL, '2021-04-08 11:06:47', 47, '122.227.194.137', '未知', '登录系统', '{"password":"你是看不见我的","code":"REWA","saveLogin":"true","captchaId":"70eb7a43af1443e39519168bb72113e7","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380085449657290752, NULL, '2021-04-08 17:09:47', 0, NULL, '2021-04-08 17:09:47', 32, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"BMLF","saveLogin":"true","captchaId":"6dc87d038688468f9d05f3b1f36ebe6f","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380147215976239104, NULL, '2021-04-08 21:15:13', 0, NULL, '2021-04-08 21:15:13', 29, '122.227.194.137', '未知', '登录系统', '{"password":"你是看不见我的","code":"AFCR","saveLogin":"true","captchaId":"39562b1e493742e6ab0bf5621487b073","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380415900385153024, NULL, '2021-04-09 15:02:52', 0, NULL, '2021-04-09 15:02:52', 32, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"GGTR","saveLogin":"true","captchaId":"1582fdd12c4f4abd9b0c33a067e4c631","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380428634413731840, NULL, '2021-04-09 15:53:29', 0, NULL, '2021-04-09 15:53:29', 283, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"ep5b","saveLogin":"true","captchaId":"098eaa9b9bdf4b3cac10d39c96352767","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380429157170810880, NULL, '2021-04-09 15:55:33', 0, NULL, '2021-04-09 15:55:33', 32, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"Q7ZV","saveLogin":"true","captchaId":"5c51bd4a2fe34b71aad62fd9075d7c5c","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380726126128795648, NULL, '2021-04-10 11:35:36', 0, NULL, '2021-04-10 11:35:36', 250, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"CGKL","saveLogin":"true","captchaId":"d7b0c12676bc4594a3f820326e1a6ace","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380807569215459328, NULL, '2021-04-10 16:59:13', 0, NULL, '2021-04-10 16:59:13', 31, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"UCR9","saveLogin":"true","captchaId":"34cbb2d584174e01b1748f8c570f0240","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1380815363930984448, NULL, '2021-04-10 17:30:12', 0, NULL, '2021-04-10 17:30:12', 219, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"EUTC","saveLogin":"true","captchaId":"1c015fa5b73a4f859b668e890aba6a13","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381045140772229120, NULL, '2021-04-11 08:43:15', 0, NULL, '2021-04-11 08:43:15', 344, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"8MYZ","saveLogin":"true","captchaId":"e3aa4f0720ba42f8ac4773c232b5f6d3","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381097721166958592, NULL, '2021-04-11 12:12:11', 0, NULL, '2021-04-11 12:12:11', 282, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"HH6K","saveLogin":"true","captchaId":"cc6ee3464ecc416b88e02efa9b68ed65","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381131654785011712, NULL, '2021-04-11 14:27:02', 0, NULL, '2021-04-11 14:27:02', 221, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"YFNW","saveLogin":"true","captchaId":"3bc84f14f837433b9d2264ec432e8436","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381134437579886592, NULL, '2021-04-11 14:38:05', 0, NULL, '2021-04-11 14:38:05', 234, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"RU7P","saveLogin":"true","captchaId":"b8321a840d424102b0d36790b07995a0","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381135247055392768, NULL, '2021-04-11 14:41:18', 0, NULL, '2021-04-11 14:41:18', 219, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"X1GD","saveLogin":"true","captchaId":"893aa821193b454bb9f020b156c1d3de","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381143181768396800, NULL, '2021-04-11 15:12:50', 0, NULL, '2021-04-11 15:12:50', 31, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"DJIX","saveLogin":"true","captchaId":"002a8a0b2d144a2f87ee52a52140e054","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381162841473683456, NULL, '2021-04-11 16:30:57', 0, NULL, '2021-04-11 16:30:57', 47, '122.227.194.137', '未知', '登录系统', '{"password":"你是看不见我的","code":"lea5","saveLogin":"true","captchaId":"6926e5de9f5a4e5e97049862033a0d2f","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1381418844656111616, NULL, '2021-04-12 09:28:13', 0, NULL, '2021-04-12 09:28:13', 31, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"512G","saveLogin":"true","captchaId":"5edf2a2b6e914aa78d44fa1b8fec1c4c","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1382225359721861120, NULL, '2021-04-14 14:53:01', 0, NULL, '2021-04-14 14:53:01', 69, '122.227.194.131', '未知', '登录系统', '{"password":"你是看不见我的","code":"bkbb","saveLogin":"true","captchaId":"d389cd44e8094eafa343ad3f59868bcc","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1382246307082670080, NULL, '2021-04-14 16:16:15', 0, NULL, '2021-04-14 16:16:15', 32, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"H2EP","saveLogin":"true","captchaId":"80d5703f1ef94cbe848a247b3ccb1ff8","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1382310466965082112, NULL, '2021-04-14 20:31:12', 0, NULL, '2021-04-14 20:31:12', 47, '122.227.194.137', '未知', '登录系统', '{"password":"你是看不见我的","code":"MRMY","saveLogin":"true","captchaId":"088f3d4712ac4b8780a99cfd7e5c6f22","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1382882151711772672, NULL, '2021-04-16 10:22:52', 0, NULL, '2021-04-16 10:22:52', 37, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"RLTZ","saveLogin":"true","captchaId":"6bc383a860d74beab83c3c4315fee66e","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383246312258015232, NULL, '2021-04-17 10:30:00', 0, NULL, '2021-04-17 10:30:00', 4469, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"B8HW","saveLogin":"true","captchaId":"7f4142e50498401498df2422ae1abdec","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383248586271232000, NULL, '2021-04-17 10:38:57', 0, NULL, '2021-04-17 10:38:57', 172, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"PX48","saveLogin":"true","captchaId":"30569ed3ef8e44e1b9f2d234c987addb","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383250916685254656, NULL, '2021-04-17 10:48:13', 0, NULL, '2021-04-17 10:48:13', 94, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"1H9F","saveLogin":"true","captchaId":"7946651107f7404985bdcd49afc78b26","username":"15888543307"}', 'POST', '/xboot/login', '15888543307', 1),
	(1383251148521213952, NULL, '2021-04-17 10:49:08', 0, NULL, '2021-04-17 10:49:08', 47, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"HHNE","saveLogin":"true","captchaId":"3097bf41ca6149d3a161122da77b124b","username":"18268627373"}', 'POST', '/xboot/login', '18268627373', 1),
	(1383251211142172672, NULL, '2021-04-17 10:49:23', 0, NULL, '2021-04-17 10:49:23', 31, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"V61O","saveLogin":"true","captchaId":"136c00c5786741f9b595ddb5fd60a925","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383251356013432832, NULL, '2021-04-17 10:49:58', 0, NULL, '2021-04-17 10:49:58', 109, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"PCCQ","saveLogin":"true","captchaId":"36f5d842a89d4a7a8e2724d8aef3e7da","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383351467649404928, NULL, '2021-04-17 17:27:46', 0, NULL, '2021-04-17 17:27:46', 31, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"SECL","saveLogin":"true","captchaId":"8a7a6aa5c1c24d87b21cad141221573b","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383582327959064576, NULL, '2021-04-18 08:45:08', 0, NULL, '2021-04-18 08:45:08', 289, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"CX3I","saveLogin":"true","captchaId":"30ddfe80018f4183884186b64617ad42","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383648763549192192, NULL, '2021-04-18 13:09:07', 0, NULL, '2021-04-18 13:09:07', 202, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"VYY8","saveLogin":"true","captchaId":"6893c9899af842c7b65ac7d88651aad4","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1383683259719880704, NULL, '2021-04-18 15:26:12', 0, NULL, '2021-04-18 15:26:12', 500, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"FVGD","saveLogin":"true","captchaId":"dc6c747250da44c0917321a87d47dd47","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1384462895374536704, NULL, '2021-04-20 19:04:11', 0, NULL, '2021-04-20 19:04:11', 47, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"PHOG","saveLogin":"true","captchaId":"d512d375861741ebbc51634bcf1d7dbc","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1384476893180465152, NULL, '2021-04-20 19:59:49', 0, NULL, '2021-04-20 19:59:49', 266, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"4DMO","saveLogin":"true","captchaId":"d605f6abff81432c97533bbb93eba3f5","username":"17857054385"}', 'POST', '/xboot/login', '17857054385', 1),
	(1384477066182922240, NULL, '2021-04-20 20:00:30', 0, NULL, '2021-04-20 20:00:30', 32, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"EMW9","saveLogin":"true","captchaId":"3c6dfcc9b0a640a8843d4c34a92e5138","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1384477413597122560, NULL, '2021-04-20 20:01:52', 0, NULL, '2021-04-20 20:01:52', 42, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"LJXJ","saveLogin":"true","captchaId":"2dca850f82a4424ab7a6a8c1a0109039","username":"17857054385"}', 'POST', '/xboot/login', '17857054385', 1),
	(1384514847122788352, NULL, '2021-04-20 22:30:37', 0, NULL, '2021-04-20 22:30:37', 47, '122.227.194.137', '未知', '登录系统', '{"password":"你是看不见我的","code":"hm1d","saveLogin":"true","captchaId":"2d2b46ef08844b45a2910b270bdb1149","username":"18268627373"}', 'POST', '/xboot/login', '18268627373', 1),
	(1385392947993907200, NULL, '2021-04-23 08:39:53', 0, NULL, '2021-04-23 08:39:53', 484, '122.224.37.226', '未知', '登录系统', '{"password":"你是看不见我的","code":"E9BJ","saveLogin":"true","captchaId":"4b6eba73f89d4db5aa7230a18808fbb0","username":"admin"}', 'POST', '/xboot/login', 'admin', 1);
/*!40000 ALTER TABLE `t_log` ENABLE KEYS */;

-- 导出  表 nhcj.t_message 结构
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE IF NOT EXISTS `t_message` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_send` bit(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_message 的数据：~5 rows (大约)
DELETE FROM `t_message`;
/*!40000 ALTER TABLE `t_message` DISABLE KEYS */;
INSERT INTO `t_message` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `create_send`, `title`, `type`, `content`) VALUES
	(43615268366192640, '', '2018-08-19 22:43:51', 0, 'admin', '2020-04-26 23:32:08', b'1', '欢迎您注册账号使用X-Boot 点我查看使用须知', '系统公告', '<p style="text-align: center;">X-Boot是很棒的Web前后端分离开发平台，开源版本请遵循GPL v3.0开源协议，不得闭源，商用需求请联系作者签署授权协议。</p><p style="text-align: center;">捐赠获取完整版：<a href="http://xpay.exrick.cn/pay?xboot" target="_blank" style="background-color: rgb(255, 255, 255);">立即去捐赠获取</a></p><p style="text-align: center;"><img src="https://i.loli.net/2018/08/24/5b801c8652227.png" style="max-width:150px;"><br></p><p style="text-align: center;">手机扫一扫支付</p><p style="text-align: center;">获取商用授权：<a href="http://wpa.qq.com/msgrd?v=3&amp;uin=1012139570&amp;site=qq&amp;menu=yes" target="_blank" style="background-color: rgb(255, 255, 255);">立即联系作者获取商用授权</a></p>'),
	(124717033060306944, 'admin', '2019-03-31 17:53:19', 0, 'admin', '2019-03-31 17:53:19', NULL, '您收到了一条新的工作流待办消息，赶快去处理查看吧', '工作流', '<p>您收到了一条新的工作流待办消息，赶快去”工作流程-我的待办“处理查看吧</p>'),
	(124743474544119808, 'admin', '2019-03-31 19:38:23', 0, 'admin', '2019-03-31 19:38:23', NULL, '您有一个工作流申请已审批通过，赶快去处理查看吧', '工作流', '<p>您有一个工作流申请已审批通过，赶快去”工作流程-我的申请“处理查看吧</p>'),
	(124744392996032512, 'admin', '2019-03-31 19:42:02', 0, 'admin', '2019-03-31 19:42:02', NULL, '您有一个工作流申请已被驳回，赶快去处理查看吧', '工作流', '<p>您有一个工作流申请已已被驳回，赶快去”工作流程-我的申请“处理查看吧</p>'),
	(124744706050494464, 'admin', '2019-03-31 19:43:17', 0, 'admin', '2020-02-26 15:53:41', b'0', '您收到了一个新的被委托待办工作流任务，赶快去处理查看吧', '工作流', '<p>您收到了一个新的被委托待办工作流任务，赶快去”工作流程-我的待办“处理查看吧</p>');
/*!40000 ALTER TABLE `t_message` ENABLE KEYS */;

-- 导出  表 nhcj.t_message_send 结构
DROP TABLE IF EXISTS `t_message_send`;
CREATE TABLE IF NOT EXISTS `t_message_send` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `message_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_message_send 的数据：~4 rows (大约)
DELETE FROM `t_message_send`;
/*!40000 ALTER TABLE `t_message_send` DISABLE KEYS */;
INSERT INTO `t_message_send` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `message_id`, `status`, `user_id`) VALUES
	(43615268663988224, NULL, '2018-08-19 22:43:51', 0, NULL, '2018-08-19 22:43:51', 43615268366192640, 0, 682265633886209),
	(43615268663988226, '', '2018-08-19 22:43:51', 0, '', '2018-08-24 12:41:24', 43615268366192640, 2, 4363087427670016),
	(1383250474089713665, NULL, '2021-04-17 10:46:27', 0, NULL, '2021-04-17 10:46:27', 43615268366192640, 0, 1383250471732514817),
	(1383250753640075265, NULL, '2021-04-17 10:47:34', 0, NULL, '2021-04-17 10:47:34', 43615268366192640, 0, 1383250752918654977);
/*!40000 ALTER TABLE `t_message_send` ENABLE KEYS */;

-- 导出  表 nhcj.t_permission 结构
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE IF NOT EXISTS `t_permission` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int(11) unsigned DEFAULT NULL,
  `button_type` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `show_always` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_permission 的数据：~64 rows (大约)
DELETE FROM `t_permission`;
/*!40000 ALTER TABLE `t_permission` DISABLE KEYS */;
INSERT INTO `t_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `name`, `parent_id`, `type`, `sort_order`, `component`, `path`, `title`, `icon`, `level`, `button_type`, `status`, `url`, `show_always`) VALUES
	(5129710648430592, '', '2018-06-04 19:02:29', 0, '', '2018-09-29 23:11:56', '', 'sys', 125909152017944576, 0, 1.00, 'Main', '/sys', '系统管理', 'ios-settings', 1, '', 0, '', b'1'),
	(5129710648430593, '', '2018-06-04 19:02:32', 0, '', '2018-08-13 15:15:33', '', 'user-manage', 5129710648430592, 0, 1.10, 'sys/user-manage/userManage', 'user-manage', '用户管理', 'md-person', 2, '', 0, '', b'1'),
	(5129710648430594, '', '2018-06-04 19:02:35', 0, '', '2018-10-13 13:51:36', '', 'role-manage', 5129710648430592, 0, 1.60, 'sys/role-manage/roleManage', 'role-manage', '角色权限管理', 'md-contacts', 2, '', 0, '', b'1'),
	(5129710648430595, '', '2018-06-04 19:02:37', 0, '', '2018-09-23 23:32:02', '', 'menu-manage', 5129710648430592, 0, 1.70, 'sys/menu-manage/menuManage', 'menu-manage', '菜单权限管理', 'md-menu', 2, '', 0, '', b'1'),
	(15701400130424832, '', '2018-06-03 22:04:06', 0, '', '2018-09-19 22:16:44', '', '', 5129710648430593, 1, 1.11, '', '/xboot/user/admin/add*', '添加用户', '', 3, 'add', 0, '', b'1'),
	(15701915807518720, '', '2018-06-03 22:06:09', 0, '', '2018-06-06 14:46:51', '', '', 5129710648430593, 1, 1.13, '', '/xboot/user/admin/disable/**', '禁用用户', '', 3, 'disable', 0, NULL, b'1'),
	(15708892205944832, '', '2018-06-03 22:33:52', 0, '', '2018-06-28 16:44:48', '', '', 5129710648430593, 1, 1.14, '', '/xboot/user/admin/enable/**', '启用用户', '', 3, 'enable', 0, NULL, b'1'),
	(16678126574637056, '', '2018-06-06 14:45:16', 0, '', '2018-09-19 22:16:48', '', '', 5129710648430593, 1, 1.12, '', '/xboot/user/admin/edit*', '编辑用户', '', 3, 'edit', 0, '', b'1'),
	(16678447719911424, '', '2018-06-06 14:46:32', 0, 'admin', '2020-04-28 14:27:03', '', '', 5129710648430593, 1, 1.15, '', '/xboot/user/delByIds**', '删除用户', '', 3, 'delete', 0, '', b'1'),
	(16687383932047360, '', '2018-06-06 15:22:03', 0, '', '2018-09-19 22:07:34', '', '', 5129710648430594, 1, 1.21, '', '/xboot/role/save*', '添加角色', '', 3, 'add', 0, '', b'1'),
	(16689632049631232, '', '2018-06-06 15:30:59', 0, '', '2018-09-19 22:07:37', '', '', 5129710648430594, 1, 1.22, '', '/xboot/role/edit*', '编辑角色', '', 3, 'edit', 0, '', b'1'),
	(16689745006432256, '', '2018-06-06 15:31:26', 0, 'admin', '2020-04-28 14:29:02', '', '', 5129710648430594, 1, 1.23, '', '/xboot/role/delByIds**', '删除角色', '', 3, 'delete', 0, '', b'1'),
	(16689883993083904, NULL, '2018-06-06 15:31:59', 0, NULL, '2018-06-06 15:31:59', NULL, NULL, 5129710648430594, 1, 1.24, NULL, '/xboot/role/editRolePerm**', '分配权限', NULL, 3, 'editPerm', 0, NULL, b'1'),
	(16690313745666048, '', '2018-06-06 15:33:41', 0, '', '2018-09-19 22:07:46', '', '', 5129710648430594, 1, 1.25, '', '/xboot/role/setDefault*', '设为默认角色', '', 3, 'setDefault', 0, '', b'1'),
	(16694861252005888, '', '2018-06-06 15:51:46', 0, '', '2018-09-19 22:07:52', '', '', 5129710648430595, 1, 1.31, '', '/xboot/permission/add*', '添加菜单', '', 3, 'add', 0, '', b'1'),
	(16695107491205120, '', '2018-06-06 15:52:44', 0, '', '2018-09-19 22:07:57', '', '', 5129710648430595, 1, 1.32, '', '/xboot/permission/edit*', '编辑菜单', '', 3, 'edit', 0, '', b'1'),
	(16695243126607872, '', '2018-06-06 15:53:17', 0, 'admin', '2020-04-28 14:29:17', '', '', 5129710648430595, 1, 1.33, '', '/xboot/permission/delByIds**', '删除菜单', '', 3, 'delete', 0, '', b'1'),
	(25014528525733888, '', '2018-06-29 14:51:09', 0, '', '2018-10-08 11:13:27', '', '', 5129710648430593, 1, 1.16, '', '无', '上传图片', '', 3, 'upload', 0, '', b'1'),
	(39915540965232640, NULL, '2018-08-09 17:42:28', 0, NULL, '2018-08-09 17:42:28', NULL, 'monitor', 125909152017944576, 0, 2.00, 'Main', '/monitor', '系统监控', 'ios-analytics', 1, NULL, 0, NULL, b'1'),
	(40238597734928384, NULL, '2018-08-10 15:06:10', 0, NULL, '2018-08-10 15:06:10', NULL, 'department-manage', 5129710648430592, 0, 1.20, 'sys/department-manage/departmentManage', 'department-manage', '部门管理', 'md-git-branch', 2, '', 0, NULL, b'1'),
	(41363147411427328, '', '2018-08-13 17:34:43', 0, 'admin', '2020-03-25 20:31:16', '', 'log-manage', 39915540965232640, 0, 2.20, 'sys/log-manage/logManage', 'log-manage', '日志管理', 'md-list-box', 2, '', 0, '', b'1'),
	(41363537456533504, '', '2018-08-13 17:36:16', 0, 'admin', '2020-04-28 14:31:54', '', '', 41363147411427328, 1, 2.11, '', '/xboot/log/delByIds**', '删除日志', '', 3, 'delete', 0, '', b'1'),
	(41364927394353152, '', '2018-08-13 17:41:48', 0, '', '2018-09-19 22:08:57', '', '', 41363147411427328, 1, 2.12, '', '/xboot/log/delAll*', '清空日志', '', 3, 'undefined', 0, '', b'1'),
	(45235621697949696, '', '2018-08-24 10:02:33', 0, '', '2018-09-19 22:06:57', '', '', 40238597734928384, 1, 1.21, '', '/xboot/department/add*', '添加部门', '', 3, 'add', 0, '', b'1'),
	(45235787867885568, '', '2018-08-24 10:03:13', 0, '', '2018-09-19 22:07:02', '', '', 40238597734928384, 1, 1.22, '', '/xboot/department/edit*', '编辑部门', '', 3, 'edit', 0, '', b'1'),
	(45235939278065664, '', '2018-08-24 10:03:49', 0, 'admin', '2020-04-28 14:27:35', '', '', 40238597734928384, 1, 1.23, '', '/xboot/department/delByIds*', '删除部门', '', 3, 'delete', 0, '', b'1'),
	(56898976661639168, '', '2018-09-25 14:28:34', 0, '', '2018-09-25 15:12:46', '', '', 5129710648430593, 1, 1.17, '', '/xboot/user/importData*', '导入用户', '', 3, 'input', 0, '', b'1'),
	(75002207560273920, 'admin', '2018-11-14 13:24:21', 0, 'admin', '2018-11-20 20:06:22', '', 'dict', 5129710648430592, 0, 1.80, 'sys/dict-manage/dictManage', 'dict', '数据字典管理', 'md-bookmarks', 2, '', 0, '', b'1'),
	(76215889006956544, 'admin', '2018-11-17 21:47:05', 0, 'admin', '2018-11-17 21:47:53', '', '', 75002207560273920, 1, 1.81, '', '/xboot/dict/add*', '添加字典', '', 3, 'add', 0, '', b'1'),
	(76216071333351424, 'admin', '2018-11-17 21:47:48', 0, 'admin', '2018-11-17 21:47:48', NULL, '', 75002207560273920, 1, 1.82, '', '/xboot/dict/edit*', '编辑字典', '', 3, 'edit', 0, NULL, b'1'),
	(76216264070008832, 'admin', '2018-11-17 21:48:34', 0, 'admin', '2020-04-28 14:29:30', '', '', 75002207560273920, 1, 1.83, '', '/xboot/dict/delByIds**', '删除字典', '', 3, 'delete', 0, '', b'1'),
	(76216459709124608, 'admin', '2018-11-17 21:49:21', 0, 'admin', '2018-11-17 21:49:21', NULL, '', 75002207560273920, 1, 1.84, '', '/xboot/dictData/add*', '添加字典数据', '', 3, 'add', 0, NULL, b'1'),
	(76216594207870976, 'admin', '2018-11-17 21:49:53', 0, 'admin', '2018-11-17 21:49:53', NULL, '', 75002207560273920, 1, 1.85, '', '/xboot/dictData/edit*', '编辑字典数据', '', 3, 'edit', 0, NULL, b'1'),
	(76216702639017984, 'admin', '2018-11-17 21:50:18', 0, 'admin', '2018-11-17 21:50:18', NULL, '', 75002207560273920, 1, 1.86, '', '/xboot/dictData/delByIds/**', '删除字典数据', '', 3, 'delete', 0, NULL, b'1'),
	(102235632889237504, 'admin', '2019-01-28 17:00:15', 0, 'admin', '2021-03-23 17:56:02', '', 'vue-generator', 125909152017944576, 0, 3.00, 'Main', '/vue-generator', '开发者工具', 'md-send', 1, '', 0, '', b'1'),
	(102237605176807424, 'admin', '2019-01-28 17:08:06', 0, 'admin', '2021-03-23 17:56:10', '', 'table-generator', 102235632889237504, 0, 0.00, 'xboot-vue-generator/tableGenerator', 'table', '表格', 'md-grid', 2, '', 0, '', b'1'),
	(125909152017944576, 'admin', '2019-04-04 00:50:22', 0, 'admin', '2021-04-17 10:39:27', '', 'xboot', 0, -1, 1.00, '', '', '系统配置', 'md-home', 0, '', 0, '', b'1'),
	(156365156580855808, 'admin', '2019-06-27 01:51:39', 0, 'admin', '2019-06-27 01:51:39', NULL, '', 5129710648430593, 1, 1.18, '', '/xboot/user/resetPass', '重置密码', '', 3, 'other', 0, NULL, b'1'),
	(1373249454269927425, 'admin', '2021-03-20 20:25:58', 0, 'admin', '2021-03-23 17:56:20', '', 'setting', 5129710648430592, 0, 11.00, 'sys/setting-manage/settingManage', 'setting', '系统配置', 'ios-settings-outline', 2, '', 0, '', b'1'),
	(1375268668069515264, 'admin', '2021-03-26 10:09:36', 0, 'admin', '2021-04-17 10:39:31', '', 'assessmentSystem', 0, -1, 3.00, '', '', '考核系统', 'md-barcode', 0, '', 0, '', b'1'),
	(1375268784457256961, 'admin', '2021-03-26 10:10:04', 0, 'admin', '2021-03-26 10:10:04', NULL, 'villageArch', 1375268668069515264, 0, 1.00, 'Main', '/villageArch', '村庄档案', 'md-analytics', 1, '', 0, NULL, b'1'),
	(1375268897757990913, 'admin', '2021-03-26 10:10:31', 0, 'admin', '2021-03-26 10:10:31', NULL, 'village', 1375268784457256961, 0, 1.00, 'assessment/village/index', 'village', '村社档案', 'ios-albums', 2, '', 0, NULL, b'1'),
	(1375272504389668864, 'admin', '2021-03-26 10:24:51', 0, 'admin', '2021-03-26 10:24:51', NULL, 'villageMany', 1375268784457256961, 0, 2.00, 'assessment/villageMany/index', 'villageMany', '联村档案', 'ios-basket', 2, '', 0, NULL, b'1'),
	(1375289279084892160, 'admin', '2021-03-26 11:31:30', 0, 'admin', '2021-03-26 11:31:30', NULL, 'assessmentLineArch', 1375268668069515264, 0, 2.00, 'Main', '/assessmentLineArch', '考核线档案', 'md-at', 1, '', 0, NULL, b'1'),
	(1375289382168301568, 'admin', '2021-03-26 11:31:55', 0, 'admin', '2021-03-26 11:31:55', NULL, 'assessmentLine', 1375289279084892160, 0, 1.00, 'assessment/assessmentLine/index', 'assessmentLine', '考核线档案', 'md-browsers', 2, '', 0, NULL, b'1'),
	(1375293934070272001, 'admin', '2021-03-26 11:50:00', 0, 'admin', '2021-03-26 11:50:00', NULL, 'assessmentTime', 1375289279084892160, 0, 2.00, 'assessment/assessmentTime/index', 'assessmentTime', '考核期档案', 'ios-boat', 2, '', 0, NULL, b'1'),
	(1375315264341676032, 'admin', '2021-03-26 13:14:46', 0, 'admin', '2021-03-26 13:14:46', NULL, 'assessmentLineItem', 1375289279084892160, 0, 3.00, 'assessment/assessmentLineItem/index', 'assessmentLineItem', '考核细则', 'md-build', 2, '', 0, NULL, b'1'),
	(1375335678958768128, 'admin', '2021-03-26 14:35:53', 0, 'admin', '2021-03-26 14:35:53', NULL, 'windowsLook', 1375268668069515264, 0, 3.00, 'Main', '/windowsLook', '操作界面', 'ios-browsers', 1, '', 0, NULL, b'1'),
	(1375335957938704384, 'admin', '2021-03-26 14:37:00', 0, 'admin', '2021-03-26 14:37:00', NULL, 'twoWindows', 1375335678958768128, 0, 2.00, 'assessment/twoWindows/index', 'twoWindows', '二级操作界面', 'ios-bug', 2, '', 0, NULL, b'1'),
	(1375364573640658945, 'admin', '2021-03-26 16:30:42', 0, 'admin', '2021-03-26 16:30:42', NULL, 'fourWindows', 1375335678958768128, 0, 4.00, 'assessment/fourWindows/index', 'fourWindows', '四级操作界面', 'md-cloud', 2, '', 0, NULL, b'1'),
	(1383248359015452673, 'admin', '2021-04-17 10:38:03', 0, 'admin', '2021-04-17 10:39:15', '', 'threeCarSystem', 0, -1, 2.00, '', '', '三小车系统', 'ios-apps', 0, '', 0, '', b'1'),
	(1383248835903623169, 'admin', '2021-04-17 10:39:57', 0, 'admin', '2021-04-17 10:39:57', NULL, 'sellerList', 1383248359015452673, 0, 1.00, 'Main', '/sellerList', '卖家档案', 'ios-aperture', 1, '', 0, NULL, b'1'),
	(1383248914563600384, 'admin', '2021-04-17 10:40:15', 0, 'admin', '2021-04-17 10:40:15', NULL, 'buyList', 1383248359015452673, 0, 2.00, 'Main', '/buyList', '买家档案', 'md-appstore', 1, '', 0, NULL, b'1'),
	(1383248999305318401, 'admin', '2021-04-17 10:40:36', 0, 'admin', '2021-04-17 10:40:36', NULL, 'carList', 1383248359015452673, 0, 3.00, 'Main', '/carList', '车辆档案', 'md-archive', 1, '', 0, NULL, b'1'),
	(1383249146949013505, 'admin', '2021-04-17 10:41:11', 0, 'admin', '2021-04-17 10:41:11', NULL, 'auditList', 1383248359015452673, 0, 4.00, 'Main', '/auditList', '审核模块', 'md-at', 1, '', 0, NULL, b'1'),
	(1383249229895569409, 'admin', '2021-04-17 10:41:31', 0, 'admin', '2021-04-17 10:41:31', NULL, 'seller', 1383248835903623169, 0, 1.00, 'tricycle/seller/index', 'seller', '卖家档案', 'ios-aperture', 2, '', 0, NULL, b'1'),
	(1383249341468250113, 'admin', '2021-04-17 10:41:57', 0, 'admin', '2021-04-17 10:41:57', NULL, 'owner', 1383248914563600384, 0, 1.00, 'tricycle/owner/index', 'owner', '买家档案', 'md-aperture', 2, '', 0, NULL, b'1'),
	(1383249413341843457, 'admin', '2021-04-17 10:42:14', 0, 'admin', '2021-04-17 10:42:14', NULL, 'car', 1383248999305318401, 0, 1.00, 'tricycle/car/index', 'car', '车辆档案', 'ios-arrow-back', 2, '', 0, NULL, b'1'),
	(1383249493981532161, 'admin', '2021-04-17 10:42:34', 0, 'admin', '2021-04-17 10:42:34', NULL, 'examine', 1383249146949013505, 0, 1.00, 'tricycle/examine/index', 'examine', '车主资质审核', 'ios-bowtie', 2, '', 0, NULL, b'1'),
	(1383249554857660417, 'admin', '2021-04-17 10:42:48', 0, 'admin', '2021-04-17 10:42:48', NULL, 'examineCar', 1383249146949013505, 0, 2.00, 'tricycle/examineCar/index', 'examineCar', '小车审核', 'md-attach', 2, '', 0, NULL, b'1'),
	(1383249720381673473, 'admin', '2021-04-17 10:43:28', 0, 'admin', '2021-04-17 10:43:28', NULL, 'workerList', 1383248359015452673, 0, 5.00, 'Main', '/workerList', '工作人员模块', 'md-build', 1, '', 0, NULL, b'1'),
	(1383249842511417345, 'admin', '2021-04-17 10:43:57', 0, 'admin', '2021-04-17 10:43:57', NULL, 'adminLookArch', 1383249720381673473, 0, 1.00, 'tricycle/adminLookArch/index', 'adminLookArch', '工作人员档案', 'md-analytics', 2, '', 0, NULL, b'1'),
	(1383675843267661824, 'admin', '2021-04-18 14:56:43', 0, 'admin', '2021-04-18 14:56:43', NULL, 'oneWindows', 1375335678958768128, 0, 1.00, 'assessment/oneWindows/index', 'oneWindows', '一级操作界面', 'md-attach', 2, '', 0, NULL, b'1'),
	(1384477234097688577, 'admin', '2021-04-20 20:01:10', 0, 'admin', '2021-04-20 20:01:10', NULL, 'carForSeller', 1383248999305318401, 0, 2.00, 'tricycle/carForSeller/index', 'carForSeller', '车辆登记', 'ios-apps', 2, '', 0, NULL, b'1');
/*!40000 ALTER TABLE `t_permission` ENABLE KEYS */;

-- 导出  表 nhcj.t_quartz_job 结构
DROP TABLE IF EXISTS `t_quartz_job`;
CREATE TABLE IF NOT EXISTS `t_quartz_job` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `job_class_name` varchar(255) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_quartz_job 的数据：~0 rows (大约)
DELETE FROM `t_quartz_job`;
/*!40000 ALTER TABLE `t_quartz_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_quartz_job` ENABLE KEYS */;

-- 导出  表 nhcj.t_require 结构
DROP TABLE IF EXISTS `t_require`;
CREATE TABLE IF NOT EXISTS `t_require` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `examine_date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `examine_msg` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `examine_status` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `look_man` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mouth` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `require_text` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `send_date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `require_title` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `require_type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_require 的数据：~8 rows (大约)
DELETE FROM `t_require`;
/*!40000 ALTER TABLE `t_require` DISABLE KEYS */;
INSERT INTO `t_require` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `examine_date`, `examine_msg`, `examine_status`, `look_man`, `mouth`, `remark`, `require_text`, `send_date`, `user_name`, `year`, `require_title`, `require_type`) VALUES
	('10001', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '城建考核要求111111', NULL, NULL, '2021', NULL, '城建'),
	('10002', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '城建考核要求22222', NULL, NULL, '2021', NULL, '城建'),
	('10003', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '城建考核要求33333', NULL, NULL, '2021', NULL, '城建'),
	('10004', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '城建考核要求44444', NULL, NULL, '2021', NULL, '城建'),
	('10005', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '农办考核要求111111', NULL, NULL, '2021', NULL, '农办'),
	('10006', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '组织考核要求22222', NULL, NULL, '2021', NULL, '组织'),
	('10007', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '公安考核要求33333', NULL, NULL, '2021', NULL, '公安'),
	('10008', 'admin', '2021-03-17 13:59:29.000000', 0, NULL, NULL, NULL, NULL, NULL, NULL, '3', NULL, '公安考核要求44444', NULL, NULL, '2021', NULL, '公安');
/*!40000 ALTER TABLE `t_require` ENABLE KEYS */;

-- 导出  表 nhcj.t_role 结构
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE IF NOT EXISTS `t_role` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `data_type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_role 的数据：~5 rows (大约)
DELETE FROM `t_role`;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` (`id`, `create_by`, `create_time`, `update_by`, `update_time`, `name`, `del_flag`, `default_role`, `description`, `data_type`) VALUES
	(496138616573952, '', '2018-04-22 23:03:49', 'admin', '2018-11-15 23:02:59', 'ROLE_ADMIN', 0, NULL, '超级管理员 拥有所有权限', 0),
	(496138616573953, '', '2018-05-02 21:40:03', 'admin', '2018-11-01 22:59:48', 'ROLE_USER', 0, b'1', '普通注册用户 路过看看', 0),
	(1383250191871774721, 'admin', '2021-04-17 10:45:20', 'admin', '2021-04-17 10:45:20', 'ROLE_CARADMIN', 0, NULL, '三小车系统超级管理员', 0),
	(1383347239669338113, 'admin', '2021-04-17 17:10:58', 'admin', '2021-04-17 17:10:58', 'ROLE_ZFADMIN', 0, NULL, '政府超级管理员', 0),
	(1384462977951993857, 'admin', '2021-04-20 19:04:31', 'admin', '2021-04-20 19:04:31', 'ROLE_CARSELLER', 0, NULL, '三小车卖家', 0);
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;

-- 导出  表 nhcj.t_role_department 结构
DROP TABLE IF EXISTS `t_role_department`;
CREATE TABLE IF NOT EXISTS `t_role_department` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_role_department 的数据：~0 rows (大约)
DELETE FROM `t_role_department`;
/*!40000 ALTER TABLE `t_role_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_role_department` ENABLE KEYS */;

-- 导出  表 nhcj.t_role_permission 结构
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE IF NOT EXISTS `t_role_permission` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `permission_id` bigint(20) unsigned DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_role_permission 的数据：~103 rows (大约)
DELETE FROM `t_role_permission`;
/*!40000 ALTER TABLE `t_role_permission` DISABLE KEYS */;
INSERT INTO `t_role_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `permission_id`, `role_id`) VALUES
	(1383250838704754689, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383248359015452673, 1383250191871774721),
	(1383250838704754690, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383248835903623169, 1383250191871774721),
	(1383250838704754691, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249229895569409, 1383250191871774721),
	(1383250838704754692, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383248914563600384, 1383250191871774721),
	(1383250838704754693, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249341468250113, 1383250191871774721),
	(1383250838704754694, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383248999305318401, 1383250191871774721),
	(1383250838704754695, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249413341843457, 1383250191871774721),
	(1383250838704754696, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249146949013505, 1383250191871774721),
	(1383250838704754697, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249493981532161, 1383250191871774721),
	(1383250838704754698, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249554857660417, 1383250191871774721),
	(1383250838704754699, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249720381673473, 1383250191871774721),
	(1383250838704754700, 'admin', '2021-04-17 10:47:54', 0, 'admin', '2021-04-17 10:47:54', 1383249842511417345, 1383250191871774721),
	(1383675897927831552, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383248359015452673, 1383347239669338113),
	(1383675897927831553, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383248835903623169, 1383347239669338113),
	(1383675897927831554, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249229895569409, 1383347239669338113),
	(1383675897927831555, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383248914563600384, 1383347239669338113),
	(1383675897927831556, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249341468250113, 1383347239669338113),
	(1383675897927831557, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383248999305318401, 1383347239669338113),
	(1383675897927831558, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249413341843457, 1383347239669338113),
	(1383675897927831559, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249146949013505, 1383347239669338113),
	(1383675897927831560, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249493981532161, 1383347239669338113),
	(1383675897927831561, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249554857660417, 1383347239669338113),
	(1383675897927831562, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249720381673473, 1383347239669338113),
	(1383675897927831563, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383249842511417345, 1383347239669338113),
	(1383675897927831564, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375268668069515264, 1383347239669338113),
	(1383675897927831565, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375268784457256961, 1383347239669338113),
	(1383675897927831566, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375268897757990913, 1383347239669338113),
	(1383675897927831567, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375272504389668864, 1383347239669338113),
	(1383675897927831568, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375289279084892160, 1383347239669338113),
	(1383675897927831569, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375289382168301568, 1383347239669338113),
	(1383675897927831570, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375293934070272001, 1383347239669338113),
	(1383675897927831571, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375315264341676032, 1383347239669338113),
	(1383675897927831572, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375335678958768128, 1383347239669338113),
	(1383675897927831573, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1383675843267661824, 1383347239669338113),
	(1383675897927831574, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375335957938704384, 1383347239669338113),
	(1383675897927831575, 'admin', '2021-04-18 14:56:56', 0, 'admin', '2021-04-18 14:56:56', 1375364573640658945, 1383347239669338113),
	(1384477310446604288, 'admin', '2021-04-20 20:01:28', 0, 'admin', '2021-04-20 20:01:28', 1383248359015452673, 1384462977951993857),
	(1384477310446604289, 'admin', '2021-04-20 20:01:28', 0, 'admin', '2021-04-20 20:01:28', 1383248999305318401, 1384462977951993857),
	(1384477310446604290, 'admin', '2021-04-20 20:01:28', 0, 'admin', '2021-04-20 20:01:28', 1384477234097688577, 1384462977951993857),
	(1384477329320972289, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 125909152017944576, 496138616573952),
	(1384477329320972290, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 5129710648430592, 496138616573952),
	(1384477329320972291, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 5129710648430593, 496138616573952),
	(1384477329320972292, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 15701400130424832, 496138616573952),
	(1384477329320972293, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16678126574637056, 496138616573952),
	(1384477329320972294, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 15701915807518720, 496138616573952),
	(1384477329320972295, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 15708892205944832, 496138616573952),
	(1384477329320972296, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16678447719911424, 496138616573952),
	(1384477329320972297, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 25014528525733888, 496138616573952),
	(1384477329320972298, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 56898976661639168, 496138616573952),
	(1384477329320972299, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 156365156580855808, 496138616573952),
	(1384477329320972300, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 40238597734928384, 496138616573952),
	(1384477329320972301, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 45235621697949696, 496138616573952),
	(1384477329320972302, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 45235787867885568, 496138616573952),
	(1384477329320972303, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 45235939278065664, 496138616573952),
	(1384477329320972304, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 5129710648430594, 496138616573952),
	(1384477329320972305, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16687383932047360, 496138616573952),
	(1384477329320972306, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16689632049631232, 496138616573952),
	(1384477329320972307, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16689745006432256, 496138616573952),
	(1384477329320972308, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16689883993083904, 496138616573952),
	(1384477329320972309, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16690313745666048, 496138616573952),
	(1384477329320972310, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 5129710648430595, 496138616573952),
	(1384477329320972311, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16694861252005888, 496138616573952),
	(1384477329320972312, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16695107491205120, 496138616573952),
	(1384477329320972313, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 16695243126607872, 496138616573952),
	(1384477329320972314, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 75002207560273920, 496138616573952),
	(1384477329320972315, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 76215889006956544, 496138616573952),
	(1384477329320972316, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 76216071333351424, 496138616573952),
	(1384477329320972317, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 76216264070008832, 496138616573952),
	(1384477329320972318, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 76216459709124608, 496138616573952),
	(1384477329320972319, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 76216594207870976, 496138616573952),
	(1384477329320972320, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 76216702639017984, 496138616573952),
	(1384477329320972321, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1373249454269927425, 496138616573952),
	(1384477329320972322, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 39915540965232640, 496138616573952),
	(1384477329320972323, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 41363147411427328, 496138616573952),
	(1384477329320972324, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 41363537456533504, 496138616573952),
	(1384477329320972325, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 41364927394353152, 496138616573952),
	(1384477329320972326, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 102235632889237504, 496138616573952),
	(1384477329320972327, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 102237605176807424, 496138616573952),
	(1384477329320972328, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383248359015452673, 496138616573952),
	(1384477329320972329, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383248835903623169, 496138616573952),
	(1384477329320972330, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249229895569409, 496138616573952),
	(1384477329320972331, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383248914563600384, 496138616573952),
	(1384477329320972332, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249341468250113, 496138616573952),
	(1384477329320972333, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383248999305318401, 496138616573952),
	(1384477329320972334, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249413341843457, 496138616573952),
	(1384477329320972335, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1384477234097688577, 496138616573952),
	(1384477329320972336, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249146949013505, 496138616573952),
	(1384477329320972337, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249493981532161, 496138616573952),
	(1384477329320972338, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249554857660417, 496138616573952),
	(1384477329320972339, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249720381673473, 496138616573952),
	(1384477329320972340, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383249842511417345, 496138616573952),
	(1384477329320972341, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375268668069515264, 496138616573952),
	(1384477329320972342, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375268784457256961, 496138616573952),
	(1384477329320972343, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375268897757990913, 496138616573952),
	(1384477329320972344, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375272504389668864, 496138616573952),
	(1384477329320972345, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375289279084892160, 496138616573952),
	(1384477329320972346, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375289382168301568, 496138616573952),
	(1384477329320972347, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375293934070272001, 496138616573952),
	(1384477329320972348, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375315264341676032, 496138616573952),
	(1384477329320972349, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375335678958768128, 496138616573952),
	(1384477329320972350, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1383675843267661824, 496138616573952),
	(1384477329320972351, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375335957938704384, 496138616573952),
	(1384477329320972352, 'admin', '2021-04-20 20:01:32', 0, 'admin', '2021-04-20 20:01:32', 1375364573640658945, 496138616573952);
/*!40000 ALTER TABLE `t_role_permission` ENABLE KEYS */;

-- 导出  表 nhcj.t_roster_user_a 结构
DROP TABLE IF EXISTS `t_roster_user_a`;
CREATE TABLE IF NOT EXISTS `t_roster_user_a` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `level` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_roster_user_a 的数据：~0 rows (大约)
DELETE FROM `t_roster_user_a`;
/*!40000 ALTER TABLE `t_roster_user_a` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_roster_user_a` ENABLE KEYS */;

-- 导出  表 nhcj.t_s4_shen_shu 结构
DROP TABLE IF EXISTS `t_s4_shen_shu`;
CREATE TABLE IF NOT EXISTS `t_s4_shen_shu` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `mouth` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `require_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `require_text` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `village_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `village_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vo_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `require_reason` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `grade` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `item_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `item_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `time_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_s4_shen_shu 的数据：~0 rows (大约)
DELETE FROM `t_s4_shen_shu`;
/*!40000 ALTER TABLE `t_s4_shen_shu` DISABLE KEYS */;
INSERT INTO `t_s4_shen_shu` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `mouth`, `reason`, `remark`, `require_id`, `require_text`, `village_id`, `village_name`, `vo_id`, `year`, `require_reason`, `grade`, `item_id`, `item_name`, `time_id`) VALUES
	('1372510915332804609', NULL, '2021-03-18 19:31:16.899000', 0, NULL, NULL, NULL, '123', NULL, '10001', '城建考核要求111111', '1372073268785319936', '长街村', '1372504805121069063', NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `t_s4_shen_shu` ENABLE KEYS */;

-- 导出  表 nhcj.t_seller 结构
DROP TABLE IF EXISTS `t_seller`;
CREATE TABLE IF NOT EXISTS `t_seller` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `id_card` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `open_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `shop_duty` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `shop_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `yyzz` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `address_file` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `yyzz_file` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sh` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `tj` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_seller 的数据：~9 rows (大约)
DELETE FROM `t_seller`;
/*!40000 ALTER TABLE `t_seller` DISABLE KEYS */;
INSERT INTO `t_seller` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `address`, `date`, `id_card`, `mobile`, `open_id`, `remark`, `shop_duty`, `shop_name`, `yyzz`, `address_file`, `yyzz_file`, `sh`, `tj`) VALUES
	('1381147474437214208', NULL, '2021-04-11 15:29:53.042000', 0, 'admin', '2021-04-16 09:35:09.261000', '长街东兴路', '2021-04-13', '330226199901013329', '18667856127', 'o7coV5YmheKkzEV14_9eVCSBQSLw', NULL, '测试', '东风', '2358866', '7a906bfffa1c4801a457e8e53414ee9a.jpg', 'b45b5f8426ae45299610ec16266638a9.jpg', '1', '1'),
	('1381311974385782785', NULL, '2021-04-12 02:23:32.886000', 0, NULL, NULL, NULL, NULL, '', NULL, 'o7coV5YlabiehZcDHaMTI3m8Zjdg', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0'),
	('1381785361931440128', NULL, '2021-04-13 09:44:37.273000', 0, NULL, NULL, NULL, NULL, '', NULL, 'o7coV5dxL7Y-S4dMMew1GgRYvZUw', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0'),
	('1381804305098608640', NULL, '2021-04-13 10:59:53.677000', 0, NULL, NULL, NULL, NULL, '', NULL, 'o7coV5ZkoUvfYITJxtRNrejpJHGg', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0'),
	('1382166045929902081', NULL, '2021-04-14 10:57:19.410000', 0, NULL, NULL, NULL, NULL, '', NULL, 'o7coV5S0SjoL5R0-SOiJ8hrtEi2c', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0'),
	('1382882729334542337', NULL, '2021-04-16 10:25:10.049000', 0, NULL, NULL, NULL, NULL, '', NULL, 'o7coV5QfEfHkUvrNz8sblt02jxk0', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0'),
	('1383087522401357824', NULL, '2021-04-16 23:58:56.521000', 0, NULL, NULL, NULL, NULL, '', NULL, 'o7coV5YvZMY4IDri7Iv2gO4MN0Zs', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0'),
	('1383287669802536961', NULL, '2021-04-17 13:14:15.395000', 0, NULL, NULL, NULL, NULL, '', NULL, 'o7coV5fa5qgpXtnFfpnvt9aGlYWg', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0'),
	('1385394385809707009', 'admin', '2021-04-23 08:45:35.633000', 0, NULL, NULL, '测试账号,存放初始车辆', NULL, '330283199909090009', '17857054385', 'o7coV5cPxcPbBkSmKUA-tTwxXw9s', '测试账号,存放初始车辆', '测试账号', '虚拟店铺', 'XXXXXXXXXXXXXXXXX', NULL, NULL, '1', '1');
/*!40000 ALTER TABLE `t_seller` ENABLE KEYS */;

-- 导出  表 nhcj.t_setting 结构
DROP TABLE IF EXISTS `t_setting`;
CREATE TABLE IF NOT EXISTS `t_setting` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_setting 的数据：~0 rows (大约)
DELETE FROM `t_setting`;
/*!40000 ALTER TABLE `t_setting` DISABLE KEYS */;
INSERT INTO `t_setting` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `value`) VALUES
	('OTHER_SETTING', 'admin', '2021-03-20 20:26:13', 0, 'admin', '2021-03-20 20:30:01', '{"domain":"https://artskyhome.com:8080","ssoDomain":"artskyhome.com","blacklist":""}');
/*!40000 ALTER TABLE `t_setting` ENABLE KEYS */;

-- 导出  表 nhcj.t_sh_msg 结构
DROP TABLE IF EXISTS `t_sh_msg`;
CREATE TABLE IF NOT EXISTS `t_sh_msg` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `form_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `msg` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `seller_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_sh_msg 的数据：~7 rows (大约)
DELETE FROM `t_sh_msg`;
/*!40000 ALTER TABLE `t_sh_msg` DISABLE KEYS */;
INSERT INTO `t_sh_msg` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `date`, `form_id`, `msg`, `status`, `type`, `seller_id`, `name`) VALUES
	('1381139037112373250', NULL, '2021-04-11 14:56:21.427000', 0, 'admin', '2021-04-11 14:56:50.877000', '2021-04-11 14时56分50秒', '1381138258209148928', '不行', '未通过', '卖家资质审核', '1381138258209148928', '测试店铺'),
	('1381139260559724544', NULL, '2021-04-11 14:57:14.701000', 0, 'admin', '2021-04-11 14:57:22.732000', '2021-04-11 14时57分22秒', '1381138258209148928', '审核通过', '已通过', '卖家资质审核', '1381138258209148928', '测试店铺'),
	('1381139510305361922', NULL, '2021-04-11 14:58:14.245000', 0, 'admin', '2021-04-11 14:58:33.340000', '2021-04-11 14时58分33秒', '1381139510305361920', '不可以', '未通过', '车辆新增审核', '1381138258209148928', '电动三轮车 - DDD'),
	('1381139666593517569', NULL, '2021-04-11 14:58:51.507000', 0, 'admin', '2021-04-11 14:59:04.406000', '2021-04-11 14时59分4秒', '1381139510305361920', '', '已通过', '车辆修改审核', '1381138258209148928', '电动三轮车 - DDD'),
	('1381140178520903680', NULL, '2021-04-11 15:00:53.560000', 0, 'admin', '2021-04-16 09:38:43.930000', '2021-04-16 9时38分43秒', '1381139510305361920', '可以的', '已通过', '车辆修改审核', '1381138258209148928', '电动三轮车 - DDD'),
	('1381659427974811648', NULL, '2021-04-13 01:24:12.279000', 0, 'admin', '2021-04-16 09:35:09.257000', '2021-04-16 9时35分9秒', '1381147474437214208', '审核通过', '已通过', '卖家资质审核', '1381147474437214208', '东风'),
	('1384476581023584256', NULL, '2021-04-20 19:58:33.904000', 0, 'admin', '2021-04-20 19:58:44.951000', '2021-04-20 19时58分44秒', '1384476351179919360', '审核通过', '已通过', '卖家资质审核', '1384476351179919360', '测试店铺');
/*!40000 ALTER TABLE `t_sh_msg` ENABLE KEYS */;

-- 导出  表 nhcj.t_social 结构
DROP TABLE IF EXISTS `t_social`;
CREATE TABLE IF NOT EXISTS `t_social` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `platform` tinyint(1) unsigned DEFAULT NULL,
  `relate_username` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relate_open_id` (`open_id`,`platform`) USING BTREE,
  UNIQUE KEY `relate_username` (`relate_username`,`platform`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_social 的数据：~0 rows (大约)
DELETE FROM `t_social`;
/*!40000 ALTER TABLE `t_social` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_social` ENABLE KEYS */;

-- 导出  表 nhcj.t_system_user_role 结构
DROP TABLE IF EXISTS `t_system_user_role`;
CREATE TABLE IF NOT EXISTS `t_system_user_role` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `level` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_system_user_role 的数据：~57 rows (大约)
DELETE FROM `t_system_user_role`;
/*!40000 ALTER TABLE `t_system_user_role` DISABLE KEYS */;
INSERT INTO `t_system_user_role` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `level`, `name`, `remark`, `type`) VALUES
	('1372142573380046848', NULL, '2021-03-17 19:07:37.412000', 0, NULL, NULL, '一', '长街镇', '无备注', '一级账号'),
	('1372142761058373632', NULL, '2021-03-17 19:08:22.075000', 0, NULL, NULL, '二', '镇组织线', '无备注', '组织'),
	('1372143178416787456', NULL, '2021-03-17 19:10:01.581000', 0, NULL, NULL, '二', '镇城建线', '无备注', '城建'),
	('1372143217121824768', NULL, '2021-03-17 19:10:10.808000', 0, NULL, NULL, '二', '镇农办线', '无备注', '农办'),
	('1372143410458267649', NULL, '2021-03-17 19:10:56.905000', 0, NULL, NULL, '二', '镇公安线', '无备注', '公安'),
	('1372144090174590976', NULL, '2021-03-17 19:13:38.962000', 0, NULL, NULL, '三', '长街联村', '无备注', '联村'),
	('1372144113062907904', NULL, '2021-03-17 19:13:44.418000', 0, NULL, NULL, '三', '大湖联村', '无备注', '联村'),
	('1372144139663183872', NULL, '2021-03-17 19:13:50.760000', 0, NULL, NULL, '三', '岳井联村', '无备注', '联村'),
	('1372144157497364480', NULL, '2021-03-17 19:13:55.012000', 0, NULL, NULL, '三', '伍山联村', '无备注', '联村'),
	('1372144175151190016', NULL, '2021-03-17 19:13:59.220000', 0, NULL, NULL, '三', '龙浦联村', '无备注', '联村'),
	('1372144193400606720', NULL, '2021-03-17 19:14:03.572000', 0, NULL, NULL, '三', '山头联村', '无备注', '联村'),
	('1372144214405681152', NULL, '2021-03-17 19:14:08.580000', 0, NULL, NULL, '三', '青珠联村', '无备注', '联村'),
	('1372145752079470597', NULL, '2021-03-17 19:20:15.197000', 0, NULL, NULL, '四', '长街村', '无备注', '行政村'),
	('1372145752167550976', NULL, '2021-03-17 19:20:15.209000', 0, NULL, NULL, '四', '九江村', '无备注', '行政村'),
	('1372145752175939584', NULL, '2021-03-17 19:20:15.211000', 0, NULL, NULL, '四', '洋湖村', '无备注', '行政村'),
	('1372145752184328192', NULL, '2021-03-17 19:20:15.213000', 0, NULL, NULL, '四', '车岙村', '无备注', '行政村'),
	('1372145752192716800', NULL, '2021-03-17 19:20:15.215000', 0, NULL, NULL, '四', '石桥头村', '无备注', '行政村'),
	('1372145752201105408', NULL, '2021-03-17 19:20:15.218000', 0, NULL, NULL, '四', '环河社区', '无备注', '行政村'),
	('1372145752213688320', NULL, '2021-03-17 19:20:15.220000', 0, NULL, NULL, '四', '西岙村', '无备注', '行政村'),
	('1372145752222076928', NULL, '2021-03-17 19:20:15.222000', 0, NULL, NULL, '四', '城塘村', '无备注', '行政村'),
	('1372145752230465536', NULL, '2021-03-17 19:20:15.225000', 0, NULL, NULL, '四', '山前村', '无备注', '行政村'),
	('1372145752243048448', NULL, '2021-03-17 19:20:15.227000', 0, NULL, NULL, '四', '大祝村', '无备注', '行政村'),
	('1372145752251437056', NULL, '2021-03-17 19:20:15.229000', 0, NULL, NULL, '四', '大湖村', '无备注', '行政村'),
	('1372145752259825664', NULL, '2021-03-17 19:20:15.231000', 0, NULL, NULL, '四', '南塘村', '无备注', '行政村'),
	('1372145752268214272', NULL, '2021-03-17 19:20:15.233000', 0, NULL, NULL, '四', '塘里村', '无备注', '行政村'),
	('1372145752272408576', NULL, '2021-03-17 19:20:15.234000', 0, NULL, NULL, '四', '浦东村', '无备注', '行政村'),
	('1372145752276602880', NULL, '2021-03-17 19:20:15.236000', 0, NULL, NULL, '四', '新塘村', '无备注', '行政村'),
	('1372145752289185792', NULL, '2021-03-17 19:20:15.239000', 0, NULL, NULL, '四', '隔洋塘村', '无备注', '行政村'),
	('1372145752301768704', NULL, '2021-03-17 19:20:15.241000', 0, NULL, NULL, '四', '李家庄村', '无备注', '行政村'),
	('1372145752305963008', NULL, '2021-03-17 19:20:15.243000', 0, NULL, NULL, '四', '岳井村', '无备注', '行政村'),
	('1372145752314351616', NULL, '2021-03-17 19:20:15.244000', 0, NULL, NULL, '四', '岳墩村', '无备注', '行政村'),
	('1372145752322740224', NULL, '2021-03-17 19:20:15.246000', 0, NULL, NULL, '四', '对岙洞村', '无备注', '行政村'),
	('1372145752326934528', NULL, '2021-03-17 19:20:15.248000', 0, NULL, NULL, '四', '上塘村', '无备注', '行政村'),
	('1372145752335323136', NULL, '2021-03-17 19:20:15.249000', 0, NULL, NULL, '四', '伍山村', '无备注', '行政村'),
	('1372145752343711744', NULL, '2021-03-17 19:20:15.251000', 0, NULL, NULL, '四', '下湾塘村', '无备注', '行政村'),
	('1372145752352100352', NULL, '2021-03-17 19:20:15.253000', 0, NULL, NULL, '四', '月兰村', '无备注', '行政村'),
	('1372145752356294656', NULL, '2021-03-17 19:20:15.254000', 0, NULL, NULL, '四', '向阳村', '无备注', '行政村'),
	('1372145752364683264', NULL, '2021-03-17 19:20:15.256000', 0, NULL, NULL, '四', '长胜村', '无备注', '行政村'),
	('1372145752368877568', NULL, '2021-03-17 19:20:15.257000', 0, NULL, NULL, '四', '下塘村', '无备注', '行政村'),
	('1372145752377266176', NULL, '2021-03-17 19:20:15.259000', 0, NULL, NULL, '四', '总浦塘村', '无备注', '行政村'),
	('1372145752385654784', NULL, '2021-03-17 19:20:15.261000', 0, NULL, NULL, '四', '宁东村', '无备注', '行政村'),
	('1372145752389849088', NULL, '2021-03-17 19:20:15.262000', 0, NULL, NULL, '四', '新城村', '无备注', '行政村'),
	('1372145752398237696', NULL, '2021-03-17 19:20:15.264000', 0, NULL, NULL, '四', '龙山村', '无备注', '行政村'),
	('1372145752402432000', NULL, '2021-03-17 19:20:15.265000', 0, NULL, NULL, '四', '连浦村', '无备注', '行政村'),
	('1372145752410820608', NULL, '2021-03-17 19:20:15.267000', 0, NULL, NULL, '四', '湘田山村', '无备注', '行政村'),
	('1372145752415014912', NULL, '2021-03-17 19:20:15.269000', 0, NULL, NULL, '四', '五福村', '无备注', '行政村'),
	('1372145752423403520', NULL, '2021-03-17 19:20:15.270000', 0, NULL, NULL, '四', '山头村', '无备注', '行政村'),
	('1372145752431792128', NULL, '2021-03-17 19:20:15.272000', 0, NULL, NULL, '四', '港中村', '无备注', '行政村'),
	('1372145752435986432', NULL, '2021-03-17 19:20:15.273000', 0, NULL, NULL, '四', '平原村', '无备注', '行政村'),
	('1372145752444375040', NULL, '2021-03-17 19:20:15.275000', 0, NULL, NULL, '四', '大青村', '无备注', '行政村'),
	('1372145752444375041', NULL, '2021-03-17 19:20:15.275000', 0, NULL, NULL, '四', '东港村', '无备注', '行政村'),
	('1372145752452763648', NULL, '2021-03-17 19:20:15.277000', 0, NULL, NULL, '四', '双家村', '无备注', '行政村'),
	('1372145752456957952', NULL, '2021-03-17 19:20:15.279000', 0, NULL, NULL, '四', '青珠村', '无备注', '行政村'),
	('1372145752465346560', NULL, '2021-03-17 19:20:15.280000', 0, NULL, NULL, '四', '新南村', '无备注', '行政村'),
	('1372145752469540864', NULL, '2021-03-17 19:20:15.282000', 0, NULL, NULL, '四', '新五星村', '无备注', '行政村'),
	('1372145752477929472', NULL, '2021-03-17 19:20:15.283000', 0, NULL, NULL, '四', '文围村', '无备注', '行政村'),
	('1372145752486318080', NULL, '2021-03-17 19:20:15.285000', 0, NULL, NULL, '四', '青农社区', '无备注', '行政村');
/*!40000 ALTER TABLE `t_system_user_role` ENABLE KEYS */;

-- 导出  表 nhcj.t_two_windows 结构
DROP TABLE IF EXISTS `t_two_windows`;
CREATE TABLE IF NOT EXISTS `t_two_windows` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `item_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `item_name` varchar(512) COLLATE utf8_croatian_ci DEFAULT NULL,
  `aa` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `aaa` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `aaaa` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `aaaaa` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `bb` float NOT NULL,
  `bbb` float NOT NULL,
  `bbbb` float NOT NULL,
  `bbbbb` float NOT NULL,
  `cc` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ccc` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `cccc` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ccccc` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `dd` float NOT NULL,
  `ddd` float NOT NULL,
  `dddd` float NOT NULL,
  `ddddd` float NOT NULL,
  `ee` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `eee` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `eeee` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `eeeee` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ff` float NOT NULL,
  `fff` float NOT NULL,
  `ffff` float NOT NULL,
  `fffff` float NOT NULL,
  `gg` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ggg` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `gggg` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ggggg` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `hh` float NOT NULL,
  `hhh` float NOT NULL,
  `hhhh` float NOT NULL,
  `hhhhh` float NOT NULL,
  `ii` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `iii` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `iiii` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `iiiii` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `jj` float NOT NULL,
  `jjj` float NOT NULL,
  `jjjj` float NOT NULL,
  `jjjjj` float NOT NULL,
  `kk` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `kkk` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `kkkk` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `kkkkk` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `line_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ll` float NOT NULL,
  `lll` float NOT NULL,
  `llll` float NOT NULL,
  `lllll` float NOT NULL,
  `mm` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mmm` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mmmm` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `nn` float NOT NULL,
  `nnn` float NOT NULL,
  `nnnn` float NOT NULL,
  `oo` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ooo` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `oooo` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `pp` float NOT NULL,
  `ppp` float NOT NULL,
  `pppp` float NOT NULL,
  `qq` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `qqq` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `qqqq` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `rr` float NOT NULL,
  `rrr` float NOT NULL,
  `rrrr` float NOT NULL,
  `ss` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sss` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `ssss` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `time_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `tt` float NOT NULL,
  `ttt` float NOT NULL,
  `tttt` float NOT NULL,
  `uu` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `uuu` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `uuuu` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `vv` float NOT NULL,
  `vvv` float NOT NULL,
  `vvvv` float NOT NULL,
  `ww` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `www` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `wwww` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `xx` float NOT NULL,
  `xxx` float NOT NULL,
  `xxxx` float NOT NULL,
  `yy` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `yyy` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `yyyy` varchar(30) COLLATE utf8_croatian_ci DEFAULT NULL,
  `zz` float NOT NULL,
  `zzz` float NOT NULL,
  `zzzz` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_two_windows 的数据：~131 rows (大约)
DELETE FROM `t_two_windows`;
/*!40000 ALTER TABLE `t_two_windows` DISABLE KEYS */;
INSERT INTO `t_two_windows` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `item_id`, `item_name`, `aa`, `aaa`, `aaaa`, `aaaaa`, `bb`, `bbb`, `bbbb`, `bbbbb`, `cc`, `ccc`, `cccc`, `ccccc`, `dd`, `ddd`, `dddd`, `ddddd`, `ee`, `eee`, `eeee`, `eeeee`, `ff`, `fff`, `ffff`, `fffff`, `gg`, `ggg`, `gggg`, `ggggg`, `hh`, `hhh`, `hhhh`, `hhhhh`, `ii`, `iii`, `iiii`, `iiiii`, `jj`, `jjj`, `jjjj`, `jjjjj`, `kk`, `kkk`, `kkkk`, `kkkkk`, `line_id`, `ll`, `lll`, `llll`, `lllll`, `mm`, `mmm`, `mmmm`, `nn`, `nnn`, `nnnn`, `oo`, `ooo`, `oooo`, `pp`, `ppp`, `pppp`, `qq`, `qqq`, `qqqq`, `rr`, `rrr`, `rrrr`, `ss`, `sss`, `ssss`, `time_id`, `tt`, `ttt`, `tttt`, `uu`, `uuu`, `uuuu`, `vv`, `vvv`, `vvvv`, `ww`, `www`, `wwww`, `xx`, `xxx`, `xxxx`, `yy`, `yyy`, `yyyy`, `zz`, `zzz`, `zzzz`) VALUES
	('1383649035247816706', 'null', '2021-04-18 13:10:11.000000', 0, 'admin', '2021-04-18 15:29:19.032000', '1376058976256528384', '村干部缺席各类会议和活动每人次扣0.1分，无故迟到或早退每人次扣0.1分。', '做的不行', '无', '无', '无', -1, 0, 0, 0, '做的很好', '无', '无', '无', 1, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055106562297857', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035340091392', NULL, '2021-04-18 13:10:11.640000', 0, NULL, NULL, '1376059104619008001', '未按要求完成镇党委政府布置的工作的每起扣1分，经催办后仍未落实的加倍扣分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055106562297857', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035365257219', 'null', '2021-04-18 13:10:11.000000', 0, 'admin', '2021-04-18 13:10:22.575000', '1376059427060322305', '镇代表无故不参加人大会议、活动的每次扣0.5分；', '不好', '无', '无', '无', -0.5, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055196844691456', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035382034432', NULL, '2021-04-18 13:10:11.649000', 0, NULL, NULL, '1376059459620704257', '代表建议涉及权限不配合落实的，酌情扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055196844691456', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035394617344', NULL, '2021-04-18 13:10:11.654000', 0, NULL, NULL, '1376059516751319040', '在县、镇人大代表选举工作不支持、不配合的，酌情扣1－3分，存在破坏选举行为的，扣5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055196844691456', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035428171789', NULL, '2021-04-18 13:10:11.670000', 0, NULL, NULL, '1376059552214159361', '党建亮显党徽、党语、村干部值班表、联村干部亮相台、党员形象栏、共产党员户、联户网格等缺失不完善的，每项扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035478503424', NULL, '2021-04-18 13:10:11.672000', 0, NULL, NULL, '1376059577723916288', '村社班子挂牌、党员活动室三要素等悬挂不规范的，每项扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035491086336', NULL, '2021-04-18 13:10:11.675000', 0, NULL, NULL, '1376059608560439296', '村班子不团结，公开散布不团结言行的，班子内相互信访的，每例扣2分，造成严重影响和不良后果的，每例加扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035503669248', NULL, '2021-04-18 13:10:11.678000', 0, NULL, NULL, '1376059640953049088', '村社主职干部违法违纪被处理的，或被司法机关处罚的，每例扣3分；存在被评为不合格村社干部、歇职教育、免职等情形的，每例扣5分。其他干部存在上述情况的，减半扣分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035516252160', NULL, '2021-04-18 13:10:11.682000', 0, NULL, NULL, '1376059669512065025', '在县镇党代表、县政协委员选举工作中不配合、不支持的，每例酌情扣0.5－3分，存在破坏选举行为的，每例扣5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035528835072', NULL, '2021-04-18 13:10:11.685000', 0, NULL, NULL, '1376059699115462656', '未严格落实周二联合办公、村干部坐班值班的，每例扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035541417984', NULL, '2021-04-18 13:10:11.688000', 0, NULL, NULL, '1376059721013923841', '支部标准化规范化建设不到位，“三会一课”未落实的，每例扣0.5分；主题党日不规范的，每例扣0.5分。会议记录不规范、党员会议到会率未达到80%的，每项每次扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035554000896', NULL, '2021-04-18 13:10:11.691000', 0, NULL, NULL, '1376059758540361729', '锋领指数考评、组织生活会、党员民主评议等县镇规定工作未完成的，每项扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035566583808', NULL, '2021-04-18 13:10:11.694000', 0, NULL, NULL, '1376059820293099521', '两委班子中无大专及以上学历的，扣0.5分；无35周岁及以下干部的，扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035579166720', NULL, '2021-04-18 13:10:11.696000', 0, NULL, NULL, '1376059857932783617', '未落实村级后备干部培育措施的，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035591749632', NULL, '2021-04-18 13:10:11.700000', 0, NULL, NULL, '1376059881945174017', '党费收缴不规范，每例扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035608526848', NULL, '2021-04-18 13:10:11.704000', 0, NULL, NULL, '1376059924987121664', '党员发展各项指标未完成的每项扣1分；三年以上未发展党员的，扣5分，每多一年加扣1分；无35周岁及以下党员村社未销号的，扣2分；每村2名入党积极分子要求未达标的，扣2分，积极分子达到5人以上的，每增加1人加0.5分，最高加2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035621109760', NULL, '2021-04-18 13:10:11.707000', 0, NULL, NULL, '1376060032587796480', '新发展党员年龄低于35周岁的，每例加0.5分；新发展高中学历党员，每例扣0.5分，初中及以下学历党员，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035633692672', NULL, '2021-04-18 13:10:11.709000', 0, NULL, NULL, '1376060078158909441', '党员除名、党组织关系迁移教育整转支部的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035646275584', NULL, '2021-04-18 13:10:11.712000', 0, NULL, NULL, '1376060104704659456', '党务未按时公开的，每次扣1分；公开内容不全面，程序不到位，张贴不规范的，每次扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035654664192', NULL, '2021-04-18 13:10:11.715000', 0, NULL, NULL, '1376060129836929025', '被评为二星级及以下党组织的，分别扣1－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035667247104', NULL, '2021-04-18 13:10:11.717000', 0, NULL, NULL, '1376060167719882753', '后进村党组织未按期完成整转的，每例扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035679830016', NULL, '2021-04-18 13:10:11.721000', 0, NULL, NULL, '1376060198791286785', '项目党建助推中心工作有力，被确立为县级竞赛项目的，每例加0.5分，百村立功竞赛获评县级优秀项目一、二、三等奖的，每例加3－1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035692412928', NULL, '2021-04-18 13:10:11.724000', 0, NULL, NULL, '1376060237970280449', '新建党建联盟实效明显，现有党建联盟扩面提质的，每例酌情加1－2分；现有党建联盟未实际运转的，每例酌情扣1－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035704995840', NULL, '2021-04-18 13:10:11.726000', 0, NULL, NULL, '1376060270518079489', '党员联户落实到位，党员在助推基层治理、乡村振兴等工作中发挥作用较好的，酌情加1－5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035717578752', NULL, '2021-04-18 13:10:11.729000', 0, NULL, NULL, '1376060314029789185', '按要求参与并完成村5A级党群服务中心创建的，加3分，未完成的，扣3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035725967360', NULL, '2021-04-18 13:10:11.732000', 0, NULL, NULL, '1376060349370994689', '申请中央资金扶持项目但未按时完成的，扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035738550272', NULL, '2021-04-18 13:10:11.735000', 0, NULL, NULL, '1376060384590565376', '配合上级部门参加党建活动，或迎接县级以上检查并通过的，每次加0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035751133184', NULL, '2021-04-18 13:10:11.737000', 0, NULL, NULL, '1376060414193963009', '党建工作有亮点，被县级以上平台报道的，每项加1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055267174780929', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035772104705', NULL, '2021-04-18 13:10:11.742000', 0, NULL, NULL, '1376060459832184832', '违反村级权力清单三十六条相关规定的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055361924108288', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035780493312', NULL, '2021-04-18 13:10:11.745000', 0, NULL, NULL, '1376060486377934848', '村内党员受到党内警告、党内严重警告处分的每人扣0.5分，受撤销职务、留党察看处分的每人扣1分，开除党籍的每人扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055361924108288', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035793076224', NULL, '2021-04-18 13:10:11.747000', 0, NULL, NULL, '1376060531529617408', '违反农村基层党风廉政建设有关制度规定，每项扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055361924108288', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035805659136', NULL, '2021-04-18 13:10:11.750000', 0, NULL, NULL, '1376060566497529857', '村班子不支持村务监督委员会工作的，每例扣1分；村务监督委员会工作开展不正常的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055361924108288', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035814047744', NULL, '2021-04-18 13:10:11.753000', 0, NULL, NULL, '1376060602967003136', '审计发现问题移交县级部门的，每例扣3分，移交镇纪委的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055361924108288', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035835019268', NULL, '2021-04-18 13:10:11.757000', 0, NULL, NULL, '1376060655127367681', '未严格落实意识形态工作责任制扣1分，反馈问题未及时整改到位，党员、村干部言行引发网络意识形态问题的，每项扣1分，产生重大影响的，加扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055423685234688', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035847602176', NULL, '2021-04-18 13:10:11.760000', 0, NULL, NULL, '1376060688363032577', '学习强国平台注册量完成党员数、活跃度高于全县平均水平加0.5分，未完成、活跃度低于全县平均的，各扣1分;未在规定时间内完成年度党报党刊征订工作，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055423685234688', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035855990784', NULL, '2021-04-18 13:10:11.763000', 0, NULL, NULL, '1376060818252238849', '农村文化礼堂未配备专职文化管理员，未能按时正常开放，每项扣1分；全年上报甬礼堂5次以上，每少一次扣1分；建成乡村书吧并开放的，加0.5分；未按上级部门标准建有文化、广播、图书等设施，每项扣0.5分；群众文艺团队不足2支的，扣0.5分；创成四、五星级文化礼堂，加0.5－1分；积极参加上级组织的各类赛事、送戏下乡、百姓大舞台等文化活动，每次加0.5分；全年开展各类文化活动等5次以上，每少一次扣0.5分；建有农村文化礼堂基金（公益金），加1分；有一首“村歌”，加1分。未每月巡查报送平台“扫黄打非”2次以上，扣1分。发生重大文物安全事故、文化相关违法事件、节庆活动重大安全事故、文化单位重大安全事故，每例扣5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055423685234688', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035872768000', NULL, '2021-04-18 13:10:11.767000', 0, NULL, NULL, '1376060877278679041', '创城工作未达标或整改不到位的，每次扣5分。省级测评出现严重问题的，每项扣5分。未按要求完成新时代文明实践站工作的，扣1分；全年完成新时代文明实践志愿服务（必须穿红马甲）8次，每少一次扣0.5分。创成县级、市级、省级文明村，成效明显的分别加1－3分，在上级各项检查、评定工作中被要求整改的每次扣1分，整改不到位或被摘牌的，扣2分。有力推进县“三美乡村”精品村建设，加1分。组织开展扣好“人生第一粒扣子”主题教育实践活动、“我们的节日”主题活动、“春泥计划”实施工作，每次加1分，最多不超过3分。推荐好人的，每例加1分；被评为宁海好人、宁波好人、浙江好人、中国好人，分别加1－4分。推进志愿服务规范化，在宁波WE志愿平台完成发布、认领等经常性工作，每年50%的活跃度，未达标扣1－3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055423685234688', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035893739523', NULL, '2021-04-18 13:10:11.771000', 0, NULL, NULL, '1376060920299655169', '成立村乡贤议事会，加2分；经常性开展工作，加1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055498255765504', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035906322432', NULL, '2021-04-18 13:10:11.774000', 0, NULL, NULL, '1376060977153445889', '宗教场所和民间信仰场所每合并（削减）1处的，加2分；出现新增违建、大型涉宗露天造像的，每处扣2分；消防安全隐患未及时整改到位的，每处扣1分；特殊时期未按上级要求开放或关闭的，每次每处扣1分。已整治民间信仰点、私设聚会点出现回潮的，每处扣2分；容留僧尼和游僧常住或参与管理民间信仰场所的，每处扣2分。大型宗教和民间信仰活动未按规定事前报批的，每例扣2分，造成重大影响的，加扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055498255765504', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035918905344', NULL, '2021-04-18 13:10:11.777000', 0, NULL, NULL, '1376061009416032257', '关工委办公场所未落实的，扣0.5分；制度未上墙的，扣0.5分；工作开展不正常的，扣0.5分；创成县级以上五好关工委的加1－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055498255765504', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035935682572', NULL, '2021-04-18 13:10:11.781000', 0, NULL, NULL, '1376061041162719233', '隐瞒、谎报、缓报、漏报或者授意他人隐瞒、谎报、缓报涉稳信息、信访信息的，每件扣1分，造成严重后果的，加扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035948265472', NULL, '2021-04-18 13:10:11.784000', 0, NULL, NULL, '1376061096108101633', '未及时上报每月《矛盾纠纷和不稳定因素排摸月报表》的，每次扣0.5分；遇有紧急情况或重大节点期间，未根据有关要求开展排查工作并上报的，每次扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035960848384', NULL, '2021-04-18 13:10:11.787000', 0, NULL, NULL, '1376061136792850433', '流动人口管理服务工作落地不到位，包括流动人口居住登记、居住信息准确率、居住房屋出租登记，每次扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035973431296', NULL, '2021-04-18 13:10:11.790000', 0, NULL, NULL, '1376061175086845952', '单个到县、市、省、京上访的每例扣0.5、1、2、5分，集体访加倍扣分；集体访涉及多个村群众参与的按单个分别计算，有效参与劝返处置工作的酌情减免；重点维稳人员管控不力，到县去市赴省进京扰序滋事，每人每次加扣1分；发生越级访、集体访、重复访的，每次加扣1分；因村工作不力，导致信访件不满意的，或导致信访件被上级抽查不通过的，导致信访人重复上访的，每例分别扣1分，造成较大影响的扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035986014208', NULL, '2021-04-18 13:10:11.793000', 0, NULL, NULL, '1376061219991064576', '未及时化解双联中心推送的纠纷警情或处理后仍未有效化解，每起扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649035994402816', NULL, '2021-04-18 13:10:11.796000', 0, NULL, NULL, '1376061252010381313', '严重精神障碍患者监管工作不力，肇事肇祸的，每例扣1分；预防青少年违法犯罪工作不到位，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036006985728', NULL, '2021-04-18 13:10:11.798000', 0, NULL, NULL, '1376061292879679489', '未配合犬类整治工作，造成无主犬类多次伤人而未捕杀，每例扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036015374336', NULL, '2021-04-18 13:10:11.801000', 0, NULL, NULL, '1376061323561013249', '未积极开展平安创建工作，每月平安巡防志愿者活动未达2次，扣1分；平安宣传工作落实不力，扣0.5分；未按要求开展道路交通安全隐患排摸，扣1分，引发安全意外死亡，每例扣2分；', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036032151552', NULL, '2021-04-18 13:10:11.805000', 0, NULL, NULL, '1376061362677092353', '不履行网格长工作职责，造成网格工作运行流转不畅的，扣1分；根据镇指挥中心每月通报，扣除e宁波系统不达标网格0.5分；', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036044734464', NULL, '2021-04-18 13:10:11.807000', 0, NULL, NULL, '1376061401042391041', '对本村发生的各类纠纷情况不清、底子不明，导致矛盾纠纷出村的，每例扣0.5分；未及时调解村内发生的各类纠纷或未按规定上报至镇矛调中心，导致矛盾纠纷反映至县级以上有关单位，每例扣2分；因矛盾纠纷调处不及时，发生治安案件、刑事案件的，每件分别扣2分、3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036053123072', NULL, '2021-04-18 13:10:11.810000', 0, NULL, NULL, '1376061446621892608', '未落实社区矫正帮教管控及刑满释放人员安置帮教措施的，扣0.5分；因此导致社区矫正对象及刑满释放人员重新犯罪的，每例加扣1分；不配合镇普法办开展乡村法治讲座、法治宣传进文化礼堂等活动的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036065705984', NULL, '2021-04-18 13:10:11.816000', 0, NULL, NULL, '1376061481715634176', '其他事项需要加扣分项。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055559643598848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036128620551', NULL, '2021-04-18 13:10:11.827000', 0, NULL, NULL, '1376061518331908097', '兵役登记率未达到100%的，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036141203456', NULL, '2021-04-18 13:10:11.830000', 0, NULL, NULL, '1376061578058797057', '征兵工作应征青年体检率未达到100%，按每下降5%扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036149592064', NULL, '2021-04-18 13:10:11.832000', 0, NULL, NULL, '1376061625668341761', '配合征兵工作，动员应征青年光荣入伍，每出兵1例加0.5分，为大学毕业生的，每例再加0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036162174976', NULL, '2021-04-18 13:10:11.835000', 0, NULL, NULL, '1376061669565927425', '未按规定落实民兵连长换届的，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036178952192', NULL, '2021-04-18 13:10:11.839000', 0, NULL, NULL, '1376061708296130561', '民兵连部规范化建设首次达标的，加1分；受到县级或县级以上参观的，加1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036187340800', NULL, '2021-04-18 13:10:11.842000', 0, NULL, NULL, '1376061822972596224', '民兵连预设党支部未建立的，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036199923712', NULL, '2021-04-18 13:10:11.844000', 0, NULL, NULL, '1376061860708749313', '有出动民兵参加执行重大任务或抢险救灾的，酌情加0.5－1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036208312320', NULL, '2021-04-18 13:10:11.846000', 0, NULL, NULL, '1376061909106823169', '悬挂光荣牌未落实到位的，每遗落1人扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036216700928', NULL, '2021-04-18 13:10:11.849000', 0, NULL, NULL, '1376061972549865473', '八一、春节未开展大走访大慰问活动的，扣1分（以慰问照片或打电话抽查为准）。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036229283840', NULL, '2021-04-18 13:10:11.851000', 0, NULL, NULL, '1376062008096591873', '建成全国示范型退役军人服务站的，加3分，建成“枫桥式”退役军人服务站的，加1.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036241866752', NULL, '2021-04-18 13:10:11.854000', 0, NULL, NULL, '1376062044457013249', '落实退役军人轮值站长制度和每月8日学习制度不力的，分别酌情扣1－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036254449664', NULL, '2021-04-18 13:10:11.858000', 0, NULL, NULL, '1376062123402203137', '发挥退役军人作用明显，积极组织退役军人志愿队服务社会发展的，加1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036267032576', NULL, '2021-04-18 13:10:11.860000', 0, NULL, NULL, '1376062172903378944', '因工作不到位，造成退役军人到县级或县级以上单位非法上访的，每人每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055627377414144', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036283809792', NULL, '2021-04-18 13:10:11.864000', 0, NULL, NULL, '1376062219527262209', '日常工作配合不积极的，扣0.5－3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055692636590081', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036292198400', NULL, '2021-04-18 13:10:11.870000', 0, NULL, NULL, '1376062269368176641', '成功创建县级以上有关项目的，加1－3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055692636590081', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036325752834', NULL, '2021-04-18 13:10:11.874000', 0, NULL, NULL, '1376062317824970753', '未按要求及时排摸、反馈所在村的食品、药品等公共安全协管工作相关信息的，每例扣0.5分；导致出现较大影响公共安全问题的，酌情加扣1－3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055764153667584', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036338335744', NULL, '2021-04-18 13:10:11.877000', 0, NULL, NULL, '1376062339652128769', '未按要求开展网格内环境保护方面问题巡查监督工作的，每例扣1分；巡查中发现建筑工地扬尘污染、垃圾焚烧及农业农村废弃物焚烧以及畜禽养殖污染等环境问题，未及时进行制止并上报的，每例扣1分；出现更为严重的环境问题的，酌情加扣1－3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055764153667584', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036355112968', NULL, '2021-04-18 13:10:11.881000', 0, NULL, NULL, '1376062443607953409', '完成水利工程项目，水环境工程、小流域整治工程、高标准农田项目等，每个加0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036363501568', NULL, '2021-04-18 13:10:11.884000', 0, NULL, NULL, '1376062482858250240', '违反财务制度的，每例酌情扣2－4分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036376084480', NULL, '2021-04-18 13:10:11.887000', 0, NULL, NULL, '1376062522238570497', '建设美丽新农村，打造小集镇式中心村的，加1.5分；打造美丽乡村示范村的，加1分；完成乡村梳理式改造的，加0.5分；市级以上的另加1、2、3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036388667392', NULL, '2021-04-18 13:10:11.890000', 0, NULL, NULL, '1376062553456775169', '完成森林防灭火工作，发生违规野外用火案件的，每例扣1分；完成市级以上公益林生态保护管理工作的，加1分；完成两株及以上散生古树名木或一个群及以上保护管理工作的，加0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036401250304', NULL, '2021-04-18 13:10:11.893000', 0, NULL, NULL, '1376062588886061057', '完成农村综合改革（村级公益事业建设）项目，市级加2分，县级加1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036413833216', NULL, '2021-04-18 13:10:11.895000', 0, NULL, NULL, '1376062618451709953', '农调队农业调查未完成的，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036422221824', NULL, '2021-04-18 13:10:11.897000', 0, NULL, NULL, '1376062667336323072', '未落实定人联船制度的，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036434804736', NULL, '2021-04-18 13:10:11.900000', 0, NULL, NULL, '1376062696696451072', '未完成年度五水共治工作任务的，扣1分；未落实河长制被通报的，每例扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036443193344', NULL, '2021-04-18 13:10:11.903000', 0, NULL, NULL, '1376062731429482497', '未完成上级交办其他工作的，每项扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055816355975169', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036464164876', NULL, '2021-04-18 13:10:11.907000', 0, NULL, NULL, '1376062800148959233', '计划生育工作按照《长街镇联村干部、村干部计划生育工作考核办法》执行，达不到要求的，酌情扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036472553472', NULL, '2021-04-18 13:10:11.910000', 0, NULL, NULL, '1376062842683396096', '未完成年度无偿献血任务的，酌情扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036485136384', NULL, '2021-04-18 13:10:11.912000', 0, NULL, NULL, '1376062868021186561', '未完成各级卫生村复查和创建任务的，酌情扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036493524992', NULL, '2021-04-18 13:10:11.914000', 0, NULL, NULL, '1376062899549769728', '在国家卫生城镇创建中，涉及村工作达不到要求的，酌情扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036506107904', NULL, '2021-04-18 13:10:11.917000', 0, NULL, NULL, '1376062926678528001', '健康宣传栏维护达不到要求的，扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036518690816', NULL, '2021-04-18 13:10:11.920000', 0, NULL, NULL, '1376062959905804289', '未完成家庭医生签约任务的，未完成的，酌情扣0.5－1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036531273728', NULL, '2021-04-18 13:10:11.923000', 0, NULL, NULL, '1376062990947848193', '根据《长街镇农村环境卫生和垃圾分类工作考核办法》，经第三方考核年度汇总，结果为优秀的，加2分；结果为良好的，加1分；结果为不合格的，酌情扣1－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036539662336', NULL, '2021-04-18 13:10:11.925000', 0, NULL, NULL, '1376063027480236033', '各级体育项目建设、维护和管理工作达不到要求的，酌情扣0.5－1分；', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036548050944', NULL, '2021-04-18 13:10:11.928000', 0, NULL, NULL, '1376063072376066049', '不能按要求组队参加县、镇各级体育赛事活动的，酌情扣0.5－1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036560633856', NULL, '2021-04-18 13:10:11.930000', 0, NULL, NULL, '1376063114679816193', '学生防溺水工作达不到要求的，扣0.5分，发生有关事故的，酌情加扣0.5－1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036569022464', NULL, '2021-04-18 13:10:11.932000', 0, NULL, NULL, '1376063144828473345', '未按要求做好居家健康观察人员硬隔离工作的，每例扣0.5分，造成重大影响的，酌情加扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036577411072', NULL, '2021-04-18 13:10:11.935000', 0, NULL, NULL, '1376063177766342657', '防疫工作不到位，未按防疫要求做好乡村码登记工作的，酌情扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036589993984', NULL, '2021-04-18 13:10:11.938000', 0, NULL, NULL, '1376063221923975168', '未做好甬行码扫码工作的，按镇通报次数多少，酌情扣0.5－2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055873146851329', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036610965508', NULL, '2021-04-18 13:10:11.942000', 0, NULL, NULL, '1376063265385353217', '出现“两违”行为且处理未到位的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055927039463424', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036623548416', NULL, '2021-04-18 13:10:11.945000', 0, NULL, NULL, '1376063323451297793', '煽动群众阻扰镇政府及有关部门拆违行动的，每例扣2分；农村建房纠纷未在村内调处解决，上交至镇政府及有关部门的，镇政府及有关部门调处解决农村建房纠纷时，村方不予配合或进行阻扰的，每项每例扣1分；未按规定程序进行农村建房审批，出现未批先建行为的，农村建房选址未按村庄规划要求开展，出现擅自建设行为的，未根据土地利用总体规划擅自建设的，每项每例扣1分；公共资源交易出现“应招未招”情况的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055927039463424', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036631937024', NULL, '2021-04-18 13:10:11.947000', 0, NULL, NULL, '1376063363095859201', '分拆项目规避招标行为的，每例扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055927039463424', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036640325632', NULL, '2021-04-18 13:10:11.949000', 0, NULL, NULL, '1376063401612152833', '村级项目实施中出现安全事故，每例扣1分，引起较大社会影响的，每例加扣1分；村级项目实施未能按期开展，每例扣1分，工期滞后严重且造成重大影响的，每例加扣1分；在村级项目结算过程中出现农民工讨薪事件的，每例扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055927039463424', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036657102854', NULL, '2021-04-18 13:10:11.954000', 0, NULL, NULL, '1376063487859625985', '城乡居民基本养老保险参保率未达到97%的，酌情扣0.5－1分；城乡居民基本养老保险到龄人员未及时参保的，每例扣0.5分；失土保险对象未严格审核的，每例扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055986367893505', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036669685760', NULL, '2021-04-18 13:10:11.957000', 0, NULL, NULL, '1376063520763940865', '城乡居民基本医疗保险参保率未达99.5%的，扣0.5－1分，未按规定时间上报参保名单的，扣0.5分，未及时缴纳医保资金的，扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055986367893505', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036682268672', NULL, '2021-04-18 13:10:11.959000', 0, NULL, NULL, '1376063555199176704', '殡葬管理工作未按要求落实的，每例扣0.5分；低保对象未严格审核的，每例扣0.5分；在取消低保、低边、五保户过程中未积极配合的，每例扣0.5分；村级居家养老服务站未达AA级的，扣0.5分，创建达AAA级的，加0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055986367893505', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036694851584', NULL, '2021-04-18 13:10:11.962000', 0, NULL, NULL, '1376063592868220929', '配合残疾人动态调查不积极的，扣0.5分；配合开展残疾人“两项补贴”不积极的，扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055986367893505', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036703240192', NULL, '2021-04-18 13:10:11.964000', 0, NULL, NULL, '1376063631585841153', '未完成慈善募捐任务的，酌情扣0.5－1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055986367893505', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036711628800', NULL, '2021-04-18 13:10:11.966000', 0, NULL, NULL, '1376063666214014977', '未配合“两个满意度”调查的，扣0.5分；政务和“最多跑一次”涉及便民服务事项落实不到位的，扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376055986367893505', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036728406022', NULL, '2021-04-18 13:10:11.971000', 0, NULL, NULL, '1376063719389401089', '未严格落实镇三防指挥部指令的，每例扣1分；发生“三防”事故，每例扣2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056061106196480', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036740988928', NULL, '2021-04-18 13:10:11.973000', 0, NULL, NULL, '1376063785202225153', '未严格按照镇森林防火要求设卡、设点的，扣1分；发生火警，每例扣0.5分；发生森林火灾，每例扣1分，特别严重的，加扣1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056061106196480', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036749377536', NULL, '2021-04-18 13:10:11.975000', 0, NULL, NULL, '1376063818563719168', '开展村内防灾减灾应急演习的，加0.5-1分；开展避灾安置点规范化建设的，加0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056061106196480', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036757766144', NULL, '2021-04-18 13:10:11.978000', 0, NULL, NULL, '1376063867871956992', '未落实安全生产责任制的，扣0.5分；未落实安全生产网格员制度的，扣0.5分；非法售卖烟花爆竹的，每例扣0.5分；发生一般安全事故的，每例扣0.5分；发生村庄火灾的，每例扣0.5－1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056061106196480', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036770349056', NULL, '2021-04-18 13:10:11.980000', 0, NULL, NULL, '1376063912952336384', '发生较大事故以上扣10分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056061106196480', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036782931968', NULL, '2021-04-18 13:10:11.983000', 0, NULL, NULL, '1376063966589095937', '其他事项需要加扣分的内容。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056061106196480', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036799709184', NULL, '2021-04-18 13:10:11.987000', 0, NULL, NULL, '1376064014592905217', '重大决策落实和重点工作推进不力的，每例酌情扣1－10分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056353117835265', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036808097792', NULL, '2021-04-18 13:10:11.989000', 0, NULL, NULL, '1376064060583448576', '配合完成镇及以上重点工程、重大项目落地政策处理的，每例酌情加1-10分。配合推进不力的，每例酌情扣1－10分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056353117835265', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036824875008', NULL, '2021-04-18 13:10:11.993000', 0, NULL, NULL, '1376064138501033985', '协助引进规（限）上内资企业加1分；引进外资企业加2分；实到外资每增加100万美元加1分。村民引进隶属长街镇企业的参照执行。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056424781713409', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036837457922', NULL, '2021-04-18 13:10:11.996000', 0, NULL, NULL, '1376064179752013825', '协助申报甬江引才计划团队、人员，每个加1分，申报成功的，加2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056487633358848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036850040832', NULL, '2021-04-18 13:10:11.999000', 0, NULL, NULL, '1376064208122286080', '协助引进高层次人才团队，每个加1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056487633358848', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036875206656', NULL, '2021-04-18 13:10:12.007000', 0, NULL, NULL, '1376064259544453120', '新建省市旅游基地的，加0.5分；新建通过文旅部门评定的A级旅游厕所的，加0.5分，最高加1分；文化和旅游资源各项普查工作配合不积极的，扣0.5分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056537973395457', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036896178176', NULL, '2021-04-18 13:10:12.011000', 0, NULL, NULL, '1376064444416790529', '被评为省AAA级、AA级、A级景区村庄的，分别加2分、1分、0.5分，同一行政村不重复累计；年度通过验收认定新增民宿床位20张（含）以上的，加1分，超过50张（含）的，加2分，新增白金宿、金宿、银宿的，每家分别加3分、2分、1分，同一民宿不重复累计，最高加3分；新建成游客中心、停车场、游步道、标识系统等乡村旅游基础设施，每个加0.5分，最高加2分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056537973395457', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036912955392', NULL, '2021-04-18 13:10:12.015000', 0, NULL, NULL, '1376064475609829377', '积极参加上级文旅部门组织的旅游交易会及推介会的，加0.5分；有效配合做好“5·19”徐霞客开游节相关活动的，加0.5分；举办镇级节庆活动的，每例加1分，成效显著的，再加1分；举办的文旅节事活动获上级主管部门嘉奖的，加1分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056537973395457', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036925538304', NULL, '2021-04-18 13:10:12.018000', 0, NULL, NULL, '1376064501807452161', '在上级各项检查、暗访、复核、评定工作中被通报、摘牌或整改不到位的，酌情扣1－3分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056537973395457', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036946509825', NULL, '2021-04-18 13:10:12.023000', 0, NULL, NULL, '1376064634565562369', '实行信访“四无村”考核，无到县级及以上信访、无群体访、无信访滋事扰序事件、无信访舆论炒作事件；连续1－5年无到县级以上单位信访，且无到镇集体访，存在到镇信访但由村劝回的，分别奖励1、3、5、7、9万元。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056590121177088', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036967481347', NULL, '2021-04-18 13:10:12.027000', 0, NULL, NULL, '1376064684570054657', '有关工作获镇党委政府，县、市、省级部门通报表扬的，分别加2、4、6、10分；工作有创新，先进经验被镇、县、市、省推广的，分别加4、8、12、20分；同一项目，就高加分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056934603558912', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036980064256', NULL, '2021-04-18 13:10:12.030000', 0, NULL, NULL, '1376064716715200513', '凡行政村当年被评为镇、县、市、省、国家级综合先进的，分别加2、4、8、12、24分，同一项目就高加分。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056934603558912', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649036988452864', NULL, '2021-04-18 13:10:12.033000', 0, NULL, NULL, '1376064741449011201', '经镇党委会研究决定给予加分的情形。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376056934603558912', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037005230081', NULL, '2021-04-18 13:10:12.037000', 0, NULL, NULL, '1376064788546850817', '有关工作被镇通报的，每例扣1分，被县级部门通报的，每例扣2分，被县委县政府及办公室通报的，每例扣4分，市级以上通报的分类分级加倍扣分。（单线另行规定的除外）', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057004744904705', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037026201608', NULL, '2021-04-18 13:10:12.041000', 0, NULL, NULL, '1376064852547735553', '本人被司法机关处理的。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037034590208', NULL, '2021-04-18 13:10:12.043000', 0, NULL, NULL, '1376064881954000897', '连续3年未发展党员。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037047173120', NULL, '2021-04-18 13:10:12.046000', 0, NULL, NULL, '1376064906188689408', '县、镇党代表、人大代表、县政协委员选举不支持、不配合的。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037051367424', NULL, '2021-04-18 13:10:12.047000', 0, NULL, NULL, '1376064945497706497', '所在村本年度发生审计移送县级部门案件的。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037059756032', NULL, '2021-04-18 13:10:12.049000', 0, NULL, NULL, '1376064974128025601', '食品药品安全和环保网格监管发生重大事故以上实行“一票否决”（因不可抗力因素除外）。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037068144640', NULL, '2021-04-18 13:10:12.052000', 0, NULL, NULL, '1376065014322040833', '发生较大事故以上实行“一票否决”。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037080727552', NULL, '2021-04-18 13:10:12.055000', 0, NULL, NULL, '1376065052322435073', '民宗出现政治问题、安全问题和重大违建问题实行一票否决。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037093310464', NULL, '2021-04-18 13:10:12.057000', 0, NULL, NULL, '1376065086585704449', '防疫工作执行不到位被县级以上通报或导致重大事故的。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0),
	('1383649037101699072', NULL, '2021-04-18 13:10:12.059000', 0, NULL, NULL, '1376065120848973825', '县里有另行规定的其他情况。', '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', 0, 0, 0, 0, '无', '无', '无', '无', '1376057045131857920', 0, 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', '1376067966306750464', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0, '无', '无', '无', 0, 0, 0);
/*!40000 ALTER TABLE `t_two_windows` ENABLE KEYS */;

-- 导出  表 nhcj.t_update_record 结构
DROP TABLE IF EXISTS `t_update_record`;
CREATE TABLE IF NOT EXISTS `t_update_record` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `address_hu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `address_hu1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `address_zhu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `address_zhu1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `gu` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `gu1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `jia` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `jia1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `look_flag` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `look_people` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `old_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `owner_idcard` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `owner_idcard1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `pin_pai` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `pin_pai1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re11` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re2` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `re21` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sell_date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sell_date1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `type1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `xing_hao` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `xing_hao1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `seller_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `send_date` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `seller_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_update_record 的数据：~0 rows (大约)
DELETE FROM `t_update_record`;
/*!40000 ALTER TABLE `t_update_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_update_record` ENABLE KEYS */;

-- 导出  表 nhcj.t_user 结构
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE IF NOT EXISTS `t_user` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `pass_strength` varchar(2) DEFAULT NULL,
  `department_title` varchar(255) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_user 的数据：~4 rows (大约)
DELETE FROM `t_user`;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` (`id`, `create_by`, `create_time`, `update_by`, `update_time`, `address`, `avatar`, `description`, `email`, `mobile`, `nickname`, `password`, `sex`, `status`, `type`, `username`, `del_flag`, `department_id`, `street`, `pass_strength`, `department_title`, `birth`, `level`) VALUES
	(682265633886208, '', '2018-05-01 16:13:51', 'admin', '2021-04-17 10:49:46', '["330000","330200","330226"]', 'https://i.loli.net/2019/04/28/5cc5a71a6e3b6.png', '', 'zwz@qq.com', '17857054386', '管理员', '$2a$10$KMkizrdfZytxnx6sjs.nhe7yMhWNXiNPbVqAnajp5grvtsjLmKi4y', '男', 0, 1, 'admin', 0, 40322777781112832, 'XX街道', '中', '总部', '2020-04-15 00:00:00.000000', ''),
	(1383250471732514817, 'admin', '2021-04-17 10:46:27', 'admin', '2021-04-17 10:47:42', '', 'https://i.loli.net/2019/04/28/5cc5a71a6e3b6.png', '', '15888543307@qq.com', '15888543307', '零', '$2a$10$kxauAuMZkfN9WxRd/HzmUenyyK44LLshJx1H2cC3CeJnL2G/zCWSm', '男', 0, 1, '15888543307', 0, 40322777781112832, '', '弱', '总部', NULL, ''),
	(1383250752918654977, 'admin', '2021-04-17 10:47:34', 'admin', '2021-04-17 10:50:55', '', 'https://i.loli.net/2019/04/28/5cc5a71a6e3b6.png', '', '18268627373@qq.com', '18268627373', '周任斌', '$2a$10$OW.k5VzklJb1nTt.E/sWk.PvMFg9PskexFB2qljPYi3/pbtZQlBvO', '男', 0, 1, '18268627373', 0, 40322777781112832, '', '弱', '总部', NULL, ''),
	(1384476627358060545, 'admin', '2021-04-20 19:58:45', NULL, NULL, NULL, 'https://i.loli.net/2019/04/28/5cc5a71a6e3b6.png', NULL, '30a-6c8e1d4566ee@cj.com', '17857054385', '测试店铺', '$2a$10$5EGOKvpKTi2RZRQing3awujjMa2hXIj0pZC0y0wGAyHUSBpQnUFC6', NULL, 0, 0, '17857054385', 0, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;

-- 导出  表 nhcj.t_user_role 结构
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE IF NOT EXISTS `t_user_role` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  nhcj.t_user_role 的数据：~4 rows (大约)
DELETE FROM `t_user_role`;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
INSERT INTO `t_user_role` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `role_id`, `user_id`) VALUES
	(1374302645245841408, 'admin', '2021-03-23 18:10:59', 0, 'admin', '2021-03-23 18:10:59', 496138616573952, 682265633886208),
	(1383250787127398400, 'admin', '2021-04-17 10:47:42', 0, 'admin', '2021-04-17 10:47:42', 1383250191871774721, 1383250471732514817),
	(1383347412655017984, 'admin', '2021-04-17 17:11:39', 0, 'admin', '2021-04-17 17:11:39', 1383347239669338113, 1383250752918654977),
	(1384476627815239680, 'admin', '2021-04-20 19:58:45', 0, 'admin', '2021-04-20 19:58:45', 1384462977951993857, 1384476627358060545);
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;

-- 导出  表 nhcj.t_village 结构
DROP TABLE IF EXISTS `t_village`;
CREATE TABLE IF NOT EXISTS `t_village` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `village_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `grade` float NOT NULL,
  `field_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `field_grade` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_village 的数据：~45 rows (大约)
DELETE FROM `t_village`;
/*!40000 ALTER TABLE `t_village` DISABLE KEYS */;
INSERT INTO `t_village` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `remark`, `village_name`, `grade`, `field_name`, `field_grade`) VALUES
	('1372073268785319936', NULL, '2021-03-17 14:32:13.892000', 0, NULL, NULL, NULL, '长街村', 0, 'aa', 'bb'),
	('1372073325429395456', NULL, '2021-03-17 14:32:27.330000', 0, NULL, NULL, NULL, '九江村', 0, 'cc', 'dd'),
	('1372073365078151168', NULL, '2021-03-17 14:32:36.782000', 0, NULL, NULL, NULL, '洋湖村', 0, 'ee', 'ff'),
	('1372073505016909824', NULL, '2021-03-17 14:33:10.147000', 0, NULL, NULL, NULL, '车岙村', 0, 'gg', 'hh'),
	('1372073526336557056', NULL, '2021-03-17 14:33:15.229000', 0, NULL, NULL, NULL, '石桥头村', 0, 'ii', 'jj'),
	('1372073546884452352', NULL, '2021-03-17 14:33:20.129000', 0, NULL, NULL, NULL, '环河社区', 0, 'kk', 'll'),
	('1372073576223608832', NULL, '2021-03-17 14:33:27.123000', 0, NULL, NULL, NULL, '西岙村', 0, 'mm', 'nn'),
	('1372073599090954240', NULL, '2021-03-17 14:33:32.575000', 0, NULL, NULL, NULL, '城塘村', 0, 'oo', 'pp'),
	('1372073622629388288', NULL, '2021-03-17 14:33:38.188000', 0, NULL, NULL, NULL, '山前村', 0, 'qq', 'rr'),
	('1372073649737175040', NULL, '2021-03-17 14:33:44.650000', 0, NULL, NULL, NULL, '大祝村', 0, 'ss', 'tt'),
	('1372073664094277632', NULL, '2021-03-17 14:33:48.073000', 0, NULL, NULL, NULL, '大湖村', 0, 'uu', 'vv'),
	('1372073686240202752', NULL, '2021-03-17 14:33:53.353000', 0, NULL, NULL, NULL, '南塘村', 0, 'ww', 'xx'),
	('1372073707589210112', NULL, '2021-03-17 14:33:58.443000', 0, NULL, NULL, NULL, '塘里村', 0, 'yy', 'zz'),
	('1372073734160125953', NULL, '2021-03-17 14:34:04.779000', 0, NULL, NULL, NULL, '浦东村', 0, 'aaa', 'bbb'),
	('1372073759992844288', NULL, '2021-03-17 14:34:10.937000', 0, NULL, NULL, NULL, '新塘村', 0, 'ccc', 'ddd'),
	('1372073781547372544', NULL, '2021-03-17 14:34:16.077000', 0, NULL, NULL, NULL, '隔洋塘村', 0, 'eee', 'fff'),
	('1372073801264795648', NULL, '2021-03-17 14:34:20.777000', 0, NULL, NULL, NULL, '李家庄村', 0, 'ggg', 'hhh'),
	('1372073822274064384', NULL, '2021-03-17 14:34:25.786000', 0, NULL, NULL, NULL, '岳井村', 0, 'iii', 'jjj'),
	('1372073841072934912', NULL, '2021-03-17 14:34:30.268000', 0, NULL, NULL, NULL, '岳墩村', 0, 'kkk', 'lll'),
	('1372073870063964160', NULL, '2021-03-17 14:34:37.180000', 0, NULL, NULL, NULL, '对岙洞村', 0, 'mmm', 'nnn'),
	('1372073898522316800', NULL, '2021-03-17 14:34:43.966000', 0, NULL, NULL, NULL, '上塘村', 0, 'ooo', 'ppp'),
	('1372073916973060096', NULL, '2021-03-17 14:34:48.364000', 0, NULL, NULL, NULL, '伍山村', 0, 'qqq', 'rrr'),
	('1372073932806557697', NULL, '2021-03-17 14:34:52.140000', 0, NULL, NULL, NULL, '下湾塘村', 0, 'sss', 'ttt'),
	('1372073949915123712', NULL, '2021-03-17 14:34:56.218000', 0, NULL, NULL, NULL, '月兰村', 0, 'uuu', 'vvv'),
	('1372073970182000640', NULL, '2021-03-17 14:35:01.050000', 0, NULL, NULL, NULL, '向阳村', 0, 'www', 'xxx'),
	('1372073988502720512', NULL, '2021-03-17 14:35:05.418000', 0, NULL, NULL, NULL, '长胜村', 0, 'yyy', 'zzz'),
	('1372074004608847872', NULL, '2021-03-17 14:35:09.258000', 0, NULL, NULL, NULL, '下塘村', 0, 'aaaa', 'bbbb'),
	('1372074027832709120', NULL, '2021-03-17 14:35:14.795000', 0, NULL, NULL, NULL, '总浦塘村', 0, 'cccc', 'dddd'),
	('1372074046283452417', NULL, '2021-03-17 14:35:19.195000', 0, NULL, NULL, NULL, '宁东村', 0, 'eeee', 'ffff'),
	('1372074068571983872', NULL, '2021-03-17 14:35:24.508000', 0, NULL, NULL, NULL, '新城村', 0, 'gggg', 'hhhh'),
	('1372074085693132800', NULL, '2021-03-17 14:35:28.590000', 0, NULL, NULL, NULL, '龙山村', 0, 'iiii', 'jjjj'),
	('1372074108891828225', NULL, '2021-03-17 14:35:34.122000', 0, NULL, NULL, NULL, '连浦村', 0, 'kkkk', 'llll'),
	('1372074123244736512', NULL, '2021-03-17 14:35:37.543000', 0, NULL, NULL, NULL, '湘田山村', 0, 'mmmm', 'nnnn'),
	('1372074141104082944', NULL, '2021-03-17 14:35:41.801000', 0, NULL, NULL, NULL, '五福村', 0, 'oooo', 'pppp'),
	('1372074162457284608', NULL, '2021-03-17 14:35:46.892000', 0, NULL, NULL, NULL, '山头村', 0, 'qqqq', 'rrrr'),
	('1372074178613743617', NULL, '2021-03-17 14:35:50.745000', 0, NULL, NULL, NULL, '港中村', 0, 'ssss', 'tttt'),
	('1372074194992500736', NULL, '2021-03-17 14:35:54.649000', 0, NULL, NULL, NULL, '平原村', 0, 'uuuu', 'vvvv'),
	('1372074211773911040', NULL, '2021-03-17 14:35:58.650000', 0, NULL, NULL, NULL, '大青村', 0, 'wwww', 'xxxx'),
	('1372074229427736576', NULL, '2021-03-17 14:36:02.860000', 0, NULL, NULL, NULL, '东港村', 0, 'yyyy', 'zzzz'),
	('1372074245940711424', NULL, '2021-03-17 14:36:06.796000', 0, NULL, NULL, NULL, '双家村', 0, 'aaaaa', 'bbbbb'),
	('1372074264185933824', NULL, '2021-03-17 14:36:11.146000', 0, NULL, NULL, NULL, '青珠村', 0, 'ccccc', 'ddddd'),
	('1372074281248362497', NULL, '2021-03-17 14:36:15.215000', 0, NULL, NULL, NULL, '新南村', 0, 'eeeee', 'fffff'),
	('1372074295454470144', NULL, '2021-03-17 14:36:18.601000', 0, NULL, NULL, NULL, '新五星村', 0, 'ggggg', 'hhhhh'),
	('1372074315998171136', NULL, '2021-03-17 14:36:23.499000', 0, NULL, NULL, NULL, '文围村', 0, 'iiiii', 'jjjjj'),
	('1372074335455547392', NULL, '2021-03-17 14:36:28.138000', 0, NULL, NULL, NULL, '青农社区', 0, 'kkkkk', 'lllll');
/*!40000 ALTER TABLE `t_village` ENABLE KEYS */;

-- 导出  表 nhcj.t_village_many 结构
DROP TABLE IF EXISTS `t_village_many`;
CREATE TABLE IF NOT EXISTS `t_village_many` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `village_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_village_many 的数据：~7 rows (大约)
DELETE FROM `t_village_many`;
/*!40000 ALTER TABLE `t_village_many` DISABLE KEYS */;
INSERT INTO `t_village_many` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `remark`, `village_name`) VALUES
	('1375272920506568705', 'admin', '2021-03-26 10:26:30.253000', 0, NULL, NULL, '', '长街'),
	('1375272947119427584', 'admin', '2021-03-26 10:26:36.589000', 0, NULL, NULL, '', '大湖'),
	('1375272975347093504', 'admin', '2021-03-26 10:26:43.318000', 0, NULL, NULL, '', '岳井'),
	('1375272995823685632', 'admin', '2021-03-26 10:26:48.200000', 0, NULL, NULL, '', '伍山'),
	('1375273020377141248', 'admin', '2021-03-26 10:26:54.054000', 0, NULL, NULL, '', '龙浦'),
	('1375273041529016320', 'admin', '2021-03-26 10:26:59.097000', 0, NULL, NULL, '', '山头'),
	('1375273062500536320', 'admin', '2021-03-26 10:27:04.098000', 0, NULL, NULL, '', '青珠');
/*!40000 ALTER TABLE `t_village_many` ENABLE KEYS */;

-- 导出  表 nhcj.t_village_many_vo 结构
DROP TABLE IF EXISTS `t_village_many_vo`;
CREATE TABLE IF NOT EXISTS `t_village_many_vo` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `many_id` varchar(50) COLLATE utf8_croatian_ci NOT NULL DEFAULT '',
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `village_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_village_many_vo 的数据：~4 rows (大约)
DELETE FROM `t_village_many_vo`;
/*!40000 ALTER TABLE `t_village_many_vo` DISABLE KEYS */;
INSERT INTO `t_village_many_vo` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `many_id`, `remark`, `village_id`) VALUES
	('1375283810823966720', 'admin', '2021-03-26 11:09:46.701000', 0, NULL, NULL, '1375272920506568705', NULL, '1372073268785319936'),
	('1375283810886881280', 'admin', '2021-03-26 11:09:46.712000', 0, NULL, NULL, '1375272920506568705', NULL, '1372073325429395456'),
	('1375285891802730496', 'admin', '2021-03-26 11:18:02.845000', 0, NULL, NULL, '1375272995823685632', NULL, '1372073526336557056'),
	('1375285891861450752', 'admin', '2021-03-26 11:18:02.855000', 0, NULL, NULL, '1375272995823685632', NULL, '1372073546884452352');
/*!40000 ALTER TABLE `t_village_many_vo` ENABLE KEYS */;

-- 导出  表 nhcj.t_village_require_vo 结构
DROP TABLE IF EXISTS `t_village_require_vo`;
CREATE TABLE IF NOT EXISTS `t_village_require_vo` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `grade` float NOT NULL,
  `require_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `village_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `village_name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `grade1` float NOT NULL,
  `require_title` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `require_type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `reason1` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mouth` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  nhcj.t_village_require_vo 的数据：~360 rows (大约)
DELETE FROM `t_village_require_vo`;
/*!40000 ALTER TABLE `t_village_require_vo` DISABLE KEYS */;
INSERT INTO `t_village_require_vo` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `grade`, `require_id`, `village_id`, `village_name`, `grade1`, `require_title`, `require_type`, `reason`, `reason1`, `mouth`, `year`) VALUES
	('1372515265467781120', NULL, '2021-03-18 19:48:34.045000', 0, NULL, NULL, 0, '10001', '1372073268785319936', '长街村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265476169728', NULL, '2021-03-18 19:48:34.047000', 0, NULL, NULL, 0, '10002', '1372073268785319936', '长街村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265480364032', NULL, '2021-03-18 19:48:34.048000', 0, NULL, NULL, 0, '10003', '1372073268785319936', '长街村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265484558336', NULL, '2021-03-18 19:48:34.049000', 0, NULL, NULL, 0, '10004', '1372073268785319936', '长街村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265488752640', NULL, '2021-03-18 19:48:34.050000', 0, NULL, NULL, 0, '10005', '1372073268785319936', '长街村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265492946944', NULL, '2021-03-18 19:48:34.051000', 0, NULL, NULL, 0, '10006', '1372073268785319936', '长街村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265497141248', NULL, '2021-03-18 19:48:34.052000', 0, NULL, NULL, 0, '10007', '1372073268785319936', '长街村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265501335552', NULL, '2021-03-18 19:48:34.053000', 0, NULL, NULL, 0, '10008', '1372073268785319936', '长街村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265505529856', NULL, '2021-03-18 19:48:34.054000', 0, NULL, NULL, 0, '10001', '1372073325429395456', '九江村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265509724160', NULL, '2021-03-18 19:48:34.055000', 0, NULL, NULL, 0, '10002', '1372073325429395456', '九江村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265509724161', NULL, '2021-03-18 19:48:34.055000', 0, NULL, NULL, 0, '10003', '1372073325429395456', '九江村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265513918464', NULL, '2021-03-18 19:48:34.056000', 0, NULL, NULL, 0, '10004', '1372073325429395456', '九江村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265518112768', NULL, '2021-03-18 19:48:34.057000', 0, NULL, NULL, 0, '10005', '1372073325429395456', '九江村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265522307072', NULL, '2021-03-18 19:48:34.058000', 0, NULL, NULL, 0, '10006', '1372073325429395456', '九江村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265530695680', NULL, '2021-03-18 19:48:34.060000', 0, NULL, NULL, 0, '10007', '1372073325429395456', '九江村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265534889984', NULL, '2021-03-18 19:48:34.061000', 0, NULL, NULL, 0, '10008', '1372073325429395456', '九江村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265539084288', NULL, '2021-03-18 19:48:34.062000', 0, NULL, NULL, 0, '10001', '1372073365078151168', '洋湖村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265543278592', NULL, '2021-03-18 19:48:34.063000', 0, NULL, NULL, 0, '10002', '1372073365078151168', '洋湖村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265543278593', NULL, '2021-03-18 19:48:34.064000', 0, NULL, NULL, 0, '10003', '1372073365078151168', '洋湖村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265547472896', NULL, '2021-03-18 19:48:34.065000', 0, NULL, NULL, 0, '10004', '1372073365078151168', '洋湖村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265551667200', NULL, '2021-03-18 19:48:34.066000', 0, NULL, NULL, 0, '10005', '1372073365078151168', '洋湖村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265555861504', NULL, '2021-03-18 19:48:34.067000', 0, NULL, NULL, 0, '10006', '1372073365078151168', '洋湖村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265560055808', NULL, '2021-03-18 19:48:34.068000', 0, NULL, NULL, 0, '10007', '1372073365078151168', '洋湖村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265564250112', NULL, '2021-03-18 19:48:34.069000', 0, NULL, NULL, 0, '10008', '1372073365078151168', '洋湖村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265572638720', NULL, '2021-03-18 19:48:34.070000', 0, NULL, NULL, 0, '10001', '1372073505016909824', '车岙村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265576833024', NULL, '2021-03-18 19:48:34.071000', 0, NULL, NULL, 0, '10002', '1372073505016909824', '车岙村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265581027328', NULL, '2021-03-18 19:48:34.072000', 0, NULL, NULL, 0, '10003', '1372073505016909824', '车岙村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265585221632', NULL, '2021-03-18 19:48:34.073000', 0, NULL, NULL, 0, '10004', '1372073505016909824', '车岙村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265589415936', NULL, '2021-03-18 19:48:34.074000', 0, NULL, NULL, 0, '10005', '1372073505016909824', '车岙村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265593610240', NULL, '2021-03-18 19:48:34.075000', 0, NULL, NULL, 0, '10006', '1372073505016909824', '车岙村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265597804544', NULL, '2021-03-18 19:48:34.076000', 0, NULL, NULL, 0, '10007', '1372073505016909824', '车岙村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265601998848', NULL, '2021-03-18 19:48:34.077000', 0, NULL, NULL, 0, '10008', '1372073505016909824', '车岙村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265606193152', NULL, '2021-03-18 19:48:34.078000', 0, NULL, NULL, 0, '10001', '1372073526336557056', '石桥头村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265610387456', NULL, '2021-03-18 19:48:34.079000', 0, NULL, NULL, 0, '10002', '1372073526336557056', '石桥头村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265614581760', NULL, '2021-03-18 19:48:34.080000', 0, NULL, NULL, 0, '10003', '1372073526336557056', '石桥头村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265618776064', NULL, '2021-03-18 19:48:34.081000', 0, NULL, NULL, 0, '10004', '1372073526336557056', '石桥头村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265622970368', NULL, '2021-03-18 19:48:34.082000', 0, NULL, NULL, 0, '10005', '1372073526336557056', '石桥头村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265627164672', NULL, '2021-03-18 19:48:34.083000', 0, NULL, NULL, 0, '10006', '1372073526336557056', '石桥头村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265631358976', NULL, '2021-03-18 19:48:34.084000', 0, NULL, NULL, 0, '10007', '1372073526336557056', '石桥头村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265635553280', NULL, '2021-03-18 19:48:34.085000', 0, NULL, NULL, 0, '10008', '1372073526336557056', '石桥头村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265639747584', NULL, '2021-03-18 19:48:34.086000', 0, NULL, NULL, 0, '10001', '1372073546884452352', '环河社区', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265643941888', NULL, '2021-03-18 19:48:34.087000', 0, NULL, NULL, 0, '10002', '1372073546884452352', '环河社区', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265648136192', NULL, '2021-03-18 19:48:34.088000', 0, NULL, NULL, 0, '10003', '1372073546884452352', '环河社区', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265652330496', NULL, '2021-03-18 19:48:34.090000', 0, NULL, NULL, 0, '10004', '1372073546884452352', '环河社区', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265656524800', NULL, '2021-03-18 19:48:34.091000', 0, NULL, NULL, 0, '10005', '1372073546884452352', '环河社区', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265660719104', NULL, '2021-03-18 19:48:34.092000', 0, NULL, NULL, 0, '10006', '1372073546884452352', '环河社区', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265664913408', NULL, '2021-03-18 19:48:34.092000', 0, NULL, NULL, 0, '10007', '1372073546884452352', '环河社区', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265669107712', NULL, '2021-03-18 19:48:34.093000', 0, NULL, NULL, 0, '10008', '1372073546884452352', '环河社区', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265673302016', NULL, '2021-03-18 19:48:34.094000', 0, NULL, NULL, 0, '10001', '1372073576223608832', '西岙村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265677496320', NULL, '2021-03-18 19:48:34.095000', 0, NULL, NULL, 0, '10002', '1372073576223608832', '西岙村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265681690624', NULL, '2021-03-18 19:48:34.096000', 0, NULL, NULL, 0, '10003', '1372073576223608832', '西岙村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265685884928', NULL, '2021-03-18 19:48:34.097000', 0, NULL, NULL, 0, '10004', '1372073576223608832', '西岙村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265685884929', NULL, '2021-03-18 19:48:34.097000', 0, NULL, NULL, 0, '10005', '1372073576223608832', '西岙村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265690079232', NULL, '2021-03-18 19:48:34.098000', 0, NULL, NULL, 0, '10006', '1372073576223608832', '西岙村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265694273536', NULL, '2021-03-18 19:48:34.099000', 0, NULL, NULL, 0, '10007', '1372073576223608832', '西岙村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265698467840', NULL, '2021-03-18 19:48:34.100000', 0, NULL, NULL, 0, '10008', '1372073576223608832', '西岙村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265702662144', NULL, '2021-03-18 19:48:34.101000', 0, NULL, NULL, 0, '10001', '1372073599090954240', '城塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265706856448', NULL, '2021-03-18 19:48:34.102000', 0, NULL, NULL, 0, '10002', '1372073599090954240', '城塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265711050752', NULL, '2021-03-18 19:48:34.103000', 0, NULL, NULL, 0, '10003', '1372073599090954240', '城塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265715245056', NULL, '2021-03-18 19:48:34.104000', 0, NULL, NULL, 0, '10004', '1372073599090954240', '城塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265719439360', NULL, '2021-03-18 19:48:34.105000', 0, NULL, NULL, 0, '10005', '1372073599090954240', '城塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265723633664', NULL, '2021-03-18 19:48:34.107000', 0, NULL, NULL, 0, '10006', '1372073599090954240', '城塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265727827968', NULL, '2021-03-18 19:48:34.108000', 0, NULL, NULL, 0, '10007', '1372073599090954240', '城塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265732022272', NULL, '2021-03-18 19:48:34.109000', 0, NULL, NULL, 0, '10008', '1372073599090954240', '城塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265736216576', NULL, '2021-03-18 19:48:34.110000', 0, NULL, NULL, 0, '10001', '1372073622629388288', '山前村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265740410880', NULL, '2021-03-18 19:48:34.110000', 0, NULL, NULL, 0, '10002', '1372073622629388288', '山前村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265744605184', NULL, '2021-03-18 19:48:34.111000', 0, NULL, NULL, 0, '10003', '1372073622629388288', '山前村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265748799488', NULL, '2021-03-18 19:48:34.112000', 0, NULL, NULL, 0, '10004', '1372073622629388288', '山前村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265752993792', NULL, '2021-03-18 19:48:34.113000', 0, NULL, NULL, 0, '10005', '1372073622629388288', '山前村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265757188096', NULL, '2021-03-18 19:48:34.114000', 0, NULL, NULL, 0, '10006', '1372073622629388288', '山前村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265761382400', NULL, '2021-03-18 19:48:34.115000', 0, NULL, NULL, 0, '10007', '1372073622629388288', '山前村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265765576704', NULL, '2021-03-18 19:48:34.116000', 0, NULL, NULL, 0, '10008', '1372073622629388288', '山前村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265769771008', NULL, '2021-03-18 19:48:34.117000', 0, NULL, NULL, 0, '10001', '1372073649737175040', '大祝村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265773965312', NULL, '2021-03-18 19:48:34.118000', 0, NULL, NULL, 0, '10002', '1372073649737175040', '大祝村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265778159616', NULL, '2021-03-18 19:48:34.119000', 0, NULL, NULL, 0, '10003', '1372073649737175040', '大祝村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265782353920', NULL, '2021-03-18 19:48:34.120000', 0, NULL, NULL, 0, '10004', '1372073649737175040', '大祝村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265786548224', NULL, '2021-03-18 19:48:34.121000', 0, NULL, NULL, 0, '10005', '1372073649737175040', '大祝村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265790742528', NULL, '2021-03-18 19:48:34.122000', 0, NULL, NULL, 0, '10006', '1372073649737175040', '大祝村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265794936832', NULL, '2021-03-18 19:48:34.124000', 0, NULL, NULL, 0, '10007', '1372073649737175040', '大祝村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265799131136', NULL, '2021-03-18 19:48:34.125000', 0, NULL, NULL, 0, '10008', '1372073649737175040', '大祝村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265803325440', NULL, '2021-03-18 19:48:34.126000', 0, NULL, NULL, 0, '10001', '1372073664094277632', '大湖村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265807519744', NULL, '2021-03-18 19:48:34.127000', 0, NULL, NULL, 0, '10002', '1372073664094277632', '大湖村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265811714048', NULL, '2021-03-18 19:48:34.128000', 0, NULL, NULL, 0, '10003', '1372073664094277632', '大湖村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265815908352', NULL, '2021-03-18 19:48:34.128000', 0, NULL, NULL, 0, '10004', '1372073664094277632', '大湖村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265820102656', NULL, '2021-03-18 19:48:34.129000', 0, NULL, NULL, 0, '10005', '1372073664094277632', '大湖村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265824296960', NULL, '2021-03-18 19:48:34.130000', 0, NULL, NULL, 0, '10006', '1372073664094277632', '大湖村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265828491264', NULL, '2021-03-18 19:48:34.131000', 0, NULL, NULL, 0, '10007', '1372073664094277632', '大湖村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265832685568', NULL, '2021-03-18 19:48:34.132000', 0, NULL, NULL, 0, '10008', '1372073664094277632', '大湖村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265836879872', NULL, '2021-03-18 19:48:34.133000', 0, NULL, NULL, 0, '10001', '1372073686240202752', '南塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265841074176', NULL, '2021-03-18 19:48:34.134000', 0, NULL, NULL, 0, '10002', '1372073686240202752', '南塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265845268480', NULL, '2021-03-18 19:48:34.135000', 0, NULL, NULL, 0, '10003', '1372073686240202752', '南塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265849462784', NULL, '2021-03-18 19:48:34.136000', 0, NULL, NULL, 0, '10004', '1372073686240202752', '南塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265853657088', NULL, '2021-03-18 19:48:34.137000', 0, NULL, NULL, 0, '10005', '1372073686240202752', '南塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265857851392', NULL, '2021-03-18 19:48:34.138000', 0, NULL, NULL, 0, '10006', '1372073686240202752', '南塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265857851393', NULL, '2021-03-18 19:48:34.138000', 0, NULL, NULL, 0, '10007', '1372073686240202752', '南塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265862045696', NULL, '2021-03-18 19:48:34.139000', 0, NULL, NULL, 0, '10008', '1372073686240202752', '南塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265866240000', NULL, '2021-03-18 19:48:34.140000', 0, NULL, NULL, 0, '10001', '1372073707589210112', '塘里村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265870434304', NULL, '2021-03-18 19:48:34.141000', 0, NULL, NULL, 0, '10002', '1372073707589210112', '塘里村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265874628608', NULL, '2021-03-18 19:48:34.142000', 0, NULL, NULL, 0, '10003', '1372073707589210112', '塘里村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265878822912', NULL, '2021-03-18 19:48:34.143000', 0, NULL, NULL, 0, '10004', '1372073707589210112', '塘里村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265883017216', NULL, '2021-03-18 19:48:34.144000', 0, NULL, NULL, 0, '10005', '1372073707589210112', '塘里村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265887211520', NULL, '2021-03-18 19:48:34.145000', 0, NULL, NULL, 0, '10006', '1372073707589210112', '塘里村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265891405824', NULL, '2021-03-18 19:48:34.146000', 0, NULL, NULL, 0, '10007', '1372073707589210112', '塘里村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265895600128', NULL, '2021-03-18 19:48:34.147000', 0, NULL, NULL, 0, '10008', '1372073707589210112', '塘里村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265899794432', NULL, '2021-03-18 19:48:34.148000', 0, NULL, NULL, 0, '10001', '1372073734160125953', '浦东村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265903988736', NULL, '2021-03-18 19:48:34.149000', 0, NULL, NULL, 0, '10002', '1372073734160125953', '浦东村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265908183040', NULL, '2021-03-18 19:48:34.150000', 0, NULL, NULL, 0, '10003', '1372073734160125953', '浦东村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265912377344', NULL, '2021-03-18 19:48:34.151000', 0, NULL, NULL, 0, '10004', '1372073734160125953', '浦东村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265916571648', NULL, '2021-03-18 19:48:34.152000', 0, NULL, NULL, 0, '10005', '1372073734160125953', '浦东村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265920765952', NULL, '2021-03-18 19:48:34.153000', 0, NULL, NULL, 0, '10006', '1372073734160125953', '浦东村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265924960256', NULL, '2021-03-18 19:48:34.154000', 0, NULL, NULL, 0, '10007', '1372073734160125953', '浦东村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265929154560', NULL, '2021-03-18 19:48:34.155000', 0, NULL, NULL, 0, '10008', '1372073734160125953', '浦东村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265933348864', NULL, '2021-03-18 19:48:34.156000', 0, NULL, NULL, 0, '10001', '1372073759992844288', '新塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265937543168', NULL, '2021-03-18 19:48:34.157000', 0, NULL, NULL, 0, '10002', '1372073759992844288', '新塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265941737472', NULL, '2021-03-18 19:48:34.158000', 0, NULL, NULL, 0, '10003', '1372073759992844288', '新塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265945931776', NULL, '2021-03-18 19:48:34.159000', 0, NULL, NULL, 0, '10004', '1372073759992844288', '新塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265950126080', NULL, '2021-03-18 19:48:34.160000', 0, NULL, NULL, 0, '10005', '1372073759992844288', '新塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265954320384', NULL, '2021-03-18 19:48:34.161000', 0, NULL, NULL, 0, '10006', '1372073759992844288', '新塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265958514688', NULL, '2021-03-18 19:48:34.162000', 0, NULL, NULL, 0, '10007', '1372073759992844288', '新塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265962708992', NULL, '2021-03-18 19:48:34.163000', 0, NULL, NULL, 0, '10008', '1372073759992844288', '新塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265966903296', NULL, '2021-03-18 19:48:34.164000', 0, NULL, NULL, 0, '10001', '1372073781547372544', '隔洋塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265971097600', NULL, '2021-03-18 19:48:34.165000', 0, NULL, NULL, 0, '10002', '1372073781547372544', '隔洋塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265975291904', NULL, '2021-03-18 19:48:34.166000', 0, NULL, NULL, 0, '10003', '1372073781547372544', '隔洋塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265979486208', NULL, '2021-03-18 19:48:34.167000', 0, NULL, NULL, 0, '10004', '1372073781547372544', '隔洋塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515265983680512', NULL, '2021-03-18 19:48:34.168000', 0, NULL, NULL, 0, '10005', '1372073781547372544', '隔洋塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515265987874816', NULL, '2021-03-18 19:48:34.169000', 0, NULL, NULL, 0, '10006', '1372073781547372544', '隔洋塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515265992069120', NULL, '2021-03-18 19:48:34.170000', 0, NULL, NULL, 0, '10007', '1372073781547372544', '隔洋塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515265996263424', NULL, '2021-03-18 19:48:34.171000', 0, NULL, NULL, 0, '10008', '1372073781547372544', '隔洋塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266000457728', NULL, '2021-03-18 19:48:34.172000', 0, NULL, NULL, 0, '10001', '1372073801264795648', '李家庄村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266004652032', NULL, '2021-03-18 19:48:34.173000', 0, NULL, NULL, 0, '10002', '1372073801264795648', '李家庄村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266008846336', NULL, '2021-03-18 19:48:34.174000', 0, NULL, NULL, 0, '10003', '1372073801264795648', '李家庄村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266013040640', NULL, '2021-03-18 19:48:34.175000', 0, NULL, NULL, 0, '10004', '1372073801264795648', '李家庄村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266017234944', NULL, '2021-03-18 19:48:34.176000', 0, NULL, NULL, 0, '10005', '1372073801264795648', '李家庄村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266021429248', NULL, '2021-03-18 19:48:34.177000', 0, NULL, NULL, 0, '10006', '1372073801264795648', '李家庄村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266025623552', NULL, '2021-03-18 19:48:34.178000', 0, NULL, NULL, 0, '10007', '1372073801264795648', '李家庄村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266029817856', NULL, '2021-03-18 19:48:34.179000', 0, NULL, NULL, 0, '10008', '1372073801264795648', '李家庄村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266034012160', NULL, '2021-03-18 19:48:34.180000', 0, NULL, NULL, 0, '10001', '1372073822274064384', '岳井村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266034012161', NULL, '2021-03-18 19:48:34.180000', 0, NULL, NULL, 0, '10002', '1372073822274064384', '岳井村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266038206464', NULL, '2021-03-18 19:48:34.181000', 0, NULL, NULL, 0, '10003', '1372073822274064384', '岳井村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266042400768', NULL, '2021-03-18 19:48:34.182000', 0, NULL, NULL, 0, '10004', '1372073822274064384', '岳井村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266050789376', NULL, '2021-03-18 19:48:34.184000', 0, NULL, NULL, 0, '10005', '1372073822274064384', '岳井村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266050789377', NULL, '2021-03-18 19:48:34.185000', 0, NULL, NULL, 0, '10006', '1372073822274064384', '岳井村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266054983680', NULL, '2021-03-18 19:48:34.186000', 0, NULL, NULL, 0, '10007', '1372073822274064384', '岳井村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266059177984', NULL, '2021-03-18 19:48:34.187000', 0, NULL, NULL, 0, '10008', '1372073822274064384', '岳井村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266063372288', NULL, '2021-03-18 19:48:34.188000', 0, NULL, NULL, 0, '10001', '1372073841072934912', '岳墩村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266067566592', NULL, '2021-03-18 19:48:34.189000', 0, NULL, NULL, 0, '10002', '1372073841072934912', '岳墩村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266075955200', NULL, '2021-03-18 19:48:34.190000', 0, NULL, NULL, 0, '10003', '1372073841072934912', '岳墩村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266080149504', NULL, '2021-03-18 19:48:34.191000', 0, NULL, NULL, 0, '10004', '1372073841072934912', '岳墩村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266084343808', NULL, '2021-03-18 19:48:34.192000', 0, NULL, NULL, 0, '10005', '1372073841072934912', '岳墩村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266088538112', NULL, '2021-03-18 19:48:34.193000', 0, NULL, NULL, 0, '10006', '1372073841072934912', '岳墩村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266092732416', NULL, '2021-03-18 19:48:34.194000', 0, NULL, NULL, 0, '10007', '1372073841072934912', '岳墩村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266096926720', NULL, '2021-03-18 19:48:34.195000', 0, NULL, NULL, 0, '10008', '1372073841072934912', '岳墩村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266101121024', NULL, '2021-03-18 19:48:34.196000', 0, NULL, NULL, 0, '10001', '1372073870063964160', '对岙洞村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266109509632', NULL, '2021-03-18 19:48:34.198000', 0, NULL, NULL, 0, '10002', '1372073870063964160', '对岙洞村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266113703936', NULL, '2021-03-18 19:48:34.199000', 0, NULL, NULL, 0, '10003', '1372073870063964160', '对岙洞村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266117898240', NULL, '2021-03-18 19:48:34.201000', 0, NULL, NULL, 0, '10004', '1372073870063964160', '对岙洞村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266126286848', NULL, '2021-03-18 19:48:34.202000', 0, NULL, NULL, 0, '10005', '1372073870063964160', '对岙洞村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266130481152', NULL, '2021-03-18 19:48:34.203000', 0, NULL, NULL, 0, '10006', '1372073870063964160', '对岙洞村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266134675456', NULL, '2021-03-18 19:48:34.204000', 0, NULL, NULL, 0, '10007', '1372073870063964160', '对岙洞村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266138869760', NULL, '2021-03-18 19:48:34.205000', 0, NULL, NULL, 0, '10008', '1372073870063964160', '对岙洞村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266143064064', NULL, '2021-03-18 19:48:34.206000', 0, NULL, NULL, 0, '10001', '1372073898522316800', '上塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266147258368', NULL, '2021-03-18 19:48:34.207000', 0, NULL, NULL, 0, '10002', '1372073898522316800', '上塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266151452672', NULL, '2021-03-18 19:48:34.208000', 0, NULL, NULL, 0, '10003', '1372073898522316800', '上塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266155646976', NULL, '2021-03-18 19:48:34.209000', 0, NULL, NULL, 0, '10004', '1372073898522316800', '上塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266159841280', NULL, '2021-03-18 19:48:34.210000', 0, NULL, NULL, 0, '10005', '1372073898522316800', '上塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266164035584', NULL, '2021-03-18 19:48:34.211000', 0, NULL, NULL, 0, '10006', '1372073898522316800', '上塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266168229888', NULL, '2021-03-18 19:48:34.212000', 0, NULL, NULL, 0, '10007', '1372073898522316800', '上塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266172424192', NULL, '2021-03-18 19:48:34.213000', 0, NULL, NULL, 0, '10008', '1372073898522316800', '上塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266176618496', NULL, '2021-03-18 19:48:34.214000', 0, NULL, NULL, 0, '10001', '1372073916973060096', '伍山村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266180812800', NULL, '2021-03-18 19:48:34.215000', 0, NULL, NULL, 0, '10002', '1372073916973060096', '伍山村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266185007104', NULL, '2021-03-18 19:48:34.216000', 0, NULL, NULL, 0, '10003', '1372073916973060096', '伍山村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266189201408', NULL, '2021-03-18 19:48:34.217000', 0, NULL, NULL, 0, '10004', '1372073916973060096', '伍山村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266193395712', NULL, '2021-03-18 19:48:34.218000', 0, NULL, NULL, 0, '10005', '1372073916973060096', '伍山村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266197590016', NULL, '2021-03-18 19:48:34.219000', 0, NULL, NULL, 0, '10006', '1372073916973060096', '伍山村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266201784320', NULL, '2021-03-18 19:48:34.220000', 0, NULL, NULL, 0, '10007', '1372073916973060096', '伍山村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266205978624', NULL, '2021-03-18 19:48:34.221000', 0, NULL, NULL, 0, '10008', '1372073916973060096', '伍山村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266210172928', NULL, '2021-03-18 19:48:34.222000', 0, NULL, NULL, 0, '10001', '1372073932806557697', '下湾塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266210172929', NULL, '2021-03-18 19:48:34.222000', 0, NULL, NULL, 0, '10002', '1372073932806557697', '下湾塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266214367232', NULL, '2021-03-18 19:48:34.223000', 0, NULL, NULL, 0, '10003', '1372073932806557697', '下湾塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266218561536', NULL, '2021-03-18 19:48:34.224000', 0, NULL, NULL, 0, '10004', '1372073932806557697', '下湾塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266222755840', NULL, '2021-03-18 19:48:34.225000', 0, NULL, NULL, 0, '10005', '1372073932806557697', '下湾塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266226950144', NULL, '2021-03-18 19:48:34.226000', 0, NULL, NULL, 0, '10006', '1372073932806557697', '下湾塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266231144448', NULL, '2021-03-18 19:48:34.227000', 0, NULL, NULL, 0, '10007', '1372073932806557697', '下湾塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266235338752', NULL, '2021-03-18 19:48:34.228000', 0, NULL, NULL, 0, '10008', '1372073932806557697', '下湾塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266239533056', NULL, '2021-03-18 19:48:34.229000', 0, NULL, NULL, 0, '10001', '1372073949915123712', '月兰村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266243727360', NULL, '2021-03-18 19:48:34.230000', 0, NULL, NULL, 0, '10002', '1372073949915123712', '月兰村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266247921664', NULL, '2021-03-18 19:48:34.231000', 0, NULL, NULL, 0, '10003', '1372073949915123712', '月兰村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266252115968', NULL, '2021-03-18 19:48:34.232000', 0, NULL, NULL, 0, '10004', '1372073949915123712', '月兰村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266256310272', NULL, '2021-03-18 19:48:34.233000', 0, NULL, NULL, 0, '10005', '1372073949915123712', '月兰村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266256310273', NULL, '2021-03-18 19:48:34.234000', 0, NULL, NULL, 0, '10006', '1372073949915123712', '月兰村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266260504576', NULL, '2021-03-18 19:48:34.235000', 0, NULL, NULL, 0, '10007', '1372073949915123712', '月兰村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266264698880', NULL, '2021-03-18 19:48:34.235000', 0, NULL, NULL, 0, '10008', '1372073949915123712', '月兰村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266273087488', NULL, '2021-03-18 19:48:34.237000', 0, NULL, NULL, 0, '10001', '1372073970182000640', '向阳村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266277281792', NULL, '2021-03-18 19:48:34.238000', 0, NULL, NULL, 0, '10002', '1372073970182000640', '向阳村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266281476096', NULL, '2021-03-18 19:48:34.239000', 0, NULL, NULL, 0, '10003', '1372073970182000640', '向阳村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266285670400', NULL, '2021-03-18 19:48:34.240000', 0, NULL, NULL, 0, '10004', '1372073970182000640', '向阳村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266289864704', NULL, '2021-03-18 19:48:34.241000', 0, NULL, NULL, 0, '10005', '1372073970182000640', '向阳村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266294059008', NULL, '2021-03-18 19:48:34.242000', 0, NULL, NULL, 0, '10006', '1372073970182000640', '向阳村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266298253312', NULL, '2021-03-18 19:48:34.243000', 0, NULL, NULL, 0, '10007', '1372073970182000640', '向阳村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266302447616', NULL, '2021-03-18 19:48:34.244000', 0, NULL, NULL, 0, '10008', '1372073970182000640', '向阳村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266306641920', NULL, '2021-03-18 19:48:34.245000', 0, NULL, NULL, 0, '10001', '1372073988502720512', '长胜村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266310836224', NULL, '2021-03-18 19:48:34.246000', 0, NULL, NULL, 0, '10002', '1372073988502720512', '长胜村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266310836225', NULL, '2021-03-18 19:48:34.247000', 0, NULL, NULL, 0, '10003', '1372073988502720512', '长胜村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266319224832', NULL, '2021-03-18 19:48:34.248000', 0, NULL, NULL, 0, '10004', '1372073988502720512', '长胜村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266323419136', NULL, '2021-03-18 19:48:34.249000', 0, NULL, NULL, 0, '10005', '1372073988502720512', '长胜村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266327613440', NULL, '2021-03-18 19:48:34.250000', 0, NULL, NULL, 0, '10006', '1372073988502720512', '长胜村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266331807744', NULL, '2021-03-18 19:48:34.251000', 0, NULL, NULL, 0, '10007', '1372073988502720512', '长胜村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266336002048', NULL, '2021-03-18 19:48:34.252000', 0, NULL, NULL, 0, '10008', '1372073988502720512', '长胜村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266340196352', NULL, '2021-03-18 19:48:34.253000', 0, NULL, NULL, 0, '10001', '1372074004608847872', '下塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266344390656', NULL, '2021-03-18 19:48:34.254000', 0, NULL, NULL, 0, '10002', '1372074004608847872', '下塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266348584960', NULL, '2021-03-18 19:48:34.255000', 0, NULL, NULL, 0, '10003', '1372074004608847872', '下塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266352779264', NULL, '2021-03-18 19:48:34.256000', 0, NULL, NULL, 0, '10004', '1372074004608847872', '下塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266356973568', NULL, '2021-03-18 19:48:34.257000', 0, NULL, NULL, 0, '10005', '1372074004608847872', '下塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266361167872', NULL, '2021-03-18 19:48:34.258000', 0, NULL, NULL, 0, '10006', '1372074004608847872', '下塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266365362176', NULL, '2021-03-18 19:48:34.259000', 0, NULL, NULL, 0, '10007', '1372074004608847872', '下塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266369556480', NULL, '2021-03-18 19:48:34.260000', 0, NULL, NULL, 0, '10008', '1372074004608847872', '下塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266373750784', NULL, '2021-03-18 19:48:34.261000', 0, NULL, NULL, 0, '10001', '1372074027832709120', '总浦塘村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266377945088', NULL, '2021-03-18 19:48:34.262000', 0, NULL, NULL, 0, '10002', '1372074027832709120', '总浦塘村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266382139392', NULL, '2021-03-18 19:48:34.263000', 0, NULL, NULL, 0, '10003', '1372074027832709120', '总浦塘村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266386333696', NULL, '2021-03-18 19:48:34.264000', 0, NULL, NULL, 0, '10004', '1372074027832709120', '总浦塘村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266386333697', NULL, '2021-03-18 19:48:34.264000', 0, NULL, NULL, 0, '10005', '1372074027832709120', '总浦塘村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266390528000', NULL, '2021-03-18 19:48:34.265000', 0, NULL, NULL, 0, '10006', '1372074027832709120', '总浦塘村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266394722304', NULL, '2021-03-18 19:48:34.266000', 0, NULL, NULL, 0, '10007', '1372074027832709120', '总浦塘村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266398916608', NULL, '2021-03-18 19:48:34.267000', 0, NULL, NULL, 0, '10008', '1372074027832709120', '总浦塘村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266403110912', NULL, '2021-03-18 19:48:34.268000', 0, NULL, NULL, 0, '10001', '1372074046283452417', '宁东村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266407305216', NULL, '2021-03-18 19:48:34.269000', 0, NULL, NULL, 0, '10002', '1372074046283452417', '宁东村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266411499520', NULL, '2021-03-18 19:48:34.270000', 0, NULL, NULL, 0, '10003', '1372074046283452417', '宁东村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266415693824', NULL, '2021-03-18 19:48:34.271000', 0, NULL, NULL, 0, '10004', '1372074046283452417', '宁东村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266419888128', NULL, '2021-03-18 19:48:34.272000', 0, NULL, NULL, 0, '10005', '1372074046283452417', '宁东村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266424082432', NULL, '2021-03-18 19:48:34.273000', 0, NULL, NULL, 0, '10006', '1372074046283452417', '宁东村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266428276736', NULL, '2021-03-18 19:48:34.274000', 0, NULL, NULL, 0, '10007', '1372074046283452417', '宁东村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266432471040', NULL, '2021-03-18 19:48:34.275000', 0, NULL, NULL, 0, '10008', '1372074046283452417', '宁东村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266436665344', NULL, '2021-03-18 19:48:34.276000', 0, NULL, NULL, 0, '10001', '1372074068571983872', '新城村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266440859648', NULL, '2021-03-18 19:48:34.277000', 0, NULL, NULL, 0, '10002', '1372074068571983872', '新城村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266445053952', NULL, '2021-03-18 19:48:34.278000', 0, NULL, NULL, 0, '10003', '1372074068571983872', '新城村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266449248256', NULL, '2021-03-18 19:48:34.279000', 0, NULL, NULL, 0, '10004', '1372074068571983872', '新城村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266453442560', NULL, '2021-03-18 19:48:34.280000', 0, NULL, NULL, 0, '10005', '1372074068571983872', '新城村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266457636864', NULL, '2021-03-18 19:48:34.281000', 0, NULL, NULL, 0, '10006', '1372074068571983872', '新城村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266461831168', NULL, '2021-03-18 19:48:34.282000', 0, NULL, NULL, 0, '10007', '1372074068571983872', '新城村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266466025472', NULL, '2021-03-18 19:48:34.283000', 0, NULL, NULL, 0, '10008', '1372074068571983872', '新城村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266470219776', NULL, '2021-03-18 19:48:34.284000', 0, NULL, NULL, 0, '10001', '1372074085693132800', '龙山村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266474414080', NULL, '2021-03-18 19:48:34.285000', 0, NULL, NULL, 0, '10002', '1372074085693132800', '龙山村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266478608384', NULL, '2021-03-18 19:48:34.286000', 0, NULL, NULL, 0, '10003', '1372074085693132800', '龙山村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266482802688', NULL, '2021-03-18 19:48:34.287000', 0, NULL, NULL, 0, '10004', '1372074085693132800', '龙山村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266486996992', NULL, '2021-03-18 19:48:34.288000', 0, NULL, NULL, 0, '10005', '1372074085693132800', '龙山村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266491191296', NULL, '2021-03-18 19:48:34.289000', 0, NULL, NULL, 0, '10006', '1372074085693132800', '龙山村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266495385600', NULL, '2021-03-18 19:48:34.290000', 0, NULL, NULL, 0, '10007', '1372074085693132800', '龙山村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266499579904', NULL, '2021-03-18 19:48:34.291000', 0, NULL, NULL, 0, '10008', '1372074085693132800', '龙山村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266503774208', NULL, '2021-03-18 19:48:34.292000', 0, NULL, NULL, 0, '10001', '1372074108891828225', '连浦村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266507968512', NULL, '2021-03-18 19:48:34.293000', 0, NULL, NULL, 0, '10002', '1372074108891828225', '连浦村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266512162816', NULL, '2021-03-18 19:48:34.294000', 0, NULL, NULL, 0, '10003', '1372074108891828225', '连浦村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266516357120', NULL, '2021-03-18 19:48:34.295000', 0, NULL, NULL, 0, '10004', '1372074108891828225', '连浦村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266520551424', NULL, '2021-03-18 19:48:34.296000', 0, NULL, NULL, 0, '10005', '1372074108891828225', '连浦村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266524745728', NULL, '2021-03-18 19:48:34.297000', 0, NULL, NULL, 0, '10006', '1372074108891828225', '连浦村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266528940032', NULL, '2021-03-18 19:48:34.298000', 0, NULL, NULL, 0, '10007', '1372074108891828225', '连浦村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266533134336', NULL, '2021-03-18 19:48:34.299000', 0, NULL, NULL, 0, '10008', '1372074108891828225', '连浦村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266537328640', NULL, '2021-03-18 19:48:34.300000', 0, NULL, NULL, 0, '10001', '1372074123244736512', '湘田山村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266541522944', NULL, '2021-03-18 19:48:34.301000', 0, NULL, NULL, 0, '10002', '1372074123244736512', '湘田山村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266545717248', NULL, '2021-03-18 19:48:34.302000', 0, NULL, NULL, 0, '10003', '1372074123244736512', '湘田山村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266549911552', NULL, '2021-03-18 19:48:34.303000', 0, NULL, NULL, 0, '10004', '1372074123244736512', '湘田山村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266554105856', NULL, '2021-03-18 19:48:34.304000', 0, NULL, NULL, 0, '10005', '1372074123244736512', '湘田山村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266558300160', NULL, '2021-03-18 19:48:34.305000', 0, NULL, NULL, 0, '10006', '1372074123244736512', '湘田山村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266558300161', NULL, '2021-03-18 19:48:34.305000', 0, NULL, NULL, 0, '10007', '1372074123244736512', '湘田山村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266562494464', NULL, '2021-03-18 19:48:34.306000', 0, NULL, NULL, 0, '10008', '1372074123244736512', '湘田山村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266566688768', NULL, '2021-03-18 19:48:34.307000', 0, NULL, NULL, 0, '10001', '1372074141104082944', '五福村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266570883072', NULL, '2021-03-18 19:48:34.308000', 0, NULL, NULL, 0, '10002', '1372074141104082944', '五福村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266579271680', NULL, '2021-03-18 19:48:34.310000', 0, NULL, NULL, 0, '10003', '1372074141104082944', '五福村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266583465984', NULL, '2021-03-18 19:48:34.311000', 0, NULL, NULL, 0, '10004', '1372074141104082944', '五福村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266587660288', NULL, '2021-03-18 19:48:34.312000', 0, NULL, NULL, 0, '10005', '1372074141104082944', '五福村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266596048896', NULL, '2021-03-18 19:48:34.314000', 0, NULL, NULL, 0, '10006', '1372074141104082944', '五福村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266600243200', NULL, '2021-03-18 19:48:34.315000', 0, NULL, NULL, 0, '10007', '1372074141104082944', '五福村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266604437504', NULL, '2021-03-18 19:48:34.316000', 0, NULL, NULL, 0, '10008', '1372074141104082944', '五福村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266612826112', NULL, '2021-03-18 19:48:34.318000', 0, NULL, NULL, 0, '10001', '1372074162457284608', '山头村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266617020416', NULL, '2021-03-18 19:48:34.319000', 0, NULL, NULL, 0, '10002', '1372074162457284608', '山头村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266621214720', NULL, '2021-03-18 19:48:34.320000', 0, NULL, NULL, 0, '10003', '1372074162457284608', '山头村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266625409024', NULL, '2021-03-18 19:48:34.321000', 0, NULL, NULL, 0, '10004', '1372074162457284608', '山头村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266629603328', NULL, '2021-03-18 19:48:34.322000', 0, NULL, NULL, 0, '10005', '1372074162457284608', '山头村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266633797632', NULL, '2021-03-18 19:48:34.323000', 0, NULL, NULL, 0, '10006', '1372074162457284608', '山头村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266637991936', NULL, '2021-03-18 19:48:34.324000', 0, NULL, NULL, 0, '10007', '1372074162457284608', '山头村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266642186240', NULL, '2021-03-18 19:48:34.325000', 0, NULL, NULL, 0, '10008', '1372074162457284608', '山头村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266646380544', NULL, '2021-03-18 19:48:34.326000', 0, NULL, NULL, 0, '10001', '1372074178613743617', '港中村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266650574848', NULL, '2021-03-18 19:48:34.327000', 0, NULL, NULL, 0, '10002', '1372074178613743617', '港中村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266654769152', NULL, '2021-03-18 19:48:34.328000', 0, NULL, NULL, 0, '10003', '1372074178613743617', '港中村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266658963456', NULL, '2021-03-18 19:48:34.329000', 0, NULL, NULL, 0, '10004', '1372074178613743617', '港中村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266663157760', NULL, '2021-03-18 19:48:34.330000', 0, NULL, NULL, 0, '10005', '1372074178613743617', '港中村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266667352064', NULL, '2021-03-18 19:48:34.331000', 0, NULL, NULL, 0, '10006', '1372074178613743617', '港中村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266671546368', NULL, '2021-03-18 19:48:34.332000', 0, NULL, NULL, 0, '10007', '1372074178613743617', '港中村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266675740672', NULL, '2021-03-18 19:48:34.333000', 0, NULL, NULL, 0, '10008', '1372074178613743617', '港中村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266679934976', NULL, '2021-03-18 19:48:34.334000', 0, NULL, NULL, 0, '10001', '1372074194992500736', '平原村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266684129280', NULL, '2021-03-18 19:48:34.335000', 0, NULL, NULL, 0, '10002', '1372074194992500736', '平原村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266688323584', NULL, '2021-03-18 19:48:34.336000', 0, NULL, NULL, 0, '10003', '1372074194992500736', '平原村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266692517888', NULL, '2021-03-18 19:48:34.337000', 0, NULL, NULL, 0, '10004', '1372074194992500736', '平原村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266696712192', NULL, '2021-03-18 19:48:34.338000', 0, NULL, NULL, 0, '10005', '1372074194992500736', '平原村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266700906496', NULL, '2021-03-18 19:48:34.339000', 0, NULL, NULL, 0, '10006', '1372074194992500736', '平原村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266705100800', NULL, '2021-03-18 19:48:34.340000', 0, NULL, NULL, 0, '10007', '1372074194992500736', '平原村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266709295104', NULL, '2021-03-18 19:48:34.341000', 0, NULL, NULL, 0, '10008', '1372074194992500736', '平原村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266713489408', NULL, '2021-03-18 19:48:34.342000', 0, NULL, NULL, 0, '10001', '1372074211773911040', '大青村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266717683712', NULL, '2021-03-18 19:48:34.343000', 0, NULL, NULL, 0, '10002', '1372074211773911040', '大青村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266721878016', NULL, '2021-03-18 19:48:34.344000', 0, NULL, NULL, 0, '10003', '1372074211773911040', '大青村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266726072320', NULL, '2021-03-18 19:48:34.345000', 0, NULL, NULL, 0, '10004', '1372074211773911040', '大青村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266730266624', NULL, '2021-03-18 19:48:34.346000', 0, NULL, NULL, 0, '10005', '1372074211773911040', '大青村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266734460928', NULL, '2021-03-18 19:48:34.347000', 0, NULL, NULL, 0, '10006', '1372074211773911040', '大青村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266734460929', NULL, '2021-03-18 19:48:34.347000', 0, NULL, NULL, 0, '10007', '1372074211773911040', '大青村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266738655232', NULL, '2021-03-18 19:48:34.348000', 0, NULL, NULL, 0, '10008', '1372074211773911040', '大青村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266742849536', NULL, '2021-03-18 19:48:34.349000', 0, NULL, NULL, 0, '10001', '1372074229427736576', '东港村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266742849537', NULL, '2021-03-18 19:48:34.350000', 0, NULL, NULL, 0, '10002', '1372074229427736576', '东港村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266747043840', NULL, '2021-03-18 19:48:34.351000', 0, NULL, NULL, 0, '10003', '1372074229427736576', '东港村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266751238144', NULL, '2021-03-18 19:48:34.351000', 0, NULL, NULL, 0, '10004', '1372074229427736576', '东港村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266759626752', NULL, '2021-03-18 19:48:34.353000', 0, NULL, NULL, 0, '10005', '1372074229427736576', '东港村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266763821056', NULL, '2021-03-18 19:48:34.354000', 0, NULL, NULL, 0, '10006', '1372074229427736576', '东港村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266768015360', NULL, '2021-03-18 19:48:34.355000', 0, NULL, NULL, 0, '10007', '1372074229427736576', '东港村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266772209664', NULL, '2021-03-18 19:48:34.356000', 0, NULL, NULL, 0, '10008', '1372074229427736576', '东港村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266776403968', NULL, '2021-03-18 19:48:34.357000', 0, NULL, NULL, 0, '10001', '1372074245940711424', '双家村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266780598272', NULL, '2021-03-18 19:48:34.358000', 0, NULL, NULL, 0, '10002', '1372074245940711424', '双家村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266784792576', NULL, '2021-03-18 19:48:34.359000', 0, NULL, NULL, 0, '10003', '1372074245940711424', '双家村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266788986880', NULL, '2021-03-18 19:48:34.360000', 0, NULL, NULL, 0, '10004', '1372074245940711424', '双家村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266797375488', NULL, '2021-03-18 19:48:34.362000', 0, NULL, NULL, 0, '10005', '1372074245940711424', '双家村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266801569792', NULL, '2021-03-18 19:48:34.363000', 0, NULL, NULL, 0, '10006', '1372074245940711424', '双家村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266805764096', NULL, '2021-03-18 19:48:34.365000', 0, NULL, NULL, 0, '10007', '1372074245940711424', '双家村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266809958400', NULL, '2021-03-18 19:48:34.366000', 0, NULL, NULL, 0, '10008', '1372074245940711424', '双家村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266814152704', NULL, '2021-03-18 19:48:34.367000', 0, NULL, NULL, 0, '10001', '1372074264185933824', '青珠村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266818347008', NULL, '2021-03-18 19:48:34.367000', 0, NULL, NULL, 0, '10002', '1372074264185933824', '青珠村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266822541312', NULL, '2021-03-18 19:48:34.368000', 0, NULL, NULL, 0, '10003', '1372074264185933824', '青珠村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266826735616', NULL, '2021-03-18 19:48:34.369000', 0, NULL, NULL, 0, '10004', '1372074264185933824', '青珠村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266830929920', NULL, '2021-03-18 19:48:34.370000', 0, NULL, NULL, 0, '10005', '1372074264185933824', '青珠村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266835124224', NULL, '2021-03-18 19:48:34.371000', 0, NULL, NULL, 0, '10006', '1372074264185933824', '青珠村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266839318528', NULL, '2021-03-18 19:48:34.372000', 0, NULL, NULL, 0, '10007', '1372074264185933824', '青珠村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266843512832', NULL, '2021-03-18 19:48:34.373000', 0, NULL, NULL, 0, '10008', '1372074264185933824', '青珠村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266847707136', NULL, '2021-03-18 19:48:34.374000', 0, NULL, NULL, 0, '10001', '1372074281248362497', '新南村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266856095744', NULL, '2021-03-18 19:48:34.376000', 0, NULL, NULL, 0, '10002', '1372074281248362497', '新南村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266860290048', NULL, '2021-03-18 19:48:34.377000', 0, NULL, NULL, 0, '10003', '1372074281248362497', '新南村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266860290049', NULL, '2021-03-18 19:48:34.378000', 0, NULL, NULL, 0, '10004', '1372074281248362497', '新南村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266864484352', NULL, '2021-03-18 19:48:34.379000', 0, NULL, NULL, 0, '10005', '1372074281248362497', '新南村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266868678656', NULL, '2021-03-18 19:48:34.380000', 0, NULL, NULL, 0, '10006', '1372074281248362497', '新南村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266872872960', NULL, '2021-03-18 19:48:34.380000', 0, NULL, NULL, 0, '10007', '1372074281248362497', '新南村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266877067264', NULL, '2021-03-18 19:48:34.381000', 0, NULL, NULL, 0, '10008', '1372074281248362497', '新南村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266881261568', NULL, '2021-03-18 19:48:34.382000', 0, NULL, NULL, 0, '10001', '1372074295454470144', '新五星村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266885455872', NULL, '2021-03-18 19:48:34.383000', 0, NULL, NULL, 0, '10002', '1372074295454470144', '新五星村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266889650176', NULL, '2021-03-18 19:48:34.384000', 0, NULL, NULL, 0, '10003', '1372074295454470144', '新五星村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266893844480', NULL, '2021-03-18 19:48:34.385000', 0, NULL, NULL, 0, '10004', '1372074295454470144', '新五星村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266898038784', NULL, '2021-03-18 19:48:34.386000', 0, NULL, NULL, 0, '10005', '1372074295454470144', '新五星村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266902233088', NULL, '2021-03-18 19:48:34.387000', 0, NULL, NULL, 0, '10006', '1372074295454470144', '新五星村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266906427392', NULL, '2021-03-18 19:48:34.388000', 0, NULL, NULL, 0, '10007', '1372074295454470144', '新五星村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266910621696', NULL, '2021-03-18 19:48:34.389000', 0, NULL, NULL, 0, '10008', '1372074295454470144', '新五星村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266910621697', NULL, '2021-03-18 19:48:34.389000', 0, NULL, NULL, 0, '10001', '1372074315998171136', '文围村', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266914816000', NULL, '2021-03-18 19:48:34.390000', 0, NULL, NULL, 0, '10002', '1372074315998171136', '文围村', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266919010304', NULL, '2021-03-18 19:48:34.392000', 0, NULL, NULL, 0, '10003', '1372074315998171136', '文围村', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266923204608', NULL, '2021-03-18 19:48:34.393000', 0, NULL, NULL, 0, '10004', '1372074315998171136', '文围村', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266927398912', NULL, '2021-03-18 19:48:34.394000', 0, NULL, NULL, 0, '10005', '1372074315998171136', '文围村', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266931593216', NULL, '2021-03-18 19:48:34.395000', 0, NULL, NULL, 0, '10006', '1372074315998171136', '文围村', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266935787520', NULL, '2021-03-18 19:48:34.396000', 0, NULL, NULL, 0, '10007', '1372074315998171136', '文围村', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266939981824', NULL, '2021-03-18 19:48:34.397000', 0, NULL, NULL, 0, '10008', '1372074315998171136', '文围村', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266948370432', NULL, '2021-03-18 19:48:34.398000', 0, NULL, NULL, 0, '10001', '1372074335455547392', '青农社区', 0, '城建考核要求111111', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266952564736', NULL, '2021-03-18 19:48:34.399000', 0, NULL, NULL, 0, '10002', '1372074335455547392', '青农社区', 0, '城建考核要求22222', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266956759040', NULL, '2021-03-18 19:48:34.400000', 0, NULL, NULL, 0, '10003', '1372074335455547392', '青农社区', 0, '城建考核要求33333', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266960953344', NULL, '2021-03-18 19:48:34.401000', 0, NULL, NULL, 0, '10004', '1372074335455547392', '青农社区', 0, '城建考核要求44444', '城建', '未填写', '未填写', NULL, NULL),
	('1372515266965147648', NULL, '2021-03-18 19:48:34.402000', 0, NULL, NULL, 0, '10005', '1372074335455547392', '青农社区', 0, '农办考核要求111111', '农办', '未填写', '未填写', NULL, NULL),
	('1372515266969341952', NULL, '2021-03-18 19:48:34.403000', 0, NULL, NULL, 0, '10006', '1372074335455547392', '青农社区', 0, '组织考核要求22222', '组织', '未填写', '未填写', NULL, NULL),
	('1372515266973536256', NULL, '2021-03-18 19:48:34.404000', 0, NULL, NULL, 0, '10007', '1372074335455547392', '青农社区', 0, '公安考核要求33333', '公安', '未填写', '未填写', NULL, NULL),
	('1372515266977730560', NULL, '2021-03-18 19:48:34.405000', 0, NULL, NULL, 0, '10008', '1372074335455547392', '青农社区', 0, '公安考核要求44444', '公安', '未填写', '未填写', NULL, NULL);
/*!40000 ALTER TABLE `t_village_require_vo` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
