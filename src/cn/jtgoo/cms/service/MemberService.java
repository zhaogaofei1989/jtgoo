package cn.jtgoo.cms.service;

import java.util.List;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.Member;

public interface MemberService extends BaseDao<Member> {

	List<Member> findAllByUserType(String field,String key);
}
