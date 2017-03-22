package com.b5m.cpsx.model;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;

/**
 * @author janwen
 * Apr 12, 2013 4:02:07 PM
 * 
 */
public class RBACRoleAccess  implements Serializable{

	
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RBACRoleAccess [rolename=" + roleName + ", accessurl="
				+ accessurl + "]";
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -3682019618273191174L;
	private String roleName;
	
	
	private Long roleId;

	
	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	/**
	 * @return the rolename
	 */
	public String getRoleName() {
		return roleName;
	}

	/**
	 * @param rolename the rolename to set
	 */
	public void setRolename(String roleName) {
		this.roleName = roleName;
	}

	/**
	 * @return the accessurl
	 */
	public String getAccessurl() {
		return accessurl;
	}

	/**
	 * @param accessurl the accessurl to set
	 */
	public void setAccessurl(String accessurl) {
		this.accessurl = accessurl;
	}

	private String accessurl;
	
	
	public boolean isvalidRole(){
		return StringUtils.isNotBlank(getRoleName()) && NumberUtils.isNumber(getRoleId()+"");
	}
}
