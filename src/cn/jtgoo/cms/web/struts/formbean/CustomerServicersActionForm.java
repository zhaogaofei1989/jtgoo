package cn.jtgoo.cms.web.struts.formbean;

import java.util.HashSet;
import java.util.Set;

import org.apache.struts.action.ActionForm;

import cn.jtgoo.cms.domain.VisaOrder;

/**
* 客服人员,为避免表数据太多，单独分离出客服表
 */
public class CustomerServicersActionForm extends ActionForm {

	/**
	 * 用户类型 0代表同业用户 1代表直接用户
	 */
	private String userType;
	/**
	 * 编号
	 */
	private Long id;

	/**
	 * 客户的流水号
	 */

	private String serialNumber;
	/**
	 * 客户名称
	 */
	private String name;
	/**
	 * 客户名称
	 */
	private String userName;
	/**
	 * 手机
	 */
	private String mobliePhone;
	/**
	 * 电话
	 */
  /**
   * 0 lock 1 unlock
   */
	private String status;
	

	
	/**
	 * 输入日期
	 */
	private String inputTime;
	
	/**
	 * 输入人员
	 */
	private String inputName;
	
	private String remark;
	
	private String phone;

	/**
	 * 通讯号码 qq 或者msn
	 */
	private String chatTools;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 身份证
	 */
	private String IdCart;

	/**
	 * 公司名称
	 */
	private String companyName;
	/**
	 * 公司电话
	 */

	private String companyPhone;

	/**
	 * 公司地址
	 */
	private String companyAddr;

	/**
	 * 家庭 地址
	 */

	private String address;

	/**
	 * 一个客户可能对应多个订单
	 * 
	 * @return
	 */

	private String remoteIp;
	private String position;

	private String updateTime;

	/**
	 * 一个客户 对应多个订单
	 * @return
	 */
	private Set<VisaOrder> visaOrderSet = new HashSet<VisaOrder>();
	/**
	 * 客户信息
	 */





	
	/**
	 * 注册时间
	 */
	private String regTime;






	public String getUserType() {
		return userType;
	}






	public void setUserType(String userType) {
		this.userType = userType;
	}






	public Long getId() {
		return id;
	}






	public void setId(Long id) {
		this.id = id;
	}






	public String getSerialNumber() {
		return serialNumber;
	}






	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}






	public String getName() {
		return name;
	}






	public void setName(String name) {
		this.name = name;
	}






	public String getUserName() {
		return userName;
	}






	public void setUserName(String userName) {
		this.userName = userName;
	}






	public String getMobliePhone() {
		return mobliePhone;
	}






	public void setMobliePhone(String mobliePhone) {
		this.mobliePhone = mobliePhone;
	}






	public String getStatus() {
		return status;
	}






	public void setStatus(String status) {
		this.status = status;
	}






	public String getInputTime() {
		return inputTime;
	}






	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}






	public String getInputName() {
		return inputName;
	}






	public void setInputName(String inputName) {
		this.inputName = inputName;
	}






	public String getRemark() {
		return remark;
	}






	public void setRemark(String remark) {
		this.remark = remark;
	}






	public String getPhone() {
		return phone;
	}






	public void setPhone(String phone) {
		this.phone = phone;
	}






	public String getChatTools() {
		return chatTools;
	}






	public void setChatTools(String chatTools) {
		this.chatTools = chatTools;
	}






	public String getEmail() {
		return email;
	}






	public void setEmail(String email) {
		this.email = email;
	}






	public String getIdCart() {
		return IdCart;
	}






	public void setIdCart(String idCart) {
		IdCart = idCart;
	}






	public String getCompanyName() {
		return companyName;
	}






	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}






	public String getCompanyPhone() {
		return companyPhone;
	}






	public void setCompanyPhone(String companyPhone) {
		this.companyPhone = companyPhone;
	}






	public String getCompanyAddr() {
		return companyAddr;
	}






	public void setCompanyAddr(String companyAddr) {
		this.companyAddr = companyAddr;
	}






	public String getAddress() {
		return address;
	}






	public void setAddress(String address) {
		this.address = address;
	}






	public String getRemoteIp() {
		return remoteIp;
	}






	public void setRemoteIp(String remoteIp) {
		this.remoteIp = remoteIp;
	}






	public String getPosition() {
		return position;
	}






	public void setPosition(String position) {
		this.position = position;
	}






	public String getUpdateTime() {
		return updateTime;
	}






	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}






	public Set<VisaOrder> getVisaOrderSet() {
		return visaOrderSet;
	}






	public void setVisaOrderSet(Set<VisaOrder> visaOrderSet) {
		this.visaOrderSet = visaOrderSet;
	}






	public String getRegTime() {
		return regTime;
	}






	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}



}
