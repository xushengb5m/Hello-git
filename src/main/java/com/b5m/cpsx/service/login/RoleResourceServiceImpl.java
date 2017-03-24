package com.b5m.cpsx.service.login;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.b5m.cpsx.commons.constant.CacheConstant;
import com.b5m.cpsx.dao.IBaseCommonMapper;
import com.b5m.cpsx.model.CpsxRole;
import com.b5m.cpsx.service.cache.CacheMapService;

@Service("roleResourceService")
public class RoleResourceServiceImpl implements IRoleResourceService{
	
	@Autowired
	protected IBaseCommonMapper baseCommonMapper;
	
	@Autowired
	private CacheMapService cacheMapService;
	

	@Override
	public int updateRoleResource(CpsxRole role, List<Map> params) {
		int suc = 1;
		try {
			baseCommonMapper.delete("roleResourceMapper.delRoleResource", Long.valueOf(role.getId()));
			baseCommonMapper.update("cpsxRoleMapper.updateRole", role);
			baseCommonMapper.insert("roleResourceMapper.bindResourceRoleBatch", params);
			for (int i = 1; i < 99; i++) {
				cacheMapService.removeCache(CacheConstant.RBAC_ROLE + i);
			}
		} catch (Exception e) {
			e.printStackTrace();
			suc=0;
		}
		return suc;
	}

}
