package com.b5m.cpsx.interceptors;

import java.net.URLEncoder;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.b5m.cpsx.commons.constant.CacheConstant;
import com.b5m.cpsx.commons.constant.CookieKeyConstant;
import com.b5m.cpsx.commons.constant.HttpAttributeKey;
import com.b5m.cpsx.model.Resource;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.service.cache.CacheMapService;
import com.b5m.cpsx.service.login.InitService;
import com.b5m.cpsx.utils.WebCookieComponent;

/**
 * @author janwen Apr 16, 2013 10:04:41 AM
 * 
 */
public class LoginInterceptor extends HandlerInterceptorAdapter implements ServletContextAware {
	
	private List<String> path;
	
	private ServletContext sc;
	
	@Autowired
	private InitService initDmpService;
	
	@Autowired
	private CacheMapService cacheMapService;

	/**
	 * @return the path
	 */
	public List<String> getPath() {
		return path;
	}

	/**
	 * @param path
	 *            the path to set
	 */
	public void setPath(List<String> path) {
		this.path = path;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cpc.interceptors.CPCBaseInterceptor#preHandle(javax.servlet.http
	 * .HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String requestUri = request.getRequestURI();
		// if (HttpRequestUtils.filterPath(path, request)) {
		Cookie c = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER, request);
		if (c != null) {
			Object cUserObject = cacheMapService.getCache(CacheConstant.USER_PREFIX + c.getValue());
			if (cUserObject != null && cUserObject instanceof User) {
				User cUser = (User) cUserObject;
				if (cUser != null) {
					String last_logincookie = (String) cacheMapService
							.getCache(CacheConstant.USER_PREFIX + cUser.getId());
					if (StringUtils.isNotBlank(last_logincookie)
							&& StringUtils.equals(last_logincookie,
									c.getValue())) {
						request.setAttribute(HttpAttributeKey.CPSX_USER_INFO,
								cUser);
						String uri[] = requestUri.split("/");
						if (uri != null && uri.length != 0) {
							String temp = uri[uri.length - 1];
							String tapName = "";
							if (temp.indexOf(".") != -1) {
								tapName = temp.substring(0, temp.indexOf("."));
							}

							Map<String, String> tapMap = new HashMap<String, String>();
							tapMap.put(tapName, "class=\"cur\"");

							request.setAttribute("tapMap", tapMap);
						}
						boolean ra = baseRedisService.expire(CacheConstant.USER_PREFIX + c.getValue(), 30*60);
						boolean rb = baseRedisService.expire(CacheConstant.USER_PREFIX + cUser.getId(),30*60);
						if (sc.getAttribute(CacheConstant.CPSX_MENU) == null
								|| sc.getAttribute(CacheConstant.CPSX_MENU_TOP) == null) {
							initDmpService.loadMenu(cUser.getRoleIds());
						}

						// menu hover status keeper
						@SuppressWarnings("unchecked")
						Map<String, List<Resource>> menus = (Map<String, List<Resource>>) sc
								.getAttribute(CacheConstant.CPSX_MENU+ cUser.getRoleIds());

						request.setAttribute(CacheConstant.CPSX_MENU, menus);

						String reqUrl = request.getRequestURI();

						String reqUrlNoparam = StringUtils.substring(reqUrl, 0,
								reqUrl.indexOf(".do") + 3);

						Collection<List<Resource>> coll = menus.values();
						List<Resource> rows = new LinkedList<Resource>();
						for (Iterator<List<Resource>> iter = coll.iterator(); iter
								.hasNext();) {
							rows.addAll(iter.next());
						}

						/*for (Resource url : rows) {
							String resourceUrl = url.getResourceUrl();
							if (resourceUrl.startsWith(reqUrlNoparam)) {
								request.setAttribute("keepMenuId",
										url.getTopid());
								break;
							}
						}*/

						return true;
					}
				}
			} else {
				WebCookieComponent.removeCookie(c.getName());
			}

		}

		String paramString = "";
		Enumeration<String> paramNames = request.getParameterNames();
		while (paramNames.hasMoreElements()) {
			String paramName = paramNames.nextElement().toString();
			if (paramName.equals("loginPwd") || paramName.equals("loginEmail")) {
				continue;
			}
			paramString += "&" + paramName + "="
					+ request.getParameter(paramName);
		}

		String fromUrl = request.getRequestURI();
		if (fromUrl.indexOf(".do") > -1) {
			fromUrl += "?" + paramString;
		}

		String returnUrl = URLEncoder.encode(fromUrl, "UTF-8");
		
		response.getWriter().write(
				"<script>top.location='" + request.getContextPath()
						+ "/cpsx/toLogin.do?from=" + returnUrl
						+ "';</script>");
		return false;
		
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cpc.interceptors.CPCBaseInterceptor#postHandle(javax.servlet.
	 * http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, org.springframework.web.servlet.ModelAndView)
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cpc.interceptors.CPCBaseInterceptor#afterCompletion(javax.servlet
	 * .http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, java.lang.Exception)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	public void setServletContext(ServletContext servletContext) {
		this.sc = servletContext;
	}

}
