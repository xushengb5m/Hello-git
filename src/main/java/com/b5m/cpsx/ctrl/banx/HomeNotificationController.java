/**   
 * @Title: HomeNotificationController.java 
 * @Package com.b5m.cpsx.ctrl.banx 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月27日 下午3:29:43 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.banx;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;

/** 
 * @ClassName: HomeNotificationController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月27日 下午3:29:43 
 *  
 */
@Controller
@RequestMapping(value = "/banx/home")
public class HomeNotificationController extends BaseController {
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/notification/{id}", method=RequestMethod.GET)
	private ModelAndView queryOne(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("/home/notification");
		String namespace = "homeNotificationMapper.selectOne";
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		try {
			User user = GetUserFromCookieUtils.getUser(request);
			mav.addObject("login_user", user);
			Map<String, String> row = (Map<String, String>) baseCommonService.selectOne(namespace, param);
			mav.addObject("row", row);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
}
