package cn.jtgoo.cms.service.impl;

import java.util.List;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.VisaCountryService;

public class VisaCountryServiceImpl extends BaseDaoImpl<Country> implements VisaCountryService {
	@SuppressWarnings("unchecked")
	public List<Country> findTopLevel() {
		return getSession().createQuery(//
				"FROM Country c WHERE c.parent IS NULL and c.del_status=0 ORDER BY c.parent.id")//
				.list();
	}

	public Country findByName(String name) {
		return (Country) getSession().createQuery("FROM Country c WHERE c.name='"+name+"'").uniqueResult();
	}
	public void delete(Long id) {
		Country country = (Country) getSession().get(Country.class, id);
		country.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		this.update(country);
	}

}