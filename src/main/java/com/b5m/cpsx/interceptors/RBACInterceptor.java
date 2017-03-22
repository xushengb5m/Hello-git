package com.b5m.cpsx.interceptors;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.b5m.cpsx.commons.constant.HttpAttributeKey;
import com.b5m.cpsx.model.RBACRoleAccess;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.service.login.IRBACService;

/**
 * @author janwen Apr 17, 2013 5:59:40 PM
 * 
 */
public class RBACInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private IRBACService RBACService; 
	
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
	 * com.b5m.cms.interceptors.CMSLoginInterceptor#preHandle(javax.servlet.
	 * http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		User cu = (User) request.getAttribute(HttpAttributeKey.CPSX_USER_INFO);
		if (cu != null) {
			if(cu.getRoleIds().size()>0){
				for(int i=0;i<cu.getRoleIds().size();i++){
					RBACRoleAccess ra = new RBACRoleAccess();
					ra.setRoleId(new Long(cu.getRoleIds().get(i)+""));
					ra.setRolename(cu.getRoleName());
					ra.setAccessurl(request.getRequestURI());//设置被拦截的URL为RBACRoleAccess的URL
					if (RBACService.hasAccess(ra)) {
						//如果允许访问
						return true;
					}
				}
				request.getRequestDispatcher("/haitaocps/noAccess.do").forward(request, response);
				return false;
			}else{
				return false;
			}
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cms.interceptors.CMSLoginInterceptor#postHandle(javax.servlet
	 * .http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
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
	 * com.b5m.cms.interceptors.CMSLoginInterceptor#afterCompletion(javax.servlet
	 * .http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, java.lang.Exception)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

}
