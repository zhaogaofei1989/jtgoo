package cn.jtgoo.cms.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.CusDat;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerToVisaProduct;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.CustomerService;
import cn.jtgoo.cms.util.NumberFormatTools;
@SuppressWarnings("unchecked")
public class CustomerServiceImpl extends BaseDaoImpl<Customer> implements
		CustomerService {
	

	public void save(Customer entity) {
		super.save(entity);
		Customer persistence=this.getById(entity.getId());
//		Long maxId = (Long) getSession().createQuery(//
//				"select max(c.id) from Customer c")//
//				.uniqueResult();
//		entity.setId(maxId);
		String seriNumber = "KH-"
				+ NumberFormatTools.formatNumber(String.valueOf(entity.getId()),
						"0000000");
		persistence.setSerialNumber(seriNumber);
	}

	
	public void update(Customer entity) {
		super.update(entity);
		if(entity.getSerialNumber()==null||entity.getSerialNumber().length()==0)
		{
		Customer persistence=this.getById(entity.getId());
		String seriNumber = "KH-"
			+ NumberFormatTools.formatNumber(String.valueOf(entity.getId()),
					"00000000");
		persistence.setSerialNumber(seriNumber);
		}
		}


	public List<Customer> findAllByUserType(String userType,String field,String key) {
		Query query=getSession().createSQLQuery("select * from jtgoo_customer c where c.userType=" + userType +" and c."+field+" like '%"+key+"%'").addEntity(Customer.class);
		System.out.println(query.getQueryString());
		return query.list();
		
	}
	public List<Customer> findAllByUserType(String userType) {
		return this.getSession().createQuery(
				"from Customer c where c.userType=" + userType ).list();
	}

	@SuppressWarnings("unchecked")
	public List<Customer> findAllByUserType() {
		return this.getSession().createQuery(
				"from Customer c where c.userType!=2").list();
	}

	public void save_order_customertList(Long visaproductId,Long visaOrderId,List<Customer> list) {
		
//		Query query = getSession()
//		.createSQLQuery("update  jtgoo_customer set visaorderId='"+visaOrderId+"' where id='"+customerId+"'");
//			query.executeUpdate();
		Customer customer=null;
		for (int i = 0; i < list.size(); i++) {
			customer = list.get(i);
			Query querydetail =getSession().createSQLQuery("insert into jtgoo_cus_dat (visaProductId,visaorderId,customerId,customerName) values(?,?,?,?)");
			querydetail.setLong(0 ,visaproductId);
			querydetail.setLong(1 ,visaOrderId);
			querydetail.setLong(2 ,customer.getId());
			querydetail.setString(3 ,customer.getName());
			System.out.println(querydetail.getQueryString());
			querydetail.executeUpdate();
			// 批插入的对象立即写入数据库并释放内存  
			if (i % 10 == 0) {
				getSession().flush();
				getSession().clear();
			}
		}
		
	}

	
	@SuppressWarnings("unchecked")
	public List<Customer> findAllByVisaIdAndProductId(Long visaProductId,Long orderId) {
		return   getSession().createSQLQuery("select * from jtgoo_customer jc ,jtgoo_cus_dat jcd where jc.id=jcd.customerId  and jcd.visaorderId='"+orderId+"'").addEntity(Customer.class).list();
	}
	/**
	 * 去除重复数据，获取上传的客户id,
	 * 根据客户id进行查询customer信息
	 * 客户修改信息后,更新jtgoo_cus_dat 中所有改该customerId 的状态.
	 */
	public List<CusDat> findCusDatByorderId(Long orderId) {
		return   getSession().createSQLQuery("select * ,count( DISTINCT(customerId)) as t from jtgoo_cus_dat jc where jc.visaorderId="+orderId+" group by customerId").addEntity(CusDat.class).list();
	}

	public void removeCustomerRelation(Long cus_da_id) {
		Object obj = getSession().get(CusDat.class, cus_da_id);
		getSession().delete(obj);
	}

	
	public void saveCustomertoDatatype(Long visaproductId,Long customerId,List<CusDat> list,Long visaOrderId,String customerName) {

//		Query query = getSession()
//		.createSQLQuery("update  jtgoo_customer set visaorderId='"+visaOrderId+"' where id='"+customerId+"'");
//			query.executeUpdate();
		CusDat dataTypeDetail=null;
			for (int i = 0; i < list.size(); i++) {
				dataTypeDetail = list.get(i);
	    	Query querydetail =getSession().createSQLQuery("insert into jtgoo_cus_dat (visaProductId,visaorderId,customerId,datatypeDetailId,datatypedetailTitle,customerName,original,copy,remarks,type) values(?,?,?,?,?,?,?,?,?,?)");
	    	querydetail.setLong(0 ,visaproductId);
	    	querydetail.setLong(1 ,visaOrderId);
	    	querydetail.setLong(2 ,customerId);
	    	querydetail.setLong(3 ,dataTypeDetail.getDatatypeDetailId());
	    	querydetail.setString(4 ,dataTypeDetail.getDatatypedetailTitle());
	    	querydetail.setString(5 ,customerName);
	    	querydetail.setString(6 ,dataTypeDetail.getOriginal());
	    	querydetail.setString(7 ,dataTypeDetail.getCopy());
	    	querydetail.setString(8 ,dataTypeDetail.getRemarks());
	    	querydetail.setString(9 ,dataTypeDetail.getType());
			querydetail.executeUpdate();
				// 批插入的对象立即写入数据库并释放内存  
				if (i % 10 == 0) {
					getSession().flush();
					getSession().clear();
				}
			}
	
	}
	public void updateCustomertoDatatype(Long visaProductId, Long customerId,
			List<CusDat> dtdList,Long id) {
		
//		Query query = getSession()
//		.createSQLQuery("update  jtgoo_customer set visaProductId='"+visaProductId+"' where id='"+customerId+"'");
//			query.executeUpdate();
		CusDat dataTypeDetail=null;
		for (int i = 0; i < dtdList.size(); i++) {
			dataTypeDetail = dtdList.get(i);
			Query querydetail =getSession().createSQLQuery("update  jtgoo_cus_dat set original=?,copy=?,remarks=?,datatypedetailTitle=?,type=?,datatypeDetailId=? where id="+id);
			querydetail.setString(0 ,dataTypeDetail.getOriginal());
			querydetail.setString(1 ,dataTypeDetail.getCopy());
			querydetail.setString(2 ,dataTypeDetail.getRemarks());
			querydetail.setString(3 ,dataTypeDetail.getDatatypedetailTitle());
			querydetail.setString(4 ,dataTypeDetail.getType());
			querydetail.setLong(5 ,dataTypeDetail.getDatatypeDetailId());
			querydetail.executeUpdate();
			// 批插入的对象立即写入数据库并释放内存  
			if (i % 10 == 0) {
				getSession().flush();
				getSession().clear();
			}
		}
		
	}
	public void updateCustomerVisaResult() {

//		Query query = getSession()
//		.createSQLQuery("update  jtgoo_customer set visaProductId='"+visaProductId+"' where id='"+customerId+"'");
//			query.executeUpdate();
//			for (int i = 0; i < dtdList.size(); i++) {
//				dataTypeDetail = dtdList.get(i);
//
//	    	Query querydetail =getSession().createSQLQuery("update  jtgoo_cus_dat set original=?,copy=?,remarks=?,status=? where id="+id);
//	    	querydetail.setString(0 ,dataTypeDetail.getOriginal());
//	    	querydetail.setString(1 ,dataTypeDetail.getCopy());
//	    	querydetail.setString(2 ,dataTypeDetail.getRemarks());
//	    	querydetail.setString(3 ,dataTypeDetail.getStatus());
//			querydetail.executeUpdate();
//				// 批插入的对象立即写入数据库并释放内存  
//				if (i % 10 == 0) {
//					getSession().flush();
//					getSession().clear();
//				}
//				System.out.println(querydetail.getQueryString());
//			}
	
	}

	public void updatePeer(Customer customer) {
		Query query=getSession().createSQLQuery("update jtgoo_customer set userName=?,email=?,name=?,phone=?,mobliePhone=?,chatTools=?,address=?,companyName=?,companyAddr=?,companyPhone=?,regTime=? ,serialNumber=? where id="+customer.getId());
		query.setString(0, customer.getUserName());
		query.setString(1, customer.getEmail());
		query.setString(2, customer.getName());
		query.setString(3, customer.getPhone());
		query.setString(4, customer.getMobliePhone());
		query.setString(5, customer.getChatTools());
		query.setString(6, customer.getAddress());
		query.setString(7, customer.getCompanyName());
		query.setString(8, customer.getCompanyAddr());
		query.setString(9, customer.getCompanyPhone());
		query.setString(10, customer.getRegTime());
		query.setString(11, customer.getSerialNumber()==null?"KH-"+NumberFormatTools.formatNumber(String.valueOf(customer.getId()), "0000000"):customer.getSerialNumber());
		query.executeUpdate();
	
	}


	public List<CustomerToVisaProduct> findAllByCustomerId(Long id) {
		List<CustomerToVisaProduct> ctvpList=new ArrayList<CustomerToVisaProduct>();
	   	List<Object[]> list=getSession().createSQLQuery("select distinct jcp.visaproductId ,jcp.customerId, jcp.price from jtgoo_cus_product jcp ,jtgoo_lingqu_customer jlc where jcp.customerId=jlc.customerId and jcp.customerId="+id).list();
	   	CustomerToVisaProduct customerToVisaProduct=null;
	   	if(list!=null&&list.size()>0)
	   	{
	   		for(Object[] obj:list)
	   		{
	   			customerToVisaProduct=new CustomerToVisaProduct(Long.valueOf(obj[0].toString()),Long.valueOf(obj[1].toString()),obj[2].toString());
	   			ctvpList.add(customerToVisaProduct);
	   		}
	   		
	   	}
	   	return ctvpList;
	}

	@SuppressWarnings("unchecked")
	public void saveVisaResult(Long orderId, Map map) {
		 Set<String> key =map.keySet();
		  int i=0;
	        for (Iterator it = key.iterator(); it.hasNext();) {
	            String str = (String) it.next();
	            if(StringUtils.isNotEmpty(str))
	            {
	            	Query query=getSession().createSQLQuery("update jtgoo_cus_dat set status=? where id="+str);
	            	query.setString(0, map.get(str).toString());
	            	query.executeUpdate();
	            	i++;
	            	if (i % 10 == 0) {
						getSession().flush();
						getSession().clear();
					}
	            }
	        }
	}

	public void saveCustomertertoProduct(Long id, Map map) {
		
		  Set<String> key =map.keySet();
		  int i=0;
	        for (Iterator it = key.iterator(); it.hasNext();) {
	            String str = (String) it.next();
	            if(StringUtils.isNotEmpty(str))
	            {
	            	Query query=getSession().createSQLQuery("REPLACE INTO jtgoo_cus_product(customerId,visaproductId,price) VALUES(?,?,?)");
	            	query.setLong(0, id);
	            	query.setLong(1, Long.valueOf(str));
	            	query.setString(2, map.get(str).toString());
	            	query.executeUpdate();
	            	i++;
	            	if (i % 10 == 0) {
						getSession().flush();
						getSession().clear();
					}
	            }
	        }
	}
	public List<Customer> getByName(String name,String mobliePhone) {
		return getSession().createQuery("FROM Customer u WHERE u.name=? and u.mobliePhone=? ")
				.setParameter(0, name).setParameter(1, mobliePhone)
				.list();
	}

	@Override
	public List<CusDat> findCusByCustomer(Map param) {
		//select jcd.id,jcd.reason, jcd.visaorderId,jcd.analysis,jcd.results, jcd.customerId,jcd.visastatus,jcd.datatypeDetailId,jcd.visaProductId,jcd.copy,jc.name as customerName ,jdt.name as datatypeName ,jdtd.title as datatypedetailTitle ,jcd.original,jcd.copy,jcd.remarks,jcd.status,jcd.visaorderId from jtgoo_cus_dat jcd ,jtgoo_customer jc,jtgoo_datatypedetail jdtd ,jtgoo_datatype jdt where jcd.customerId=jc.id and jcd.datatypeDetailId =jdtd.id  and jdt.id=jdtd.dataTypeId and jcd.visaProductId
		StringBuffer buffer=new StringBuffer();
		buffer.append("select DISTINCT(jcd.id),jcd.reason, jcd.visaorderId,jcd.analysis,jcd.results, jcd.customerId,jcd.visastatus,jcd.datatypeDetailId,jcd.visaProductId,jcd.copy,jc.name as customerName ,jdt.name as datatypeName ,jdtd.title as datatypedetailTitle ,jcd.original,jcd.copy,jcd.remarks,jcd.status,jcd.visaorderId from jtgoo_cus_dat jcd ,jtgoo_customer jc,jtgoo_datatypedetail jdtd ,jtgoo_datatype jdt where jc.id=jcd.customerId ");
	
//		buffer.append("select  * ,count( DISTINCT(jc.id)) from jtgoo_customer jc, jtgoo_cus_dat jcd where jc.id=jcd.customerId ");
		if(param!=null&&param.size()>0)
		{
		
			Iterator<Entry<String, String>> iter = param.entrySet().iterator();
			Entry<String, String> entry;
			while (iter.hasNext()) {
			    entry = iter.next();
			    String  key = entry.getKey();
			    String   value = entry.getValue();
			   if(StringUtils.isNotEmpty(value))
			   {buffer.append(" and ");
		    	buffer.append(key+" = ").append("'%"+value+"%'");
			   }
			}
		}
		Query queryList= getSession().createSQLQuery(buffer.toString()).addEntity(CusDat.class);
		System.out.println(queryList.getQueryString());
		return queryList.list();
	}

	@Override
	public void delete(Long[] ids) {
		for(int i=0;i<ids.length;i++)
		{
			Customer customer = (Customer) getSession().get(Customer.class, ids[i]);
			customer.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		}
		getSession().flush();
		
	}

	
	
	

	/**
	 * 登陆账户密码
	 */
	public Customer getByLoginNameAndPassword(String loginName, String password) {
		
		return (Customer) getSession().createQuery(//
		"FROM Customer u WHERE u.userName=? AND u.passwd=?")//
		.setParameter(0, loginName)//
		.setParameter(1, password)//
		.uniqueResult();
	}

	@Override
	public List<Customer> findAll() {
			return getSession().createQuery("FROM Customer as c where c.del_status=0").list();

	}



}