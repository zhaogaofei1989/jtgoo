package cn.jtgoo.cms.domain;
 
import java.util.HashSet;
import java.util.Set;

import cn.jtgoo.cms.util.NumberFormatTools;

/**
 **
 *从 customer 表中 提取出直接用户
 * 
 * 该表包涵 会员用户
 * 和直接用户
 */
public class Member {
	

	/**
	 * 用户类型 0代表同业用户 1代表直接用户,2代表会员用户
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
	 * 业务
	 */
	
	private String business_content;
	/**
	 * 电话
	 */
  /**
   * 0 lock 1 unlock,2 applying
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
	private String price;
	
	
	/**
	 * 客服姓名
	 */
	
	private String customerServiceNames;
	
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
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status="0";


	/**
	 * 与产品是多对多
	 */
	private Set<VisaProduct> visaProductSet = new HashSet<VisaProduct>();
	
	/**
	 * 一个客户有多个客服
	 */
	private Set<CustomerServicersVo> customerServicers = new HashSet<CustomerServicersVo>();

	
	
	
	/**
	 * 一个同业可以有多个联系人
	 */
	private Set<CustomerServicersVo> linkMans = new HashSet<CustomerServicersVo>();
	/**
	 * 客户信息
	 */

	/**
	 * 同业用户或者直接用户
	 */
	private Member otherUser;
	/**
	 * 同业或者 直接用户与客户的关系
	 */
	private Set<Member> children = new HashSet<Member>();
	
	
	
	
	/**
	 * 资料详情  多对多的关系
	 */
	private Set<DataTypeDetail> dataTypeDetailSet = new HashSet<DataTypeDetail>();

	/**
	 * 注册时间
	 */

	/**
	 * 领区
	 */
	private Set<Lingqu> lingquSet = new HashSet<Lingqu>();
	
	/**
	 * 同业用户组
	 */
	private PeerGroup peerGroup;
	
	/**
	 * 销售人员
	 */
	
	private User saler;
	
	
	/**
	 * 注册时间
	 */
	private String regTime;

	
	/**职业划分
	 * occupation
	 * @return
	 */
	private String occupation="1";
	
	private String schoolName;
	private String schoolAddr;
	private String professional;
	private String operator;
	/**
	 * 职业说明
	 */
	private String description;
	
	
	
	
	
	
	
	
	
	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}

	public String getOperator() {
		return operator;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set<CustomerServicersVo> getLinkMans() {
		return linkMans;
	}

	public void setLinkMans(Set<CustomerServicersVo> linkMans) {
		this.linkMans = linkMans;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public Long getId() {
		return id;
	}

	public Set<CustomerServicersVo> getCustomerServicers() {
		return customerServicers;
	}

	public String getCustomerServiceNames() {
		return customerServiceNames;
	}

	public void setCustomerServiceNames(String customerServiceNames) {
		this.customerServiceNames = customerServiceNames;
	}

	public void setCustomerServicers(Set<CustomerServicersVo> customerServicers) {
		this.customerServicers = customerServicers;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Set<Lingqu> getLingquSet() {
		return lingquSet;
	}

	public void setLingquSet(Set<Lingqu> lingquSet) {
		this.lingquSet = lingquSet;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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


	public String getBusiness_content() {
		return business_content;
	}

	public void setBusiness_content(String business_content) {
		this.business_content = business_content;
	}

	public void setIdCart(String idCart) {
		IdCart = idCart;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	
	public String getStatus() {
		return status;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobliePhone() {
		return mobliePhone;
	}

	public void setMobliePhone(String mobliePhone) {
		this.mobliePhone = mobliePhone;
	}

	public String getChatTools() {
		return chatTools;
	}

	public void setChatTools(String chatTools) {
		this.chatTools = chatTools;
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

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
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







	public Member getOtherUser() {
		return otherUser;
	}

	public void setOtherUser(Member otherUser) {
		this.otherUser = otherUser;
	}

	public Set<Member> getChildren() {
		return children;
	}

	public void setChildren(Set<Member> children) {
		this.children = children;
	}

	public Set<DataTypeDetail> getDataTypeDetailSet() {
		return dataTypeDetailSet;
	}

	public void setDataTypeDetailSet(Set<DataTypeDetail> dataTypeDetailSet) {
		this.dataTypeDetailSet = dataTypeDetailSet;
	}

	public String getRegTime() {
		return regTime==""?NumberFormatTools.getCurrentTime():regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public PeerGroup getPeerGroup() {
		return peerGroup;
	}

	public void setPeerGroup(PeerGroup peerGroup) {
		this.peerGroup = peerGroup;
	}

	public String getOccupation() {
		return occupation==null?"1":occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public User getSaler() {
		return saler;
	}


	public void setSaler(User saler) {
		this.saler = saler;
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

	public Set<VisaProduct> getVisaProductSet() {
		return visaProductSet;
	}

	public void setVisaProductSet(Set<VisaProduct> visaProductSet) {
		this.visaProductSet = visaProductSet;
	}


}
