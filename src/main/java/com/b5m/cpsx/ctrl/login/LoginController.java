/**   
 * @Title: LoginController.java 
 * @Package com.b5m.cpsx.ctrl.login 
 * @author feitian  
 * @date 2016年6月1日 下午3:29:40 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.login;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.b5m.cpsx.commons.constant.CacheConstant;
import com.b5m.cpsx.commons.constant.CookieKeyConstant;
import com.b5m.cpsx.commons.constant.HttpAttributeKey;
import com.b5m.cpsx.commons.constant.LogFormatConstants;
import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.service.cache.CacheMapService;
import com.b5m.cpsx.service.login.InitService;
import com.b5m.cpsx.utils.DigestUtils;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;
import com.b5m.cpsx.utils.WebCookieComponent;

/**
 * @ClassName: LoginController
 * @Description: 登录
 * @author feitian
 * @date 2016年6月1日 下午3:29:40
 * 
 */
@Controller
@RequestMapping(value = "/cpsx")
public class LoginController extends BaseController implements ServletContextAware{
	
	@Autowired
	private InitService initService; //初始化服务
	
	@Autowired
	private CacheMapService cacheMapService;
	
	private ServletContext sc;
	
	protected Logger logger = Logger.getLogger(LoginController.class);

	@RequestMapping(value = "/toLogin.do")
	private ModelAndView checkLogin(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("/login");
		
		//切换中英文的cookie，默认中文
		Cookie languageCookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_Language, request);
		if(languageCookie != null && StringUtils.isNotBlank(languageCookie.getValue())) {
			/*languageCookie = WebCookieComponent.createCookie(CookieKeyConstant.CPSX_Language, "1", 60*60*24, "www.b5m.com");
			response.addCookie(languageCookie);*/
		} else {
			languageCookie = WebCookieComponent.createCookie(CookieKeyConstant.CPSX_Language, "1", 60*60*24, "www.b5m.com");
			response.addCookie(languageCookie);
		}
		
		try {
			mav.addObject("notices", baseCommonService.selectListAll("cpsxIndexMapper.selectNotice"));
			mav.addObject("rewards", baseCommonService.selectListAll("cpsxIndexMapper.selectReward"));
			mav.addObject("sales", baseCommonService.selectListAll("cpsxIndexMapper.selectSale"));
			mav.addObject("advertisers", baseCommonService.selectListAll("cpsxIndexMapper.selectAdvertiser"));
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		
		Cookie cookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER, request);
		if (cookie != null && StringUtils.isNotBlank(cookie.getValue())) {
			Object userObject = cacheMapService.getCache(CacheConstant.USER_PREFIX + cookie.getValue());
			if (userObject != null && userObject instanceof User) {
				User user = (User) userObject;
				String last_login_cookie = (String)cacheMapService.getCache(CacheConstant.USER_PREFIX + user.getId());
				if (StringUtils.isNotBlank(last_login_cookie)
						&& StringUtils.equalsIgnoreCase(last_login_cookie,cookie.getValue())) {
					mav.setViewName("redirect:/cpsx/index.do");
				}
			}
		}
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/checkValidation", produces={"application/json;charset=UTF-8"})
	private String checkValidation(HttpServletRequest request,
			HttpServletResponse response, Model model, User user) {
		JSONObject jObject = new JSONObject();
		try {
			Cookie cookie = WebCookieComponent.getCookie(
					CookieKeyConstant.CPSX_CHECK_CODE, request);
			if (cookie != null) {
				String checkCode = cookie.getValue();
				if (user != null) {
					if (user.getAuthCode() == null
							|| user.getPassword() == null
							|| user.getEmail() == null) {
						jObject.put("msg0", "Empty Submit!");
						jObject.put("msg1", "禁止空的提交！");
					} else {
						if (user.getAuthCode().toUpperCase()
								.equals(checkCode.toUpperCase())) {
							// check user in database!
							User s_user = (User) baseCommonService.selectOne(
									"cpsxUserMapper.selectOneUser", user);
							if (s_user != null) {
								jObject.put("msg0", "Success");
								jObject.put("msg1", "成功");
							} else {
								jObject.put("msg0", "Wrong Email OR Wrong Password!");
								jObject.put("msg1", "用户名或密码错误！");
							}
						} else {
							jObject.put("msg0", "Wrong Verfication Code!");
							jObject.put("msg1", "验证码错误！");
						}
					}
				}
			}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
		}
		return jObject.toJSONString();
	}

	@RequestMapping("/login")
	private String checkInfo(HttpServletRequest request,
			HttpServletResponse response, Model model, User user) {
		String forward = "login";
		try {
			Cookie cookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_CHECK_CODE, request);
			if (cookie != null) {
				String checkCode = cookie.getValue();
				if (user != null) {
					if (user.getAuthCode() == null
							|| user.getPassword() == null
							|| user.getEmail() == null) {
						model.addAttribute("failFlag", "输入信息有误！");
					} else {
						if (user.getAuthCode().toUpperCase()
								.equals(checkCode.toUpperCase())) {
							// check user in database!
							User loginUser = (User) baseCommonService.selectOne("cpsxUserMapper.selectOneUser",user);
							if (loginUser != null) {
								loginUser.rolesHandling();
								Cookie userCookie = WebCookieComponent.createCookie(CookieKeyConstant.CPSX_LOGIN_USER,
										DigestUtils.getMD5Hex(UUID.randomUUID().toString()),-1);
								response.addCookie(userCookie);

								// 向缓存放入用户对象
								cacheMapService.putCache(CacheConstant.USER_PREFIX+ userCookie.getValue(), loginUser);

								// 向缓存放入安全密匙码
								cacheMapService.putCache(CacheConstant.USER_PREFIX+ loginUser.getId(),userCookie.getValue());

								model.addAttribute("user", loginUser);
								Cookie rmCookie = WebCookieComponent.removeCookie(CookieKeyConstant.CPSX_CHECK_CODE);
								response.addCookie(rmCookie);
								// 加载可用菜单
								initService.loadMenu(loginUser.getRoleIds());
								forward = "redirect:/cpsx/index.do";
							} else {
								model.addAttribute("failMsg",
										"用户名密码错误");
								model.addAttribute("reLogin", "reLogin");
							}
					}else{
						model.addAttribute("failMsg", "验证码错误！");
						model.addAttribute("reLogin", "reLogin");
						}
					}
				}else{
					model.addAttribute("failMsg", "重新登录");
					model.addAttribute("reLogin", "reLogin");
				}
		}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
			Map<String, Object> asMap = model.asMap();
			asMap.clear();
			return "redirect:/500.jsp";
		}
		return forward;
	}
	

	@RequestMapping("/mrgLogout")
	public String mrgLogout(HttpServletRequest request,
			HttpServletResponse response) {
		User u = (User) request
				.getAttribute(HttpAttributeKey.CPSX_USER_INFO);
		if (u != null) {
			sc.removeAttribute(CacheConstant.CPSX_MENU_TOP + u.getRoleId());
			sc.removeAttribute(CacheConstant.CPSX_MENU + u.getRoleId());
		}

		try {
			Cookie userCookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER,
					request);
			if (userCookie != null) {
				String userLogin4Cookie = userCookie.getValue();
				if (!userLogin4Cookie.equals("")) {
					cacheMapService.removeCache(CacheConstant.USER_PREFIX + userLogin4Cookie);
					if (u != null) {
					cacheMapService.removeCache(CacheConstant.USER_PREFIX + u.getId());
					}
				}
			}

			Cookie rmCookie = WebCookieComponent.removeCookie(CookieKeyConstant.CPSX_LOGIN_USER);
			if (rmCookie != null) {
				response.addCookie(rmCookie);
			}
			Cookie urlCookie = WebCookieComponent.getCookie("cookie_url", request);
			if (urlCookie != null) {
				urlCookie.setMaxAge(0);
				response.addCookie(urlCookie);
			}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
			return "redirect:/500.jsp";
		}

		String toUrl = request.getParameter("toUrl");
		if (toUrl != null) {
			return "redirect:" + toUrl;
		} else {
			return "redirect:/";
		}
	}
	
	@RequestMapping("/userAccount.do")
	@ResponseBody
	public ModelAndView userAccount(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		mv.setViewName("admin/userAccount");
		String userId = request.getParameter("userId");
		User user = (User) baseCommonService.selectOne("cpsxUserMapper.selectOneUserInfo", userId);
		mv.addObject("loginUser", user);
		return mv;
	}
	
	@RequestMapping("/editUserAccount.do")
	@ResponseBody
	public String editUserAccount(HttpServletRequest request, HttpServletResponse response,User user) {
		request.setAttribute("msg", "修改账户信息");
		int suc = baseCommonService.update("cpsxUserMapper.updateUserAccount", user);
		return suc==1?"success":"failed";
	}
	
	@RequestMapping("/timeLine.do")
	@ResponseBody
	public ModelAndView timeLine(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		mv.setViewName("admin/timeLine");
		User user = GetUserFromCookieUtils.getUser(request);
		List<Object> records =  baseCommonService.selectList("cpsxUserMapper.selectTimeLineInfo", user.getId());
		mv.addObject("userInfo", user);
		mv.addObject("records", records);
		return mv;
	}

	@RequestMapping("/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response) {
			
			return "common/top";
	}
	
	@RequestMapping("/home.do")
	public Object home(HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
		//切换中英文的cookie，先都设为默认英文，后期优化
				Cookie languageCookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_Language, request);
				if(languageCookie != null && StringUtils.isNotBlank(languageCookie.getValue())) {
					/*languageCookie = WebCookieComponent.createCookie(CookieKeyConstant.CPSX_Language, "1", 60*60*24, "www.b5m.com");
					response.addCookie(languageCookie);*/
				} else {
					languageCookie = WebCookieComponent.createCookie(CookieKeyConstant.CPSX_Language, "1", 60*60*24, "www.b5m.com");
					response.addCookie(languageCookie);
				}
				
				try {
					User user = GetUserFromCookieUtils.getUser(request);
					mav.addObject("login_user", user);
					mav.addObject("notices", baseCommonService.selectListAll("cpsxIndexMapper.selectNotice"));
					mav.addObject("rewards", baseCommonService.selectListAll("cpsxIndexMapper.selectReward"));
					mav.addObject("sales", baseCommonService.selectListAll("cpsxIndexMapper.selectSale"));
					mav.setViewName("login");
					mav.addObject("advertisers", baseCommonService.selectListAll("cpsxIndexMapper.selectAdvertiser"));
				} catch (Exception e) {
					log.error(this.getClass().getName(), e);
				}
			return mav;
	}
		
	@Override
	public void setServletContext(ServletContext servletContext) {
			this.sc = servletContext;
	}
		
	
}
