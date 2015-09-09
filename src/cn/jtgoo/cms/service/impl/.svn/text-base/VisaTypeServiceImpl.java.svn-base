package cn.jtgoo.cms.service.impl;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.domain.VisaType;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.VisaTypeService;

public class VisaTypeServiceImpl extends BaseDaoImpl<VisaType> implements VisaTypeService {

	public VisaType findByName(String name) {
		return (VisaType) getSession().createQuery("FROM VisaType c WHERE c.name='"+name+"'").uniqueResult();
	}
	public void delete(Long id) {
		VisaType visatype = (VisaType) getSession().get(VisaType.class, id);
		visatype.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}


}