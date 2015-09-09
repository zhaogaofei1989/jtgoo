package cn.jtgoo.cms.service.impl;

import java.util.List;

import org.hibernate.Query;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.service.VisaProductService;
import cn.jtgoo.cms.util.NumberFormatTools;
@SuppressWarnings("unchecked")
public class VisaProductServiceImpl extends BaseDaoImpl<VisaProduct> implements VisaProductService {
	public List<VisaProduct> findAllByUser(List list) {
		if(list!=null&&list.size()>0)
		{
			String hql="FROM VisaProduct c WHERE c.lingqu.id IN (:alist)";  
			Query query = getSession().createQuery(hql);  
			query.setParameterList("alist", list);  
	    	return query.list();
		}
		return null;
	}

	@Override
	public List<VisaProduct> findByName(String keyword) {
		Query query=getSession().createSQLQuery("select * from jtgoo_visaproduct c where c.name like '%"+keyword+"%'").addEntity(VisaProduct.class);
		return query.list();
	}


	public List<VisaProduct> findTopLevel() {

		return getSession().createQuery(//
		"FROM VisaProduct v WHERE v.country.parent IS NULL")//
		.list();
	}

	@Override
	public List<VisaProduct> findByCountryId(long countryId) {
		
		return getSession().createQuery(//
		"FROM VisaProduct v WHERE v.country.id =?").setParameter(0, countryId)
		.list();
	}

	@Override
	public List<VisaProduct> findByLingquId(long lingquId) {
		return getSession().createQuery(//
		"FROM VisaProduct v WHERE v.lingqu.id =?").setParameter(0, lingquId)
		.list();
	}

	@Override
	public List<VisaProduct> findByVisatypeId(long visatypeId) {
		return getSession().createQuery(//
		"FROM VisaProduct v WHERE v.type.id =?").setParameter(0, visatypeId)
		.list();
	}
	public void delete(Long id) {
		VisaProduct visaproduct = (VisaProduct) getSession().get(VisaProduct.class, id);
		visaproduct.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}

	public void save(VisaProduct entity) {
		super.save(entity);
		VisaProduct dbProduct=this.getById(entity.getId());
		String formatNumber=NumberFormatTools.formatNumber(String.valueOf(entity.getId()),"0000000");
		dbProduct.setSerialNumber(Param.visaProductPre+"-"+formatNumber);
	}
	
	
	public void update(VisaProduct entity) {
		super.update(entity);
		VisaProduct dbProduct=this.getById(entity.getId());
		String formatNumber=NumberFormatTools.formatNumber(String.valueOf(entity.getId()),"0000000");
		dbProduct.setSerialNumber(Param.visaProductPre+"-"+formatNumber);
	}
	
	
	}



