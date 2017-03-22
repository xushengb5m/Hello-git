package com.b5m.cpsx.service.login;

import java.util.List;
import java.util.Map;

import com.b5m.cpsx.model.CpsxRole;

public interface IRoleResourceService{
	int updateRoleResource(CpsxRole role, List<Map> params);
}
