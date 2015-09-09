package cn.jtgoo.cms.web.struts.fenxiaoaction;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.VisaOrder;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.domain.VisaType;
import cn.jtgoo.cms.enumvo.VisaOrderStatusEnum;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.util.VisaOrderStatusUtils;
import cn.jtgoo.cms.vo.VisaOrderState;
public class VisaOrderFenXiaoAction extends BaseAction {
	/** 列表 */
	public ActionForward customerOrderList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
			//该字段，是为了处理left.jsp 订单管理列表中的夹带的状态
		String status=request.getParameter("status");
		//获取当前session中的 用户实例
		Customer customer = (Customer) request.getSession().getAttribute("customer"); 
		//默认是直查VisaOrder VO，如果有查询客户的情况，就重新生成hqlHelper ，使用左连接查询
		HqlHelper hqlHelper = new HqlHelper(" FROM  VisaOrder vo");
		hqlHelper.addWhereCondition("vo.customer.id=?", customer.getId());
		
		//处理 left 订单列表中夹带的status  和 header 中 最新订单中的status
		if(status!=null &&status.length()>0)
		{
			if(status.length()==1)
			{
				hqlHelper.addWhereCondition("vo.status=?", status==null?1:status);
			}
			else
			{//如果是其它 订单状态就用 status 列表  ，hql中 用 in 语句
				List<String> alist=new ArrayList<String>();
				String[] arr=status.split("\\|");
				for(int i=0;i<arr.length;i++)
				{
					alist.add(arr[i]);
				}
				hqlHelper.addWhereCondition("vo.status in (:alist)", alist);
			}
		}
		else
		{
			//此时不以left.jsp  订单列表中的 状态作为首要查询条件，而是页面中table 上边的form 查询条件，需重新拼接 或者构造hql语句
			String serialnumber=request.getParameter("serialnumber");
			String customer_name=request.getParameter("customer_name");
			String country_select=request.getParameter("country_select");
			String lingqu_select=request.getParameter("lingqu_select");
			String visatype_select=request.getParameter("visatype_select");
			String startTime=request.getParameter("startTime");
			String order_status=request.getParameter("order_status");
			String customerServicers=request.getParameter("customerServicers");
			if(StringUtils.isNotEmpty(customer_name))
			{
				//由于牵扯到了多个客户列表，需要重新生成 hql 语句，用left join 拼接
				hqlHelper = new HqlHelper(" FROM  VisaOrder vo  left join vo.customerSet c");
				hqlHelper.addSelectProperty("vo");
				hqlHelper.addWhereCondition("vo.customer.id=?", customer.getId());
				hqlHelper.addWhereCondition("c.name  like ? ", "%"+customer_name+"%");
			}
			
			
			
			if(StringUtils.isNotEmpty(serialnumber))
			{
				hqlHelper.addWhereCondition("vo.serialnumber=?",serialnumber);
			}
			if(StringUtils.isNotEmpty(country_select))
			{
				hqlHelper.addWhereCondition("vo.visaProduct.country.id=?",Long.valueOf(country_select.trim()));
			}
			if(StringUtils.isNotEmpty(lingqu_select))
			{
				hqlHelper.addWhereCondition("vo.visaProduct.lingqu.id=?",Long.valueOf(lingqu_select.trim()));
			}
			if(StringUtils.isNotEmpty(visatype_select))
			{
				hqlHelper.addWhereCondition("vo.visaProduct.type.id=?",Long.valueOf(visatype_select.trim()));
			}
		
			if(startTime!=null&&startTime.trim().length()>0)
			{		
				hqlHelper.addBetween(" AND  vo.interviewTime ",startTime, request.getParameter("endTime"));
			}
			if(order_status!=null&&order_status.trim().length()>0)
			{		
				hqlHelper.addWhereCondition("vo.status=?",order_status.trim());
			}
			if(customerServicers!=null&&customerServicers.trim().length()>0)
			{		
				hqlHelper.addWhereCondition("vo.customerServicers.name=?",customerServicers.trim());
			}
			
		}
		PageBean	pageBean = visaOrderService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		List<String> statsList=new ArrayList<String>();
		statsList.add(String.valueOf(VisaOrderStatusEnum.RESERVED.ordinal()));
		statsList.add(String.valueOf(VisaOrderStatusEnum.RECEIVED_MATERIAL.ordinal()));
		statsList.add(String.valueOf(VisaOrderStatusEnum.APPLIED_MATERIAL.ordinal()));
		statsList.add(String.valueOf(VisaOrderStatusEnum.APPOINTMENT.ordinal()));
		statsList.add(String.valueOf(VisaOrderStatusEnum.HAVA_AN_INTERVIEW.ordinal()));
		statsList.add(String.valueOf(VisaOrderStatusEnum.GOT_THE_VISA.ordinal()));
		statsList.add(String.valueOf(VisaOrderStatusEnum.SENT_BACK.ordinal()));
		Long nocheck=visaOrderService.findByCustomesStatus(customer.getId(),String.valueOf(VisaOrderStatusEnum.NON_CHECKED.ordinal()));
		Long finished=visaOrderService.findByCustomesStatus(customer.getId(),String.valueOf(VisaOrderStatusEnum.FINISHED.ordinal()));
		//处理中
		Long process=visaOrderService.findByCustomesStatus(customer.getId(),statsList);
		request.getSession().setAttribute("nocheck", nocheck);
		request.getSession().setAttribute("process", process);
		request.getSession().setAttribute("finished", finished);
		request.setAttribute("pageBean", pageBean);
		
		//七大洲
		List<Country> topCountryList=visaCountryService.findTopLevel();
		//领取
		List<Lingqu> lingquList=visaLingquService.findAllByStatus();
		//签证类型
		List<VisaType> visaTypeList=visaTypeService.findAllByStatus();
		
		request.setAttribute("topCountryList", topCountryList);
		request.setAttribute("lingquList", lingquList);
		request.setAttribute("visaTypeList", visaTypeList);
		VisaOrderStatusUtils.visaStatus(request);
		
		return mapping.findForward("customerOrderList");
	}
	
	/** 列表 */
	public ActionForward productOrderUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Customer customer = (Customer) request.getSession().getAttribute("customer"); 
		customer = customerService.getById(customer.getId());
		String visaproductId=request.getParameter("productId").trim();
		VisaProduct visaProduct=null;
		if(StringUtils.isNotEmpty(visaproductId))
		{
			visaProduct=visaProductService.getById(Long.valueOf(visaproductId.trim()));
		}
		request.setAttribute("visaProduct", visaProduct);
		request.setAttribute("customerServices", customer.getCustomerServicers());
		return mapping.findForward("productOrderUI");
	}
	public ActionForward reserveOrder(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Customer customer = (Customer) request.getSession().getAttribute("customer"); 
		customer = customerService.getById(customer.getId());
		String visaproductId=request.getParameter("productId").trim();
		//客服id
		String service_select=request.getParameter("service_select").trim();
		String num=request.getParameter("num").trim();
		String num1=request.getParameter("num1").trim();
		String num2=request.getParameter("num2").trim();
		VisaProduct visaProduct=null;
		if(StringUtils.isNotEmpty(visaproductId))
		{
			visaProduct=visaProductService.getById(Long.valueOf(visaproductId.trim()));
			VisaOrder visaOrder = new VisaOrder();
			visaOrder.setStatus(String.valueOf(VisaOrderState.Unaudited.ordinal()));
			visaOrder.setExpectCertificateTime(NumberFormatTools.getCurrentTime());
			visaOrder.setSendSignedTime(NumberFormatTools.getCurrentTime());
			visaOrder.setUser_type(cn.jtgoo.cms.enumvo.CustomerTypeEnum.PEER_USER_TYPE.ordinal());
			visaOrder.setCustomer(customer);
			visaOrder.setVisaProduct(visaProduct);
			visaOrder.setUser(null);
			visaOrder.setName(visaProduct.getName());
			//客服
			cn.jtgoo.cms.domain.CustomerServicersVo csv=customerServicers.getById(Long.valueOf(service_select.trim()));
			visaOrder.setCustomerServicers(csv);
			//设置人数
			visaOrder.setNum(num==""?0:Integer.valueOf(num));
			visaOrder.setNum1(num==""?0:Integer.valueOf(num1));
			visaOrder.setNum2(num==""?0:Integer.valueOf(num2));
			//关联 客户信息
			visaOrderService.save(visaOrder);
			//查询所有客户信息
			Long[] customerIds= NumberFormatTools.arrayconverToLongarray(request.getParameterValues("customerIds"));
			if(customerIds!=null && customerIds.length>0)
			{
				List<Customer> customer_list=customerService.getByIds(customerIds);
				if(customer_list!=null && customer_list.size()>0)
				{
				customerService.save_order_customertList(Long.valueOf(visaproductId), visaOrder.getId(), customer_list);
				}
			}
			}
		// 1, actionForm --> new User()
		return mapping.findForward("success");
	}
	/** 列表 */
	public ActionForward appointmentDynamicTimeList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Customer customer = (Customer) request.getSession().getAttribute("customer"); 
		customer = customerService.getById(customer.getId());
		PageBean pageBean = null;
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String lingquId=request.getParameter("lingquId");
		System.out.println(lingquId+">>");
		String startTime=request.getParameter("startTime");
		HqlHelper hqlHelper = new HqlHelper(VisaOrder.class, "vo")
		.addWhereCondition("vo.visaProduct.lingqu.id=?",Long.valueOf(lingquId.trim()))
		.addWhereCondition("vo.customer.id=?",customer.getId());
			Set<Lingqu> lingquSet = customer.getLingquSet();
			if (lingquSet != null && lingquSet.size() > 0) {
				
			     if(startTime!=null&&startTime.trim().length()>0)
					{
						hqlHelper.addBetween(" AND vo.interviewTime ",startTime.trim(), request.getParameter("endTime").trim());
					}
				pageBean = visaOrderService.getPageBean(hqlHelper,
						getPageNum(request),getPageSize(request));

		} else {
		     if(startTime!=null&&startTime.trim().length()>0)
				{
					hqlHelper.addBetween(" AND  vo.interviewTime ",startTime.trim(), request.getParameter("endTime").trim());
				}
			pageBean = visaOrderService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
		}
		/**
		 * 查询所有洲际
		 */
		
		List<Country> zhouJiList=visaCountryService.findTopLevel();
//		
//		visaStatus(request);
//		request.setAttribute("lingquVo", lingquVo);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("zhouJiList", zhouJiList);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("appointmentDynamicTimeList");
	}
	
}