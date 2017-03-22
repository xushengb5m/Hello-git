package com.b5m.cpsx.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

/**
 * @author janwen Apr 10, 2013 12:16:50 PM
 * 
 */
public class WebCookieComponent {

	private static final String defaultDomainName = ".b5m.com";

	/**
	 * 
	 @author janwen
	 * @param key
	 * @param value
	 * @param expirtime
	 *            in seconds
	 * @param domainName
	 *            default:sell.b5m.com
	 * @return
	 */
	public static Cookie createCookie(String key, String value, int expirtime,
			String domainName) {
		if (StringUtils.isNotBlank(key) && StringUtils.isNotBlank(value)) {
			Cookie cookie = new Cookie(key, value);
			cookie.setMaxAge(expirtime);
			cookie.setPath("/");
			domainName = StringUtils.isBlank(domainName) ? defaultDomainName
					: domainName;
			// cookie.setDomain(domainName);

			return cookie;
		} else {
			return null;
		}
	}

	/**
	 * 
	 @author janwen
	 * @param key
	 * @param value
	 * @param expirtime
	 *            in seconds
	 * @return
	 */
	public static Cookie createCookie(String key, String value, int expirtime) {
		if (StringUtils.isNotBlank(key) && StringUtils.isNotBlank(value)) {
			Cookie cookie = new Cookie(key, value);
			cookie.setMaxAge(expirtime);
			cookie.setPath("/");
			return cookie;
		}
		return null;
	}

	/**
	 * 
	 @author janwen
	 * @param key
	 * @param request 
	 * @return 当前对应key的cookie
	 */
	public static Cookie getCookie(String key, HttpServletRequest request) {
		if (StringUtils.isNotBlank(key)) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (key.equals(cookie.getName())) {
						return cookie;
					}
				}
			}

		}
		return null;
	}

	/**
	 * 
	 @author janwen
	 * @param key
	 * @param request
	 * @return
	 */
	public static Cookie removeCookie(String key, HttpServletRequest request) {
		if (StringUtils.isNotBlank(key)) {
			Cookie[] cookies = request.getCookies();
			for (Cookie cookie : cookies) {
				if (key.equals(cookie.getName())) {
					cookie.setMaxAge(-1);
					cookie.setValue("");
					cookie.setPath("/");
					// cookie.setDomain(defaultDomainName);
					return cookie;
				}
			}
		}
		return null;
	}

	/**
	 * 
	 @author janwen
	 * @param key
	 * @return
	 */
	public static Cookie removeCookie(String key) {
		if (StringUtils.isNotBlank(key)) {
			Cookie cookie = new Cookie(key, "");
			cookie.setMaxAge(-1);
			cookie.setPath("/");
			return cookie;
		} else {
			return null;
		}
	}
	/**
	 * 
	 * @param request
	 * @return
	 */
	public static Cookie[] getAllCookie(HttpServletRequest request) {
		return request.getCookies();
	}

}
