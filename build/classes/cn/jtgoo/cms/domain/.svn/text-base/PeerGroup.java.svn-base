package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;


/**
 * 用户
 * 
 * @author zhaogaofei
 * 
 */
public class PeerGroup implements java.io.Serializable {
	private Long id;
	
/**
 * 分类名称
 */
	private String name;
	/**
	 * 分类描述  代表分类所管辖的地方
	 */
	private String description;
	/**
	 * 会员数
	 */
	private Integer memberCount;
	/**
	 * 同业用户列表
	 */
	private  Set<Customer> customerSet= new HashSet<Customer>();
//
//	/**
//	 * 一个签证类型可以对应多个签证产品
//	 */
//	private Set<VisaProduct> visaProductSet = new HashSet<VisaProduct>();
	/**
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status="0";
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
	public Integer getMemberCount() {
		return memberCount;
	}
	public void setMemberCount(Integer memberCount) {
		this.memberCount = memberCount;
	}
	public Set<Customer> getCustomerSet() {
		return customerSet;
	}
	public void setCustomerSet(Set<Customer> customerSet) {
		this.customerSet = customerSet;
	}
	public String getDel_status() {
		return del_status;
	}
	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}




}
