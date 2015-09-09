package cn.jtgoo.cms.service.impl;

import java.util.List;

import org.hibernate.Query;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.VisaOrder;
import cn.jtgoo.cms.service.VisaOrderService;
import cn.jtgoo.cms.util.NumberFormatTools;

public class VisaOrderServiceImpl extends BaseDaoImpl<VisaOrder> implements
		VisaOrderService {

	String serialnumber = "";

	public void save(VisaOrder entity) {
		super.save(entity);
		VisaOrder dbVo=this.getById(entity.getId());
		Long maxId =entity.getId();
		/**
		 * 判断领区的名称
		 */
		String prefix=entity.getVisaProduct().getLingqu().getPrefix();
		serialnumber = prefix+"-"+ NumberFormatTools.formatNumber(String.valueOf(maxId),"0000000");
		//持久化数据
		dbVo.setSerialnumber(serialnumber);
	}


	public void delete(Long id) {
		/**
		 * 删除中间表的所有数据jtgoo_cus_dat
		 */
		getSession().createSQLQuery("delete from jtgoo_cus_dat where visaorderId="+id).executeUpdate();
		/**
		 * 删除订单
		 */
		Object obj = getSession().get(clazz, id);
		getSession().delete(obj);
	}


	@SuppressWarnings("unchecked")
	public List<VisaOrder> listByCondition(String str) {
		List list=null;
		StringBuffer buffer=new StringBuffer();
		buffer.append("  FROM cn.jtgoo.cms.domain.VisaOrder vo WHERE vo.customerServicers like ?"); 
	    Query query=this.getSession().createQuery(buffer.toString()).setParameter(0, 1);
	    list=query.list();
	     return list;
	}


	/* (non-Javadoc)
	 * 按
	 * @see cn.jtgoo.cms.service.VisaOrderService#findByCustomesStatus(java.lang.Long, java.lang.String)
	 */
	public Long findByCustomesStatus(Long id,String status) {
		Object count =  getSession().createSQLQuery(
		"select count(jv.id) from jtgoo_visaorder as jv ,jtgoo_customer as jc where jv.customerId=jc.id and jv.status=? and jv.customerId=?").setParameter(0, status).setParameter(1,id).uniqueResult();
		return Long.valueOf(count.toString());
	}
	public Long findByCustomesStatus(Long customerId,List<String>  ids) {
		StringBuffer buffer=new StringBuffer();
		buffer.append("(");
		for(int i=0;i<ids.size();i++)
		{
			buffer.append(ids.get(i)+",");
		}
		buffer.delete(buffer.length()-1, buffer.length());
		buffer.append(")");	
		Query query= getSession().createSQLQuery("select count(jv.id) from jtgoo_visaorder as jv ,jtgoo_customer as jc where jv.customerId=jc.id and jv.status in "+buffer+" and jv.customerId=?");
			
			query.setParameter(0, customerId);
		return Long.valueOf(query.uniqueResult().toString());
	}


	
	
}