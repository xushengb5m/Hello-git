/**
 * 资源访问(菜单)Model对象
 * @author johnson
 */
package com.b5m.cpsx.model;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 资源类,同时充当菜单
 * @author ldb,johnson
 *
 */
public class Resource extends EasyUiTreeNode<Resource> implements Serializable {
	
	private static final long serialVersionUID = -9001779575117862445L;
	private int id;
	private String resourceUrl;
	private String resourceName;
	private String ismenu;
	private int posorder;
//	private int topid=Integer.MAX_VALUE;
	private int topid=-1;
	private String clsname;
	//当作查询条件dto时候需要使用.
	private String engName;
	private int roleId;
	private List<Integer> roleIdList;

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public List<Integer> getRoleIdList() {
		return roleIdList;
	}

	public void setRoleIdList(List<Integer> roleIdList) {
		this.roleIdList = roleIdList;
	}

	public String getClsname() {
		return clsname;
	}

	public void setClsname(String clsname) {
		this.clsname = clsname;
	}

	public String getIsmenu() {
		return ismenu;
	}

	public void setIsmenu(String ismenu) {
		this.ismenu = ismenu;
	}

	public int getPosorder() {
		return posorder;
	}

	public void setPosorder(int posorder) {
		this.posorder = posorder;
	}

	public int getTopid() {
		return topid;
	}

	public void setTopid(int topid) {
		this.topid = topid;
	}

	public String getResourceName() {
		return resourceName;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	
	public String getRemark() {
		return resourceName;
	}

	public void setRemark(String mark) {
		this.resourceName = mark;
		this.setText(mark);
	}

	public Resource(){
		
	}
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getResourceUrl() {
		return resourceUrl;
	}

	public void setResourceUrl(String resourceUrl) {
		this.resourceUrl = resourceUrl;
	}

	/** 将easyuitree中所需要的属性添加到attributes属性下 **/
	public Map<String, String> getAttributes(){
		Map<String, String> map = new HashMap<String, String>();
		map.put("resourceName", this.resourceName);
		map.put("resourceUrl", this.resourceUrl);
		map.put("ismenu", this.ismenu);
		map.put("posorder", String.valueOf(this.posorder));
		map.put("topid", String.valueOf(this.topid));
		map.put("clsname", this.clsname == null ? "" : this.clsname);
		map.put("engName", this.engName == null ? "" : this.engName);
		map.put("id", String.valueOf(this.id));
		return map;
	}

	public String getEngName() {
		return engName;
	}

	public void setEngName(String engName) {
		this.engName = engName;
	}
}
