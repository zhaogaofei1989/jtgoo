package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * 
 * @author alex 资料类型详情表 一个资料类型可以包括多个资料详情 在职人员-0 退休人员-1 学生及未成年人-2 自由职业-3 不分职业-4
 */
public class DataTypeDetail {

	/**
	 * 编号
	 */
	private Long id;

	
	private Integer sort =0;
	/**
	 * 类型
	 */
	private String type;

	/**
	 * 标题
	 */
	private String title;

	/****
	 * 内容
	 */
	private String content;
	
	/**
	 * 资料类型
	 */
	private DataType dataType;
	
	/**
	 * 加标记
	 */
	private String sign;
	/**
	 * 签证产品
	 */
	private VisaProduct visaProduct;
	

	
	/**
	 * 状态
	 */
	private String status;
	

	/**
	 * 对客户是多对多的关系
	 * @return
	 * 
	 */
	private Set<Customer> customerSet=new HashSet<Customer>();
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




	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public DataType getDataType() {
		return dataType;
	}

	public void setDataType(DataType dataType) {
		this.dataType = dataType;
	}

	

	public void setContent(String content) {
		this.content = content;
	}

	public VisaProduct getVisaProduct() {
		return visaProduct;
	}

	public void setVisaProduct(VisaProduct visaProduct) {
		this.visaProduct = visaProduct;
	}

	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Set<Customer> getCustomerSet() {
		return customerSet;
	}

	public void setCustomerSet(Set<Customer> customerSet) {
		this.customerSet = customerSet;
	}



}
