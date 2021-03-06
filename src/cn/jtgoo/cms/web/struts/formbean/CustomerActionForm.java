package cn.jtgoo.cms.web.struts.formbean;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.apache.struts.action.ActionForm;

import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.util.NumberFormatTools;

public class CustomerActionForm extends ActionForm {
	private Long id;
	private String name;
	private String visaProductId;
	/**
	 *手机 
	 */
	private String mobliePhone;
	/**
	 * 电话
	 */
	private String phone;
	/**
	 * 通讯号码 qq 或者msn
	 */
	private String chatTools;
	private String address;
	//业务
	private String business_content;
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
	 *家庭 地址
	 */
	
	private String serialNumber;
	private String userName;
	private String remoteIp;
	private String updateTime;
	private String customService;
	private String position;
	private String peergroupId="0";
	private String salerId;
//	private PeerGroup peerGroupForm;

	/**
	 * 0 lock 1 unlock
	 */
	private String status;

	/**
	 * 0 yes 1 no
	 */
	private String isPeer;
	/**
	 * peername
	 */
	private String peerName;

	/**
	 * 输入日期
	 */
	private String inputTime;

	/**
	 * 输入人员
	 */
	private String inputName;

	/**
	 * 密码
	 */
	private String passwd;
	/**
	 * 确认密码
	 */
	private String confirmPasswd;

	/**
	 * 同业价格
	 */
	private String peerPrice;
	

	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 职业说明
	 */
	private String description;
	/**
	 * 同业用户或者直接用户
	 */
//	private Customer parentForm;
//	/**
//	 * 同业或者 直接用户与客户的关系
//	 */
//	private Set<Customer> childrenForm = new HashSet<Customer>();
//	private Set<DataTypeDetail> dataTypeDetailSetForm = new HashSet<DataTypeDetail>();
//	private Set<Lingqu> lingquSetForm = new HashSet<Lingqu>();

	private Long[] customerIds;
	private String regTime;
	private String occupation="1";
	private String schoolName;
	private String schoolAddr;
	private String professional;
	private String operator;
	private Set<CustomerServicersVo> customerServicersVo = new HashSet<CustomerServicersVo>();
	private Long[] visaProductArraysPrice=new Long[100];
	
	public String getRegTime() {
		return regTime==null?NumberFormatTools.getCurrentTime():regTime;
	}

	public Long[] getVisaProductArraysPrice() {
		return visaProductArraysPrice;
	}

	public void setVisaProductArraysPrice(Long[] visaProductArraysPrice) {
		this.visaProductArraysPrice = visaProductArraysPrice;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	
	public Set<CustomerServicersVo> getCustomerServicersVo() {
		return customerServicersVo;
	}

	public void setCustomerServicersVo(Set<CustomerServicersVo> customerServicersVo) {
		this.customerServicersVo = customerServicersVo;
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

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}


	public String getPeergroupId() {
		return peergroupId;
	}

	public void setPeergroupId(String peergroupId) {
		this.peergroupId = peergroupId;
	}

	public String getMobliePhone() {
		return mobliePhone;
	}

	public void setMobliePhone(String mobliePhone) {
		this.mobliePhone = mobliePhone;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRemoteIp() {
		return remoteIp;
	}

	public void setRemoteIp(String remoteIp) {
		this.remoteIp = remoteIp;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}


//	public PeerGroup getPeerGroupForm() {
//		return peerGroupForm;
//	}
//
//	public void setPeerGroupForm(PeerGroup peerGroupForm) {
//		this.peerGroupForm = peerGroupForm;
//	}

//	public Customer getParentForm() {
//		return parentForm;
//	}
//
//	public void setParentForm(Customer parentForm) {
//		this.parentForm = parentForm;
//	}

	

	public String getVisaProductId() {
		return visaProductId;
	}

	public void setVisaProductId(String visaProductId) {
		this.visaProductId = visaProductId;
	}

//
//	public Set<Customer> getChildrenForm() {
//		return childrenForm;
//	}
//
//	public void setChildrenForm(Set<Customer> childrenForm) {
//		this.childrenForm = childrenForm;
//	}
//
//	public Set<DataTypeDetail> getDataTypeDetailSetForm() {
//		return dataTypeDetailSetForm;
//	}
//
//	public void setDataTypeDetailSetForm(Set<DataTypeDetail> dataTypeDetailSetForm) {
//		this.dataTypeDetailSetForm = dataTypeDetailSetForm;
//	}
//
//	public Set<Lingqu> getLingquSetForm() {
//		return lingquSetForm;
//	}
//
//	public void setLingquSetForm(Set<Lingqu> lingquSetForm) {
//		this.lingquSetForm = lingquSetForm;
//	}

	public String getCustomService() {
		return customService;
	}

	public void setCustomService(String customService) {
		this.customService = customService;
	}

	public Long[] getCustomerIds() {
		return customerIds;
	}

	public void setCustomerIds(Long[] customerIds) {
		this.customerIds = customerIds;
	}

	public String getStatus() {
		return status==null?"0":status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIsPeer() {
		return isPeer;
	}

	public void setIsPeer(String isPeer) {
		this.isPeer = isPeer;
	}

	public String getPeerName() {
		return peerName;
	}

	public void setPeerName(String peerName) {
		this.peerName = peerName;
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

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getConfirmPasswd() {
		return confirmPasswd;
	}

	public void setConfirmPasswd(String confirmPasswd) {
		this.confirmPasswd = confirmPasswd;
	}


	public String getPeerPrice() {
		return peerPrice;
	}

	public void setPeerPrice(String peerPrice) {
		this.peerPrice = peerPrice;
	}



	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public String getEndTime() {
	
		return 	new Date().toString();
	}

	public String getSalerId() {
		return salerId;
	}

	public void setSalerId(String salerId) {
		this.salerId = salerId;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getSchoolAddr() {
		return schoolAddr;
	}

	public void setSchoolAddr(String schoolAddr) {
		this.schoolAddr = schoolAddr;
	}

	public String getProfessional() {
		return professional;
	}

	public void setProfessional(String professional) {
		this.professional = professional;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getBusiness_content() {
		return business_content;
	}

	public void setBusiness_content(String business_content) {
		this.business_content = business_content;
	}





}
