package cn.jtgoo.cms.domain;


/**
 * 用户
 * 
 * @author zhaogaofei 预定客户
 * 
 */
@SuppressWarnings("serial")
public class ReserveOrder implements java.io.Serializable {
	/**
	 * 数据库主键
	 */
	private Long id;
	
	/**
	 * 业务id 
	 */
	private int business_id;

	
	/**
	 * 产品名称
	 */
	private String product_name;
	/**
	 * 产品id
	 */
	private Long product_id;
	
	
	/**
	 * 订单价格
	 */
	private String order_price;
	
	/**
	*客户名称
	 */
	private String customer_name;
	/*
	 * 电话号码
	 */
	private String mobile_phone;
	/**
	 * 邮箱
	 */
	private String mail;
	/**
	 * 出发城市
	 */
	private String city;
	/**
	 * 成人客户数
	 */
	private String number_of_people1;
	/**
	 * 0-12岁人数
	 */
	private String number_of_people2;
	
	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 时间
	 */
	private String register_time;
	
	/**
	 * ip
	 */
	private String ip_addr;

	
	private String del_status;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getBusiness_id() {
		return business_id;
	}

	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getOrder_price() {
		return order_price;
	}

	public void setOrder_price(String order_price) {
		this.order_price = order_price;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public String getMobile_phone() {
		return mobile_phone;
	}

	public void setMobile_phone(String mobile_phone) {
		this.mobile_phone = mobile_phone;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getNumber_of_people1() {
		return number_of_people1;
	}

	public void setNumber_of_people1(String number_of_people1) {
		this.number_of_people1 = number_of_people1;
	}

	public String getNumber_of_people2() {
		return number_of_people2;
	}

	public void setNumber_of_people2(String number_of_people2) {
		this.number_of_people2 = number_of_people2;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRegister_time() {
		return register_time;
	}

	public void setRegister_time(String register_time) {
		this.register_time = register_time;
	}

	public String getIp_addr() {
		return ip_addr;
	}

	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
	}

	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}

	public Long getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Long product_id) {
		this.product_id = product_id;
	}


	
}