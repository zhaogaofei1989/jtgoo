package cn.jtgoo.cms.domain;

public class CusDat {
private Long id;
private Long customerId;
private Long datatypeDetailId;
private Long visaProductId;
private Long visaorderId;
private String original;
private String copy;
private String remarks;
private String type;
private String status;
private String customerName;
private String datatypeName;
private String datatypedetailTitle;
private String reason;
private String analysis;
private String results;

public Long getId() {
	return id;
}

public String getReason() {
	return reason;
}

public void setReason(String reason) {
	this.reason = reason;
}

public String getAnalysis() {
	return analysis;
}

public void setAnalysis(String analysis) {
	this.analysis = analysis;
}

public String getResults() {
	return results;
}

public void setResults(String results) {
	this.results = results;
}


public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}

public Long getVisaorderId() {
	return visaorderId;
}
public void setVisaorderId(Long visaorderId) {
	this.visaorderId = visaorderId;
}
public void setId(Long id) {
	this.id = id;
}
public Long getCustomerId() {
	return customerId;
}
public void setCustomerId(Long customerId) {
	this.customerId = customerId;
}
public Long getDatatypeDetailId() {
	return datatypeDetailId;
}
public void setDatatypeDetailId(Long datatypeDetailId) {
	this.datatypeDetailId = datatypeDetailId;
}
public Long getVisaProductId() {
	return visaProductId;
}
public void setVisaProductId(Long visaProductId) {
	this.visaProductId = visaProductId;
}
public String getOriginal() {
	return original;
}
public void setOriginal(String original) {
	this.original = original;
}
public String getCopy() {
	return copy;
}
public void setCopy(String copy) {
	this.copy = copy;
}
public String getRemarks() {
	return remarks;
}
public void setRemarks(String remarks) {
	this.remarks = remarks;
}

public String getType() {
	return type;
}

public void setType(String type) {
	this.type = type;
}

public String getCustomerName() {
	return customerName;
}
public void setCustomerName(String customerName) {
	this.customerName = customerName;
}
public String getDatatypeName() {
	return datatypeName;
}
public void setDatatypeName(String datatypeName) {
	this.datatypeName = datatypeName;
}
public String getDatatypedetailTitle() {
	return datatypedetailTitle;
}
public void setDatatypedetailTitle(String datatypedetailTitle) {
	this.datatypedetailTitle = datatypedetailTitle;
}


}
