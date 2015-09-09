package cn.jtgoo.cms.service.impl;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.InsuranceType;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.InsuranceTypeService;

public class InsuranceTypeServiceImpl extends BaseDaoImpl<InsuranceType> implements InsuranceTypeService {
	public void delete(Long id) {
		InsuranceType insurancetype = (InsuranceType) getSession().get(InsuranceType.class, id);
		insurancetype.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}

}