/**   
 * @Title: EarnerActivityApprovalController.java 
 * @Package com.b5m.cpsx.ctrl.earner 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月20日 下午2:43:55 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.earner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;

/** 
 * @ClassName: EarnerActivityApprovalController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月20日 下午2:43:55 
 *  
 */
@Controller
@RequestMapping(value = "/earner/app")
public class EarnerActivityApprovalController extends BaseController {

	@RequestMapping(value = "/approval", method=RequestMethod.GET)
	private ModelAndView query(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("/earner/activity-approval");
		String namespace = "earnerActivityApprovalMapper.select";
		try {
			List<Object> rows = baseCommonService.selectListAll(namespace);
			mav.addObject("rows", rows);
			/*User user = GetUserFromCookieUtils.getUser(request, baseRedisService);
			mav.addObject("user_id", user.getId());*/
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	@RequestMapping(value = "/approval/{id}/{approval_status}/{rate}", method=RequestMethod.PUT)
	private void update(@PathVariable String id, @PathVariable String approval_status,@PathVariable String rate, HttpServletRequest request, HttpServletResponse response) {
		String namespace = "earnerActivityApprovalMapper.update";
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("approval_status", approval_status);
		param.put("rate", rate);
		try {
			baseCommonService.update(namespace, param);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
	}
	 
	
}
