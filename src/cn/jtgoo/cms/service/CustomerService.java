package cn.jtgoo.cms.service;

import java.util.List;
import java.util.Map;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.CusDat;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerToVisaProduct;

public interface CustomerService extends BaseDao<Customer> {

	/**
	 * 查询所有
	 * 
	 * @return
	 */
	List<Customer> findAllByUserType(String userType,String field,String key);
	List<Customer> findAllByUserType(String userType);
	List<CustomerToVisaProduct> findAllByCustomerId(Long id);
	List<Customer> findAllByUserType();
	public void save_order_customertList(Long visaproductId,Long visaOrderId,List<Customer> list);
	public void saveCustomertoDatatype(Long visaproductId,Long customerId,List<CusDat> list,Long visaOrderId,String customerName);
	List<Customer> findAllByVisaIdAndProductId(Long productId,Long orderId);
	Customer getByLoginNameAndPassword(String loginName, String password);
	/**
	 * 模糊查询
	 * @param customer
	 * @return
	 */
	List<CusDat> findCusByCustomer(Map map);
	List<CusDat> findCusDatByorderId(Long orderId);
	void removeCustomerRelation(Long valueOf);
	void updateCustomertoDatatype(Long visaProductId, Long customerId,
			List<CusDat> dtdList,Long id);
	void updatePeer(Customer customer);
	void saveCustomertertoProduct(Long id, Map map);
	void saveVisaResult(Long id, Map map);
	List<Customer> getByName(String name,String mobliePhone);
	
	
	

	
}
