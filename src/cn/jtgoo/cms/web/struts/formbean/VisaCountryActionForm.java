package cn.jtgoo.cms.web.struts.formbean;

import org.apache.struts.action.ActionForm;

public class VisaCountryActionForm extends ActionForm {
	private Long id;

	private String name;
	private String icon;
	private String description;
	private Long parentId;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
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

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}



}
