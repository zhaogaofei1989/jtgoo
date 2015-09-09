package cn.jtgoo.cms.service.impl;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.PeerGroup;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.PeerGroupService;

public class PeerGroupServiceImpl extends BaseDaoImpl<PeerGroup> implements PeerGroupService {

	public void delete(Long id) {
		PeerGroup peerGroup = (PeerGroup) getSession().get(PeerGroup.class, id);
		peerGroup.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}

}