package cn.jtgoo.cms.service.impl;

import java.util.List;

import org.hibernate.Query;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.Member;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.MemberService;
import cn.jtgoo.cms.util.NumberFormatTools;

/**
 * @author  作者 zhaogaofei
 * @version  创建时间：May 15, 2015 9:18:39 AM
 * @email   zhaogaofei2012@163.com 
 * 类说明
 */
public class MemberServiceImpl extends BaseDaoImpl<Member> implements MemberService {
	public void delete(Long id) {
		Member member = (Member) getSession().get(Member.class, id);
		member.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}
	public List<Member> findAllByUserType(String field,String key) {
		Query query=getSession().createSQLQuery("select * from jtgoo_member c where  c."+field+" like '%"+key+"%'").addEntity(Member.class);
		return query.list();
	}
	public void save(Member entity) {
		super.save(entity);
		Member persistence=this.getById(entity.getId());
		String seriNumber = "MB-"
				+ NumberFormatTools.formatNumber(String.valueOf(persistence.getId()),
						"0000000");
		persistence.setSerialNumber(seriNumber);
	}
	public void update(Member entity) {
		super.update(entity);
		if(entity.getSerialNumber()==null||entity.getSerialNumber().length()==0)
		{
			Member persistence=this.getById(entity.getId());
		String seriNumber = "MB-"
			+ NumberFormatTools.formatNumber(String.valueOf(entity.getId()),
					"0000000");
		persistence.setSerialNumber(seriNumber);
		}
		}
	
}