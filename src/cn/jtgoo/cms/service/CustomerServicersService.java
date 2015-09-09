package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.CustomerServicersVo;

public interface CustomerServicersService extends BaseDao<CustomerServicersVo> {

	List<CustomerServicersVo> findListByPeerId(Long peerId,String userType);
	List<CustomerServicersVo> findListByCustomerId(Long CustomerId);
	List<CustomerServicersVo> findAllByName(String keyword);


}
