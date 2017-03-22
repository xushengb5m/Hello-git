package com.b5m.cpsx.service.login;

import java.io.UnsupportedEncodingException;
import java.util.List;

import com.b5m.cpsx.model.RBACRoleAccess;
import com.b5m.cpsx.model.User;

public interface IRBACService {
	
	void refreshRoleAccess();
	
	public boolean hasAccess(RBACRoleAccess roleAccess);
	
	public List<String> getRoleAccess(RBACRoleAccess roleAccess);

	long updateUserInfo(User user) throws UnsupportedEncodingException;
	
}
