package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

/**
 * @author alex
 * ǩ֤��Ʒ
 */
public class VisaProduct {
private Long id;
private String serialNumber;

private String name;



/**
 * ǩ֤����
 */
private Country country;

private Set<Attachment> attachmentSet=new HashSet<Attachment>();

/**
 * ǩ֤����
 */
private Lingqu lingqu;
/**
 * �����ײ�
 */
private InsurancePackage insurancePackage;
/**
 * ���ζ��
 */
private String  oneToManySelect;


/**
 * ǩ֤����
 */
private VisaType type;

/**
 * �Ƿ�����
 * 0������1�����
 * @return
 */
private String isInterview;
/*
 * 0 ������ 1 �����
 */
private String isNeedToAppointment;


private String icon;

/**
 * ǩ֤��������
 * @return
 */

String visaApplyCycle;


/**
 * һ��ǩ֤��Ч��
 */

String visaValid;

/**
 * һ��ͣ����
 */
String periodOfStay;
/**
 * ����Χ
 */
String scopeOfAcceptance;
/**
 * ����  ͼƬ
 */
String nationalFlag;

/**
 * �����  ���� 0-6���ͯ 6-12���ͯ
 * servicefee1
 * servicefee2
 * servicefee3
 */
Double serviceFee1;
Double visaFee;
Double visaFee1;
Double visaFee2;
Double bookFee;
Double bookFee1;
Double bookFee2;


/**textarea
 * �۸�˵��
 */
String priceDesc;



/**textarea
ǩ֤��ע
*/

String visaRemarks;
/**
 * textarea
 * ǩ֤����
 */


String visaMaterials;

/**
 * textarea
 * �ݽ����뼰����
 */
String submitApplicationAndInterview;
/**
 * ��������
 */
String lingquDivide;
/**
 * ԤԼ����
 */
String bookingInterview;

/**  1   2   3
 * ͬҵ�û�����ѻ�׼��
 */

/** 1   2  3
 * ǩ֤��
 */

/**1  2  3
 * ԤԼ��
 */

/**
 * ǩ֤��ѯ����ȡ 	
 */
String visaQueryAndReceive;

/**
 * ǩ֤�����Ȳ���ʾ
 */

private Set<VisaOrder> visaOrderSet=new HashSet<VisaOrder>();
/**
 * ͬ����ͬ�еĹ�ϵ�Ƕ�Զ�
 */
private Set<Customer> customerSet=new HashSet<Customer>();

/**
 * ��datatypedeil ��һ�Զ��
 * @return
 */
private Set<DataTypeDetail> dataTypeDetailSet=new LinkedHashSet<DataTypeDetail>();

/**
 * ��������
 * 0 ����
 * 1 ��ǩ
 */
private String acceptType;


/**
 * �����Ƿ���ǩ֤����
 * 0��
 * 1 ��
 */
private String quotationHasVisaPrice;



/**
 * ԤԼ��Ҫ����Ϣ
 * @return
 */
private String bookingInformationNeeds;


/**
 * ʹ��ݺ�ǩ֤���ĵ�ַ
 * @return
 */
private String consularAndVisaCenterAddress;

/**
 * �������ǩ֤��ѯ
 */
private String howToQueryVisaInfo;

/**
 * ǩ֤����ȡ
 * @return
 */
private String getVisaInfo;


/**
 * ��������
 * @return
 */
private String disclaimer;


/**
 * ��ַ����
 * @return
 */

private String webSiteLink;
/**
 * ɾ��״̬ 0 ���� δɾ����1����ɾ��
 */
private String del_status="0";

private  String price;

/**
 * ����ʱ��
 */
private String updateTime;

public String getWebSiteLink() {
	return webSiteLink;
}


public String getDel_status() {
	return del_status;
}


public void setDel_status(String del_status) {
	this.del_status = del_status;
}


public String getOneToManySelect() {
	return oneToManySelect;
}


public void setOneToManySelect(String oneToManySelect) {
	this.oneToManySelect = oneToManySelect;
}


public String getIcon() {
	return icon;
}


public void setIcon(String icon) {
	this.icon = icon;
}


public Double getServiceFee1() {
	return serviceFee1;
}


public void setServiceFee1(Double serviceFee1) {
	this.serviceFee1 = serviceFee1;
}


public String getPrice() {
	return price;
}


public void setPrice(String price) {
	this.price = price;
}


public void setWebSiteLink(String webSiteLink) {
	this.webSiteLink = webSiteLink;
}


public String getSerialNumber() {
	return serialNumber;
}


public void setSerialNumber(String serialNumber) {
	this.serialNumber = serialNumber;
}


public Long getId() {
	return id;
}


public Set<Customer> getCustomerSet() {
	return customerSet;
}


public void setCustomerSet(Set<Customer> customerSet) {
	this.customerSet = customerSet;
}


public String getUpdateTime() {
	return updateTime;
}


public void setUpdateTime(String updateTime) {
	this.updateTime = updateTime;
}


public void setId(Long id) {
	this.id = id;
}


public Set<Attachment> getAttachmentSet() {
	return attachmentSet;
}


public void setAttachmentSet(Set<Attachment> attachmentSet) {
	this.attachmentSet = attachmentSet;
}


public String getName() {
	return name;
}


public void setName(String name) {
	this.name = name;
}


public String getBookingInterview() {
	return bookingInterview;
}


public void setBookingInterview(String bookingInterview) {
	this.bookingInterview = bookingInterview;
}


public Country getCountry() {
	return country;
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


public String getIsNeedToAppointment() {
	return isNeedToAppointment;
}


public void setIsNeedToAppointment(String isNeedToAppointment) {
	this.isNeedToAppointment = isNeedToAppointment;
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


public Set<VisaOrder> getVisaOrderSet() {
	return visaOrderSet;
}


public void setVisaOrderSet(Set<VisaOrder> visaOrderSet) {
	this.visaOrderSet = visaOrderSet;
}


public Set<DataTypeDetail> getDataTypeDetailSet() {
	return dataTypeDetailSet;
}

public void setDataTypeDetailSet(Set<DataTypeDetail> dataTypeDetailSet) {
	this.dataTypeDetailSet = dataTypeDetailSet;
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


public void setConsularAndVisaCenterAddress(String consularAndVisaCenterAddress) {
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


public InsurancePackage getInsurancePackage() {
	return insurancePackage;
}


public void setInsurancePackage(InsurancePackage insurancePackage) {
	this.insurancePackage = insurancePackage;
}



}
