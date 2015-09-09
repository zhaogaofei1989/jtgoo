package cn.jtgoo.cms.web.struts.action;

import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.CusDat;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.Member;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.domain.VisaOrder;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.domain.VisaType;
import cn.jtgoo.cms.exception.AppException;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.ExportUtils;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.ObjInfo;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.util.VisaOrderStatusUtils;
import cn.jtgoo.cms.vo.VisaOrderState;
import cn.jtgoo.cms.web.struts.formbean.VisaOrderActionForm;

public class VisaOrderAction extends BaseAction {
	/** 列表 */
	@SuppressWarnings("unchecked")
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String startTime=request.getParameter("startTime");
		User user = (User) request.getSession().getAttribute("user");
		user = userService.getById(user.getId());
		PageBean pageBean = null;
		HqlHelper hqlHelper=null;
		List coutryList= NumberFormatTools.arrayconverToList(request.getParameterValues("visa_country[]"));
		List visa_typeList= NumberFormatTools.arrayconverToList(request.getParameterValues("visa_type[]"));
		List visa_lingquList= NumberFormatTools.arrayconverToList(request.getParameterValues("visa_lingqu[]"));
		List visa_status= NumberFormatTools.arrayconverToStringList(request.getParameterValues("visa_status[]"));
		// String userId=
		// 一、构建查询条件
		/**
		 * 先判断查询条件中是否含有customer的参数，比如，qq 邮箱什么，如果有就用左外连接，如果没有就用普通查询
		 */
		String customerparam=request.getParameter("customerparam");
		String search_customerparam=request.getParameter("search_customerparam");
		if(StringUtils.isEmpty(customerparam))
		{
			hqlHelper = new HqlHelper(VisaOrder.class,"vo");
		}
	
		else
		{
			hqlHelper = new HqlHelper(" FROM  VisaOrder vo  left join vo.customerSet c");
			hqlHelper.addSelectProperty("vo");
			hqlHelper.addWhereCondition("c."+customerparam+" like ? ", "%"+search_customerparam==null?"":search_customerparam.trim()+"%");
		}
			/**
			 * 联系人信息
			 */
		String linkmanparam=request.getParameter("linkmanparam");
		String search_linkmanparam=request.getParameter("search_linkmanparam");
		if(StringUtils.isNotEmpty(linkmanparam))
		{
			hqlHelper.addWhereCondition(linkmanparam==null?"":" vo.customerServicers."+linkmanparam.trim()+" like ? ", "%"+search_linkmanparam==null?"":search_linkmanparam.trim()+"%");
		}
		
		//禁止再生成where 字段
//		hqlHelper.setWhereClause("");
		hqlHelper.addWhereCondition("vo.single=?",request.getParameter("search_single"));
		hqlHelper.addWhereCondition("vo.serialnumber=?",request.getParameter("serialnumber"));
		hqlHelper.addWhereCondition("vo.visaProduct.country.id in( ",coutryList==null?"":NumberFormatTools.convertListToString(coutryList)+")");
		hqlHelper.addWhereCondition("vo.visaProduct.type.id in( ", visa_typeList==null?"":NumberFormatTools.convertListToString(visa_typeList)+")");
		hqlHelper.addWhereCondition("vo.visaProduct.lingqu.id in( ", visa_lingquList==null?"":NumberFormatTools.convertListToString(visa_lingquList)+")");
		hqlHelper.addWhereCondition("vo.status in(", visa_status==null?"":NumberFormatTools.convertListToString(visa_status)+")");
		
		//=====================================================
		
		hqlHelper.addWhereCondition("vo.sentToSignPeople=?",request.getParameter("sentToSignPeople"));
		hqlHelper.addWhereCondition("vo.operator=?",request.getParameter("operator"));
		hqlHelper.addWhereCondition("vo.recorder=?",request.getParameter("recorder"));
		hqlHelper.addWhereCondition("vo.companyName=?",request.getParameter("companyName"));
		hqlHelper.addWhereCondition("vo.dataIsComplete=?",request.getParameter("dataIsComplete"));
		
		String isChart=request.getParameter("isChart");
		if(StringUtils.isNotEmpty(isChart))
		{
				if(isChart.equals("9"))
				{
					hqlHelper.addWhereCondition("vo.status=?",isChart);
				}
				else
				{
					hqlHelper.addWhereCondition("vo.status!=?","9");
				}
			
		}
		if(StringUtils.isNotEmpty(request.getParameter("isRefusal")))
		{
			hqlHelper = new HqlHelper(" FROM  VisaOrder vo  left join vo.customerSet c");
			hqlHelper.addSelectProperty("vo");
			hqlHelper.addWhereCondition("c.isRefusal =? ", request.getParameter("isChart"));
		}
		hqlHelper.addWhereCondition("vo.buyInsurance=?",request.getParameter("buyInsurance"));

		if (!user.getLoginName().equals("admin")) {
			List<String> list = new ArrayList<String>();
			Set<Lingqu> lingquSet = user.getLingquSet();
			if (lingquSet != null && lingquSet.size() > 0) {
				for (Lingqu lingqu : lingquSet) {list.add(lingqu.getId().toString());}
				hqlHelper.addWhereCondition("vo.visaProduct.lingqu.id in(", list==null?"":NumberFormatTools.convertListToString(list)+")");
			     if(startTime!=null&&startTime.trim().length()>0)
					{
						hqlHelper.addBetween(" AND jv.interviewTime ",startTime, request.getParameter("endTime"));
					}
				pageBean = visaOrderService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
			} else {
				pageBean = visaOrderService.getPageBean(hqlHelper,	getPageNum(request),getPageSize(request));
				pageBean.setRecordList(null);
				pageBean.setRecordCount(0);
			}
		} else {
		     if(startTime!=null&&startTime.trim().length()>0)
				{
					hqlHelper.addBetween("  vo.interviewTime ",startTime, request.getParameter("endTime"));
				}
		     	hqlHelper.addOrderProperty("vo.id", false);
			pageBean = visaOrderService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
		}

		/**
		 * 订单状态集合
		 * 以后可考虑将订单状态放入单独的表中
		 */
		VisaOrderStatusUtils.visaStatus(request);
		
		/** 
		 * 国家集合
		 */
		List<Country> countryList = visaCountryService.findTopLevel();
		request.setAttribute("countryList", countryList);
		/**
		 * 类型集合
		 */
		List<VisaType>visaTypeList=visaTypeService.findAll();
		request.setAttribute("visaTypeList", visaTypeList);
		/**
		 * 领区集合
		 */
		List<Lingqu> lingquList=visaLingquService.findAll();
		request.setAttribute("lingquList", lingquList);
		List<User> userList=userService.findAll();
		request.setAttribute("userList", userList);
		request.setAttribute("pageBean", pageBean);
		
		//用户姓名，根据订单中的customerId 进行查询，如果是type=0,查同业用户，如果type=1 查直接用户
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("list");
	}


	
	
	public ActionForward interviewAppointmentList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		user = userService.getById(user.getId());
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String lingquId=request.getParameter("lingquId");
		String startTime=request.getParameter("startTime");
		Lingqu lingquVo=visaLingquService.getById(Long.valueOf(lingquId.trim()));
		// String userId=
		// 一、构建查询条件
		VisaOrderActionForm order = (VisaOrderActionForm) form;
		HqlHelper hqlHelper = new HqlHelper(VisaOrder.class, "vo")
		.addWhereCondition("vo.visaProduct.lingqu.id=?",Long.valueOf(lingquId.trim()))
		.addWhereCondition("vo.user.name=?", order.getUser().getName());
		PageBean pageBean = null;
		if (!user.getLoginName().equals("admin")) {
			List<String> list = new ArrayList<String>();
			Set<Lingqu> lingquSet = user.getLingquSet();
			if (lingquSet != null && lingquSet.size() > 0) {
				for (Lingqu lingqu : lingquSet) {
					list.add(lingqu.getId().toString());
				}
				
//				hqlHelper.addWhereCondition(
//						"vo.visaProduct.lingqu.id in (", list==null?"":NumberFormatTools.convertListToString(list)+")");
				
			     if(startTime!=null&&startTime.trim().length()>0)
					{
						hqlHelper.addBetween(" AND vo.interviewTime ",startTime.trim(), request.getParameter("endTime").trim());
					}
				pageBean = visaOrderService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
			} else {
				pageBean = visaOrderService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
				pageBean.setRecordList(null);
				pageBean.setRecordCount(0);
			}

		} else {
		     if(startTime!=null&&startTime.trim().length()>0)
				{
					hqlHelper.addBetween(" AND  vo.interviewTime ",startTime.trim(), request.getParameter("endTime").trim());
				}
			pageBean = visaOrderService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
		}

		/**
		 * 订单状态集合
		 * 以后可考虑将订单状态放入单独的表中
		 */
		VisaOrderStatusUtils.visaStatus(request);
		request.setAttribute("lingquVo", lingquVo);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		
		return mapping.findForward("interviewAppointmentList");
	}
	
	/**
	 * 出发时间提醒
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ActionForward startTimeRemainList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		user = userService.getById(user.getId());
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String lingquId=request.getParameter("lingquId");
		String startTime=request.getParameter("startTime");
		Lingqu lingquVo=visaLingquService.getById(Long.valueOf(lingquId.trim()));
		// String userId=
		// 一、构建查询条件
		VisaOrderActionForm order = (VisaOrderActionForm) form;
		HqlHelper hqlHelper = new HqlHelper(VisaOrder.class, "vo")
		.addWhereCondition("vo.visaProduct.lingqu.id=?",Long.valueOf(lingquId.trim()))
		.addWhereCondition("vo.user.name=?", order.getUser().getName());
		PageBean pageBean = null;
		if (!user.getLoginName().equals("admin")) {
			List<String> list = new ArrayList<String>();
			Set<Lingqu> lingquSet = user.getLingquSet();
			if (lingquSet != null && lingquSet.size() > 0) {
				for (Lingqu lingqu : lingquSet) {
					list.add(lingqu.getId().toString());
				}
//				hqlHelper.addWhereCondition(
//						"vo.visaProduct.lingqu.id in(", list==null?"":NumberFormatTools.convertListToString(list)+")");;
				
			     if(startTime!=null&&startTime.trim().length()>0)
					{
						hqlHelper.addBetween(" AND vo.interviewTime ",startTime.trim(), request.getParameter("endTime").trim());
						hqlHelper.addOrderProperty(" vo.receivedDataTime3 ", true);
					}
			     		pageBean = visaOrderService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
			} else {
				pageBean = visaOrderService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
				pageBean.setRecordList(null);
				pageBean.setRecordCount(0);
			}

		} else {
		     if(startTime!=null&&startTime.trim().length()>0)
				{
		    	 hqlHelper.addBetween(" AND  vo.interviewTime ",startTime.trim(), request.getParameter("endTime").trim());
				hqlHelper.addOrderProperty(" vo.receivedDataTime3 ", true);
				}
			pageBean = visaOrderService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
		}
	
		/**
		 * 订单状态集合
		 * 以后可考虑将订单状态放入单独的表中
		 */
		VisaOrderStatusUtils.visaStatus(request);
		request.setAttribute("lingquVo", lingquVo);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		
		return mapping.findForward("startTimeRemainList");
	}
	
	public ActionForward appointmentDynamicTimeList (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		user = userService.getById(user.getId());
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String lingquId=request.getParameter("lingquId");
		String startTime=request.getParameter("startTime");
		Lingqu lingquVo=visaLingquService.getById(Long.valueOf(lingquId.trim()));
		// String userId=
		// 一、构建查询条件
		VisaOrderActionForm order = (VisaOrderActionForm) form;
		HqlHelper hqlHelper = new HqlHelper(VisaOrder.class, "vo")
		.addWhereCondition("vo.visaProduct.lingqu.id=?",Long.valueOf(lingquId.trim()))
		.addWhereCondition("vo.user.name=?", order.getUser().getName());
		PageBean pageBean = null;
		if (!user.getLoginName().equals("admin")) {
			List list = new ArrayList();
			Set<Lingqu> lingquSet = user.getLingquSet();
			if (lingquSet != null && lingquSet.size() > 0) {
				for (Lingqu lingqu : lingquSet) {
					list.add(lingqu.getId());
				}
//				hqlHelper.addWhereCondition(
//						"vo.visaProduct.lingqu.id in (:alist)", list);
				
			     if(startTime!=null&&startTime.trim().length()>0)
					{
						hqlHelper.addBetween(" AND vo.interviewTime ",startTime.trim(), request.getParameter("endTime").trim());
					}
				pageBean = visaOrderService.getPageBean(hqlHelper,
						getPageNum(request),getPageSize(request));
			} else {
				pageBean = visaOrderService.getPageBean(hqlHelper,
						getPageNum(request),getPageSize(request));
				pageBean.setRecordList(null);
				pageBean.setRecordCount(0);
			}

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
		
		VisaOrderStatusUtils.visaStatus(request);
		request.setAttribute("lingquVo", lingquVo);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("zhouJiList", zhouJiList);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		
		return mapping.findForward("appointmentDynamicTimeList");
	}
	
	
	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		visaOrderService.delete(id);
		return mapping.findForward("toList");
	}

	public ActionForward splitOrderUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String id = request.getParameter("id");
		VisaOrder visaOrder = visaOrderService.getById(Long.valueOf(id));
		visaOrder.getCustomerSet().clear();
		List<Customer> customerList = customerService
				.findAllByVisaIdAndProductId(
						visaOrder.getVisaProduct().getId(), visaOrder.getId());
		Set<Customer> set = new LinkedHashSet<Customer>();
		set.addAll(customerList);
		visaOrder.getCustomerSet().addAll(set);
		request.setAttribute("visaOrder", visaOrder);
		return mapping.findForward("splitOrderUI");
	}

	public ActionForward splitOrder(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String id = request.getParameter("id");
		String customerIds = request.getParameter("customerIds");

		/**
		 * copy 数据库生成新的订单 order 代表当前的已有的订单
		 */
		VisaOrder order = visaOrderService.getById(Long.valueOf(id.trim()));
		//防止出现 两个对象同时引用一个集合
		order.setCustomerSet(null);
		order.setCusDat(null);
		String[] array=customerIds.split(",");
		Long[] ids=new Long[array.length];
		
		for(int i=0;i<ids.length;i++)
		{
			ids[i]=Long.valueOf(array[i]);
			System.out.println(ids[i]);
		}
		List<Customer> customerList=customerService.getByIds(ids);
		System.out.println(customerList);
		
		VisaOrder newOrder = new VisaOrder();
		BeanUtils.copyProperties(newOrder, order);
		newOrder.setId(null);
		HashSet<Customer> hashSet=new HashSet<Customer>();
		hashSet.addAll(customerList);
		newOrder.setCustomerSet(hashSet);
		visaOrderService.save(newOrder);
		/**
		 * 从老的订单更新所选的客户，改变其映射关系
		 * 
		 */

		visaDataTypeDetailService.updateRelationByOrderId(newOrder.getId(),
				customerIds);

		/**
		 * 删除被拆分的订单中的客户
		 */
		return mapping.findForward("toList");
	}

	/** 订单报表的生成 */
	public ActionForward orderPDF(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		
		String ids = request.getParameter("id");
		List<VisaOrder> orderList = new ArrayList<VisaOrder>();
		if (StringUtils.isNotEmpty(ids)) {
			String[] array = ids.split(",");
			Long[] idArr = new Long[array.length];
			for (int i = 0; i < array.length; i++) {
				idArr[i] = Long.valueOf(array[i].toString());
			}
			orderList = visaOrderService.getByIds(idArr);
			for (VisaOrder vo : orderList) {
				// 如果有，清空所有值
				vo.getCustomerSet().clear();
				List<Customer> customerList = customerService
						.findAllByVisaIdAndProductId(vo.getVisaProduct()
								.getId(), vo.getId());
				Set<Customer> set = new LinkedHashSet<Customer>();
				set.addAll(customerList);
				vo.getCustomerSet().addAll(set);
				/**
				 * 
				 */
				if (StringUtils.isNotEmpty(vo.getCustomServiceId())) {
					CustomerServicersVo cusers = customerServicers.getById(Long
							.valueOf(vo.getCustomServiceId().trim()));
					vo.setCustomerServersPhone(cusers.getPhone());
				}
			}
		}
		request.setAttribute("orderList", orderList);
		return mapping.findForward("orderPDF");
	}

	/** 导出excel */
	public ActionForward exportExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String label = request.getParameter("label");
		String lingquId = request.getParameter("lingquId");
		String ids = request.getParameter("id");
		List<VisaOrder> orderList = new ArrayList<VisaOrder>();
		if (StringUtils.isNotEmpty(ids)) {
			String[] array = ids.split(",");
			Long[] idArr = new Long[array.length];
			for (int i = 0; i < array.length; i++) {
				idArr[i] = Long.valueOf(array[i].toString());
			}
			orderList = visaOrderService.getByIds(idArr);
			for (VisaOrder vo : orderList) {
				// 如果有，清空所有值
				List<CusDat> cusdatList = customerService
						.findCusDatByorderId(vo.getId());
				vo.setCusDat(cusdatList);

				List<Customer> customerList = customerService
						.findAllByVisaIdAndProductId(vo.getVisaProduct()
								.getId(), vo.getId());
				Set<Customer> set = new LinkedHashSet<Customer>();
				set.addAll(customerList);
				vo.getCustomerSet().addAll(set);
				if (StringUtils.isNotEmpty(vo.getCustomServiceId())) {
					CustomerServicersVo servicer = customerServicers.getById(Long.valueOf(vo.getCustomServiceId()));
					vo.setCustomerServicers(servicer);
				}
			}
		}

		// 导出
		
		/**
		 * 根据来判断用哪个方法
		 */
		String name ="";
		if(label.equals("001"))
		{
			 name = exportExcel(request,orderList);
		}
		/**
		 * 面试预约提醒
		 */
		  else if(label.equals("002"))
		{
			if(StringUtils.isNotEmpty(lingquId))
			{
		     Lingqu lingqu=visaLingquService.getById(Long.valueOf(lingquId));
			 name = exportExcel002(request,orderList,lingqu.getName());
			}
		}
		/**
		 * 出发时间提醒
		 */
		else if(label.equals("003"))
		{
			if(StringUtils.isNotEmpty(lingquId))
			{
		     Lingqu lingqu=visaLingquService.getById(Long.valueOf(lingquId));
			 name = exportExcel003(request,orderList,lingqu.getName());
			}
		}
		/**
		 * 预约时间动态提醒
		 */
		else if(label.equals("004"))
		{
			if(StringUtils.isNotEmpty(lingquId))
			{
		     Lingqu lingqu=visaLingquService.getById(Long.valueOf(lingquId));
			 name = exportExcel003(request,orderList,lingqu.getName());
			}
		}
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=\""+ new String("签证订单".getBytes("GBK"),"ISO8859-1")+NumberFormatTools.getCurrentDay()+".xls" + "\"");
		// 输出文件内容
		FileInputStream in = new FileInputStream(name);
		try {
			IOUtils.copy(in, response.getOutputStream());
		} catch (Exception e) {
			System.out.println(request.getHeader("User-Agent")
					+ " have problem!");
		}
		finally {
			IOUtils.closeQuietly(in);
		}
		return null;
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession httpSession = (HttpSession) request.getSession();
		User user = (User) httpSession.getAttribute("user");
		List<User> userList = userService.findAll();
		VisaOrder order = new VisaOrder();
		VisaOrderActionForm visa = (VisaOrderActionForm) form;
		visa.setCustomer_userType("0");
		visa.setRecorder(user.getLoginName());
		SetQueryTypeMethod(request, order);
		request.setAttribute("userList", userList);
		request.setAttribute("customer_userType", visa.getCustomer_userType());
		request.setAttribute("dataIsComplete", visa.getDataIsComplete());
		return mapping.findForward("saveUI");
	}

	/** 保存并继续 */

	public ActionForward saveAndGoOn(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HttpSession httpSession = (HttpSession) request.getSession();
		User user = (User) httpSession.getAttribute("user");
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		VisaOrder visaOrder = new VisaOrder();
		BeanUtils.copyProperties(visaOrder, actionForm);
		String customer_userType = actionForm.getCustomer_userType();
		saveCustomer(request, actionForm, customer_userType, visaOrder);
		visaOrder.setStatus(String.valueOf(VisaOrderState.Unaudited.ordinal()));
		visaOrder.setQueryType("1");
		visaOrder.setExpectCertificateTime(NumberFormatTools.getCurrentTime());
		visaOrder.setSendSignedTime(NumberFormatTools.getCurrentTime());
		if (StringUtils.isEmpty(visaOrder.getStatus())) {
			visaOrder.setStatus("0");
		}

		setCurrentUser(0, user, actionForm);
		SetQueryTypeMethod(request, visaOrder);
		visaOrder.setUser(user);
		visaOrderService.save(visaOrder);

		// 回显数据
		List<User> userList = userService.findAll();
		/**
		 * 保存并继续只有在新新加订单才使用
		 */
		actionForm.setId(String.valueOf(visaOrder.getId()));
		actionForm.setSerialnumber(visaOrder.getSerialnumber());
		request.setAttribute("user1", user.getName());
		request.setAttribute("userList", userList);
		request.setAttribute("customer_userType", actionForm
				.getCustomer_userType());
		request.setAttribute("single", visaOrder.getSingle() == "" ? "0"
				: visaOrder.getSingle());
		request.setAttribute("status", Integer
				.valueOf(visaOrder.getStatus() == null ? "0" : visaOrder
						.getStatus()));
		//通用方法的设置该属性时，还没有绑定关系。该方法必须重新覆盖,否则联系人列表将为空
		request.setAttribute("customerServiceSet", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getCustomerServicers());
		// 3, return
		request.setAttribute("visaProductId", visaOrder.getVisaProduct().getId());
		request.setAttribute("visaProductName", visaOrder.getVisaProduct().getName());
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	@SuppressWarnings("unused")
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> new User()
		HttpSession httpSession = (HttpSession) request.getSession();
		User user = (User) httpSession.getAttribute("user");
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		VisaOrder visaOrder = new VisaOrder();
		BeanUtils.copyProperties(visaOrder, actionForm);
		String customer_userType = actionForm.getCustomer_userType();
		saveCustomer(request, actionForm, customer_userType, visaOrder);
		visaOrder.setStatus(String.valueOf(VisaOrderState.Unaudited.ordinal()));
		visaOrder.setQueryType("1");
		visaOrder.setExpectCertificateTime(NumberFormatTools.getCurrentTime());
		visaOrder.setSendSignedTime(NumberFormatTools.getCurrentTime());
		setCurrentUser(0, user, actionForm);
		visaOrder.setUser(user);
		visaOrderService.save(visaOrder);
		// 3, return
		return mapping.findForward("toList");
	}
	
	
	
	public ActionForward saveAndClose(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession httpSession = (HttpSession) request.getSession();
		User user = (User) httpSession.getAttribute("user");
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		String customer_userType = actionForm.getCustomer_userType();
		VisaOrder visaOrder = visaOrderService.getById(Long.valueOf(actionForm	.getId()));
		// 防止号码被冲掉
		actionForm.setSerialnumber(visaOrder.getSerialnumber()==null?visaOrder.getVisaProduct().getLingqu().getPrefix()+"-"+ NumberFormatTools.formatNumber(String.valueOf(visaOrder.getId()),"0000000"):visaOrder.getSerialnumber());
		// 复制属性
		BeanUtils.copyProperties(visaOrder, actionForm);
		saveCustomer(request, actionForm, customer_userType, visaOrder);
		SetExpressMethod(request, visaOrder);
		visaOrder.setUser(user);
		setCurrentUser(Integer.valueOf(actionForm.getStatus()), user,actionForm);
		setAllUser(request, visaOrder);
		SetQueryTypeMethod(request, visaOrder);
		request.setAttribute("visaProductId", visaOrder.getVisaProduct().getId());
		request.setAttribute("visaProductName", visaOrder.getVisaProduct().getName());
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {	
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		VisaOrder visaOrder = visaOrderService.getById(Long.valueOf(actionForm.getId()));
		
		// cusdat表数据
		List<CusDat> cusDatList = customerService.findCusDatByorderId(visaOrder.getId());
		if (cusDatList != null && cusDatList.size() > 0&& cusDatList.get(0) != null) {
			Long[] cusDatId = new Long[cusDatList.size()];
			for (int i = 0; i < cusDatList.size(); i++) {
				cusDatId[i] = cusDatList.get(i).getCustomerId();
			}
		}
		List<User> userList = userService.findAll();
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, visaOrder);
		if(visaOrder.getUser_type()==0)
		{
		actionForm.setCustomerId(String.valueOf(visaOrder.getCustomer().getId()));
		actionForm.setTradeUserForm(visaOrder.getCustomer().getUserName());
		actionForm.setDirectUserForm(visaOrder.getCustomer().getUserName());
		request.setAttribute("hidden_user_name", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getUserName());
		request.setAttribute("customerServiceSet", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getCustomerServicers());
		}
		else if(visaOrder.getUser_type()==1)
		{
			actionForm.setCustomerId(String.valueOf(visaOrder.getMember().getId()));
			actionForm.setTradeUserForm(visaOrder.getMember().getUserName());
			actionForm.setDirectUserForm(visaOrder.getMember().getUserName());
			request.setAttribute("hidden_user_name", visaOrder.getMember()==null?"":visaOrder.getMember().getUserName());
			request.setAttribute("customerServiceSet", visaOrder.getMember().getCustomerServicers());
		}
		request.setAttribute("customer_userType", visaOrder.getUser_type().toString());
		actionForm.setVisaProductId(String.valueOf(visaOrder.getVisaProduct().getId()));
		actionForm.setCustomerForm(visaOrder.getCustomer());
		SetExpressMethod(request, visaOrder);
		SetQueryTypeMethod(request, visaOrder);
		// request.setAttribute("visaOrderList", visaOrderList);
		// 设置用户类型 是同业用户还是直接用户
		actionForm.setCustomer_userType(visaOrder.getUser_type().toString());
		setAllUser(request, visaOrder);
		/**
		 * 资料是否 模式是否  0-是  1-否
		 */
		
		request.setAttribute("dataIsComplete", visaOrder.getDataIsComplete());
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("userList", userList);
		request.setAttribute("single", visaOrder.getSingle() == null ? "": visaOrder.getSingle());
		request.setAttribute("sentToSignPeople", visaOrder.getSentToSignPeople() == null ? "" : visaOrder.getSentToSignPeople());
		request.setAttribute("operator", visaOrder.getOperator() == null ? "": visaOrder.getOperator());
		request.setAttribute("status", visaOrder.getStatus());
		request.setAttribute("visaProductId", visaOrder.getVisaProduct().getId());
		request.setAttribute("visaProductName", visaOrder.getVisaProduct().getName());
		request.setAttribute("customerServiceId", visaOrder.getCustomerServicers()==null?"":visaOrder.getCustomerServicers().getId());
		return mapping.findForward("editUI");
	}

	

	/** 修改页面 */
	public ActionForward showVisaOrderInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {	
		Long orderId=Long.valueOf(request.getParameter("orderId").trim());
		VisaOrder visaOrder = visaOrderService.getById(Long.valueOf(orderId));
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		// cusdat表数据
		List<CusDat> cusDatList = customerService.findCusDatByorderId(visaOrder.getId());
		if (cusDatList != null && cusDatList.size() > 0&& cusDatList.get(0) != null) {
			Long[] cusDatId = new Long[cusDatList.size()];
			for (int i = 0; i < cusDatList.size(); i++) {
				cusDatId[i] = cusDatList.get(i).getCustomerId();
			}
		}
		List<User> userList = userService.findAll();
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, visaOrder);
		if(visaOrder.getUser_type()==0)
		{
			actionForm.setCustomerId(String.valueOf(visaOrder.getCustomer().getId()));
			actionForm.setCustomerForm(visaOrder.getCustomer());
			request.setAttribute("customerServiceSet", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getCustomerServicers());
			request.setAttribute("hidden_user_name", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getUserName());
			actionForm.setTradeUserForm(visaOrder.getCustomer().getUserName());
		}
		else if(visaOrder.getUser_type()==1)
		{
			actionForm.setCustomerId(String.valueOf(visaOrder.getMember().getId()));
			actionForm.setMemberForm(visaOrder.getMember());
			actionForm.setDirectUserForm(visaOrder.getMember().getUserName());
			request.setAttribute("hidden_user_name", visaOrder.getMember()==null?"":visaOrder.getMember().getUserName());
		}
		actionForm.setVisaProductId(String.valueOf(visaOrder.getVisaProduct().getId()));
		SetExpressMethod(request, visaOrder);
		SetQueryTypeMethod(request, visaOrder);
		// request.setAttribute("visaOrderList", visaOrderList);
		// 设置用户类型 是同业用户还是直接用户
		actionForm.setCustomer_userType(visaOrder.getUser_type().toString());
	
		setAllUser(request, visaOrder);
		request.setAttribute("customer_userType", visaOrder.getUser_type().toString());
		/**
		 * 资料是否 模式是否  0-是  1-否
		 */
		request.setAttribute("orderId", visaOrder.getId());
		request.setAttribute("dataIsComplete", visaOrder.getDataIsComplete());
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("userList", userList);
		request.setAttribute("single", visaOrder.getSingle() == null ? "": visaOrder.getSingle());
		request.setAttribute("sentToSignPeople", visaOrder.getSentToSignPeople() == null ? "" : visaOrder.getSentToSignPeople());
		request.setAttribute("operator", visaOrder.getOperator() == null ? "": visaOrder.getOperator());
		request.setAttribute("status", visaOrder.getStatus());
		request.setAttribute("attchment", visaOrder.getVisaorder_attachment()==null?"":visaOrder.getVisaorder_attachment());
		request.setAttribute("visaProductId", visaOrder.getVisaProduct().getId());
		request.setAttribute("customerServiceId", visaOrder.getCustomerServicers()==null?"":visaOrder.getCustomerServicers().getId());
		return mapping.findForward("showVisaOrderInfo");
	}
	
	/** 修改页面 */
	public ActionForward savaNextUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession httpSession = (HttpSession) request.getSession();
		User user = (User) httpSession.getAttribute("user");
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		/**
		 * 获取用户类型 是同业用户还是直接用户 0 同业用户 1 直接用户
		 */
		String customer_userType = actionForm.getCustomer_userType();

		/**
		 * 从数据库中 得到visaorder信息
		 */
		VisaOrder visaOrder = visaOrderService.getById(Long.valueOf(request
				.getParameter("id").trim()));

		/**
		 * 加载客户信息 和客服信息
		 */
		List<User> userList = userService.findAll();

		/**
		 * 状态+1
		 */
		Long status = (Long.valueOf(actionForm.getStatus()) + 1);
		setCurrentUser(Integer.valueOf(actionForm.getStatus()) + 1, user,
				actionForm);
		actionForm.setStatus(String.valueOf(status));
		actionForm.setVisaProductId(String.valueOf(visaOrder.getVisaProduct()
				.getId()));
		actionForm.setSerialnumber(visaOrder.getSerialnumber());

		/**
		 * copy 属性
		 */
		BeanUtils.copyProperties(visaOrder, actionForm);
		// 设置用户信息
		visaOrder.setUser(user);
		saveCustomer(request, actionForm, customer_userType, visaOrder);
		SetExpressMethod(request, visaOrder);
		SetQueryTypeMethod(request, visaOrder);

		/**
		 * 设置各种信息
		 */
		setAllUser(request, visaOrder);
		/***********************************************************************
		 * 签证结果设置
		 */
		SetVisaResult(request, visaOrder);
		/***********************************************************************
		 * 签证结果设置
		 */

		request.setAttribute("userList", userList);

		request.setAttribute("single", visaOrder.getSingle() == null ? ""
				: visaOrder.getSingle());
		request.setAttribute("sentToSignPeople", visaOrder
				.getSentToSignPeople() == null ? "" : visaOrder
				.getSentToSignPeople());
		request.setAttribute("operator", visaOrder.getOperator() == null ? ""
				: visaOrder.getOperator());
		request.setAttribute("status", Integer
				.valueOf(visaOrder.getStatus() == null ? "0" : visaOrder
						.getStatus()));
		request.setAttribute("visaProductId", visaOrder.getVisaProduct().getId());
		request.setAttribute("customerServiceSet", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getCustomerServicers());
		request.setAttribute("visaProductName", visaOrder.getVisaProduct().getName());
		return mapping.findForward("editUI");
	}

	private void setAllUser(HttpServletRequest request, VisaOrder visaOrder) {
		request.setAttribute("user1", visaOrder.getUser1());
		request.setAttribute("user2", visaOrder.getUser2());
		request.setAttribute("user3", visaOrder.getUser3());
		request.setAttribute("user4", visaOrder.getUser4());
		request.setAttribute("user5", visaOrder.getUser5());
		request.setAttribute("user6", visaOrder.getUser6());
		request.setAttribute("user7", visaOrder.getUser7());
		request.setAttribute("user8", visaOrder.getUser8());
		request.setAttribute("user9", visaOrder.getUser9());
		request.setAttribute("user10", visaOrder.getUser10());

	}

	private void setCurrentUser(Integer status, User user,
			VisaOrderActionForm visaOrder) {
		switch (status) {
		case 0:
			visaOrder.setUser1(user.getName());
			break;
		case 1:
			visaOrder.setUser2(user.getName());
			break;
		case 2:
			visaOrder.setUser3(user.getName());
			break;
		case 3:
			visaOrder.setUser4(user.getName());
			break;
		case 4:
			visaOrder.setUser5(user.getName());
			break;
		case 5:
			visaOrder.setUser6(user.getName());
			break;
		case 6:
			visaOrder.setUser7(user.getName());
			break;
		case 7:
			visaOrder.setUser8(user.getName());
			break;
		case 8:
			visaOrder.setUser9(user.getName());
			break;
		case 9:
			visaOrder.setUser10(user.getName());
			break;
		default:
			break;
		}

	}

	/** 修改页面 */
	public ActionForward savaBackUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession httpSession = (HttpSession) request.getSession();
		User user = (User) httpSession.getAttribute("user");
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		/**
		 * 获取用户类型 是同业用户还是直接用户 0 同业用户 1 直接用户
		 */
		String customer_userType = actionForm.getCustomer_userType();

		/**
		 * 从数据库中 得到visaorder信息
		 */
		VisaOrder visaOrder = visaOrderService.getById(Long.valueOf(request
				.getParameter("id").trim()));

		/**
		 * 加载客户信息 和客服信息
		 */

		List<User> userList = userService.findAll();

		/**
		 * 状态+1
		 */
		Long status = (Long.valueOf(actionForm.getStatus()) - 1);
		setCurrentUser(Integer.valueOf(actionForm.getStatus()), user,
				actionForm);
		actionForm.setStatus(String.valueOf(status));

		/**
		 * 设置关联关系
		 */

		actionForm.setVisaProductId(String.valueOf(visaOrder.getVisaProduct()
				.getId()));

		/**
		 * copy 属性
		 */
		BeanUtils.copyProperties(visaOrder, actionForm);
		visaOrder.setUser(user);
		saveCustomer(request, actionForm, customer_userType, visaOrder);
		SetExpressMethod(request, visaOrder);
		SetQueryTypeMethod(request, visaOrder);
		/**
		 * 设置各种信息
		 */
		setAllUser(request, visaOrder);

		/***********************************************************************
		 * 签证结果设置
		 */

		SetVisaResult(request, visaOrder);

		/***********************************************************************
		 * 签证结果设置
		 */

		request.setAttribute("userList", userList);
		request.setAttribute("single", visaOrder.getSingle() == null ? ""
				: visaOrder.getSingle());
		request.setAttribute("sentToSignPeople", visaOrder
				.getSentToSignPeople() == null ? "" : visaOrder
				.getSentToSignPeople());
		request.setAttribute("operator", visaOrder.getOperator() == null ? ""
				: visaOrder.getOperator());
		request.setAttribute("status", Integer
				.valueOf(visaOrder.getStatus() == null ? "0" : visaOrder
						.getStatus()));
		request.setAttribute("visaProductId", visaOrder.getVisaProduct().getId());
		request.setAttribute("customerServiceSet", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getCustomerServicers());
		request.setAttribute("visaProductName", visaOrder.getVisaProduct().getName());
		return mapping.findForward("editUI");
	}

	/** 该方法特殊处理,edit 和editUI代码重合度高，需要进行重构* */
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		/**
		 * 查询网站所有人员信息
		 */
		List<User> userList = userService.findAll();
		HttpSession httpSession = (HttpSession) request.getSession();
		User user = (User) httpSession.getAttribute("user");
		VisaOrderActionForm actionForm = (VisaOrderActionForm) form;
		String customer_userType = actionForm.getCustomer_userType();
		VisaOrder visaOrder = visaOrderService.getById(Long.valueOf(actionForm
				.getId()));
		// 防止号码被冲掉
		actionForm.setSerialnumber(visaOrder.getSerialnumber()==null?visaOrder.getVisaProduct().getLingqu().getPrefix()+"-"+ NumberFormatTools.formatNumber(String.valueOf(visaOrder.getId()),"0000000"):visaOrder.getSerialnumber());
		// 复制属性
		BeanUtils.copyProperties(visaOrder, actionForm);
		saveCustomer(request, actionForm, customer_userType, visaOrder);
		
		
		
		
		// 3, return
		SetExpressMethod(request, visaOrder);
		visaOrder.setUser(user);
		setCurrentUser(Integer.valueOf(actionForm.getStatus()), user,actionForm);
		setAllUser(request, visaOrder);
		SetQueryTypeMethod(request, visaOrder);
		// 设置回显必要的数据
		/**
		 * ======================== 签证结果
		 */

		SetVisaResult(request, visaOrder);

		/**
		 * ======================== 签证结果
		 */

		request.setAttribute("userList", userList);
		request.setAttribute("single", visaOrder.getSingle() == null ? ""
				: visaOrder.getSingle());
		request.setAttribute("sentToSignPeople", visaOrder
				.getSentToSignPeople() == null ? "" : visaOrder
				.getSentToSignPeople());
		request.setAttribute("operator", visaOrder.getOperator() == null ? ""
				: visaOrder.getOperator());
		request.setAttribute("status", Integer
				.valueOf(visaOrder.getStatus() == null ? "0" : visaOrder
						.getStatus()));
		request.setAttribute("visaProductId", visaOrder.getVisaProduct().getId());
		request.setAttribute("customerServiceSet", visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getCustomerServicers());
		request.setAttribute("visaProductName", visaOrder.getVisaProduct().getName());
		return mapping.findForward("editUI");
	}

	private void SetVisaResult(HttpServletRequest request, VisaOrder visaOrder) {
		Map<String, String> map = new HashMap<String, String>();
		Set<String> key = request.getParameterMap().keySet();
		for (Iterator it = key.iterator(); it.hasNext();) {
			String str = (String) it.next();
			if (StringUtils.isNotEmpty(str) && str.startsWith("visaResult[")) {
				map.put(str.substring(str.indexOf("[") + 1, str.indexOf("]")),
						request.getParameter(str));
			}
		}
		
		//签证状态为出签时，需要更新状态
		if(Integer.valueOf(visaOrder.getStatus())>=6)
		{
			customerService.saveVisaResult(visaOrder.getId(), map);
		}
		List<CusDat> cusDatList = customerService.findCusDatByorderId(visaOrder
				.getId());
		if (cusDatList != null && cusDatList.size() > 0
				&& cusDatList.get(0) != null) {

			Long[] cusDatId = new Long[cusDatList.size()];
			for (int i = 0; i < cusDatList.size(); i++) {

				cusDatId[i] = cusDatList.get(i).getCustomerId();
			}

		}

		request.setAttribute("cusDatList", cusDatList);
	}

	/** 修改 */
	public ActionForward uploadUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String id = request.getParameter("id");
		VisaOrder order=visaOrderService.getById(Long.valueOf(id));
		request.setAttribute("attchmentId", order.getVisaorder_attachment()==null?"":order.getVisaorder_attachment().getId());
		request.setAttribute("orderId", order.getId());
		return mapping.findForward("uploadUI");
	}

	private void saveCustomer(HttpServletRequest request,
			VisaOrderActionForm actionForm, String customer_userType,
			VisaOrder visaOrder) {
		if (StringUtils.isNotEmpty(actionForm.getCustomerId())) {
	
			VisaProduct visaProduct = visaProductService.getById(Long
					.valueOf(actionForm.getVisaProductId().trim()));
			visaOrder.setVisaProduct(visaProduct);
			visaOrder.setUser_type(Integer.valueOf(customer_userType.trim()));
			if (visaOrder.getUser_type()==0) {
				/**
				 * 如果是同行，那么就不会有直接用户的信息
				 */
				if(StringUtils.isNotEmpty(request.getParameter("customerServicerId").trim()))
				{
					CustomerServicersVo customerServicersVo=customerServicers.getById(Long.valueOf(request.getParameter("customerServicerId").trim()));
					visaOrder.setCustomerServicers(customerServicersVo);
				}
				Customer customer = customerService.getById(Long.valueOf(actionForm
						.getCustomerId().trim()));
				actionForm.setCustomerId(String.valueOf(customer.getId()));
				actionForm.setTradeUserForm(customer.getUserName());
				actionForm.setDirectUserForm(customer.getUserName());
				request.setAttribute("hidden_user_name", customer==null?"":customer.getUserName());
				request.setAttribute("customerServiceId", visaOrder.getCustomerServicers()==null?"":visaOrder.getCustomerServicers().getId());
				visaOrder.setCustomer(customer);
			} 
			else if(visaOrder.getUser_type()==1)
			{
				Member member = memberService.getById(Long.valueOf(actionForm
						.getCustomerId().trim()));
				visaOrder.setCustomerServicers(null);
				actionForm.setCustomerId(String.valueOf(member.getId()));
				actionForm.setTradeUserForm(member.getUserName());
				actionForm.setDirectUserForm(member.getUserName());
				request.setAttribute("hidden_user_name", member==null?"":member.getUserName());
				visaOrder.setMember(member);
			}
			request.setAttribute("customer_userType", visaOrder.getUser_type().toString());
			

		}
	}

	private void SetExpressMethod(HttpServletRequest request,
			VisaOrder visaOrder) {
		/**
		 * Assemble 签证结果选择器 1 通过 2 拒签
		 */
		List<ObjInfo> objList = new ArrayList<ObjInfo>();
		objList.add(new ObjInfo("1", "快递"));
		objList.add(new ObjInfo("2", "申请人领区"));
		request.setAttribute("passportMethodList", objList);
		request.setAttribute("passportReturnMethod", visaOrder
				.getPassportReturnMethod());
		
		//附件 
		request.setAttribute("attchment", visaOrder.getVisaorder_attachment()==null?"":visaOrder.getVisaorder_attachment());
	}

	private void SetQueryTypeMethod(HttpServletRequest request,
			VisaOrder visaOrder) {
		/**
		 * Assemble 查询 1按用户名 2 联系人
		 */
		List<ObjInfo> objList = new ArrayList<ObjInfo>();
		objList.add(new ObjInfo("1", "用户名"));
		objList.add(new ObjInfo("2", "联系人"));

	}

	public static String exportExcel(HttpServletRequest request,List<VisaOrder> orderList) {
		ExportUtils utils = new ExportUtils();
		utils.setTitle("订单报表");// 添加报表标题
		String[] title = { "订单编号", "订单状态", "客户姓名", "手机号码", "用户名称", "联系人",
				"联系方式", "签证产品名称", "录入员","接单员", "操作员", "送签员", "拒签原因", "问题分析", "处理结果","收入","支出","利润","订单人数" };
		utils.setHeader(title);
		List<String[]> list = new ArrayList<String[]>();
		for (VisaOrder visaOrder : orderList) {
			String statusValue = getstatuValue(Integer.valueOf(visaOrder
					.getStatus().trim()));
			String customerNames = "";
			String customerPhone = "";
			for (Customer customer : visaOrder.getCustomerSet()) {
				customerNames = customerNames  + customer.getName()+"\n";
			 	customerPhone = customerPhone   + customer.getPhone()+"\n";
			}

			String reason = "";
			String analysis = "";
			String results = "";
			for (CusDat cus : visaOrder.getCusDat()) {
				reason = cus.getReason();
				analysis = cus.getAnalysis();
				results = cus.getResults();
				break;
			}
			/**
			 * cusdat 表中拒签原因的字段都是一样的，只需要取出第一条记录的数据就可以
			 */
			
			list.add(new String[] { visaOrder.getSerialnumber(), statusValue,
					customerNames.length()==0?"":customerNames.substring(0, customerNames.length()-1), customerPhone.length()==0?"":customerPhone.substring(0, customerPhone.length()-1),
					visaOrder.getCustomer()==null?"":visaOrder.getCustomer().getName(),
					visaOrder.getCustomerServicers()==null?"":visaOrder.getCustomerServicers().getName(),
					visaOrder.getCustomerServicers()==null?"":visaOrder.getCustomerServicers().getPhone(),
					visaOrder.getName(), visaOrder.getRecorder(),visaOrder.getSingle(),
					visaOrder.getOperator(), visaOrder.getSentToSignPeople(),
					reason, analysis, results,"1000","1000","1000",visaOrder.getCustomerSet()==null?"0":visaOrder.getCustomerSet().size()+"" });
		}
		// 添加报表的查询字段名称
		// String[] fname={"开始时间","结束时间","操作用户"};
		// deh.setF_name(fname);//没有查询字段则直接赋值null
		// 添加报表的查询字段值
		// String[] fvalue={"2012-01-03","2012-01-11","admin","2013-05-06"};
		// deh.setF_value(fvalue);//没有查询字段则直接赋值null
		utils.setIsVerticalFreeze(true);// 是否对header进行冻结，让表头随着滚动条而滚动。默认：false
		String file = NumberFormatTools.getCurrentDay() + ".xls";
	    utils.write(list,  request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/")+Param.excelPath,file);// 第一个参数：数据集合；第二个参数：存储路径（我这里是本地路径），如果是在servlet中则是：request.getSession().getServletContext().getRealPath("/")+"项目中的文件夹名字/workOrder.xls";
		return  request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/") +Param.excelPath+file;
	}
	
	
	public static String exportExcel002(HttpServletRequest request,List<VisaOrder> orderList,String lingqu) {
		ExportUtils utils = new ExportUtils();
		utils.setTitle("预约面试提醒-"+lingqu);// 添加报表标题
		String[] title = { "订单编号", "订单状态", "客户姓名", "手机号码",  "洲际",
				"领区", "签证类型", "用户单位", "面试时间", "销售员", "送员送签", "送签备注"};
		utils.setHeader(title);
		List<String[]> list = new ArrayList<String[]>();
		for (VisaOrder visaOrder : orderList) {
			String statusValue = getstatuValue(Integer.valueOf(visaOrder
					.getStatus().trim()));
			String customerNames = "";
			String customerPhone = "";
			for (Customer customer : visaOrder.getCustomerSet()) {
				customerNames = customerNames  + customer.getName()+"\n";
			 	customerPhone = customerPhone   + customer.getPhone()+"\n";
			}
			list.add(new String[] { visaOrder.getSerialnumber(), statusValue,
					customerNames==""?"":customerNames.substring(0, customerNames.length()-1), customerPhone==""?"":customerPhone.substring(0, customerPhone.length()-1),
					visaOrder.getVisaProduct().getCountry().getName(),
					visaOrder.getVisaProduct().getLingqu().getName(),
					visaOrder.getVisaProduct().getType().getName(),
					visaOrder.getUser_type()==0?visaOrder.getCustomer().getName():visaOrder.getMember().getName(),
				  visaOrder.getScheduledtime(),"销售",visaOrder.getSentToSignPeople(),visaOrder.getOperator(),visaOrder.getRemarksReception() });
		}
		// 添加报表的查询字段名称
		// String[] fname={"开始时间","结束时间","操作用户"};
		// deh.setF_name(fname);//没有查询字段则直接赋值null
		// 添加报表的查询字段值
		// String[] fvalue={"2012-01-03","2012-01-11","admin","2013-05-06"};
		// deh.setF_value(fvalue);//没有查询字段则直接赋值null
		utils.setIsVerticalFreeze(true);// 是否对header进行冻结，让表头随着滚动条而滚动。默认：false
		String file =NumberFormatTools.getCurrentDay() + ".xls";
	    utils.write(list,  request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/") +Param.excelPath,file);// 第一个参数：数据集合；第二个参数：存储路径（我这里是本地路径），如果是在servlet中则是：request.getSession().getServletContext().getRealPath("/")+"项目中的文件夹名字/workOrder.xls";
		return  request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/") +Param.excelPath+file;
	}
	
	public static String exportExcel003(HttpServletRequest request,List<VisaOrder> orderList,String lingqu) {
		ExportUtils utils = new ExportUtils();
		utils.setTitle("出发时间提醒-"+lingqu);// 添加报表标题
		String[] title = { "订单编号", "订单状态", "客户姓名", "手机号码",  "洲际",
				"领区", "签证类型", "用户单位","出发时间", "面试时间", "销售员", "送员送签", "送签备注"};
		utils.setHeader(title);
		List<String[]> list = new ArrayList<String[]>();
		for (VisaOrder visaOrder : orderList) {
			String statusValue = getstatuValue(Integer.valueOf(visaOrder
					.getStatus().trim()));
			String customerNames = "";
			String customerPhone = "";
			for (Customer customer : visaOrder.getCustomerSet()) {
				customerNames = customerNames  + customer.getName()+"\n";
			 	customerPhone = customerPhone   + customer.getPhone()+"\n";
			}
			list.add(new String[] { visaOrder.getSerialnumber(), statusValue,
					customerNames.length()==0?"":customerNames.substring(0, customerNames.length()-1), customerPhone.length()==0?"":customerPhone.substring(0, customerPhone.length()-1),
					visaOrder.getVisaProduct().getCountry().getName(),
					visaOrder.getVisaProduct().getLingqu().getName(),
					visaOrder.getVisaProduct().getType().getName(),
					visaOrder.getUser_type()==0?visaOrder.getCustomer().getName():visaOrder.getMember().getName(),
				    visaOrder.getReceivedDataTime3(),
				    visaOrder.getScheduledtime(),"销售",visaOrder.getSentToSignPeople(),visaOrder.getOperator(),visaOrder.getRemarksReception() });
		}
		// 添加报表的查询字段名称
		// String[] fname={"开始时间","结束时间","操作用户"};
		// deh.setF_name(fname);//没有查询字段则直接赋值null
		// 添加报表的查询字段值
		// String[] fvalue={"2012-01-03","2012-01-11","admin","2013-05-06"};
		// deh.setF_value(fvalue);//没有查询字段则直接赋值null
		utils.setIsVerticalFreeze(true);// 是否对header进行冻结，让表头随着滚动条而滚动。默认：false
		String file = NumberFormatTools.getCurrentDay() + ".xls";
	    utils.write(list,  request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/") +Param.excelPath,file);// 第一个参数：数据集合；第二个参数：存储路径（我这里是本地路径），如果是在servlet中则是：request.getSession().getServletContext().getRealPath("/")+"项目中的文件夹名字/workOrder.xls";
		return  request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/")+Param.excelPath+file;
	}

	private static String getstatuValue(Integer status) {
		switch (status) {
		case 0:
			return "未审核";
		case 1:
			return "已预订";
		case 2:
			return "已收到材料";
		case 3:
			return "已审核材料";
		case 4:
			return "已预约";
		case 5:
			return "已面试/送签";
		case 6:
			return "已出签";
		case 7:
			return "已寄回";
		case 8:
			return "已完成";
		case 9:
			return "已付款";
		default:
			return null;
		}

	}

	
	/** 下载申请的文档 */
	public ActionForward download(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("orderId"));
		VisaOrder visaOrder = visaOrderService.getById(id);
		if(visaOrder.getVisaorder_attachment()!=null)
		{
		// 指定默认的文件名
		String name = visaOrder.getVisaorder_attachment().getName();
		if (request.getHeader("User-Agent").toLowerCase().indexOf("firefox") > 0) {
			name = new String(name.getBytes("UTF-8"), "ISO8859-1");
		}
		// IE
		else {
			name = URLEncoder.encode(name, "UTF-8");
		}

		FileInputStream in  = null;
		// 输出文件内容
		try {
			in= new FileInputStream(Param.upload_filepath+visaOrder.getVisaorder_attachment().getPath());
			/**
			 * 下载提示框
			 */
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\""
					+ name + "\"");
			/**
			 * 读取文件流
			 */
			IOUtils.copy(in, response.getOutputStream());
		} catch (Exception e) {
			throw new AppException("common.file");
		}
		finally {
			IOUtils.closeQuietly(in);
		}
		}
		return null;
	}
	
}