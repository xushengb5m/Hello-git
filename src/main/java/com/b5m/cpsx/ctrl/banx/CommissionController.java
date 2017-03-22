/**   
 * @Title: CommissionController.java 
 * @Package com.b5m.cpsx.ctrl.banx 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月13日 下午4:20:28 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.banx;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.b5m.cpsx.ctrl.BaseController;

/** 
 * @ClassName: CommissionController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月13日 下午4:20:28 
 *  
 */
@Controller
@RequestMapping(value = "/banx/comm")
public class CommissionController extends BaseController {
	
	@RequestMapping(value = "/commission", method=RequestMethod.GET)
	private ModelAndView query(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		String namespace = "commissionInfoMapper.select";
		try {
			List<Object> rows = baseCommonService.selectListAll(namespace);
			mav.addObject("rows", rows);
			mav.addObject("activities", baseCommonService.selectListAll("commissionInfoMapper.selectActivity"));
			mav.setViewName("/banx/commission");
			return mav;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	@RequestMapping(value = "/commission", method = RequestMethod.POST)
	private void create(HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "commissionInfoMapper.insertOne";
		Map<String, String> param = paramMap(request);
		/*User user = GetUserFromCookieUtils.getUser(request, baseRedisService);
		Integer userId = user.getId();
		param.put("user_id", String.valueOf(userId));*/
		param.put("end_date", param.get("end_date") + " 23:59:59");
		try {
			baseCommonService.insert(namespace, param);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/commission/{id}", method=RequestMethod.GET)
	private String queryOne(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "commissionInfoMapper.selectOne";
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		try {
			Map<String, String> row = (Map<String, String>) baseCommonService.selectOne(namespace, param);
			row.put("start_date", String.valueOf(row.get("start_date")).substring(0, 10));
			row.put("end_date", String.valueOf(row.get("end_date")).substring(0, 10));
			String str = JSON.toJSONString(row, true);
			return str;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return null;
	}
	
	@RequestMapping(value = "/commission/{id}", method=RequestMethod.POST)
	private void update(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "commissionInfoMapper.updateOne";
		Map<String, String> param = paramMap(request);
		param.put("id", id);
		param.put("end_date", param.get("end_date") + " 23:59:59");
		try {
			baseCommonService.update(namespace, param);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
	}

}
