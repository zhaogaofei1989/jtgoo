package cn.jtgoo.cms.service.impl;

import java.util.List;

import org.hibernate.Query;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.VisaLingquService;
@SuppressWarnings("unchecked")
public class VisaLingquServiceImpl extends BaseDaoImpl<Lingqu> implements VisaLingquService {

	public Lingqu findByName(String name) {
		return (Lingqu) getSession().createQuery("FROM Lingqu c WHERE c.name='"+name+"'").uniqueResult();
	}

	public List<Lingqu> findAll() {
		return getSession().createQuery("FROM Lingqu as c where c.del_status=0").list();
	}

	public List<Lingqu> findAllByUser(List list) {
		if(list!=null&&list.size()>0)
		{
			String hql="FROM Lingqu c WHERE c.id IN (:alist)";  
			Query query = getSession().createQuery(hql);  
			query.setParameterList("alist", list);  
	    	return query.list();
		}
		return null;
	}
	public void delete(Long id) {
		Lingqu lingqu = (Lingqu) getSession().get(Lingqu.class, id);
		lingqu.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}

	
	
}