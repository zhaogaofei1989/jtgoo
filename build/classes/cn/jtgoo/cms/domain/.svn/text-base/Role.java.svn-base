package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * 岗位或者角色
 * 
 * @author zgf
 * 
 */
public class Role implements java.io.Serializable {
	private Long id;
	private String name;
	private String description;
	private Set<User> users = new HashSet<User>();
	/**
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status="0";
	private Set<Resource> resources = new HashSet<Resource>();

	/**
	 * 代表4中类型
	 * 0  代表系统或者后台用户
	 * 1  代表网站前台
	 * 2  代表同业用户
	 * 3  代表直接用户
	 * 在用户进行上传附件时需要进行绑定
	 */
	private String roleType;
	public Long getId() {
		return id;
	}

	public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set<Resource> getResources() {
		return resources;
	}

	public void setResources(Set<Resource> resources) {
		this.resources = resources;
	}

	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}

}
