package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * 资源：菜单、超链接
 * 
 * @author tyg
 * 
 */
public class Resource implements Comparable<Resource>, java.io.Serializable {
	private Long id;
	private Set<Role> roles = new HashSet<Role>();

	private Resource parent;
	private Set<Resource> children = new HashSet<Resource>();
    private String tag;
	private String name;
	private String url;
	private String icon; // 一级菜单用的图标
	private String level;
	private String type;
	
	public Resource() {
	}

	public Resource(String name, String url, String icon,String tag,Resource parent) {
		this.url = url;
		this.name = name;
		this.icon = icon;
		this.tag= tag;
		this.parent = parent;
	}

	/**
	 * 返回比较结果：
	 * 
	 * 大于0，表示我小于参数
	 * 
	 * 等于0，表示我等于参数
	 * 
	 * 小于0，表示我大于参数
	 * 
	 */
	public int compareTo(Resource o) {
		return new Long(this.id - o.id).intValue();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Resource getParent() {
		return parent;
	}

	public void setParent(Resource parent) {
		this.parent = parent;
	}

	public Set<Resource> getChildren() {
		return children;
	}

	public void setChildren(Set<Resource> children) {
		this.children = children;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

}
