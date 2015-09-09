package cn.jtgoo.cms.web.struts.formbean;

import org.apache.struts.action.ActionForm;

import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.VisaType;

@SuppressWarnings("serial")
public class VisaProductActionForm extends ActionForm {
	private Long id;
	private String serialNumber;
	private String icon;
	private String name;

	/**
	 * 签证国家
	 */
	private Country country;

	/**
	 * 签证领区
	 */
	private Lingqu lingqu;

	/**
	 * 单次多次
	 */
	private String oneToManySelect;
	/**
	 * 签证类型
	 */
	private VisaType type;

	/**
	 * 是否面试
	 * 
	 * @return 0代表是1代表否
	 */
	private String isInterview;
	private String isNeedToAppointment;

	/**
	 * 签证申请周期
	 * 
	 * @return
	 */

	String visaApplyCycle;

	/**
	 * 一般签证有效期
	 */

	String visaValid;

	/**
	 * 一般停留期
	 */
	String periodOfStay;
	/**
	 * 受理范围
	 */
	String scopeOfAcceptance;
	/**
	 * 国旗 图片
	 */
	String nationalFlag;

	/**
	 * 服务费 成人 0-6岁儿童 6-12岁儿童 servicefee1 servicefee2 servicefee3
	*/
	Double bookFee;
	Double bookFee1;
	Double bookFee2;
	Double visaFee;
	Double visaFee1;
	Double visaFee2;

	/**
	 * textarea 价格说明
	 */
	String priceDesc;

	/**
	 * textarea 签证备注
	 */

	String visaRemarks;
	/**
	 * textarea 签证材料
	 */

	String visaMaterials;

	/**
	 * textarea 递交申请及面试
	 */
	String submitApplicationAndInterview;
	/**
	 * 领区划分
	 */
	String lingquDivide;
	/**
	 * 预约面试
	 */
	String bookingInterview;

	/**
	 * 1 2 3 同业用户服务费基准价
	 */

	/**
	 * 1 2 3 签证费
	 */

	/**
	 * 1 2 3 预约费
	 */

	/**
	 * 签证查询和领取
	 */
	String visaQueryAndReceive;

	/**
	 * 签证资料先不显示
	 */

	/**
	 * 受理类型 0 代送 1 包签
	 */
	private String acceptType;

	/**
	 * 报价是否含有签证费用 0是 1 否
	 */
	private String quotationHasVisaPrice;

	/**
	 * 预约需要的信息
	 * 
	 * @return
	 */
	private String bookingInformationNeeds;
	/**
	 * 使领馆和签证中心地址
	 * 
	 * @return
	 */
	private String consularAndVisaCenterAddress;

	/**
	 * 如果进行签证查询
	 */
	private String howToQueryVisaInfo;

	/**
	 * 签证的领取
	 * 
	 * @return
	 */
	private String getVisaInfo;

	/**
	 * 免责声明
	 * 
	 * @return
	 */
	private String disclaimer;

	/**
	 * 网址连接
	 * 
	 * @return
	 */

	private String webSiteLink;

	private String updateTime;

	private String serviceFee1;
	public String getWebSiteLink() {
		return webSiteLink;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public void setWebSiteLink(String webSiteLink) {
		this.webSiteLink = webSiteLink;
	}

	public String getOneToManySelect() {
		return oneToManySelect;
	}

	public void setOneToManySelect(String oneToManySelect) {
		this.oneToManySelect = oneToManySelect;
	}

	public String getSerialNumber() {
		
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public Double getBookFee() {
		return bookFee;
	}

	public void setBookFee(Double bookFee) {
		this.bookFee = bookFee;
	}

	public Double getBookFee1() {
		return bookFee1;
	}

	public void setBookFee1(Double bookFee1) {
		this.bookFee1 = bookFee1;
	}

	public Double getBookFee2() {
		return bookFee2;
	}

	public void setBookFee2(Double bookFee2) {
		this.bookFee2 = bookFee2;
	}

	public Double getVisaFee() {
		return visaFee;
	}

	public void setVisaFee(Double visaFee) {
		this.visaFee = visaFee;
	}

	public Double getVisaFee1() {
		return visaFee1;
	}

	public void setVisaFee1(Double visaFee1) {
		this.visaFee1 = visaFee1;
	}

	public Double getVisaFee2() {
		return visaFee2;
	}

	public void setVisaFee2(Double visaFee2) {
		this.visaFee2 = visaFee2;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
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

	public Country getCountry() {
		return country;
	}

	public String getBookingInterview() {
		return bookingInterview;
	}

	public void setBookingInterview(String bookingInterview) {
		this.bookingInterview = bookingInterview;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public Lingqu getLingqu() {
		return lingqu;
	}

	public void setLingqu(Lingqu lingqu) {
		this.lingqu = lingqu;
	}

	public VisaType getType() {
		return type;
	}

	public void setType(VisaType type) {
		this.type = type;
	}

	public String getIsInterview() {
		return isInterview;
	}

	public void setIsInterview(String isInterview) {
		this.isInterview = isInterview;
	}

	public String getVisaApplyCycle() {
		return visaApplyCycle;
	}

	public String getServiceFee1() {
		return serviceFee1;
	}

	public void setServiceFee1(String serviceFee1) {
		this.serviceFee1 = serviceFee1;
	}

	public void setVisaApplyCycle(String visaApplyCycle) {
		this.visaApplyCycle = visaApplyCycle;
	}

	public String getVisaValid() {
		return visaValid;
	}

	public void setVisaValid(String visaValid) {
		this.visaValid = visaValid;
	}

	public String getPeriodOfStay() {
		return periodOfStay;
	}

	public void setPeriodOfStay(String periodOfStay) {
		this.periodOfStay = periodOfStay;
	}

	public String getScopeOfAcceptance() {
		return scopeOfAcceptance;
	}

	public void setScopeOfAcceptance(String scopeOfAcceptance) {
		this.scopeOfAcceptance = scopeOfAcceptance;
	}

	public String getNationalFlag() {
		return nationalFlag;
	}

	public void setNationalFlag(String nationalFlag) {
		this.nationalFlag = nationalFlag;
	}


	public String getPriceDesc() {
		return priceDesc;
	}

	public void setPriceDesc(String priceDesc) {
		this.priceDesc = priceDesc;
	}

	public String getVisaRemarks() {
		return visaRemarks;
	}

	public void setVisaRemarks(String visaRemarks) {
		this.visaRemarks = visaRemarks;
	}

	public String getVisaMaterials() {
		return visaMaterials;
	}

	public void setVisaMaterials(String visaMaterials) {
		this.visaMaterials = visaMaterials;
	}

	public String getSubmitApplicationAndInterview() {
		return submitApplicationAndInterview;
	}

	public void setSubmitApplicationAndInterview(
			String submitApplicationAndInterview) {
		this.submitApplicationAndInterview = submitApplicationAndInterview;
	}

	public String getLingquDivide() {
		return lingquDivide;
	}

	public void setLingquDivide(String lingquDivide) {
		this.lingquDivide = lingquDivide;
	}

	public String getVisaQueryAndReceive() {
		return visaQueryAndReceive;
	}

	public void setVisaQueryAndReceive(String visaQueryAndReceive) {
		this.visaQueryAndReceive = visaQueryAndReceive;
	}

	public String getIsNeedToAppointment() {
		return isNeedToAppointment;
	}

	public void setIsNeedToAppointment(String isNeedToAppointment) {
		this.isNeedToAppointment = isNeedToAppointment;
	}

	public String getAcceptType() {
		return acceptType;
	}

	public void setAcceptType(String acceptType) {
		this.acceptType = acceptType;
	}

	public String getQuotationHasVisaPrice() {
		return quotationHasVisaPrice;
	}

	public void setQuotationHasVisaPrice(String quotationHasVisaPrice) {
		this.quotationHasVisaPrice = quotationHasVisaPrice;
	}

	public String getBookingInformationNeeds() {
		return bookingInformationNeeds;
	}

	public void setBookingInformationNeeds(String bookingInformationNeeds) {
		this.bookingInformationNeeds = bookingInformationNeeds;
	}

	public String getConsularAndVisaCenterAddress() {
		return consularAndVisaCenterAddress;
	}

	public void setConsularAndVisaCenterAddress(
			String consularAndVisaCenterAddress) {
		this.consularAndVisaCenterAddress = consularAndVisaCenterAddress;
	}

	public String getHowToQueryVisaInfo() {
		return howToQueryVisaInfo;
	}

	public void setHowToQueryVisaInfo(String howToQueryVisaInfo) {
		this.howToQueryVisaInfo = howToQueryVisaInfo;
	}

	public String getGetVisaInfo() {
		return getVisaInfo;
	}

	public void setGetVisaInfo(String getVisaInfo) {
		this.getVisaInfo = getVisaInfo;
	}

	public String getDisclaimer() {
		return disclaimer;
	}

	public void setDisclaimer(String disclaimer) {
		this.disclaimer = disclaimer;
	}

	
}
