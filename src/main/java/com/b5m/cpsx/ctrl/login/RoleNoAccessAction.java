package com.b5m.cpsx.ctrl.login;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

/**
 * @description 无权限登录
 * @author xusheng
 * 
 */
@Controller
public class RoleNoAccessAction {

	@RequestMapping("/haitaocps/noAccess.do")
	public String cmsRBAC(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		if (request.getHeader("x-requested-with") != null) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("appliation/json;charset=utf-8");
			Map<String, Object> retMap = new HashMap<String, Object>();
			retMap.put("retCode", -99);
			retMap.put("retMsg", "未登录");
			response.getWriter().write(new Gson().toJson(retMap));
		}
		return "noAccess";
	}
}
