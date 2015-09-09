package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * 用户
 * 
 * @author tyg
 * 
 */
public class User implements java.io.Serializable {
	private Long id;
	private Department department;
	private Set<Role> roles = new HashSet<Role>();

	private String loginName;
	private String password;
	/**
	 * 单位名或者用户名
	 */
	private String userName;
	/**
	 * 用户的名称
	 */
	private String name;
	private String sex="0";
	private String phoneNumber;
	private String email;
	private String description;
	private String avatarPath; // 头像的路径
	
	/**
	 * 用户类型分为 0  1  2
	 * 
	 *0 代表 网站后台管理用户
	 *1 代表 同业用户
	 *2 代表 直接用户
	 */
	private String userType;

	private Set<VisaOrder> visaOrderSet = new HashSet<VisaOrder>();

	
	
	
	/**
	 * 同行用户
	 */
	private  Set<Customer> peerSet= new HashSet<Customer>();

	/**
	 * 领区
	 */
	private  Set<Lingqu> lingquSet= new HashSet<Lingqu>();
	/**
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status="0";
	public Long getId() {
		return id;
	}

	public String getDel_status() {
		return del_status;
	}


	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}


	public Set<Lingqu> getLingquSet() {
		return lingquSet;
	}


	public void setLingquSet(Set<Lingqu> lingquSet) {
		this.lingquSet = lingquSet;
	}


	public void setId(Long id) {
		this.id = id;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

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

	public String getAvatarPath() {
		return avatarPath;
	}

	public void setAvatarPath(String avatarPath) {
		this.avatarPath = avatarPath;
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


	public Set<Customer> getPeerSet() {
		return peerSet;
	}

	public void setPeerSet(Set<Customer> peerSet) {
		this.peerSet = peerSet;
	}

	

}
