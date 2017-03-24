package com.b5m.cpsx.service.login;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.b5m.cpsx.commons.constant.CacheConstant;
import com.b5m.cpsx.model.RBACRoleAccess;
import com.b5m.cpsx.model.User;
import com.b5m.cpsx.service.IBaseCommonService;
import com.b5m.cpsx.service.cache.CacheMapService;
import com.b5m.cpsx.service.login.IRBACService;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;


@Service("dMPRBACService") 
public class RBACServiceImpl implements IRBACService{
	
	@Autowired
	private IBaseCommonService baseCommonService; //通用数据服务
	
	@Autowired
	private CacheMapService cacheMapService;
	
	public void refreshRoleAccess() {
		
		List<Object> roleAccessList = baseCommonService.selectListAll("cpsxRoleMapper.selectRoleAccessList");
		List<Long> roleIdList = new ArrayList<Long>();
		
		for(Object obj:roleAccessList){
			RBACRoleAccess ra = (RBACRoleAccess)obj;
			roleIdList.add(ra.getRoleId());
		}
		
		List<Object> results = baseCommonService.selectList("cpsxResourceMapper.selectResourceUrls",roleIdList); //取出所有有资源的角色的所有资源集合
		
		if (results != null && results.size() > 0) {
			Map<Long, List<String>> cache_map = new HashMap<Long, List<String>>();
			for (int i = 0; i < results.size(); i++) {
				RBACRoleAccess result = (RBACRoleAccess) results.get(i);
				if (cache_map.containsKey(result.getRoleId())) {
					List<String> cache_urls = cache_map.get(result.getRoleId());
					cache_urls.add(result.getAccessurl());
				} else {
					List<String> cache_urls = new ArrayList<String>();
					cache_urls.add(result.getAccessurl());
					cache_map.put(result.getRoleId(), cache_urls);
				}
			}
			
			for (Map.Entry<Long, List<String>> entry : cache_map.entrySet()) {
				cacheMapService.putCache(CacheConstant.RBAC_ROLE
						+ entry.getKey().toString(), entry.getValue());
			}

		}
		
	}

	@Override
	public boolean hasAccess(RBACRoleAccess roleAccess) {
			List<String> access = getRoleAccess(roleAccess);
			if (roleAccess != null && roleAccess.isvalidRole() && access != null
					&& access.size() > 0) {
				if (StringUtils.contains(roleAccess.getAccessurl(), "B5MCPC")) {
					roleAccess.setAccessurl(StringUtils.substring(
							roleAccess.getAccessurl(), "B5MCPC".length() + 1));
				}

				for (String allowAcceptUrl : access) {
					// 去掉参数然后比较
					int paramStartInd = allowAcceptUrl.indexOf('?');
					if (paramStartInd > -1) {
						allowAcceptUrl = allowAcceptUrl.substring(0, paramStartInd);
					}
					
					if (allowAcceptUrl.equals(roleAccess.getAccessurl())){
						return true;
					}else{
						Pattern p = Pattern.compile("^/\\w+/\\w+/"); //匹配二级菜单前缀，相同则通过拦截
						Matcher m=p.matcher(roleAccess.getAccessurl());
						Matcher n=p.matcher(allowAcceptUrl);
						String targetm = null;
						String targetn = null;
						if(m.find() && n.find()){  
							targetm = m.group();
							targetn = n.group();
						}
						if(!StringUtils.isBlank(targetm) && !StringUtils.isBlank(targetn) && targetm.equals(targetn)){
							return true;
						}
					}
				}

				// return access.contains(roleAccess.getAccessurl());
			}
			return false;
	}

	@SuppressWarnings("unchecked")
	public List<String> getRoleAccess(RBACRoleAccess roleAccess) {
		List<String> urls = null;
		if (roleAccess != null && roleAccess.isvalidRole()) {
			urls = (List<String>)cacheMapService.getCache(CacheConstant.RBAC_ROLE
					+ roleAccess.getRoleId().toString());
		}

		if (roleAccess == null || urls == null || urls.size() == 0) {
			refreshRoleAccess();
			urls = (List<String>)cacheMapService.getCache(CacheConstant.RBAC_ROLE
					+ roleAccess.getRoleId().toString());
		}
		return urls;
	}

	public long updateUserInfo(User user) throws UnsupportedEncodingException {
		int row_user = 0;
		int row_urole = 0;
		int suc = 0;
		int whetherExisit = (Integer) baseCommonService.selectOne("cpsxUserMapper.selectEmailExist", user);
		if(whetherExisit>1){
			return 0;
		}else{
			if (user.getPassword()!= null) {
				try {
					row_user = baseCommonService.update("cpsxUserMapper.updateUserInfo", user);
					if(row_user>0){
						if(user.getRoleIds()!=null){
							row_urole = (Integer) baseCommonService.selectOne("userRoleMapper.selectUserRoleCount",user);
							List<Map> params = new ArrayList<Map>();
							for(int i=0;i<user.getRoleIds().size();i++){
								Map<String, Object> map = new HashMap<String, Object>();
								map.put("roleId",user.getRoleIds().get(i));
								map.put("userId", user.getId());
								params.add(map);
							}
							if(row_urole>0){
								baseCommonService.delete("userRoleMapper.deleteUserRole",user);
							}
							suc = (Integer) baseCommonService.insert("userRoleMapper.insertUserRole", params);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
		   }
		}
		return suc;
	}

}
