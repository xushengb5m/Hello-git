package com.b5m.cpsx.model;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.CharEncoding;
import org.apache.commons.lang3.StringUtils;

public class User implements Serializable{
	/** 
	 * @Fields serialVersionUID : TODO 
	 */ 
	private static final long serialVersionUID = -3823043574831776030L;
	private int id;
	private String userName;
	private String email;
	private String password;
	private long userType;
	private String realName;
	private long accountType;
	private String mobTel;
	private String fixTel;
	private String qq;
	private String address;
	private String zipCode;
	private String introduction;
	private String status;
	private String roleNumbers;
	private List<Integer> roleIds = new ArrayList<Integer>();
	private int roleId;
	private String authCode;
	private String roleName;

	private Timestamp createTime = new Timestamp(new Date().getTime());
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		if (StringUtils.isNotBlank(password) && !password.equals("******")) {
			try {
				return DigestUtils
						.md5Hex(DigestUtils.md5Hex(password
								.getBytes(CharEncoding.UTF_8))
								+ DigestUtils.md5Hex(email
										.getBytes(CharEncoding.UTF_8)));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public long getUserType() {
		return userType;
	}
	public void setUserType(long userType) {
		this.userType = userType;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	/** 
	 * @return realName 
	 */
	public String getRealName() {
		return realName;
	}
	/** 
	 * @param realName 要设置的 realName 
	 */
	public void setRealName(String realName) {
		this.realName = realName;
	}
	/** 
	 * @return accountType 
	 */
	public long getAccountType() {
		return accountType;
	}
	/** 
	 * @param accountType 要设置的 accountType 
	 */
	public void setAccountType(long accountType) {
		this.accountType = accountType;
	}
	/** 
	 * @return qq 
	 */
	public String getQq() {
		return qq;
	}
	/** 
	 * @param qq 要设置的 qq 
	 */
	public void setQq(String qq) {
		this.qq = qq;
	}
	/** 
	 * @return address 
	 */
	public String getAddress() {
		return address;
	}
	/** 
	 * @param address 要设置的 address 
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/** 
	 * @return introduction 
	 */
	public String getIntroduction() {
		return introduction;
	}
	/** 
	 * @param introduction 要设置的 introduction 
	 */
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	/** 
	 * @return status 
	 */
	public String getStatus() {
		return status;
	}
	/** 
	 * @param status 要设置的 status 
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/** 
	 * @return roleIds 
	 */
	public List<Integer> getRoleIds() {
		return roleIds;
	}
	/** 
	 * @param roleIds 要设置的 roleIds 
	 */
	public void setRoleIds(List<Integer> roleIds) {
		this.roleIds = roleIds;
	}
	/** 
	 * @return mobTel 
	 */
	public String getMobTel() {
		return mobTel;
	}
	/** 
	 * @param mobTel 要设置的 mobTel 
	 */
	public void setMobTel(String mobTel) {
		this.mobTel = mobTel;
	}
	/** 
	 * @return fixTel 
	 */
	public String getFixTel() {
		return fixTel;
	}
	/** 
	 * @param fixTel 要设置的 fixTel 
	 */
	public void setFixTel(String fixTel) {
		this.fixTel = fixTel;
	}
	/** 
	 * @return zipCode 
	 */
	public String getZipCode() {
		return zipCode;
	}
	/** 
	 * @param zipCode 要设置的 zipCode 
	 */
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	
	public void rolesHandling(){
		if(this.roleNumbers!=null){
			String rds[] = this.roleNumbers.split(",");
			for(int i=0;i<rds.length;i++){
				this.roleIds.add(Integer.parseInt(rds[i]));
			}
		}
	}
	/** 
	 * @return roleNumbers 
	 */
	public String getRoleNumbers() {
		return roleNumbers;
	}
	/** 
	 * @param roleNumbers 要设置的 roleNumbers 
	 */
	public void setRoleNumbers(String roleNumbers) {
		this.roleNumbers = roleNumbers;
	}
	
}