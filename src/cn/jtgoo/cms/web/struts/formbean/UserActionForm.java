package cn.jtgoo.cms.web.struts.formbean;

import java.util.HashSet;
import java.util.Set;

import org.apache.struts.action.ActionForm;

import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.VisaOrder;

@SuppressWarnings("serial")
public class UserActionForm extends ActionForm {
	private Long id;
	private Long departmentId;
	private Long[] roleIds;

	private String loginName;
	private String userName;
//	private String password;
	private String name;
	private String sex;
	private String phoneNumber;
	private String email;
	private String description;
	/**
	 * 用户类型分为 0  1  2
	 * 
	 *0 代表 网站后台管理用户
	 *1 代表 同业用户
	 *2 代表 直接用户
	 */
	private String userType;

	private Set<VisaOrder> visaOrderSet = new HashSet<VisaOrder>();

	private Set<Lingqu> lingquSet = new HashSet<Lingqu>();

	private Long[] userIds;
	public Long getId() {
		return id;
	}

	public Set<Lingqu> getLingquSet() {
		return lingquSet;
	}

	public void setLingquSet(Set<Lingqu> lingquSet) {
		this.lingquSet = lingquSet;
	}

	public Long[] getUserIds() {
		return userIds;
	}

	public void setUserIds(Long[] userIds) {
		this.userIds = userIds;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Long departmentId) {
		this.departmentId = departmentId;
	}

	public Long[] getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(Long[] roleIds) {
		this.roleIds = roleIds;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
//
//	public String getPassword() {
//		return password;
//	}
//
//	public void setPassword(String password) {
//		this.password = password;
//	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}


	public Set<VisaOrder> getVisaOrderSet() {
		return visaOrderSet;
	}

	public void setVisaOrderSet(Set<VisaOrder> visaOrderSet) {
		this.visaOrderSet = visaOrderSet;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
