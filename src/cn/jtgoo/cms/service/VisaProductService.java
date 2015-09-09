package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.VisaProduct;

public interface VisaProductService extends BaseDao<VisaProduct> {
	List<VisaProduct> findAllByUser(List list);
	List<VisaProduct> findByName(String keyword);
	List<VisaProduct> findTopLevel();
	List<VisaProduct>findByCountryId(long countryId);
	List<VisaProduct>findByLingquId(long lingquId);
	List<VisaProduct>findByVisatypeId(long visatypeId);
	
}
