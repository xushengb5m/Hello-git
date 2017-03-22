/**
 * @author ldb
 * @dateTime 2013-4-11 下午3:04:02
 */
package com.b5m.cpsx.model;

/**
 * DMP角色类
 * @author ldb
 *
 */
public class CpsxRole {
	
	private int id;//角色主键
	private String role;//角色名
	private String remark;//备注
	
	public CpsxRole() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}	
}
