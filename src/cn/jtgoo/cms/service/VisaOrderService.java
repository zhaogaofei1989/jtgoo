package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.VisaOrder;

public interface VisaOrderService extends BaseDao<VisaOrder> {

public List<VisaOrder> listByCondition(String str);

public Long findByCustomesStatus(Long id, String status);

public Long findByCustomesStatus(Long customerId,List<String> ids);
}
