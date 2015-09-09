package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * @author alex 附件类
 */
public class Attachment {
	// id
	private Long id;
	/**
	 * 附件名称
	 */
	private String name;
	/**
	 * 附件路径
	 */
	private String path;
	/**
	 * 附件大小
	 */
	private String size;
	
	/**
	 * 附件类型,0为基本附件,1为国家图片，2 签证产品附件
	 */
	private Integer type;
	private DataTypeDetail dataTypeDetail;
	
	private Set<VisaProduct> productSet=new HashSet<VisaProduct>();

	
	private String uploadTime;
	public Long getId() {
		return id;
	}


	public String getUploadTime() {
		return uploadTime;
	}


	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}


	public void setId(Long id) {
		this.id = id;
	}

	public Set<VisaProduct> getProductSet() {
		return productSet;
	}

	public void setProductSet(Set<VisaProduct> productSet) {
		this.productSet = productSet;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public DataTypeDetail getDataTypeDetail() {
		return dataTypeDetail;
	}

	public void setDataTypeDetail(DataTypeDetail dataTypeDetail) {
		this.dataTypeDetail = dataTypeDetail;
	}


	public Integer getType() {
		return type;
	}


	public void setType(Integer type) {
		this.type = type;
	}
	
	
	
}
