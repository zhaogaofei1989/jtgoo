package cn.jtgoo.cms.domain;


/**
 * @author alex
 * 保险 附件类
 * 与附件相同，考虑到以后可能会出现的数据量太多，因此将附件进行拆分
 */
public class BaoXianAttachment {
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
	
	private InsurancePackage insurancePackage;
	


	
	private String uploadTime;
	
	
	private String user;
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


	public InsurancePackage getInsurancePackage() {
		return insurancePackage;
	}


	public void setInsurancePackage(InsurancePackage insurancePackage) {
		this.insurancePackage = insurancePackage;
	}

	
	
}
