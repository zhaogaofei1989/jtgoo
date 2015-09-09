package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.Country;

public interface VisaCountryService extends BaseDao<Country> {


	List<Country> findTopLevel();
	Country findByName(String name);

}
