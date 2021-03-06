package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

/**
 * 用户
 * 
 * @author zhaogaofei 签证国家类型
 * 
 * 分为 欧洲申根国家 欧洲非申根国家 亚洲 美洲 非洲 大洋洲 每个下边都有子 代表各个国家
 */
@SuppressWarnings("serial")
public class Country implements java.io.Serializable {
	/**
	 * 数据库主键
	 */
	private Long id;
	
	/**
	 * 业务id 
	 */
	private int business_id;

	/**
	 * 分类名称
	 */
	private String name;
	
	/**
	 * 图片路径
	 */
	private String icon;
	
	/**
	 * 分类描述 代表分类所管辖的地方
	 */
	private String description;
	/*
	 * 申根国家 非申根国家
	 */
	private Country parent;
	/**
	 * 中国 德国 美国等国家
	 */
	private Set<Country> coutryChild = new LinkedHashSet<Country>();

	/**
	 * 一个签证类型可以对应多个签证产品
	 */
	private Set<VisaProduct> visaProductSet = new HashSet<VisaProduct>();
	private String del_status="0";
	private boolean isparent=true;
	
	
	public boolean isIsparent() {
		return isparent;
	}

	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}

	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public Country getParent() {
		return parent;
	}

	public void setParent(Country parent) {
		this.parent = parent;
	}

	public Set<Country> getCoutryChild() {
		return coutryChild;
	}

	public void setCoutryChild(Set<Country> coutryChild) {
		this.coutryChild = coutryChild;
	}

	public void setVisaProductSet(Set<VisaProduct> visaProductSet) {
		this.visaProductSet = visaProductSet;
	}

	public Set<VisaProduct> getVisaProductSet() {
		return visaProductSet;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public int getBusiness_id() {
		return business_id;
	}

	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}

	

}
