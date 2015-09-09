package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;
   
/**
 * 用户
 * 
 * @author zhaogaofei 保险类型 主要分为 平安保险，泰康人寿,畅意游险，美亚保险
 * 
 * 
 */
@SuppressWarnings("serial")
public class InsuranceType implements java.io.Serializable {
	private Long id;

	/**
	 * 保险名称
	 */
	private String name;
	/**
	 * 保险描述 或者备注
	 */
	private String description;

	/**
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status = "0";
	/**
	 * 一个保险类型 对应多个保险套餐
	 */
	private Set<InsurancePackage> insurancePackageSet = new HashSet<InsurancePackage>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
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

	public Set<InsurancePackage> getInsurancePackageSet() {
		return insurancePackageSet;
	}

	public void setInsurancePackageSet(Set<InsurancePackage> insurancePackageSet) {
		this.insurancePackageSet = insurancePackageSet;
	}

}
