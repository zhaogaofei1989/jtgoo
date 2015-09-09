package cn.jtgoo.cms.web.struts.formbean;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;

import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.DataType;

public class VisaDataTypeDetailActionForm extends ActionForm {

	/**
	 * 编号
	 */
	private Long id;

	/**
	 * 类型
	 */
	private String type;

	/**
	 * 标题
	 */
	private String title;

	/**
	 * 内容
	 */
	private String content;
	
	/**
	 * 标记
	 */
	
	private String sign;
	
	/**
	 * 资料类型
	 */
	private DataType dataType;

	/**
	 * 附件
	 */
	private Set<Customer> customerSet=new HashSet<Customer>();
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public DataType getDataType() {
		return dataType;
	}

	public void setDataType(DataType dataType) {
		this.dataType = dataType;
	}

	

	public void setContent(String content) {
		this.content = content;
	}

	public Set<Customer> getCustomerSet() {
		return customerSet;
	}

	public void setCustomerSet(Set<Customer> customerSet) {
		this.customerSet = customerSet;
	}

	public String getSign() {
		if(StringUtils.isEmpty(sign))
		{
			return "1";
		}
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}


}