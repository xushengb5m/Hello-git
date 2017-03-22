/**
 * @author ldb
 * @dateTime 2013-4-11 上午9:57:00
 */
package com.b5m.cpsx.ctrl.login;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.CharEncoding;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.b5m.cpsx.commons.constant.CpsxConstants;
import com.b5m.cpsx.commons.constant.CookieKeyConstant;
import com.b5m.cpsx.commons.constant.HttpAttributeKey;
import com.b5m.cpsx.commons.constant.LogFormatConstants;
import com.b5m.cpsx.model.CpsxRole;
import com.b5m.cpsx.model.Page;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.service.IBaseCommonService;
import com.b5m.cpsx.service.login.IRBACService;
import com.b5m.cpsx.utils.RoleContainUtil;
import com.b5m.cpsx.utils.WebCookieComponent;


/**
 * 后台账号管理类
 * 
 * @author xusheng
 * 
 */
@Controller
@RequestMapping("/admin")
public class UserManagerController {

	private Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	protected IBaseCommonService baseCommonService;

	@Autowired
	private IRBACService rbacService;  //角色权限服务
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/toAccountMrg")
	public String toAccountMrg(HttpServletRequest request,
			HttpServletResponse response, Model model, User query) {
		try {
			String pageNo = request.getParameter("pager.offset");

			int pageSize = 10;
			if (!StringUtils.isNotBlank(pageNo)
					|| !NumberUtils.isNumber(pageNo)) {
				pageNo = "0";
			}
			long total = 0l;
			request.setAttribute("pagesize", pageSize);
			List<Object> rolesList = baseCommonService.selectListAll("cpsxRoleMapper.selectAllRoles");
			List<CpsxRole> roles = new ArrayList<CpsxRole>();
			for(Object obj:rolesList){
				CpsxRole dr = (CpsxRole)obj;
				roles.add(dr);
			}
			
			if (roles!= null && roles.size() > 0) {
				model.addAttribute("roles", roles);
			}
			Cookie asdf = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER,request);
			
			if (asdf != null) {
				String dfs = asdf.getValue();
				User user = new User();

				List<User> users = new ArrayList<User>();
				Page userListPage = new Page();
				if (user != null) {
					if (RoleContainUtil.listContains(user.getRoleIds(),1)) {// 账户管理角色
						//Page page = new Page();
						userListPage.setPageNo(Integer.parseInt(pageNo));
						userListPage.setPageSize(pageSize);
						userListPage.setQueryParam(query);
						userListPage = baseCommonService.selectList("cpsxUserMapper.selectUserListPage", userListPage);
						users =  (List<User>) userListPage.getRows();
						model.addAttribute("roleFlag", "Admin");
					} else if (RoleContainUtil.listContains(user.getRoleIds(),2)
							|| RoleContainUtil.listContains(user.getRoleIds(),3)
							|| RoleContainUtil.listContains(user.getRoleIds(),4)
							|| RoleContainUtil.listContains(user.getRoleIds(),5)){// 客户维护、销售统计角色
						User cUser = (User) baseCommonService.selectOne("cpsxUserMapper.selectTheUser",user);
						if (cUser != null) {
							users.add(cUser);
						}
						model.addAttribute("roleFlag", "KHWH");
					}
				}

				total = userListPage.getTotal();
				model.addAttribute("pageNo", Integer.parseInt(pageNo)/10+1);
				if (users != null && users.size() > 0) {
					model.addAttribute("results", users);
					if (users.size() == 1) {
						model.addAttribute("total", 1);
					} else {
						model.addAttribute("total",total);
					}
					model.addAttribute("tabFlag","userMrg");
				}
			}
			if (query != null) {
				model.addAttribute("query", query);
			}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
			@SuppressWarnings("rawtypes")
			Map sdf = model.asMap();
			sdf.clear();
			return "redirect:/500.jsp";
		}
		model.addAttribute("title", "帐号管理");
		return "admin/userList";
	}

	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	@ResponseBody
	public String addUser(Model model, User User,
			HttpServletRequest request) throws Exception{
		String retStr = "fail";
		try {
			User.setCreateTime(new Timestamp(System.currentTimeMillis()));
			//验证用户重复
			int userExist = (int) baseCommonService.selectOne("cpsxUserMapper.selectEmailExist",User);
			if(userExist>=1){
				retStr = "email_exist";
			}else{
				int dsd = (int) baseCommonService.insert("cpsxUserMapper.insertOneUser", User);
				if(dsd>0){
					int userId = (int) baseCommonService.selectOne("cpsxUserMapper.selectUserIdByEmail", User);
					if(userId>0){
						User.setId(userId);
						User.rolesHandling();
						List<Map> params = new ArrayList<Map>();
						for(int i=0;i<User.getRoleIds().size();i++){
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("roleId",User.getRoleIds().get(i));
							map.put("userId", User.getId());
							params.add(map);
						}
						int rsd = (int)baseCommonService.insert("userRoleMapper.insertUserRole", params);
						if (dsd > 0 && rsd>0) {
							retStr = "success";
						} else if (dsd == 0) {
							retStr = "email_exist";
						}
					}
				}
			}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
			throw e;
		}
		return retStr;
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.POST)
	@ResponseBody
	public String editUser(Model model, User User,
			HttpServletRequest request) {
		String retStr = "fail";
		long sdf = 0;
		try {
			Cookie asdf = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER,
					request);
			if (asdf != null) {
				String dfs = asdf.getValue();
				User loginUser = new User();
				if (User != null && loginUser != null) {
					if (User.getId() != 0) {
						User.rolesHandling();
						if (RoleContainUtil.listContains(loginUser.getRoleIds(),CpsxConstants.ADMIN_ROLE_ID)) {
							sdf = rbacService.updateUserInfo(User);
						} else if (!RoleContainUtil.listContains(loginUser.getRoleIds(),CpsxConstants.ADMIN_ROLE_ID)
								&& loginUser.getId() == User.getId()) {
							User.setRoleId(loginUser.getRoleId());
							User.setUserType(loginUser.getUserType());
							
							sdf = rbacService.updateUserInfo(User);
						} else {
							retStr = "nopro";
						}
					}
				}
			}
			if (sdf >= 1) {
				retStr = "success";
			} else if (sdf == 0) {
				retStr = "email_exist";
			}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
			return "redirect:/500.jsp";
		}
		return retStr;
	}
	
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	@RequestMapping(value = "/delUser", method = RequestMethod.GET)
	@ResponseBody
	public String delUser(Model model, User User,
			HttpServletRequest request) {
		User user = (User) request
				.getAttribute(HttpAttributeKey.CPSX_USER_INFO);
		String retStr = "fail";
		if (!RoleContainUtil.listContains(user.getRoleIds(),CpsxConstants.ADMIN_ROLE_ID)) {
			return retStr;
		}
		try {
			if (User.getId() != 0) {
				baseCommonService.delete("cpsxUserMapper.delUserRole", User);
				int s2 = baseCommonService.update("cpsxUserMapper.updateUserStatus", User);
				baseCommonService.delete("cpsxUserMapper.delUserAd", User);
				if (s2>0) {
//					baseRedisService.delete(CacheConstant.USER_PREFIX
//							+ DigestUtils.md5Hex(String.valueOf(
//									String.valueOf(User.getId())).getBytes(
//									CharEncoding.UTF_8)));
					retStr = "success";
				}
			}
		} catch (Exception e) {
			logger.error(LogFormatConstants.USER_MANAGER_ERROR, e);
			@SuppressWarnings("rawtypes")
			Map sdf = model.asMap();
			sdf.clear();
			return "redirect:/500.jsp";
		}
		return retStr;
	}

	/**
	 * 添加帐号页面
	 * 
	 * @author johnson
	 */
	@RequestMapping("addUserView.do")
	public String pageAddDmpUser(HttpServletRequest request, Model model) {
		List<Object> roles = baseCommonService.selectListAll("cpsxRoleMapper.selectAllRoles");
		model.addAttribute("roles", roles);
		return "admin/addUser";
	}
//
	/**
	 * 修改帐号页面
	 * 
	 * @author johnson
	 * @param request
	 * @return
	 * @throws Exception
	 * @throws NumberFormatException
	 */
	@RequestMapping("editUserView.do")
	public String pageEditDmpUser(HttpServletRequest request, Model model)
			throws NumberFormatException, Exception {
		String dmpUserId = request.getParameter("id");
		String title = "修改帐号";
		String updateURL = "/cpsx/editUser.do";
		String btnLetter = "修改";
		List<Object> roles = baseCommonService.selectListAll("cpsxRoleMapper.selectAllRoles");
		model.addAttribute("btnLetter", btnLetter);
		model.addAttribute("roles", roles);
		model.addAttribute("formSubmitURL", updateURL);
		model.addAttribute("title", title);
		User loginedUser = (User) request
				.getAttribute(HttpAttributeKey.CPSX_USER_INFO);
		if (!RoleContainUtil.listContains(loginedUser.getRoleIds(),CpsxConstants.ADMIN_ROLE_ID)) {
			dmpUserId = "" + loginedUser.getId();
		}
		if (StringUtils.isNumeric(dmpUserId)) {
			User User = (User)baseCommonService.selectOne("cpsxUserMapper.selectUserById", new Integer(dmpUserId));
			User.rolesHandling();
			model.addAttribute("cpsxUserDetail", User);
		} else {
			return "redirect:/500.jsp";
		}
		return "admin/editUser";
	}

	@RequestMapping("refreshRBAC.do")
	public void refreshRBAC() {
		rbacService.refreshRoleAccess();
	}

}
