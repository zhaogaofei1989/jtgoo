package cn.jtgoo.cms.service.impl;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.ReserveOrder;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.ReserveOrderService;

public class ReserveOrderServiceImpl extends BaseDaoImpl<ReserveOrder> implements ReserveOrderService {
	public void delete(Long id) {
		ReserveOrder reserveOrder = (ReserveOrder) getSession().get(ReserveOrder.class, id);
		reserveOrder.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}

}