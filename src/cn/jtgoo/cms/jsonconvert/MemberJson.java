package cn.jtgoo.cms.jsonconvert;

import java.util.ArrayList;
import java.util.List;

import cn.jtgoo.cms.domain.CustomerServicersVo;

public class MemberJson {
private String id;
private String value;
private String label;

private List<CustomerServiceJson> customerservices=new ArrayList<CustomerServiceJson>();
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getValue() {
	return value;
}
public void setValue(String value) {
	this.value = value;
}
public String getLabel() {
	return label;
}
public void setLabel(String label) {
	this.label = label;
}
public List<CustomerServiceJson> getCustomerservices() {
	return customerservices;
}
public void setCustomerservices(List<CustomerServiceJson> customerservices) {
	this.customerservices = customerservices;
}

}
