package com.b5m.cpsx.ctrl.settle;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.service.settle.ISettleCommissionService;
@Controller
@RequestMapping("/settle/pay")
public class SettleFINCheckController extends BaseController{
	
	protected Logger logger = Logger.getLogger(SettleFINCheckController.class);
	
	private static final SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM");
	
	@Autowired
	private ISettleCommissionService settleCommissionService;
	
	/** 
	 * 支付佣金总览页
	 */
	@RequestMapping(value = "/payCommission", method=RequestMethod.GET)
	public ModelAndView applyCommissionList(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		List<Object> rows = baseCommonService.selectListAll("settleMapper.selectFINCommissionApply");
		mv.addObject("rows", rows);
		mv.setViewName("/settle/finCheckCommission");
		return mv;
	}
	
	/** 
	 * 支付佣金详情页
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/payCommission/{id}/{y}/{m}", method=RequestMethod.GET)
	public ModelAndView getPayCommission(@PathVariable String id,@PathVariable String y,@PathVariable String m,HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map params = new HashMap<String,String>();
		params.put("user_id", id);
		params.put("the_year", y);
		params.put("the_month", m);
		Object payInfo = baseCommonService.selectOne("payAccountMapper.selectPayUserInfo",params);
		mv.addObject("payInfo", payInfo);
		mv.setViewName("/settle/payView");
		return mv;
	}
	
	/** 
	 * 支付佣金
	 */
	@RequestMapping(value = "/payCommission/{id}/{y}/{m}", method=RequestMethod.POST)
	@ResponseBody
	public Object postPayCommission(@PathVariable String id,@PathVariable String y,@PathVariable String m,HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		params.put("user_id", id);
		params.put("the_year", y);
		params.put("the_month", m);
		ControllerMessage cm = settleCommissionService.updateCompleteCommissionPay(params);
		return cm;
	}
	
}

