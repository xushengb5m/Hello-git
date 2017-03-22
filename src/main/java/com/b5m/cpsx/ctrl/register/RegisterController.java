/**   
 * @Title: RegisterController.java 
 * @Package com.b5m.cpsx.ctrl.register 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月3日 上午10:52:09 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.register;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.b5m.cpsx.commons.constant.CookieKeyConstant;
import com.b5m.cpsx.commons.constant.LogFormatConstants;
import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.ctrl.login.LoginController;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.utils.WebCookieComponent;

/**
 * @ClassName: RegisterController
 * @Description: TODO
 * @author feitian
 * @date 2016年6月3日 上午10:52:09
 * 
 */
@Controller
@RequestMapping(value = "/registration")
public class RegisterController extends BaseController {
	
	protected Logger logger = Logger.getLogger(LoginController.class);

	@RequestMapping(value = "/toRegister")
	private String checkLogin(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// 切换中英文的cookie，默认中文
		Cookie languageCookie = WebCookieComponent.getCookie(
				CookieKeyConstant.CPSX_Language, request);
		if (languageCookie != null
				&& StringUtils.isNotBlank(languageCookie.getValue())) {
		} else {
			languageCookie = WebCookieComponent.createCookie(
					CookieKeyConstant.CPSX_Language, "1", 60 * 60 * 24,
					"www.b5m.com");
			response.addCookie(languageCookie);
		}
		return "register";
	}
	
	@ResponseBody
	@RequestMapping(value="/checkValidation", produces={"application/json;charset=UTF-8"})
	private String checkValidation(HttpServletRequest request,
			HttpServletResponse response, User user) {
		JSONObject jObject = new JSONObject();
		try {
			// 验证用户重复
			int userExist = (int) baseCommonService.selectOne(
					"cpsxUserMapper.selectEmailExist", user);
			if (userExist >= 1) {
				jObject.put("msg0", "Email Exist!");
			} else {
				jObject.put("msg0", "Success");
			}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
		}
		return jObject.toJSONString();
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String addUser(Model model, User user, HttpServletRequest request)
			throws Exception {
		String returnStr = "fail";
		try {
			user.setCreateTime(new Timestamp(System.currentTimeMillis()));
			// 验证用户重复
			int userExist = (int) baseCommonService.selectOne(
					"cpsxUserMapper.selectEmailExist", user);
			if (userExist >= 1) {
				returnStr = "email_exist";
			} else {
				int dsd = (int) baseCommonService.insert(
						"cpsxUserMapper.insertOneUser", user);
				if (dsd > 0) {
					int userId = (int) baseCommonService.selectOne(
							"cpsxUserMapper.selectUserIdByEmail", user);
					if (userId > 0) {
						user.setId(userId);
						//user.rolesHandling();
						List<Map> params = new ArrayList<Map>();
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("roleId", user.getRoleId());
						map.put("userId", user.getId());
						params.add(map);
						int rsd = (int) baseCommonService.insert(
								"userRoleMapper.insertUserRole", params);
						if (dsd > 0 && rsd > 0) {
							returnStr = "success";
						}
					}
				} else {
					returnStr = "/register-fail";
				}
			}
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
			throw e;
		}
		return "/register-succeed";
	}

}
