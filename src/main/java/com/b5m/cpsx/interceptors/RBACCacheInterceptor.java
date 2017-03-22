package com.b5m.cpsx.interceptors;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.b5m.cpsx.service.login.IRBACService;

/**
 * @author janwen Apr 22, 2013 3:36:21 PM 用户更新后，刷新权限缓存
 * 
 */
public class RBACCacheInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private IRBACService rbacService;  //角色权限服务

	private List<String> path;

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
	 * org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle
	 * (javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		return super.preHandle(request, response, handler);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.servlet.handler.HandlerInterceptorAdapter#postHandle
	 * (javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, java.lang.Object,
	 * org.springframework.web.servlet.ModelAndView)
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		//更新角色权限缓存，具体说将角色所能访问的URL全部存到Redis中
		rbacService.refreshRoleAccess();
	}


	/*
	 * (non-Javadoc)
	 * 
	 * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#
	 * afterCompletion(javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, java.lang.Object,
	 * java.lang.Exception)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#
	 * afterConcurrentHandlingStarted(javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */
	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

}
