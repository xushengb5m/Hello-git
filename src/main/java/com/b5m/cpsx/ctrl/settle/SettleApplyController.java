package com.b5m.cpsx.ctrl.settle;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.service.settle.ISettleCommissionService;
import com.b5m.cpsx.utils.CPCDigestUtils;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;
import com.b5m.cpsx.utils.MailUtils;
@Controller
@RequestMapping("/settle/apply")
public class SettleApplyController extends BaseController{
	
	protected Logger logger = Logger.getLogger(SettleApplyController.class);
	
	private static final SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM");
	
	@Autowired
	private ISettleCommissionService settleCommissionService;
	
	/** 
	 * 佣金申请页 
	 */
	@RequestMapping(value = "/commission", method=RequestMethod.GET)
	public ModelAndView selectSettleInfo(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		String user_id = GetUserFromCookieUtils.getUser(request).getId()+"";
		Object applyInfo = baseCommonService.selectOne("settleMapper.selectRemainSum", user_id);
		mv.addObject("applyInfo", applyInfo);
		mv.addObject("userId", user_id);
		Object applyfingMoney = baseCommonService.selectOne("settleMapper.selectApplyingMoney", user_id);
		mv.addObject("applyfingMoney", applyfingMoney==null?0.0:applyfingMoney);
		List<Object> applying = baseCommonService.selectList("settleMapper.selectCommissionApply",user_id);
		mv.addObject("applying", applying);
		List<Object> rows = baseCommonService.selectList("settleMapper.selectApplyDataByUserId",user_id);
		mv.addObject("rows", rows);
		List<Object> applyHistory = baseCommonService.selectList("settleMapper.selectCommissionApply_history",user_id);
		mv.addObject("applyHistory", applyHistory);
		mv.setViewName("/settle/settle");
		return mv;
	}
	
	/** 
	 * 完善银行账户页
	 */
	@RequestMapping(value = "/payAccount/{user_id}", method=RequestMethod.GET)
	public ModelAndView bankAccount(@PathVariable String user_id,HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		User usr = GetUserFromCookieUtils.getUser(request);
		if(user_id.equals(usr.getId()+"")){
			Object payAccount = baseCommonService.selectOne("payAccountMapper.selectPayAccount", user_id);
			mv.addObject("payAccount", payAccount);
			mv.addObject("user_id", user_id);
			mv.setViewName("/settle/bankAccount");
			return mv;
		}else{
			return null;
		}
		
	}
	
	/** 
	 * 设置银行账户
	 */
	@RequestMapping(value = "/payAccount/{user_id}", method=RequestMethod.POST)
	@ResponseBody
	public Object addPayAccount(@PathVariable String user_id,HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		ControllerMessage cm = new ControllerMessage();
		int exist = (int) baseCommonService.selectOne("payAccountMapper.selectExists", user_id);
		params.put("user_id", user_id);
		request.setAttribute("msg", "设置银行账户");//时间轴记录操作所用
		int suc = 0;
		if(exist==0){
			suc = (int) baseCommonService.insert("payAccountMapper.insertPayAccount", params);
		}else{
			if(!StringUtils.isEmpty(params.get("bank_name"))){
				suc = baseCommonService.update("payAccountMapper.updateBankPayAccount", params);
			}else{
				suc = baseCommonService.update("payAccountMapper.updateAliPayAccount", params);
			}
		}
		if(suc>0){
			cm.setStatue(true);
			cm.setMessage("账户设置成功!");
		}else{
			cm.setStatue(false);
			cm.setMessage("账户设置失败!");
		}
		return cm;
	}
	
	/** 
	 * 设置用户密码页
	 */
	@RequestMapping(value = "/payPassword/{id}", method=RequestMethod.GET)
	public ModelAndView payPassword(@PathVariable String id,HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		User usr = GetUserFromCookieUtils.getUser(request);
		if(id.equals(usr.getId()+"")){
			String user_id = id;
			Object userInfo = baseCommonService.selectOne("cpsxUserMapper.selectOneUserInfo", user_id);
			mv.addObject("userInfo", userInfo);
			mv.setViewName("/settle/payPassword");
			return mv;
		}else{
			return null;
		}
	}
	
	/** 
	 * 设置用户密码
	 */
	@RequestMapping(value = "/payPassword/{id}", method=RequestMethod.POST)
	@ResponseBody
	public Object EditPayPassword(@PathVariable String id,HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		ControllerMessage cm = new ControllerMessage();
		String psw = CPCDigestUtils.getMD5Hex(CPCDigestUtils.getMD5Hex(params.get("login_psw"))
				+ CPCDigestUtils.getMD5Hex(params.get("email")));
		params.put("psw", psw);
		int isExist = (int) baseCommonService.selectOne("cpsxUserMapper.selectCountUser", params);
		params.put("user_id", id);
		request.setAttribute("msg", "设置提现密码");//时间轴记录操作所用
		if(isExist>0){
			int suc = baseCommonService.update("payAccountMapper.updatePayPassword", params);
			if(suc>0){
				cm.setStatue(true);
				cm.setMessage("设置提现密码成功!");
			}else{
				cm.setStatue(false);
				cm.setMessage("设置提现密码失败!");
			}
		}else{
			cm.setStatue(false);
			cm.setMessage("操作失败,登录密码错误!!");
		}
		return cm;
	}
	
	/** 
	 * 提现佣金
	 */
	@RequestMapping(value = "/getCommission/{id}", method=RequestMethod.POST)
	@ResponseBody
	public Object applyCommission(@PathVariable String id,HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		User user = GetUserFromCookieUtils.getUser(request);
		params.put("user_id", id);
		request.setAttribute("msg", "申请提现,金额"+params.get("cash"));
		ControllerMessage cm = settleCommissionService.updateApplyingCommission(params);
		if(cm.isStatue()){
			try {
				MailUtils.sendMail(new String[]{"finance@b5m.com"},  new String[] {}, "通知:CPS提现申请", "用户"+user.getUserName()+"申请提现金额为:"+params.get("cash"));
			} catch (MessagingException e) {
				logger.error(e);
			}
		}
		return cm;
	}
	
	/** 
	 * 再次申请提现佣金
	 */
	@RequestMapping(value = "/reApplyCommission/{id}/{y}/{m}", method=RequestMethod.POST)
	public void reApplyCommission(@PathVariable String id,@PathVariable String y,@PathVariable String m,HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		params.put("user_id", id);
		params.put("the_year", y);
		params.put("the_month", m);
		request.setAttribute("msg", "再次申请提现,金额"+params.get("cash"));
		baseCommonService.update("settleMapper.reApplyCommission", params);
	}
	
	/** 
	 * 佣金详情
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/detail/{id}/{y}/{m}", method=RequestMethod.GET)
	public ModelAndView getDetailCommission(@PathVariable String id,@PathVariable String y,@PathVariable String m,HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map params = new HashMap<String,String>();
		params.put("user_id", id);
		try {
			Date dt = sm.parse(y+"-"+m);
			params.put("settle_date",sm.format(dt));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Object details = baseCommonService.selectList("confirmOrderMapper.selectConfirmOrder",params);
		mv.addObject("details", details);
		mv.setViewName("/settle/detailCommission");
		return mv;
	}
	
	public static void main(String[] args) throws ParseException {
		SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM");
		Date d = sm.parse("2016-8");
		System.out.println(d);
	}
}

