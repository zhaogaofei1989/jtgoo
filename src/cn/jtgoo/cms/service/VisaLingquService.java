package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.User;

public interface VisaLingquService extends BaseDao<Lingqu> {

	Lingqu findByName(String name);

	List<Lingqu> findAllByUser(List list);


}
