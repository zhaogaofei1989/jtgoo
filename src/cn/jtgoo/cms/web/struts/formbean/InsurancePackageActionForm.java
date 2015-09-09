package cn.jtgoo.cms.web.struts.formbean;

import org.apache.struts.action.ActionForm;

@SuppressWarnings("serial")
public class InsurancePackageActionForm extends ActionForm {
	private Long id;

	private String name;

	private String path;
	private String description;
	//成人
	Double price1;
	//0-6岁儿童
	Double price2;
	//6-12 岁儿童
	Double price3;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Double getPrice1() {
		return price1;
	}

	public void setPrice1(Double price1) {
		this.price1 = price1;
	}

	public Double getPrice2() {
		return price2;
	}

	public void setPrice2(Double price2) {
		this.price2 = price2;
	}

	public Double getPrice3() {
		return price3;
	}

	public void setPrice3(Double price3) {
		this.price3 = price3;
	}



}
