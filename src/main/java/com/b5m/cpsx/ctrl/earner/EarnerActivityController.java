/**   
 * @Title: EarnerActivityController.java 
 * @Package com.b5m.cpsx.ctrl.earner 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月15日 上午11:06:00 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.earner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;


/** 
 * @ClassName: EarnerActivityController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月15日 上午11:06:00 
 *  
 */
@Controller
@RequestMapping(value = "/earner/act")
public class EarnerActivityController extends BaseController {

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/activity", method=RequestMethod.GET)
	private ModelAndView query(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("/earner/activity");
		String namespace = "earnerActivityMapper.select";
		try {
			/*List<Object> rows = baseCommonService.selectListAll(namespace);*/
			User user = GetUserFromCookieUtils.getUser(request);
			mav.addObject("user_id", user.getId());
			List<Integer> role_ids = user.getRoleIds();
			String namespace_website="";
			if(role_ids.indexOf(1) >= 0) {
				namespace_website = "earnerActivityMapper.selectWebsiteIsAdmin";
			} else if(role_ids.indexOf(3) >= 0) {
				namespace_website = "earnerActivityMapper.selectWebsiteNotAdmin";
			}
			List<Object> websites = baseCommonService.selectList(namespace_website, user);
			mav.addObject("websites", websites);
			if(websites.size() > 0) {
				Map<String, String> first_website = (Map<String, String>) websites.get(0);
				String website_id = request.getParameter("website_id");
				Map<String, String> param = new HashMap<String, String>();
				param.put("id", String.valueOf(first_website.get("id")));
				param.put("supply_id", String.valueOf(first_website.get("supply_id")));
				if(StringUtils.isNotBlank(website_id)) {
					param.put("id", website_id);
				}
				List<Object> rows = baseCommonService.selectList(namespace, param);
				mav.addObject("rows", rows);
				mav.addObject("web", param);
			}
			return mav;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/activity/{id}/{website_id}", method=RequestMethod.GET)
	private ModelAndView queryOne(@PathVariable String id, @PathVariable String website_id, HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("/earner/detailed-activity");
		String namespace = "earnerActivityMapper.selectOne";
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		Map<String, String> param_website = new HashMap<String, String>();
		param_website.put("website_id", website_id);
		param_website.put("activity_id", id);
		try {
			Map<String, String> row = (Map<String, String>) baseCommonService.selectOne(namespace, param);
			mav.addObject("row", row);
			List<Object> commissions = baseCommonService.selectList("earnerActivityMapper.selectCommission", param);
			mav.addObject("commissions", commissions);
			List<Object> notifications = baseCommonService.selectList("earnerActivityMapper.selectNotification", param);
			mav.addObject("notifications", notifications);
			Object web = baseCommonService.selectOne("earnerActivityMapper.selectWebsite", param_website);
			mav.addObject("web", web);
			Object approval = baseCommonService.selectOne("earnerActivityMapper.selectApproval", param_website);
			mav.addObject("approval", approval);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	 
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/activity", method=RequestMethod.POST)
	private void create(HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "earnerActivityMapper.insertOne";
		Map<String, String> param = paramMap(request);
		/*User user = GetUserFromCookieUtils.getUser(request, baseRedisService);*/		
		try {
			//时间轴记录操作所用
			request.setAttribute("msg", "在站点"+param.get("website_id")+"推广活动"+param.get("activity_id"));
			Map<String, String> supply = (Map<String, String>) baseCommonService.selectOne("earnerActivityMapper.selectSupply", param);			
			String supply_id = String.valueOf(supply.get("supply_id"));
			param.put("supply_id", supply_id);
			Map<String, String> activity = (Map<String, String>) baseCommonService.selectOne("earnerActivityMapper.selectActivity", param);
			String approval_mode = String.valueOf(activity.get("approval_mode"));
			String approval_status = approval_mode.equals("2") ? "0" : "1";
			param.put("approval_status", approval_status);
			baseCommonService.insert(namespace, param);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
