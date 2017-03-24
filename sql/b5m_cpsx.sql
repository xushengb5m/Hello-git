/*
Navicat MySQL Data Transfer

Source Server         : 172.16.11.15
Source Server Version : 50532
Source Host           : 172.16.11.15:3306
Source Database       : b5m_cpsx

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2016-08-11 17:08:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cpsx_activity_dim_activity
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_activity_dim_activity`;
CREATE TABLE `cpsx_activity_dim_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `merchant_id` int(11) NOT NULL COMMENT '商家ID',
  `charge_mode` varchar(32) NOT NULL COMMENT '计费类型(cpscpacpc)',
  `type` smallint(6) NOT NULL COMMENT '活动类型 pc端和移动端',
  `name` varchar(64) NOT NULL COMMENT '活动名称',
  `domain` varchar(128) NOT NULL COMMENT '活动网站主域名',
  `category` int(11) DEFAULT NULL COMMENT '活动分类',
  `is_active` smallint(6) NOT NULL COMMENT '是否有效',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_activity_dim_activity
-- ----------------------------
INSERT INTO `cpsx_activity_dim_activity` VALUES ('1', '1001', 'CPS', '1', '618 活动', 'ww.618.com', '2', '1', '2016-06-12 20:26:37', '2016-06-16 10:03:27');
INSERT INTO `cpsx_activity_dim_activity` VALUES ('2', '10023', 'CPS', '1', 'B5M', 'www.b5m.com', '3', '1', '2016-06-12 20:38:44', '2016-06-16 10:03:34');
INSERT INTO `cpsx_activity_dim_activity` VALUES ('3', '100022', 'CPC', '2', '22 活动', 'www.22.com', '1', '1', '2016-06-13 14:45:30', '2016-06-16 10:03:46');
INSERT INTO `cpsx_activity_dim_activity` VALUES ('100', '1002', 'CPA', '1', '京东CPS', 'http://www.jd.com', '1', '1', '2016-06-20 17:09:07', '2016-07-13 14:25:15');
INSERT INTO `cpsx_activity_dim_activity` VALUES ('101', '121201', 'CPS', '1', '7月活动', 'www.test.com', '21', '1', '2016-07-01 16:07:28', null);
INSERT INTO `cpsx_activity_dim_activity` VALUES ('102', '1003', 'CPS', '1', '天猫活动', 'tmall.com', '3', '1', '2016-07-19 15:53:10', null);
INSERT INTO `cpsx_activity_dim_activity` VALUES ('103', '1008', 'CPS', '1', '韩国新世界', 'http://cn.ssg.com', '1', '1', '2016-07-28 10:31:56', null);

-- ----------------------------
-- Table structure for cpsx_activity_dim_category
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_activity_dim_category`;
CREATE TABLE `cpsx_activity_dim_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `note` text,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_activity_dim_category
-- ----------------------------
INSERT INTO `cpsx_activity_dim_category` VALUES ('1', '类型1', '类型1的描述1', '2016-06-08 14:19:51', '2016-06-12 15:43:17');
INSERT INTO `cpsx_activity_dim_category` VALUES ('2', '类型2', '类型2的介绍1', '2016-06-08 15:12:24', '2016-06-30 20:19:06');
INSERT INTO `cpsx_activity_dim_category` VALUES ('3', '类型3', '类型3的介绍', '2016-06-08 15:12:29', null);
INSERT INTO `cpsx_activity_dim_category` VALUES ('21', 'test4', 'pppd', '2016-06-30 20:18:09', '2016-07-13 14:25:06');
INSERT INTO `cpsx_activity_dim_category` VALUES ('22', '测试4', '二恶万人', '2016-07-06 15:53:47', '2016-07-07 17:01:42');
INSERT INTO `cpsx_activity_dim_category` VALUES ('23', '4645', '7657', '2016-07-12 14:06:15', null);

-- ----------------------------
-- Table structure for cpsx_activity_dim_clearing_cycle
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_activity_dim_clearing_cycle`;
CREATE TABLE `cpsx_activity_dim_clearing_cycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clearing_cycle` varchar(64) NOT NULL,
  `note` text,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_activity_dim_clearing_cycle
-- ----------------------------
INSERT INTO `cpsx_activity_dim_clearing_cycle` VALUES ('1', '81', '81天', '2016-06-12 16:08:45', '2016-06-12 16:10:26');
INSERT INTO `cpsx_activity_dim_clearing_cycle` VALUES ('2', '30', '隔月结算', '2016-06-29 15:27:22', null);
INSERT INTO `cpsx_activity_dim_clearing_cycle` VALUES ('3', '60', '隔两个月结算', '2016-06-29 15:30:16', null);
INSERT INTO `cpsx_activity_dim_clearing_cycle` VALUES ('4', '1', '隔天结算', '2016-06-29 15:30:42', null);
INSERT INTO `cpsx_activity_dim_clearing_cycle` VALUES ('5', '90', '季度报表\n', '2016-07-01 16:06:17', '2016-07-01 16:06:33');

-- ----------------------------
-- Table structure for cpsx_activity_fact_activity
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_activity_fact_activity`;
CREATE TABLE `cpsx_activity_fact_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `activity_id` int(11) NOT NULL COMMENT '活动id',
  `image` text COMMENT '活动图片',
  `commission` varchar(128) NOT NULL COMMENT '佣金比例',
  `rd` int(11) DEFAULT NULL COMMENT 'cookie有效期(天)',
  `start_date` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '活动结束时间',
  `approval_mode` smallint(6) NOT NULL COMMENT '审核方式(1-自动2-人工3-无需)',
  `clearing_cycle_id` int(11) DEFAULT NULL COMMENT '结算周期',
  `data_return_mode` int(11) DEFAULT NULL COMMENT '数据返回机制',
  `has_feedback` smallint(6) DEFAULT NULL COMMENT '是否支持反馈标签',
  `has_self_links` smallint(6) DEFAULT NULL COMMENT '是否支持自定义链接',
  `prohibited_sites_types` text COMMENT '禁止投放站点类别',
  `restrictions` text COMMENT '限制条件',
  `note` text COMMENT '活动描述',
  `is_active` smallint(6) NOT NULL COMMENT '是否有效',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_activity_fact_activity
-- ----------------------------
INSERT INTO `cpsx_activity_fact_activity` VALUES ('1', '1', 'http://cdn01.b5mcdn.com/home/img/logo.png?v=2015202015041113283920', '8%-10%', '2', '2016-02-03 00:00:00', '2016-02-03 23:59:59', '2', '1', '2', '1', '1', '2', '如何联系帮5买会员顾问？\nA:您可以通过拨打我们的热线电话：400-085-0505，或发送邮件至mc@b5m.com联系我们的客服；您也可以直接点击右边栏小帮咨询，进行在线交流；加入帮5买海淘用户QQ群-333194174，随时为您解决问题。', '帮5买(上海载和网络科技有限公司)，意为“帮我买”，是中国独立购物搜索门户网站，于2011年12月正式上线，致力于帮助中国消费者解决“买什么”和“去哪儿买”的难题，提升中国消费者的购物体验；并着力打造透明、高效的电子商务聚合平台，将数以亿计的优质商品与消费者联接起来，将消费者与数千电商网站联接起来，最终成为网民网上购物的入口。 帮5买拥有先进、精准、公正的独立购物搜索引擎，目前已有商品、团购、票务、旅游的垂直搜索，未来还将增加保险、贷款、房产等各领域的垂直搜索；并收录超过3亿条商品数据，包含商品信息、用户评论、购物相关文章等等，数据来自6000多家B2C网站，覆盖商品、团购、旅游、促销、票务等垂直产品；还与搜狐网、京东商城、亚马逊、当当网等国内知名网站达成战略合作。', '1', '2016-06-14 17:14:15', '2016-07-13 14:25:48');
INSERT INTO `cpsx_activity_fact_activity` VALUES ('2', '3', 'http://cdnweb.b5m.com/web/cmsphp/static_image/4161a60c2f79bc9e1373f008b5a7979a.png', '8%', '22', '2016-06-01 00:00:00', '2017-05-31 23:59:59', '2', '1', '22', '1', '1', '22', '如何联系帮5买会员顾问？\nA:您可以通过拨打我们的热线电话：400-085-0505，或发送邮件至mc@b5m.com联系我们的客服；您也可以直接点击右边栏小帮咨询，进行在线交流；加入帮5买海淘用户QQ群-333194174，随时为您解决问题。', '22', '1', '2016-06-14 17:51:23', '2016-06-15 20:16:02');
INSERT INTO `cpsx_activity_fact_activity` VALUES ('3', '2', 'http://upm01.b5m.com/49bef445572bebd79ff3df6531b1b2f2', '10%', '3', '2016-06-01 00:00:00', '2017-05-31 23:59:59', '1', '1', '3', '1', '1', '3', '1、禁止seo、sem投放\n2、付款后1-7天返回', '帮5买(上海载和网络科技有限公司)，意为“帮我买”，是中国独立购物搜索门户网站，于2011年12月正式上线，致力于帮助中国消费者解决“买什么”和“去哪儿买”的难题，提升中国消费者的购物体验；并着力打造透明、高效的电子商务聚合平台，将数以亿计的优质商品与消费者联接起来，将消费者与数千电商网站联接起来，最终成为网民网上购物的入口。 帮5买拥有先进、精准、公正的独立购物搜索引擎，目前已有商品、团购、票务、旅游的垂直搜索，未来还将增加保险、贷款、房产等各领域的垂直搜索；并收录超过3亿条商品数据，包含商品信息、用户评论、购物相关文章等等，数据来自6000多家B2C网站，覆盖商品、团购、旅游、促销、票务等垂直产品；还与搜狐网、京东商城、亚马逊、当当网等国内知名网站达成战略合作。', '1', '2016-06-14 20:40:25', '2016-06-16 10:45:00');
INSERT INTO `cpsx_activity_fact_activity` VALUES ('4', '100', 'https://image.yiqifa.com/ad_images/reguser/24/31/63/1364886745838.jpg', '2%', '2', '2016-06-01 00:00:00', '2017-05-31 23:59:59', '2', '1', '30', '1', '1', '无', '禁止SEO\n禁止返利', '按有效销售额提成的CPS方式，有效销售额指的是去掉退换货，以及运费，代金券等费用以外的成交订单的销售额。\n结算方式为月结，请大家申请之后登录亿起发后台获取广告代码。', '1', '2016-06-20 18:49:10', '2016-06-20 18:50:28');
INSERT INTO `cpsx_activity_fact_activity` VALUES ('5', '103', 'https://sstatic.ssggcdn.com/media/logo/stores/4/cn_logo.svg', '5%', '2', '2016-07-28 00:00:00', '2016-08-01 23:59:59', '2', '2', '1', '0', '1', '1', '1', '1', '1', '2016-07-28 10:32:58', '2016-07-28 15:03:16');

-- ----------------------------
-- Table structure for cpsx_activity_fact_commission_info
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_activity_fact_commission_info`;
CREATE TABLE `cpsx_activity_fact_commission_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `activity_id` int(11) NOT NULL COMMENT '活动id',
  `name` varchar(128) NOT NULL COMMENT '佣金类目名称',
  `commission` varchar(128) NOT NULL COMMENT '佣金比例',
  `start_date` datetime DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `apply_goods` varchar(128) DEFAULT NULL COMMENT '适用商品',
  `is_active` smallint(6) NOT NULL COMMENT '是否有效',
  `note` text COMMENT '详细说明',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_activity_fact_commission_info
-- ----------------------------
INSERT INTO `cpsx_activity_fact_commission_info` VALUES ('1', '3', '发财1', '8%-10%', '2016-06-01 00:00:00', '2017-05-31 23:59:59', '全品类', '1', 'mmm', '2016-06-13 19:38:00', '2016-07-01 11:01:08');
INSERT INTO `cpsx_activity_fact_commission_info` VALUES ('2', '2', '113', '13%', '2016-06-01 00:00:00', '2017-05-31 00:00:00', '11113', '0', 'all', '2016-06-13 20:01:13', '2016-06-14 18:34:03');
INSERT INTO `cpsx_activity_fact_commission_info` VALUES ('3', '1', '618', '13%', '2016-04-26 00:00:00', '2016-04-26 23:59:59', 'ds', '1', 'ddsf', '2016-06-14 18:13:25', '2016-07-01 11:01:23');

-- ----------------------------
-- Table structure for cpsx_activity_fact_notification
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_activity_fact_notification`;
CREATE TABLE `cpsx_activity_fact_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `activity_id` int(11) NOT NULL COMMENT '活动id',
  `type` smallint(6) NOT NULL COMMENT '通知类型(1-联盟公告、2-商家奖励、3-商家促销)',
  `title` varchar(128) NOT NULL COMMENT '通知标题',
  `info` text COMMENT '通知信息',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_activity_fact_notification
-- ----------------------------
INSERT INTO `cpsx_activity_fact_notification` VALUES ('1', '1', '1', '韩都衣舍上线！', '一千年以后 你会后悔错过这次的活动', '2016-06-14 11:31:44', '2016-06-27 18:32:15');
INSERT INTO `cpsx_activity_fact_notification` VALUES ('2', '2', '2', '名鞋库上线！', '一千年以后 你会后悔错过这次的活动', '2016-06-14 12:24:15', '2016-06-27 18:32:17');
INSERT INTO `cpsx_activity_fact_notification` VALUES ('3', '3', '1', '爱慕官方商城上线！', '一千年以后 你会后悔错过这次的活动', '2016-06-14 12:28:59', '2016-06-27 18:32:18');
INSERT INTO `cpsx_activity_fact_notification` VALUES ('4', '2', '1', '新西兰可瑞康奶粉狂欢日，用券立减50！！！！！', '一千年以后 你会后悔错过这次的活动', '2016-06-14 12:29:13', '2016-06-27 18:32:20');
INSERT INTO `cpsx_activity_fact_notification` VALUES ('5', '1', '2', 'Furla新品促销，满$350立减$100！', '一千年以后 你会后悔错过这次的活动', '2016-06-14 12:29:59', '2016-06-27 18:32:22');
INSERT INTO `cpsx_activity_fact_notification` VALUES ('6', '100', '3', '佣金高达16%！', '一千年以后 你会后悔错过这次的活动', '2016-06-22 19:23:50', '2016-06-27 18:32:24');

-- ----------------------------
-- Table structure for cpsx_report_fact_data_statistic
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_report_fact_data_statistic`;
CREATE TABLE `cpsx_report_fact_data_statistic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` date DEFAULT NULL,
  `action_id` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website_id` int(10) DEFAULT NULL,
  `business_way` tinyint(4) DEFAULT NULL,
  `click_no` bigint(20) DEFAULT NULL,
  `click_ip` bigint(20) DEFAULT NULL,
  `pre_order_count` int(10) DEFAULT NULL,
  `pre_order_money` decimal(10,2) DEFAULT NULL,
  `pre_commission` decimal(10,2) DEFAULT NULL,
  `confirm_order_count` int(10) DEFAULT NULL,
  `confirm_order_money` decimal(10,2) DEFAULT NULL,
  `confirm_commission` decimal(10,2) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cpsx_report_fact_data_statistic
-- ----------------------------
INSERT INTO `cpsx_report_fact_data_statistic` VALUES ('1', '2016-06-14', '1', '1', '1', '22343', '3424', '3', '3525.60', '220.50', '2', '2754.00', '181.00', '2016-06-20 16:43:56', '2016-06-21 18:56:00');
INSERT INTO `cpsx_report_fact_data_statistic` VALUES ('2', '2016-06-15', '1', '2', '1', '23125', '3200', '2', '3012.30', '200.50', '2', '2259.00', '147.00', '2016-06-20 17:26:59', '2016-06-21 18:56:03');
INSERT INTO `cpsx_report_fact_data_statistic` VALUES ('3', '2016-06-15', '2', '3', '1', '15513', '1332', '4', '2013.40', '220.00', '4', '2240.00', '112.00', '2016-06-21 11:35:48', '2016-06-21 18:56:06');

-- ----------------------------
-- Table structure for cpsx_report_fact_pre_order
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_report_fact_pre_order`;
CREATE TABLE `cpsx_report_fact_pre_order` (
  `unique_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '唯一编号',
  `owner_id` int(12) DEFAULT NULL,
  `action_id` int(12) DEFAULT NULL COMMENT '活动ID',
  `website_id` int(12) DEFAULT NULL COMMENT '网站ID',
  `order_no` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '订单号',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `order_status` tinyint(4) DEFAULT NULL COMMENT '订单状态(1.未确认/2.结算/3.无效)',
  `order_price` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `feed_back` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '反馈标签',
  `prod_id` int(12) DEFAULT NULL COMMENT '商品编号',
  `prod_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prod_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品类型',
  `prod_count` int(12) DEFAULT NULL COMMENT '商品数量',
  `prod_price` decimal(10,2) DEFAULT NULL COMMENT '商品单价',
  `prod_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品链接',
  `commission` decimal(10,2) DEFAULT NULL COMMENT '商品佣金',
  `commission_rate` char(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '佣金比例',
  `prod_reduction` decimal(10,2) DEFAULT NULL COMMENT '商品优惠金额',
  `order_reduction` decimal(10,2) DEFAULT NULL COMMENT '订单优惠金额',
  `currency` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'CNY' COMMENT '币种',
  `merchant_status` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商家状态',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `update_time` datetime DEFAULT NULL COMMENT 'update_time',
  PRIMARY KEY (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cpsx_report_fact_pre_order
-- ----------------------------
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('1001a', '1001', '1', '1', 'A385537352', '2016-06-14 16:17:07', '1', '256.50', 'dsdfsf', '2543', null, '12', '2', '128.50', 'http://www.prodlink.com', '20.40', '3%', null, null, null, null, null, null);
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('1001b', '1001', '1', '1', 'E5786905475', '2016-06-14 19:06:22', '1', '244.00', 'fdfsdg', '5345', null, '123', '2', '122.00', 'http://www.maopu_lop.com', '10.00', '2%', null, null, null, null, null, null);
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('1001c', '1001', '1', '1', 'F5658979700', '2016-06-14 19:07:25', '2', '245.00', 'fdfsd', '5646', null, '224', '3', '56.00', 'http://www.gogolink.com', '22.00', '3%', null, null, null, null, null, null);
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('1002a', '1001', '2', '1', 'E587873583', '2016-06-16 14:21:50', '1', '69.00', 'ffseg', '5336', null, '145', '1', '69.00', 'http://www.mothercool.com', '2.50', '2.6%', null, null, null, null, null, null);
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('1002c', '1001', '1', '1', 'F385537352', '2016-06-15 18:26:57', '2', '262.00', 'fdsfdsf', '4343', null, '123', '3', '85.00', 'http://www.plv_lop.com', '15.20', '2.5%', null, null, null, null, null, null);
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('1003s', '1002', '1', '2', 'A3492586673', '2016-06-16 14:24:52', '3', '52.00', 'hhdfh', '4563', null, '334', '1', '52.00', 'http://www.gaojila.com', '3.50', '3%', null, null, null, null, null, null);
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('2002b', '1002', '1', '1', 'S125537378', '2016-06-16 16:17:07', '1', '222.50', 'gsfsf', '3643', null, '12', '2', '111.50', 'http://www.oopaad.com', '15.40', '3%', null, null, null, null, null, null);
INSERT INTO `cpsx_report_fact_pre_order` VALUES ('2006c', '1002', '1', '2', 'S34687346', '2016-06-16 16:17:07', '2', '222.50', 'jhklu', '3643', null, '12', '2', '111.50', 'http://www.sffgs.com', '11.20', '4%', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for cpsx_settle_dim_account_info
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_settle_dim_account_info`;
CREATE TABLE `cpsx_settle_dim_account_info` (
  `user_id` int(11) DEFAULT NULL,
  `pay_psw` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '银行名称',
  `bank_address` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '银行开户地址',
  `bank_account` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '银行账户',
  `register_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '收款人',
  `bank_tel_no` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '银行绑定手机号',
  `alipay_account` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '支付宝账户',
  `alipay_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '支付宝账户名',
  `alipay_tel_no` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '支付宝绑定手机号',
  `identify_no` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证',
  `is_enable` tinyint(4) DEFAULT NULL COMMENT '是否有效',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `update_time` datetime DEFAULT NULL COMMENT 'update_time'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cpsx_settle_dim_account_info
-- ----------------------------
INSERT INTO `cpsx_settle_dim_account_info` VALUES ('1016', 'e3ceb5881a0a1fdaad01296d7554868d', '中国工商银行', '浦东支行', '32102586976132', '刘邦', '13865432586', '2642758573@qq.com', '王尼玛', '13865432586', '123456789012345678', null, null, null);
INSERT INTO `cpsx_settle_dim_account_info` VALUES ('1003', '96e79218965eb72c92a549dd5a330112', 'sdd', 'fsf', '2324325435346677', 'dsg', '12443253535', null, null, null, '43535745753546786x', null, null, null);

-- ----------------------------
-- Table structure for cpsx_settle_dim_commission_apply
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_settle_dim_commission_apply`;
CREATE TABLE `cpsx_settle_dim_commission_apply` (
  `user_id` int(11) NOT NULL,
  `the_month` int(11) NOT NULL COMMENT '月份',
  `the_year` int(11) NOT NULL COMMENT '年份',
  `commission` decimal(10,2) DEFAULT NULL COMMENT '佣金',
  `apply_money` decimal(10,2) DEFAULT '0.00' COMMENT '申请金额',
  `apply_date` datetime DEFAULT NULL COMMENT '申请日期',
  `tax_money` decimal(10,2) DEFAULT '0.00' COMMENT '支付扣税',
  `charge_money` decimal(10,2) DEFAULT '0.00' COMMENT '汇款手续费',
  `pay_money` decimal(10,2) DEFAULT '0.00' COMMENT '实际支付',
  `pay_date` datetime DEFAULT NULL COMMENT '支付日期',
  `receiver` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '收款人',
  `check_state` int(255) DEFAULT '-1' COMMENT '审核状态:-1-未审核/0-审核中/1-审核通过/2-不通过',
  `pay_state` int(11) DEFAULT '-1' COMMENT '支付状态:-1-无支付/0-待支付/1-已支付/2-未支付',
  `remain` decimal(10,2) DEFAULT '0.00' COMMENT '余额',
  `note` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `update_time` datetime DEFAULT NULL COMMENT 'update_time',
  PRIMARY KEY (`user_id`,`the_month`,`the_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cpsx_settle_dim_commission_apply
-- ----------------------------
INSERT INTO `cpsx_settle_dim_commission_apply` VALUES ('1001', '7', '2016', '2502.00', '11122.00', '2016-07-12 15:49:28', '1.00', '1.00', '1.00', '2016-07-12 15:49:43', '212', '1', '1', null, '31', '2016-07-12 15:49:28', null);
INSERT INTO `cpsx_settle_dim_commission_apply` VALUES ('1003', '7', '2016', '356.00', '10000.00', '2016-07-08 18:48:31', '1.00', '1.00', '1.00', '2016-07-13 10:44:28', '2d', '1', '1', null, '2f', '2016-07-08 18:48:31', null);
INSERT INTO `cpsx_settle_dim_commission_apply` VALUES ('1005', '6', '2016', '352.00', '200.00', '2016-07-05 16:31:19', '10.50', '2.00', '188.00', '2016-07-06 16:31:41', 'ali', '1', '1', null, '测试', null, null);
INSERT INTO `cpsx_settle_dim_commission_apply` VALUES ('1005', '7', '2016', '2255.00', '0.00', null, '0.00', '0.00', '0.00', null, null, '-1', '-1', '3000.00', null, null, null);
INSERT INTO `cpsx_settle_dim_commission_apply` VALUES ('1016', '5', '2016', '2251.00', '0.00', null, '0.00', '0.00', '0.00', '2016-05-04 19:05:24', '', '-1', '-1', '2251.00', null, null, null);
INSERT INTO `cpsx_settle_dim_commission_apply` VALUES ('1016', '6', '2016', '325.20', '225.00', '2016-07-08 14:45:37', '20.30', '10.20', '195.00', '2016-07-08 14:57:12', 'john', '1', '1', '2351.20', '', '2016-06-16 14:45:37', null);
INSERT INTO `cpsx_settle_dim_commission_apply` VALUES ('1016', '7', '2016', '3338.00', '1500.00', '2016-07-19 18:25:46', '0.30', '10.00', '1488.00', '2016-07-27 15:06:06', 'tianwang', '1', '1', '4189.20', 'ok', '2016-07-19 18:25:46', null);

-- ----------------------------
-- Table structure for cpsx_settle_fact_confirm_order
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_settle_fact_confirm_order`;
CREATE TABLE `cpsx_settle_fact_confirm_order` (
  `unique_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'null' COMMENT '唯一编号',
  `order_no` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '订单号',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动ID',
  `website_id` int(11) DEFAULT NULL COMMENT '网站Id',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `order_price` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `order_status` tinyint(4) DEFAULT NULL COMMENT '订单状态(1.未确认/2.结算/3.无效)',
  `prod_id` int(11) DEFAULT NULL COMMENT '商品编号',
  `prod_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prod_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '产品类型',
  `prod_count` int(11) DEFAULT NULL COMMENT '商品数量',
  `prod_price` decimal(10,2) DEFAULT NULL COMMENT '商品单价',
  `commission` decimal(10,2) DEFAULT NULL COMMENT '商品佣金',
  `commission_rate` double DEFAULT NULL COMMENT '佣金比例',
  `feed_back` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settle_money` decimal(10,2) DEFAULT NULL,
  `settle_time` datetime DEFAULT NULL,
  `settle_commission` decimal(10,2) DEFAULT NULL,
  `currency` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'CNY' COMMENT '币种',
  `note` text COLLATE utf8_unicode_ci COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `update_time` datetime DEFAULT NULL COMMENT 'update_time'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='通过网站主文件导入数据，可靠的结算数据';

-- ----------------------------
-- Records of cpsx_settle_fact_confirm_order
-- ----------------------------
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('3001a', 'A224545', '1', '1', '2016-06-02 15:30:54', '225.30', null, '356', null, null, '2', '152.00', '25.00', '3.5', null, '356.00', '2016-06-30 15:31:35', '25.00', 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('3005e', 'E1f5df4g', '1', '1', '2016-06-03 15:32:43', '125.00', null, '456', null, null, '1', '125.00', '10.50', '2.5', null, '125.00', '2016-06-29 15:33:12', '10.25', 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('3048s', 'Srt4y57', '2', '1', '2016-06-08 15:33:52', '685.00', null, '486', null, null, '3', '143.00', '42.60', '4', null, '425.00', '2016-06-30 15:35:44', '42.50', 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('4025a', 'A33534', '2', '1005', '2016-06-08 16:28:45', '145.00', null, '2645', null, null, '1', '145.00', '15.00', '3.5', null, '145.00', '2016-06-30 16:29:20', '15.00', 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('4008c', 'C2647rfr6', '1', '1005', '2016-06-10 16:30:03', '512.00', null, '5645', null, null, '1', '508.00', '50.00', '8', null, '508.00', '2016-06-30 16:30:40', '50.00', 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('4dg5y', 'Srt4y57', '2', '1', '2016-06-08 15:40:46', '685.00', null, '65665', null, null, '1', '199.00', '15.00', '3.5', null, '199.00', '2016-06-30 15:42:13', '15.00', 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('10aa13ba99a603fcca0ee1735652ed4b', 'A2324244fsd', '13', '34', '2016-02-10 12:00:00', '13.00', '1', '42', '胜多负少', '发顺丰', '45', '22.50', '2.00', '0.09', null, '22.50', null, null, 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('77ee44764d9503ff484940f4254f1177', 'A1223', '133', '223', '2016-03-22 12:00:00', '2250.20', '1', '256', '席梦思大被', '家居', '1', '2250.20', '200.00', '0.09', 'frg4etgety', '2199.00', '2016-03-29 12:00:00', '200.00', 'CNY', null, null, null);
INSERT INTO `cpsx_settle_fact_confirm_order` VALUES ('eaaf4f5f379c9eda9daa69974bc3961c', 'A1224', '215', '253', '2016-03-23 12:00:00', '2251.20', '1', '256', '席梦思大被', '家居', '1', '2250.20', '200.00', '0.09', 'frg5etgety', '2200.00', '2016-03-30 12:00:00', '201.00', 'CNY', null, null, null);

-- ----------------------------
-- Table structure for cpsx_settle_website_remain_sum
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_settle_website_remain_sum`;
CREATE TABLE `cpsx_settle_website_remain_sum` (
  `user_id` int(11) NOT NULL COMMENT '网站主Id',
  `applying_money` decimal(10,2) DEFAULT NULL COMMENT '提现中的金额',
  `acquired_money` decimal(10,2) DEFAULT NULL COMMENT '已提现金额',
  `remain_sum` decimal(10,2) DEFAULT NULL COMMENT '余额',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `update_time` datetime DEFAULT NULL COMMENT 'update_time',
  KEY `Foreign_key_user_id` (`user_id`),
  CONSTRAINT `Foreign_key_user_id` FOREIGN KEY (`user_id`) REFERENCES `cpsx_sys_dim_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cpsx_settle_website_remain_sum
-- ----------------------------
INSERT INTO `cpsx_settle_website_remain_sum` VALUES ('1016', '0.00', '35328992.80', '5689.20', null, null);
INSERT INTO `cpsx_settle_website_remain_sum` VALUES ('1005', '0.00', '0.00', '16525.80', null, null);
INSERT INTO `cpsx_settle_website_remain_sum` VALUES ('1002', '99999999.99', '11.00', '666.00', null, null);
INSERT INTO `cpsx_settle_website_remain_sum` VALUES ('1003', '0.00', null, '490000.00', null, null);

-- ----------------------------
-- Table structure for cpsx_supply_dim_site_type
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_supply_dim_site_type`;
CREATE TABLE `cpsx_supply_dim_site_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '站点类型名称',
  `note` text COLLATE utf8_unicode_ci COMMENT '说明',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'create_time',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'update_time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='cpsx_supply_dim_site_type';

-- ----------------------------
-- Records of cpsx_supply_dim_site_type
-- ----------------------------
INSERT INTO `cpsx_supply_dim_site_type` VALUES ('1', '购物', '购物网站', '2016-06-14 19:16:56', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_site_type` VALUES ('2', '游戏', '游戏类网站', '2016-06-15 15:23:48', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_site_type` VALUES ('3', '导航', '导航fdsfd', '2016-06-29 15:31:27', '2016-06-29 15:31:27');
INSERT INTO `cpsx_supply_dim_site_type` VALUES ('7', '旅游网站', '旅游专用', '2016-07-01 16:01:31', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for cpsx_supply_dim_website
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_supply_dim_website`;
CREATE TABLE `cpsx_supply_dim_website` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `supply_id` int(11) DEFAULT NULL COMMENT '网站主id',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '网站名称',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '网站域名',
  `app_type` smallint(6) DEFAULT NULL COMMENT '网站应用类型(pc/wap)',
  `type` int(11) DEFAULT NULL COMMENT '网站类型',
  `verification_mode` smallint(6) DEFAULT NULL COMMENT '验证方式',
  `verification_status` smallint(6) DEFAULT '1' COMMENT '验证状态',
  `approval_status` smallint(6) DEFAULT '1' COMMENT '审核状态',
  `ip_per_day` bigint(20) DEFAULT NULL COMMENT '日访问量',
  `about` text COLLATE utf8_unicode_ci COMMENT '网站简介',
  `record_info` text COLLATE utf8_unicode_ci COMMENT '网站备案信息',
  `is_default` tinyint(1) DEFAULT NULL COMMENT 'is_default',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'create_time',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'update_time',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_9` (`type`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`type`) REFERENCES `cpsx_supply_dim_site_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1016 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='cpsx_supply_dim_website';

-- ----------------------------
-- Records of cpsx_supply_dim_website
-- ----------------------------
INSERT INTO `cpsx_supply_dim_website` VALUES ('1', '1016', '51wan', 'www.51wan.com', '1', '3', '2', '2', '2', '20000', '更大幅度和', '注册资金500万，用户规模300万，累积客户3亿，活跃用户4000万，日均成交额8000万美元，纽约证券交易所上市，市值估300亿，每股成交额200美元，国际最具影响力的贸易公司之一，世界500强。。。。', '1', '2016-07-21 14:48:35', '2016-07-14 13:18:41');
INSERT INTO `cpsx_supply_dim_website` VALUES ('2', '1016', '购物', 'www.ssfdsfs.com', '2', '1', '1', '2', '2', '1222', '对方水电费', 'dfdsfsdf', '0', '2016-07-25 10:24:44', '2016-06-29 17:05:09');
INSERT INTO `cpsx_supply_dim_website` VALUES ('3', '1016', 'NBA官网', 'http://', '2', '2', '1', '2', '3', '1000000', '过得更好', '', '0', '2016-07-14 13:18:34', '2016-07-14 13:18:34');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1001', '1006', '网易', '163.com', '1', '1', '1', '2', '3', '232', '速度', '放松的方式', '1', '2016-07-13 14:08:10', '2016-07-13 14:08:10');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1002', '1006', '有道', 'youdao.com', '1', '1', '1', '3', '3', '23', 'gdfg ', 'sdfadfsaf', '1', '2016-06-16 16:21:31', '2016-06-16 16:21:31');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1003', '1016', '帮帮网', 'http://bangbang.com', '1', '1', '2', '3', '3', '2000', '帮助客户提供全面快捷的购物信息，购物咨询和推荐，团购，优惠等购物解决方案。', '电信备案大范甘迪发货的发货的发货的符合非结构化及客户给客户反馈好烦好烦好烦好dsgdsgvfsdfs低速复苏的vdgds', '0', '2016-07-29 15:16:59', '2016-06-23 17:44:14');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1004', '1024', 'B5M', 'http://www.b5m.com', '1', '1', '2', '3', '3', '1000000', 'b5m', '沪ICP备11034776号-3', '1', '2016-07-13 14:14:17', '2016-07-13 14:14:17');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1005', '1005', '百度', 'http://www.baidu.com', '2', '3', '1', '3', '3', '11', 'dadsad', 'fsdf', '0', '2016-07-25 10:24:46', '2016-07-01 16:03:40');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1006', '1016', 'csfsf', 'http://fef', '2', '2', '1', '1', '1', '134234', 'dsgsdg', 'SD敢达个', '0', '2016-07-21 15:31:18', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1007', '1016', 'fsdf', 'http://gdds', '2', '2', '1', '1', '1', '14234', 'dgsdg', 'gdgfd', '0', '2016-07-21 19:17:05', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1008', '1016', 'dgfdg', 'http://gfdg', '2', '2', '1', '3', '3', '1321334', 'dsfsdfs', 'dfdsf', '0', '2016-07-18 15:30:02', '2016-06-30 19:39:52');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1009', '1016', '返利网', 'http://fanli.com', '2', '1', '2', '1', '1', '1313', 'dsf', 'dsfdsf', '0', '2016-07-18 15:30:06', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1010', '1016', 'dsfds', 'http://dfdsf', '2', '1', '2', '1', '1', '12132', '4dfdgfd', 'dgfdg', '0', '2016-07-18 15:30:10', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1011', '1016', 'gfdgfd', 'http://gfdg', '2', '1', '2', '1', '1', '1313', 'dfdfds', 'gdfgfd', '0', '2016-06-30 20:25:10', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1012', '1002', 'superman', 'http://p.ytg', '1', '1', '1', '3', '3', '767', '77', '777', '1', '2016-07-06 15:09:30', '2016-07-06 15:09:30');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1013', '1002', 'admin', 'http://admin.com', '1', '3', '1', '1', '1', '3', '3', '3', '1', '2016-06-30 20:31:24', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1014', '1005', '谷歌', 'http://www.google.com', '2', '1', '2', '1', '1', '2', '2', '2', '1', '2016-07-01 16:03:26', '0000-00-00 00:00:00');
INSERT INTO `cpsx_supply_dim_website` VALUES ('1015', '1024', '帮我采', 'http://www.b5cai.com', '1', '1', '1', '3', '3', '10000', '顶顶顶顶', '弟弟顶顶顶顶顶', '0', '2016-07-06 14:07:37', '2016-07-06 14:07:37');

-- ----------------------------
-- Table structure for cpsx_supply_dim_website_activity_approval
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_supply_dim_website_activity_approval`;
CREATE TABLE `cpsx_supply_dim_website_activity_approval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supply_id` int(11) NOT NULL COMMENT '网站主ID',
  `website_id` int(11) NOT NULL COMMENT '站点ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `commission_rate` int(8) DEFAULT '1' COMMENT '佣金比例：1-80%；2-70%；3-60%;4-50%',
  `approval_status` smallint(6) NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='网站主_站点_活动关系表';

-- ----------------------------
-- Records of cpsx_supply_dim_website_activity_approval
-- ----------------------------
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('50', '1000', '1', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('51', '1000', '1', '1', '3', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('52', '1000', '1', '3', '3', '-1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('53', '1000', '1', '100', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('54', '1000', '2', '1', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('55', '1000', '2', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('56', '1024', '1004', '100', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('57', '1024', '1004', '3', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('58', '1016', '3', '1', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('59', '1024', '1004', '1', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('60', '1006', '1001', '1', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('61', '1016', '3', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('62', '1016', '3', '3', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('63', '1006', '1002', '1', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('64', '1006', '1002', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('65', '1016', '1003', '1', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('66', '1016', '1003', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('67', '1016', '3', '100', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('68', '1006', '1001', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('69', '1006', '1001', '3', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('70', '1006', '1001', '100', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('71', '1016', '2', '3', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('72', '1016', '2', '100', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('73', '1016', '1003', '3', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('74', '1016', '1010', '1', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('75', '1006', '1002', '3', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('76', '1016', '1009', '1', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('77', '1016', '1003', '100', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('78', '1016', '1007', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('79', '1016', '1007', '3', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('80', '1002', '1012', '1', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('81', '1002', '1012', '3', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('82', '1002', '1012', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('83', '1024', '1004', '2', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('84', '1006', '1002', '100', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('85', '1016', '1008', '1', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('86', '1006', '1002', '103', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('87', '1016', '1003', '103', '1', '1');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('88', '1005', '1005', '103', '1', '0');
INSERT INTO `cpsx_supply_dim_website_activity_approval` VALUES ('89', '1024', '1004', '103', '1', '0');

-- ----------------------------
-- Table structure for cpsx_sys_dim_operation_record
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_sys_dim_operation_record`;
CREATE TABLE `cpsx_sys_dim_operation_record` (
  `user_id` bigint(20) NOT NULL COMMENT 'user_id',
  `operate` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `target` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '表名',
  `message` text COLLATE utf8_unicode_ci COMMENT '内容',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `note` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='cpsx_sys_dim_user_base';

-- ----------------------------
-- Records of cpsx_sys_dim_operation_record
-- ----------------------------
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', '编辑', '站点', '编辑站点购物：www.b5m.com', '2016-07-06 15:02:43', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', '新增', '站点', '新增站点51wan:51wan.com', '2016-07-01 16:08:16', null);
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', '编辑', '站点', '编辑站点51wan:www.51wan.com', '2016-07-21 17:58:09', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'update', '站点', '更新站点购物:www.ssfdsfs.com', '2016-07-21 18:28:37', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '', '修改账户信息', '2016-07-21 19:12:15', 'cpsxUserMapper.updateUserAccount');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'update', '站点', '更新站点购物:www.ssfdsfs.com', '2016-07-21 19:16:44', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'update', '站点', '更新站点fsdf:http://gdds', '2016-07-21 19:17:05', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-22 18:35:41', 'settleMapper.updateApplyCheckState');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-22 18:36:31', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'update', '站点', '更新站点帮帮网:http://bangbang.com', '2016-07-25 10:24:05', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1005', 'update', '站点', '更新站点百度:http://www.baidu.com', '2016-07-25 10:24:13', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'update', '站点', '更新站点购物:www.ssfdsfs.com', '2016-07-25 10:24:44', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1005', 'update', '站点', '更新站点百度:http://www.baidu.com', '2016-07-25 10:24:46', 'websiteMapper.updateWebsite');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:20:25', 'settleMapper.updateApplyCheckState');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:20:48', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:40:15', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:41:06', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:41:42', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:44:35', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:47:02', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 14:50:21', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '结算申请', null, '2016-07-27 15:06:06', 'settleMapper.updateApplyingMoney');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'INSERT', '推广活动', '在站点1002推广活动103', '2016-07-28 10:43:31', 'earnerActivityMapper.insertOne');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1005', 'UPDATE', '', null, '2016-07-28 15:07:43', 'cpsxUserMapper.updateUserInfo');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'INSERT', '推广活动', '在站点1003推广活动103', '2016-07-28 15:08:57', 'earnerActivityMapper.insertOne');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'INSERT', '推广活动', '在站点1005推广活动103', '2016-07-28 15:09:27', 'earnerActivityMapper.insertOne');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '', null, '2016-07-28 15:17:33', 'cpsxUserMapper.updateUserInfo');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1005', 'INSERT', '推广活动', '在站点1004推广活动103', '2016-07-28 15:40:13', 'earnerActivityMapper.insertOne');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '', null, '2016-07-29 10:06:39', 'cpsxUserMapper.updateUserInfo');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '', null, '2016-07-29 10:08:15', 'cpsxUserMapper.updateUserInfo');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '', null, '2016-07-29 10:09:03', 'cpsxUserMapper.updateUserInfo');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '', null, '2016-07-29 10:09:21', 'cpsxUserMapper.updateUserInfo');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'UPDATE', '', null, '2016-07-29 10:10:08', 'cpsxUserMapper.updateUserInfo');
INSERT INTO `cpsx_sys_dim_operation_record` VALUES ('1016', 'update', '站点', '更新站点帮帮网:http://bangbang.com', '2016-07-29 15:16:59', 'websiteMapper.updateWebsite');

-- ----------------------------
-- Table structure for cpsx_sys_dim_resource
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_sys_dim_resource`;
CREATE TABLE `cpsx_sys_dim_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(128) NOT NULL COMMENT '访问路径',
  `name` varchar(64) DEFAULT NULL,
  `eng_name` varchar(64) DEFAULT NULL COMMENT '语言切换',
  `posorder` smallint(4) NOT NULL COMMENT '节点顺序',
  `parent_id` int(10) NOT NULL COMMENT '父资源Id',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `cls_name` varchar(64) DEFAULT NULL COMMENT '图标名',
  `is_menu` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_sys_dim_resource
-- ----------------------------
INSERT INTO `cpsx_sys_dim_resource` VALUES ('1', 'javascript:void(0);', 'CPS跳转', 'CPS Exchange', '2', '0', null, '2016-07-08 17:51:13', 'icon-link', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('2', '/cps/act/urlaccountById.do', 'URL账户', 'URL Account', '2', '1', null, '2016-07-13 11:25:46', 'se7en-star', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('3', 'javascript:void(0);', '后台管理', 'Administration', '10', '0', null, '2016-07-08 18:17:09', 'icon-cogs', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('4', 'javascript:void(0);', '网站主管理', 'Website', '4', '0', null, '2016-07-08 18:21:15', 'icon-credit-card', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('5', '/admin/role/roleResourceView.do', '资源管理', 'Resource', '1', '3', null, '2016-06-16 20:39:34', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('6', '/admin/role/listRole.do', '角色管理', 'Role', '4', '3', null, '2016-06-16 20:39:31', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('7', '/admin/role/addRoleView.do', '新增角色', 'New Role', '5', '3', null, '2016-06-16 20:39:29', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('8', '/admin/toAccountMrg.do', '用户管理', 'User', '6', '3', null, '2016-06-16 20:39:41', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('9', '/cps/pattern/exchangePattern.do', 'CPS规则', 'CPS Rule', '2', '1', null, '2016-06-16 20:07:11', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('10', '/cps/rule/activityrule.do', 'CPS活动规则', 'Activity Rule', '3', '1', null, '2016-06-17 11:00:15', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('11', 'javascript:void(0);', '广告主管理', 'Advertiser Management', '3', '0', null, '2016-07-08 17:38:29', 'icon-adn', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('12', '/banx/cat/category', '活动类型', 'Activity Category', '1', '11', null, '2016-07-07 14:59:55', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('13', '/banx/act/basic-activity', '基本活动', 'Basic Activity', '3', '11', null, '2016-06-28 11:05:54', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('14', '/banx/clearing/cycle', '结算周期', 'Clearing Cycle', '2', '11', null, '2016-06-28 11:06:06', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('15', '/banx/comm/commission', '佣金管理', 'Commission Control', '4', '11', null, '2016-06-28 11:06:15', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('16', '/banx/noti/notification', '广告主通知', 'Notification', '5', '11', null, '2016-06-28 11:06:25', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('17', '/web/site/sitelist.do', '站点管理', 'Website List', '1', '4', null, '2016-06-17 11:01:01', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('18', '/banx/activity/detailed-activity', '详细活动', 'Detailed Activity', '6', '11', null, '2016-06-28 11:06:40', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('19', '/web/cat/siteCategory.do', '网站分类', 'Website Category', '2', '4', null, '2016-07-13 13:57:23', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('20', 'javascript:void(0);', '推广产品', 'Promote Products', '5', '0', null, '2016-07-08 17:36:20', 'icon-bullhorn', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('21', '/earner/act/activity', '活动列表', 'Activity List', '1', '20', null, '2016-06-15 13:07:31', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('22', '/web/check/validateWebsite.do', '站点审核', 'Website Validation', '4', '4', null, '2016-07-13 13:57:32', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('23', 'javascript:void(0);', '数据报表', 'Data Report', '1', '0', null, '2016-07-08 18:16:36', 'icon-bar-chart', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('24', '/report/statistic/output.do', '业绩统计', 'Output Statistic', '1', '23', null, '2016-07-13 11:22:31', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('25', '/earner/app/approval', '活动审核', 'Activity Approval', '2', '20', null, '2016-06-20 15:12:43', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('26', '/report/detail/detail.do', '业绩明细', 'Output Detail', '2', '23', null, '2016-07-13 13:07:16', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('27', '/cpsx/home.do', '首页', 'Home', '0', '0', null, '2016-07-08 17:52:13', 'icon-home', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('28', 'javascript:void(0);', '结算佣金', 'Settle Commission', '1', '0', null, '2016-07-08 18:03:00', 'icon-dollar', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('29', '/settle/apply/commission', '申请佣金', 'apply commission', '1', '28', null, '2016-07-12 18:19:25', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('30', '/banx/cat/category/*', '活动类型restful', '', '1', '12', null, '2016-07-07 15:56:44', '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('31', '/banx/act/basic-activity/*', '基本活动restful', '', '3', '13', null, null, '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('32', '/banx/clearing/cycle/*', '结算周期restful', '', '2', '14', null, null, '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('33', '/banx/comm/commission/*', '佣金管理restful', '', '4', '15', null, null, '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('34', '/banx/noti/notification/*', '广告主通知restful', '', '5', '16', null, null, '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('35', '/banx/activity/detailed-activity/*', '详细活动restful', '', '6', '18', null, null, '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('36', '/earner/act/activity/*', '活动列表restful', '', '1', '21', null, null, '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('37', '/earner/app/approval/*', '活动审核restful', '', '2', '25', null, null, '', 'n');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('38', '/settle/pay/payCommission', '财务付款', 'Pay Commission', '3', '28', null, '2016-07-20 16:21:12', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('39', '/settle/bi/commission', '数据审核', 'Data Confirm', '2', '28', null, '2016-07-20 16:20:54', '', 'y');
INSERT INTO `cpsx_sys_dim_resource` VALUES ('40', '/settle/data/view', '上传结算数据', 'Upload Data', '4', '28', null, '2016-07-22 18:49:25', '4', 'y');

-- ----------------------------
-- Table structure for cpsx_sys_dim_role
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_sys_dim_role`;
CREATE TABLE `cpsx_sys_dim_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(64) NOT NULL,
  `remark` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_sys_dim_role
-- ----------------------------
INSERT INTO `cpsx_sys_dim_role` VALUES ('1', 'admin', '管理员', null, null);
INSERT INTO `cpsx_sys_dim_role` VALUES ('2', 'Run&Support', '运营', null, null);
INSERT INTO `cpsx_sys_dim_role` VALUES ('3', 'Site Master', '网站主', null, '2016-06-15 14:37:34');
INSERT INTO `cpsx_sys_dim_role` VALUES ('4', 'Advertiser', '广告主', null, null);
INSERT INTO `cpsx_sys_dim_role` VALUES ('5', 'tiankong', '广告主', null, '2016-07-28 15:26:50');

-- ----------------------------
-- Table structure for cpsx_sys_dim_user
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_sys_dim_user`;
CREATE TABLE `cpsx_sys_dim_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `user_type` smallint(6) NOT NULL COMMENT '用户类型(1：网站主，2：广告主，3：管理员，4：运营，5：客户经理)',
  `real_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '真实名称',
  `account_type` smallint(6) NOT NULL COMMENT '账户类型(1：公司、2：个人)',
  `mob_tel` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '联系手机',
  `fix_tel` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '固定电话',
  `qq` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'QQ',
  `address` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '通讯地址',
  `zip_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '邮编',
  `introduction` text CHARACTER SET utf8 COLLATE utf8_unicode_ci COMMENT '简介',
  `status` smallint(6) NOT NULL COMMENT '状态(是否有效，0：无效、1：有效)',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1047 DEFAULT CHARSET=utf8 COMMENT='cpsx_sys_dim_user';

-- ----------------------------
-- Records of cpsx_sys_dim_user
-- ----------------------------
INSERT INTO `cpsx_sys_dim_user` VALUES ('1000', 'ft', 'ss@126.com', '512d241356a3e670846688cd01687fe1', '1', 'fdfsf', '1', '12345678901', '35325325', '2222222', 'earthrquarker', '222222', '', '1', '2016-06-06 20:36:01', '2016-07-13 13:59:05');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1001', 'xxs', 'xxs@111.com', 'f441c0bd4dd87dac1213cc18ea6956e1', '2', 'dsd', '2', '132142894', '4235235', '253325', '到宿舍v', '222222', '', '1', '2016-06-08 19:56:28', '2016-07-19 11:29:37');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1002', 'feitian', 'feitian@b5m.com', '9cf31e129e336169679256839a07e02e', '0', 'feitian', '1', '18966666668', '15165416', '5145212', '', '', '', '1', '2016-06-12 10:07:39', '2016-06-30 15:36:56');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1003', 'yuanzi', 'yuanzi@b5m.com', 'a8574744ecc557779d455c634ecc4b01', '0', 'yuanzi', '1', '', '', '', '', '', '', '1', '2016-06-12 10:08:13', '2016-06-30 15:40:08');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1004', 'qizheng', 'qizheng@b5m.com', '262d13b2601eaeaae8386a60fece5973', '0', 'qizheng', '2', '', '', '', '', '', '', '1', '2016-06-12 15:02:12', '2016-06-30 15:40:31');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1005', 'ali', 'ali@b5m.com', '7ef4aa9b21022b67bdcbe5a069eb006e', '1', 'ali', '1', '', '', '', '', '', '', '1', '2016-06-12 15:02:43', '2016-07-28 15:17:33');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1006', 'site', 'site@b5m.com', '67ec041d41b8ce6eb08231a532597327', '2', 'Site', '1', '', '', '', '', '', '', '1', '2016-06-15 14:39:27', '2016-07-29 10:09:03');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1008', 'sm', 'sm@b5m.com', '745293642fe6c4ef97491ca23b77eccd', '2', 'sm', '1', '1231243214', '', '', '', '242456', '', '1', '2016-06-21 19:07:45', '2016-07-29 10:09:21');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1009', 'testrole', 'testrole@b5m.com', '9828c23dcaf9c9fdf376a6f21a5ba0e5', '0', 'testrole', '1', 'testrole', 'testrole', '', 'testrole', '', '', '1', '2016-06-22 15:28:03', '2016-06-28 13:44:55');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1016', 'xusheng', 'xusheng@b5m.com', 'dbe5bd16f2d4a316dcdde1ef51da1dae', '3', 'xusheng', '2', '1898989898', 'dsgdsgdsg', '46334637', 'FFFFFFFFFFF', '123456', '', '1', '2016-06-23 16:00:20', '2016-07-21 19:12:15');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1024', 'zhenyuanzi', 'zhenyuanzi@b5m.com', 'c827ccf95be7139476f395db7e1c0450', '0', 'zhenyuanzi', '1', '15111111111', '', '', '', '', '', '1', '2016-06-27 17:45:33', '2016-06-30 15:41:54');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1026', '11111', '11@11.com', '2b59525ffe581eda9f11c51dec18a0f6', '0', '11111', '2', '11111111', '', '', '', '', '', '1', '2016-06-29 17:15:59', '2016-06-30 15:42:16');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1027', '11111111', '11@111.com', '2b11762fdaa56aa6e36f7f2207e6d46c', '0', '11111', '1', '11111111', '11', '11', '11', '', '', '1', '2016-06-29 17:32:00', '2016-06-30 20:04:47');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1036', 'test2', '22@22.com', 'bafe01851a230ce5bbe58772409a3542', '0', '02121201', '2', '000000000000', '', '', '', '', '', '1', '2016-07-01 09:34:44', '2016-07-01 09:34:44');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1037', 'test3', '33@33.com', 'fb44d167a4889ce3165022fa6fcf0749', '0', '11111', '1', '11111111', '', '', '', '', '', '1', '2016-07-01 09:37:47', '2016-07-01 09:37:47');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1038', 'test4', '222@22.com', '2c20ade84537a8ceb40546b8850aff10', '0', '11111', '2', '11111111', '', '', '', '', '', '1', '2016-07-01 09:38:41', '2016-07-01 09:38:41');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1039', 'test5', '222@222.com', '19aad2a0f84839dee5c1405b71f291f6', '0', '122222', '2', '22222222', '', '', '', '', '', '0', '2016-07-01 09:39:56', '2016-07-01 10:22:17');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1040', '44444', '44@44.com', 'ded1834176e488fa3e7d19618d204db9', '0', '44444', '2', '44444444', '', '', '', '', '', '0', '2016-07-01 10:18:59', '2016-07-01 10:22:13');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1041', '55555', '55@55.com', '40780229a03b7963a420e3c7349e8c93', '0', '55555', '2', '55555555', '', '', '', '', '', '0', '2016-07-01 10:19:49', '2016-07-01 10:22:08');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1045', 'weiyang', 'weiyang@b5m.com', 'c98e2b208e6036eae89c80392eacdee5', '0', 'weiyang', '2', '12345678912', '', '', '', '', '', '1', '2016-07-01 11:07:13', '2016-07-01 11:07:13');
INSERT INTO `cpsx_sys_dim_user` VALUES ('1046', '天王', 'tianwang@b5m.com', '01bfb9b0a2ae9613ea1423ec27b6de36', '0', '天王', '1', '', '', '', '', '', '', '1', '2016-07-05 10:02:24', '2016-07-05 10:02:24');

-- ----------------------------
-- Table structure for cpsx_sys_map_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_sys_map_role_resource`;
CREATE TABLE `cpsx_sys_map_role_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `resource_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=695 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_sys_map_role_resource
-- ----------------------------
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('255', '2', '20', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('256', '2', '25', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('282', '3', '4', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('283', '3', '17', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('284', '3', '20', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('285', '3', '21', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('286', '3', '23', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('287', '3', '24', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('288', '3', '26', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('602', '4', '11', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('603', '4', '12', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('604', '4', '30', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('605', '4', '13', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('606', '4', '31', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('607', '4', '14', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('608', '4', '32', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('609', '4', '15', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('610', '4', '33', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('611', '4', '16', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('612', '4', '34', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('613', '4', '18', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('614', '4', '35', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('615', '4', '27', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('654', '1', '1', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('655', '1', '2', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('656', '1', '9', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('657', '1', '10', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('658', '1', '3', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('659', '1', '5', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('660', '1', '6', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('661', '1', '7', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('662', '1', '8', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('663', '1', '4', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('664', '1', '17', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('665', '1', '19', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('666', '1', '22', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('667', '1', '11', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('668', '1', '12', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('669', '1', '30', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('670', '1', '13', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('671', '1', '31', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('672', '1', '14', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('673', '1', '32', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('674', '1', '15', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('675', '1', '33', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('676', '1', '16', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('677', '1', '34', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('678', '1', '18', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('679', '1', '35', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('680', '1', '20', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('681', '1', '21', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('682', '1', '36', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('683', '1', '25', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('684', '1', '37', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('685', '1', '23', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('686', '1', '24', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('687', '1', '26', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('688', '1', '28', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('689', '1', '29', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('690', '1', '38', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('691', '1', '39', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('692', '1', '40', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('693', '0', '1', null, null, null);
INSERT INTO `cpsx_sys_map_role_resource` VALUES ('694', '5', '1', null, null, null);

-- ----------------------------
-- Table structure for cpsx_sys_map_user_role
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_sys_map_user_role`;
CREATE TABLE `cpsx_sys_map_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpsx_sys_map_user_role
-- ----------------------------
INSERT INTO `cpsx_sys_map_user_role` VALUES ('3', '1002', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('4', '1003', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('5', '1004', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('8', '1009', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('9', '1009', '2', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('10', '1012', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('11', '1013', '0', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('12', '1014', '0', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('13', '1015', '1', null, '2016-06-22 18:31:35');
INSERT INTO `cpsx_sys_map_user_role` VALUES ('15', '1017', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('16', '1018', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('17', '1019', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('18', '1020', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('19', '1021', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('20', '1022', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('21', '1023', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('22', '1024', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('23', '1025', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('24', '1026', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('25', '1027', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('26', '1028', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('27', '1029', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('34', '1030', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('35', '1031', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('36', '1032', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('37', '1033', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('38', '1034', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('39', '1035', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('40', '1036', '4', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('41', '1037', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('42', '1038', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('44', '1016', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('47', '1042', '4', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('48', '1043', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('49', '1044', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('50', '1045', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('51', '1046', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('53', '1000', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('55', '1001', '4', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('57', '1005', '1', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('60', '1006', '3', null, null);
INSERT INTO `cpsx_sys_map_user_role` VALUES ('62', '1008', '4', null, null);

-- ----------------------------
-- Table structure for cpsx_url_exchange_account
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_url_exchange_account`;
CREATE TABLE `cpsx_url_exchange_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pattern_id` int(11) DEFAULT NULL COMMENT '跳转规则id',
  `account_info` text COLLATE utf8_unicode_ci COMMENT '跳转账号信息(json格式数据)',
  `union_account` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟账号',
  `user_id` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟用户id',
  `host` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '关联域名',
  `is_enable` tinyint(1) DEFAULT NULL COMMENT '是否有效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'create_time',
  `create_by` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'create_by',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'update_time',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_11` (`pattern_id`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`pattern_id`) REFERENCES `cpsx_url_exchange_pattern` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='cpsx_url_exchange_account';

-- ----------------------------
-- Records of cpsx_url_exchange_account
-- ----------------------------
INSERT INTO `cpsx_url_exchange_account` VALUES ('3', '1', '{\"title_b\":\"sdsf\",\"title_a\":\"多阿米\"}', 'zzg', '45345', 'meituan.com', '1', '2016-07-13 19:11:10', 'ft', '2016-07-13 19:11:10');
INSERT INTO `cpsx_url_exchange_account` VALUES ('4', '1', '{\"title_b\":\"sdsf\",\"title_a\":\"gfc\"}', 'fdfdsf', '12', 'b5m.com', '1', '2016-07-18 14:11:36', 'ft', '2016-07-18 14:11:36');
INSERT INTO `cpsx_url_exchange_account` VALUES ('5', '1', '{\"title_b\":\"32\",\"title_a\":\"ytuj\"}', 'scds', '3342', 'jumei.com', '1', '2016-06-13 20:31:16', 'ft', '2016-06-13 20:31:16');
INSERT INTO `cpsx_url_exchange_account` VALUES ('6', '1', '{\"title_b\":\"23\",\"title_a\":\"yiqifa\"}', 'cd', '13', 'baiud.com', '1', '2016-06-13 20:31:26', 'ft', '2016-06-13 20:31:26');
INSERT INTO `cpsx_url_exchange_account` VALUES ('7', '7', '{\"feedback\":\"\",\"to\":\"\",\"sid\":\"777\",\"wid\":\"655\"}', '777', 'b5mapp', 'gome.com.cn', '1', '2016-06-16 18:18:51', 'yuanzi', '2016-06-16 18:18:51');
INSERT INTO `cpsx_url_exchange_account` VALUES ('8', '1', '{\"title_b\":\"fds\",\"title_a\":\"f\"}', 'fd', '1', 'fd', '1', '2016-07-01 18:53:05', 'xusheng', '0000-00-00 00:00:00');
INSERT INTO `cpsx_url_exchange_account` VALUES ('9', '1', '{\"title_b\":\"dsf\",\"title_a\":\"sf\"}', '46h', '356', 'gdg.com', '1', '2016-07-12 13:52:37', 'xusheng', '0000-00-00 00:00:00');
INSERT INTO `cpsx_url_exchange_account` VALUES ('10', '11', '{\"utm_medium1\":\"cps\",\"utm_campaign\":\"da\",\"utm_source1\":\"b5m.cn\"}', 'b5m.cn', 'b5m.cn', 'ssg.com', '1', '2016-07-28 10:42:36', 'xusheng', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for cpsx_url_exchange_activity_rule
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_url_exchange_activity_rule`;
CREATE TABLE `cpsx_url_exchange_activity_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动id',
  `account_id` int(11) DEFAULT NULL COMMENT '跳转规则id',
  `note` text COLLATE utf8_unicode_ci COMMENT '规则描述',
  `start_id` smallint(6) DEFAULT NULL COMMENT '开始(默认0)',
  `end_id` smallint(6) DEFAULT NULL COMMENT '结束(默认100)',
  `is_enable` tinyint(1) DEFAULT NULL COMMENT '是否有效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'create_time',
  `create_by` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'create_by',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'update_time',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_12` (`account_id`),
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`account_id`) REFERENCES `cpsx_url_exchange_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='cpsx_url_exchange_activity_rule';

-- ----------------------------
-- Records of cpsx_url_exchange_activity_rule
-- ----------------------------
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('1', '100', '5', '国美联盟', '0', '100', '1', '2016-07-28 17:57:53', null, '2016-07-28 17:57:53');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('2', '2', '4', '描述规则', '0', '100', '1', '2016-07-27 18:38:41', null, '2016-07-27 18:38:41');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('7', '1', '3', '规则多描述', '0', '100', '1', '2016-07-27 18:38:28', 'ft', '2016-07-27 18:38:28');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('8', '2', '4', '23', '0', '100', '1', '2016-07-27 18:38:55', 'ft', '2016-07-27 18:38:55');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('9', '123', '3', 'dsf', '0', '100', '1', '2016-06-16 11:26:13', 'ft', '0000-00-00 00:00:00');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('10', '1', '3', 'hfg', '0', '100', '1', '2016-06-30 10:07:09', 'ft', '2016-06-30 10:07:09');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('11', '100', '4', '6gdfg', '0', '100', '1', '2016-07-28 17:57:17', 'ft', '2016-07-28 17:57:17');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('12', '100', '5', '成果联盟', '0', '100', '1', '2016-06-22 15:41:39', 'ft', '0000-00-00 00:00:00');
INSERT INTO `cpsx_url_exchange_activity_rule` VALUES ('13', '103', '10', 'http://cn.ssg.com?utm_source=b5m.cn&utm_medium=cps&utm_campaign=da', '0', '100', '1', '2016-07-28 15:06:30', 'xusheng', '2016-07-28 15:06:30');

-- ----------------------------
-- Table structure for cpsx_url_exchange_pattern
-- ----------------------------
DROP TABLE IF EXISTS `cpsx_url_exchange_pattern`;
CREATE TABLE `cpsx_url_exchange_pattern` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `union_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟名称',
  `union_type` smallint(6) DEFAULT NULL COMMENT '联盟类型(自营、第三方联盟)',
  `handle_type` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'url处理类型(PDSI)',
  `click_type` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '点击结算类型(CPS、CPC、CPA)',
  `url_pattern_note` text COLLATE utf8_unicode_ci COMMENT '跳转规则说明',
  `url_pattern_addr` text COLLATE utf8_unicode_ci COMMENT '跳转规则地址',
  `url_param_fb` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '反馈标签字段',
  `url_param_to` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '目的地址字段',
  `url_param_ac` char(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟账号字段',
  `is_url_to_encode` tinyint(1) DEFAULT NULL COMMENT '是否encode',
  `url_account_pattern` text COLLATE utf8_unicode_ci COMMENT '链接账号规则',
  `is_enable` tinyint(1) DEFAULT NULL COMMENT '是否有效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'create_time',
  `create_by` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'create_by',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'update_time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='cpsx_url_exchange_pattern';

-- ----------------------------
-- Records of cpsx_url_exchange_pattern
-- ----------------------------
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('1', '测试联盟', '2', '1', '1', '{\"title_a\":\"标题a\",\"title_b\":\"标题b\"}', '并发布广告覆盖个反反复复吩咐嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎 嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎', 'ce', '1', 'xiayize', '1', '{\"title_a\":\"标题a\",\"title_b\":\"标题b\"}', '1', '2016-07-29 15:24:04', null, '2016-07-29 15:24:04');
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('2', '英雄联盟', '1', '1', '2', '{\"sa\":\"文艺\",\"sb\":\"武艺\"}', 'fsf', 'sdg', 'fdsf', 'fsdf', '0', '{\"sa\":\"文艺\",\"sb\":\"武艺\"}', '1', '2016-06-14 10:04:17', null, '2016-06-14 10:04:17');
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('3', 'sdsa', '1', '3', '1', '{\"ta\":\"是的\",\"tb\":\"不是\"}', 'fsdf', 'fd', 'f', 'df', '1', '{\"ta\":\"是的\",\"tb\":\"不是\"}', '1', '2016-08-05 16:17:32', null, '2016-08-05 16:17:32');
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('7', '四方很舒服', '1', '2', '1', 'http://cps.gome.com.cn/home/JoinUnion?sid=777&amp;wid=655&amp;feedback=反馈标记&amp;to=目的地址', 'http://cps.gome.com.cn/home/JoinUnion?sid=%s&amp;wid=%s&amp;feedback=%s&amp;to=%s', 'feedback', 'to', 'wid', '1', '{\"sid\":\"sid\",\"wid\":\"wid\",\"feedback\":\"feedback\",\"to\":\"to\"}', '1', '2016-07-29 15:30:09', null, '2016-07-29 15:30:09');
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('8', '广告连', '1', '1', '1', '1', '1', '2', '1', '454', '1', '{\"fsdf\":\"fsfg\"}', '1', '2016-07-28 18:02:49', null, '2016-07-28 18:02:49');
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('9', 'fsfd', '1', '3', '2', '1', '1', '1', '1', '1', '1', '{\"fdg\":\"gfd\"}', '1', '2016-07-01 10:04:52', null, '0000-00-00 00:00:00');
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('10', 'fgd', '2', '1', '1', 'dg', 'fg', 'fgf', 'fdg', 'fdg', '1', '{\"fdf\":\"trt\",\"dg\":\"gfg\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\",\"gr\":\"reh\"}', '1', '2016-07-29 15:24:58', null, '2016-07-29 15:24:58');
INSERT INTO `cpsx_url_exchange_pattern` VALUES ('11', '韩国新世界', '1', '2', '1', 'http://cn.ssg.com?utm_source=%s&utm_medium=%s&utm_campaign=%s', 'utm_source=%s&utm_medium=%s&utm_campaign=%s', '', '', '', '0', '{\"utm_source1\":\"utm_source\",\"utm_medium1\":\"utm_medium\",\"utm_campaign\":\"utm_campaign\"}', '1', '2016-08-03 15:56:26', null, '2016-07-29 15:22:13');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `class` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES ('1', '刘一', '98', '3班');
INSERT INTO `test` VALUES ('2', '赵四', '88', '1班');
INSERT INTO `test` VALUES ('3', '王五', '89', '1班');
INSERT INTO `test` VALUES ('4', '吴三', '90', '3班');
INSERT INTO `test` VALUES ('5', '李四', '66', '1班');
INSERT INTO `test` VALUES ('6', '酒泉', '78', '3班');
INSERT INTO `test` VALUES ('7', '方式', '92', '1班');
INSERT INTO `test` VALUES ('8', '寒冰', '75', '3班');
