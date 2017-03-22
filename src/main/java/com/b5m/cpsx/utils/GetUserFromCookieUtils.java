/**   
 * @Title: GetUserFromCookieUtils.java 
 * @Package com.b5m.dmp.utils 
 * @Description: TODO
 * @author feitian   
 * @date 2015年10月14日 下午4:52:15 
 * @version V1.0   
 */
package com.b5m.cpsx.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.b5m.cpsx.commons.constant.CacheConstant;
import com.b5m.cpsx.commons.constant.CookieKeyConstant;
import com.b5m.cpsx.model.User;

/**
 * @ClassName: GetUserFromCookieUtils
 * @Description: 工具类查找user
 * @author feitian
 * @date 2015年10月14日 下午4:52:15
 * 
 */
public class GetUserFromCookieUtils {

	/** 
	 * @Title: getUser 
	 * @Description: TODO
	 * @param @param request
	 * @param @return
	 * @return User
	 * @throws 
	 */
	public static User getUser(HttpServletRequest request) {
		User user = null;
		return user==null?new User():user;
	}

}
