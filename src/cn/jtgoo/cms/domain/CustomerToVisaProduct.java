package cn.jtgoo.cms.domain;

public class CustomerToVisaProduct {

	private Long visaproductId;
	private Long customerId;
	private String price;
	/**
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status="0";
	public Long getVisaproductId() {
		return visaproductId;
	}
	public void setVisaproductId(Long visaproductId) {
		this.visaproductId = visaproductId;
	}
	public Long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public CustomerToVisaProduct(Long visaproductId, Long customerId,
			String price) {
		super();
		this.visaproductId = visaproductId;
		this.customerId = customerId;
		this.price = price;
	}
	public String getDel_status() {
		return del_status;
	}
	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}
	
	
}
