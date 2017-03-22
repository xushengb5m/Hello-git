package com.b5m.cpsx.commons.constant;

/**
 * 常量定义
 * 
 * @author johnson
 * 
 */
public class CpsxConstants {
	
	/**
	 * 帐号管理
	 */
	public static final int ADMIN_ROLE_ID = 1;
	/**
	 * 运营人员
	 */
	public static final int SUPPORT_ROLE_ID = 2;
	/**
	 * 网站主
	 */
	public static final int SITER_ROLE_ID = 3;
	/**
	 *  广告主
	 */
	public static final int ADVER_ROLE_ID = 4;
	/**
	 * 默认分页大小
	 */
	public static final int PAGE_SIZE = 10;

	/** 用户类型 **/
	public static final int USER_TYPE_SALER = 1;// 销售

	public static final int USER_TYPE_ADMIN = 2;// 管理员

	public static final int USER_TYPE_AD_OWNER = 3;// 广告主

	public static final int USER_TYPE_SITE_OWNER = 4;// 广告媒体

	public static final int USER_TYPE_SITE_MANAGER = 5;// 媒介
	/*********/

	public static final int TIME_S_TYPE = 301;
	public static final int FLOW_S_TYPE = 302;
	public static final int CITY_STRATEGY_ID = 4;
	public static final int CLICK_TIMES_STRATEGY_ID = 5;
	public static final long AD_TIME_OUT_LINE_STATUS = 1;
	public static final long AD_FLOW_OUT_LINE_STATUS = 2;
	public static final long AD_ON_LINE_STATUS = 0;
	public static final long AD_DELETE_STATUS = 99;
	
	//线上
	//public static final String MongDBIP = "mongodb://10.30.105.150:5586";
	//public static final String MONGODB_IP = "mongodb://10.30.105.150:5586";
	
	//测试
	public static final String MONGODB_IP = "mongodb://172.16.11.15";
	
	public static final String MONGODB_REDIS_KEY = "dmp_data_from_MongDB_adID";
	
	public static final String REDIS_TODAY_KEY = "dmp_today";
	
	public static final String DMP_LAST_SELECT_URL = "dmp_last_select_url_";
	
}
