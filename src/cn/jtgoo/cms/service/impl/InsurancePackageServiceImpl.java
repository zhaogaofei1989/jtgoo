package cn.jtgoo.cms.service.impl;

import java.util.List;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.InsurancePackage;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.InsurancePackageService;

public class InsurancePackageServiceImpl extends BaseDaoImpl<InsurancePackage> implements InsurancePackageService {

	public void delete(Long id) {
		InsurancePackage insurancepackage = this.getById(id);
		insurancepackage.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		insurancepackage.setBaoxian_att_id(null);
	}

	public List<InsurancePackage> findByInsuranceTypeId(Long id) {
		return getSession().createQuery("FROM InsurancePackage vo  where vo.insuranceType.id="+id).list();
	}


}