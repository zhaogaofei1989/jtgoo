package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * 用户
 * 
 * @author zhaogaofei 保险套餐，每个保险都有1到 n个套餐
 */
@SuppressWarnings("serial")
public class InsurancePackage implements java.io.Serializable {
	private Long id;
	/**
	 * 分类名称
	 */
	private String name;
	
	//成人
	Double price1;
	//0-6岁儿童
	Double price2;
	//6-12 岁儿童
	Double price3;
	/**
	 * 分类描述 代表分类所管辖的地方
	 */
	private String description;

	/**
	 * 文件路径
	 */
	private String path;
	private Long baoxian_att_id;
	/**
	 * 保险类型
	 */
	private InsuranceType insuranceType;
	private BaoXianAttachment baoXianAttachment;
	/**
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status = "0";

	/**
	 * 一个签证类型可以对应多个签证产品
	 */
	
	private Set<VisaProduct> visaProductSet = new HashSet<VisaProduct>();
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

	public InsuranceType getInsuranceType() {
		return insuranceType;
	}

	public void setInsuranceType(InsuranceType insuranceType) {
		this.insuranceType = insuranceType;
	}

	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Long getBaoxian_att_id() {
		return baoxian_att_id;
	}

	public void setBaoxian_att_id(Long baoxian_att_id) {
		this.baoxian_att_id = baoxian_att_id;
	}

	public BaoXianAttachment getBaoXianAttachment() {
		return baoXianAttachment;
	}

	public void setBaoXianAttachment(BaoXianAttachment baoXianAttachment) {
		this.baoXianAttachment = baoXianAttachment;
	}

	public Set<VisaProduct> getVisaProductSet() {
		return visaProductSet;
	}

	public void setVisaProductSet(Set<VisaProduct> visaProductSet) {
		this.visaProductSet = visaProductSet;
	}

	public Double getPrice1() {
		return price1;
	}

	public void setPrice1(Double price1) {
		this.price1 = price1;
	}

	public Double getPrice2() {
		return price2;
	}

	public void setPrice2(Double price2) {
		this.price2 = price2;
	}

	public Double getPrice3() {
		return price3;
	}

	public void setPrice3(Double price3) {
		this.price3 = price3;
	}


}
