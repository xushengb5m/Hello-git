package com.b5m.cpsx.commons.constant;


/**
 * 缓存常量
 * @author lscm
 *
 */
public final class CacheConstant {

	//CPSX 菜单
	public static final String CPSX_MENU = "cpsx_menu";

	public static final String CPSX_MENU_TOP = "cpsx_menu_top";
	
	//用户登录前缀码
	public static final String USER_PREFIX = "cpsx_user_prefix_";
	
	public static final String RBAC_ROLE = "cpsx_rbac_role_";
	
	//导航管理前缀码
	public static final String CPSX_NAVI_DOMAIN = "oms_lv1_daohang_config_";
	
	//导航管理的Map
	public static final String CPSX_NAVI_MAP = "dmo_navi_map";
	private CacheConstant() {
	}
	
	public static String CACHENAME = "redis";

}
