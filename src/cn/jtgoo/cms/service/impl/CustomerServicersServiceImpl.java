package cn.jtgoo.cms.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.CustomerServicersService;
import cn.jtgoo.cms.util.NumberFormatTools;
@SuppressWarnings("unchecked")
public class CustomerServicersServiceImpl extends BaseDaoImpl<CustomerServicersVo> implements
	 CustomerServicersService{
	public List<CustomerServicersVo> findListByPeerId(Long peerId,String userType) {
		return getSession().createQuery("FROM CustomerServicersVo cs where cs.del_status="+String.valueOf(Delstatus.ACTIVE.ordinal())+" and  cs.customer.id="+peerId+" and cs.userType="+userType).list();
	}
	public List<CustomerServicersVo> findAllByName(String keyword) {
		return getSession().createSQLQuery("select * from jtgoo_customerservicers jc where jc.name like '%"+keyword+"%'").addEntity(CustomerServicersVo.class).list();
	}

	public void save(CustomerServicersVo entity) {

	   Query query=getSession().createQuery("FROM CustomerServicersVo cs where cs.customer.id=?");
	   query.setParameter(0, entity.getCustomer().getId());
	   List<CustomerServicersVo> listCustomerservice=query.list();
	   String servicersName="";
	   //更新同业用户的数据
	   for(CustomerServicersVo servicers:listCustomerservice)
	   {
		   if(StringUtils.isEmpty(servicersName))
		   {
			   servicersName=servicers.getName();
		   }
		   else
		   {
		   servicersName=servicersName+","+servicers.getName();
		   }
		   }
	   /**
	    * 追加新的联系人名称
	    */
	   servicersName=servicersName+","+entity.getName();
	   entity.getCustomer().setCustomerServiceNames(servicersName);
	   getSession().save(entity);
	   
	   String seriNumber = "KF-"+ NumberFormatTools.formatNumber(String.valueOf(entity.getId()),"0000000");
	   CustomerServicersVo dbvo=  this.getById(entity.getId());
	   dbvo.setSerialNumber(seriNumber);
	}


	/**
	 * 删除时将同业客户中客服名称去掉一个
	 */
	public void delete(Long id) {
		CustomerServicersVo dbvo=this.getById(id);
		if(dbvo!=null)
		{
			dbvo.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		}
	}

	@Override
	public List<CustomerServicersVo> findListByCustomerId(Long customerId) {
		return getSession().createQuery("FROM CustomerServicersVo cs where cs.customer.id="+customerId).list();
	}


}