package cn.jtgoo.cms.web.struts.fenxiaoaction;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.CusDat;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.PeerGroup;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.enumvo.VisaOrderStatusEnum;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.CustomerActionForm;
public class PeerUserAction extends BaseAction {
	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String param=request.getParameter("param");
		String searchvalue=request.getParameter("searchvalue");
		String startTime=request.getParameter("startTime");
		if(StringUtils.isNotEmpty(searchvalue))
		{
			searchvalue="%"+searchvalue+"%";
		}
		HqlHelper hqlHelper = new HqlHelper(Customer.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
		hqlHelper.addWhereCondition("vo.userType=?", "2");
		hqlHelper.addWhereCondition("vo."+param+" like ?", searchvalue);
	     if(startTime!=null&&startTime.trim().length()>0)
			{
				hqlHelper.addBetween(" AND vo.regTime ",startTime, request.getParameter("endTime"));
			}
			
		PageBean	pageBean = customerService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		
		return mapping.findForward("list");
	}
	

	
	/**
	 * 0代表 同业用途 1 代表直接用户
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward deleteBatch(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ctype =request.getParameter("ctype");
		String ids = request.getParameter("ids");
		Long[] long_ids=NumberFormatTools.arrayconverToLongarray(ids.split(","));
		customerService.delete(long_ids);
		if(ctype.equals("0"))
		{
			return mapping.findForward("toPeerList");
		}
		else if(ctype.equals("1"))
		{
			
			return mapping.findForward("toDirectList");
			
		}
		return null;
	}
	
	
	
	/**同业用户申请处理
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward peerApply(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
				HqlHelper hqlHelper = new HqlHelper(Customer.class, "vo")
				.addWhereCondition("vo.userType=?", "0")
				.addWhereCondition("vo.status=?","2");
		// 2，查询分页信息
		PageBean pageBean = customerService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("peerApply");
	}
	
	
	/**
	 * 	 * 用户类型 0代表同业用户 1代表直接用户
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * 
	 * 0
	 */
   
	public ActionForward peerlist(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		User user = (User) request.getSession().getAttribute("user");
		CustomerActionForm customer = (CustomerActionForm) form;
				HqlHelper hqlHelper = new HqlHelper(Customer.class, "vo")
				.addWhereCondition("vo.userType=?", "0")
				.addWhereCondition("vo.status=?", customer.getStatus())
				.addWhereCondition("vo.peerGroup.name=?",  request.getParameter("peergroup"));
				if(!user.getLoginName().equals("admin"))
				{
					hqlHelper.addWhereCondition("vo.inputName=?",user.getName());
					//hqlHelper.addWhereCondition("vo.saler.id=?",user.getId());
				}
				
				
		// 2，查询分页信息
		PageBean pageBean = visaOrderService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		
		List<PeerGroup> peerGroupList=peerGroupService.findAll();
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("peerGroupList", peerGroupList);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("peerlist");
	}
	
	
	
	
	public ActionForward peerUserList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		User user = (User) request.getSession().getAttribute("user");
		CustomerActionForm customer = (CustomerActionForm) form;
				HqlHelper hqlHelper = new HqlHelper(Customer.class, "vo")
				.addWhereCondition("vo.userType=?", "0")
				.addWhereCondition("vo.status=?", customer.getStatus())
				.addWhereCondition("vo.peerGroup.name=?",  request.getParameter("peergroup"));
				if(!user.getLoginName().equals("admin"))
				{
					hqlHelper.addWhereCondition("vo.inputName=?",user.getName());
					//hqlHelper.addWhereCondition("vo.saler.id=?",user.getId());
				}
				
				
		// 2，查询分页信息
		PageBean pageBean = visaOrderService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		
		List<PeerGroup> peerGroupList=peerGroupService.findAll();
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("peerGroupList", peerGroupList);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("peerUserList");
	}
	public ActionForward peerlistV2(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		CustomerActionForm customer = (CustomerActionForm) form;
		HqlHelper hqlHelper = new HqlHelper(Customer.class, "vo");
		String type=request.getParameter("type");
		String startTime=request.getParameter("startTime");
		String key="";
		if(type!=null)
		{
		if(type.equals("1"))
		{
			key="userName";
		}
		else	if(type.equals("2"))
		{
			key="email";
		}
		else	if(type.equals("3"))
		{//公司名称
			key="companyName";
		}
		else	if(type.equals("4"))
		{//qq
			key="chatTools";
		}
		else	if(type.equals("5"))
		{//phone
			key="phone";
		}
		else	if(type.equals("6"))
		{//saler
			key="saler.name";
		}
		else	if(type.equals("7"))
		{//saler
			key="customerServiceNames";
		}
		}
			String obj =request.getParameter("obj");
			if(obj!=null&&obj.length()>0)
			{
				obj="%"+obj+"%";
			}
			String peerGroup=request.getParameter("peergroup");
			if(peerGroup!=null&&peerGroup.length()>0)
			{
				peerGroup="%"+peerGroup+"%";
			}
			hqlHelper.addWhereCondition("vo.userType=?", "0")
				.addWhereCondition("vo.status=?", customer.getStatus())
				.addWhereCondition("vo.peerGroup.name like ?",  request.getParameter("peergroup"))
				.addWhereCondition("vo."+key+" like ?",  obj);
		    	if(!user.getLoginName().equals("admin"))
				{
					
					hqlHelper.addWhereCondition("vo.inputName=?",user.getName());
					//hqlHelper.addWhereCondition("vo.saler.id=?",user.getId());
				}
				
		     if(startTime!=null&&startTime.trim().length()>0)
				{
					hqlHelper.addBetween(" AND vo.regTime ",startTime, request.getParameter("endTime"));
				}
				
		PageBean pageBean = visaOrderService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		
		List<PeerGroup> peerGroupList=peerGroupService.findAll();
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("peerGroupList", peerGroupList);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("peerlist");
	}
	
	/**
	 * 1
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward directlist(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String regTime=request.getParameter("regTime");
		String status=request.getParameter("status");
		String groupMember=request.getParameter("groupMember");
		String type=request.getParameter("type");
		String obj =request.getParameter("obj");
		if(obj!=null&&obj.length()>0)
		{
			obj="%"+obj+"%";
		}
		String key="";
		if(type!=null)
		{
		if(type.equals("1"))
		{
			key="phone";
			
		}
		else	if(type.equals("2"))
		{
			key="chatTools";
		}
		else	if(type.equals("3"))
		{
			key="email";
		}
		else	if(type.equals("4"))
		{
			key="userName";
		}
		else	if(type.equals("5"))
		{
			key="name";
		}
		else	if(type.equals("6"))
		{//saler
			key="saler.name";
		}
		}
		
		HqlHelper hqlHelper = new HqlHelper(Customer.class, "vo");
		if(StringUtils.isNotEmpty(groupMember))
		{   
			hqlHelper.addWhereParent(" vo.peerGroup IS NOT NULL ");
			hqlHelper.addWhereCondition("vo.userType=?", "1")
//			.addWhereCondition("vo.regTime=?", regTime)
			.addWhereCondition("vo.status=?", status).addWhereCondition("vo.peerGroup.name=?", groupMember)
			.addWhereCondition("vo."+key+" like ?",  obj);
		}
		else
		{
		hqlHelper.addWhereCondition("vo.userType=?", "1")
//		.addWhereCondition("vo.regTime=?", regTime)
		.addWhereCondition("vo.status=?", status)
		.addWhereCondition("vo."+key+" like ?",  obj);
		}
	
	    if(regTime!=null&&regTime.trim().length()>0)
		{
			hqlHelper.addBetween(" AND vo.regTime ",regTime, request.getParameter("endTime"));
		}
			// 2，查询分页信息
			PageBean pageBean = visaOrderService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
			request.setAttribute("pageBean", pageBean);
			request.setAttribute("endTime",  NumberFormatTools.getCurrentDay());
			return mapping.findForward("directlist");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		customerService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<User> salerList=userService.findAll();
		request.setAttribute("salerList", salerList);
		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("inputName", user.getName());
		Map<String, String> occuMap=new LinkedHashMap<String, String>();
		occuMap.put("1", "在职人员");
		occuMap.put("2", "退休人员");
		occuMap.put("3", "学生及未成年");
		occuMap.put("4","自由职业");
		occuMap.put("5", "不分职业");
		request.setAttribute("occuMap", occuMap);
		
		return mapping.findForward("saveUI");
	}
	


	/** 修改 */
	public ActionForward customerUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String visaProductId=request.getParameter("visaProductId");
		String visaorderId=request.getParameter("visaorderId");
		List<CusDat> cusDatList=visaDataTypeDetailService.findListByVisaPid(Long.valueOf(visaProductId),Long.valueOf(visaorderId));
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("visaorderId", visaorderId);
		return mapping.findForward("customerUI");
	}
	
	public ActionForward refusedVisaResultUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		CusDat cusDat=visaDataTypeDetailService.findCusDatByid(id);
		request.setAttribute("reason", cusDat.getReason());
		request.setAttribute("analysis", cusDat.getAnalysis());
		request.setAttribute("results", cusDat.getResults());
		request.setAttribute("id", id);
		return mapping.findForward("refusedVisaResultUI");
	}
	
	

	
	/** 添加页面 */
	public ActionForward addPeerUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Lingqu> lingquList=visaLingquService.findAll();
		request.setAttribute("lingquList", lingquList);
		List<PeerGroup> peerGroupList=peerGroupService.findAll();
		request.setAttribute("peerGroupList", peerGroupList);
		List<User> salerList=userService.findAll();
		request.setAttribute("salerList", salerList);
		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("inputName", user.getName());
		
		/**
		 * 设置当前时间
		 */
		request.setAttribute("regTime", NumberFormatTools.getCurrentTime());
		
		return mapping.findForward("PeerSaveUI");
	}
	
	/** 添加页面 */
	public ActionForward addDirectUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Lingqu> lingquList=visaLingquService.findAll();
		request.setAttribute("lingquList", lingquList);
		List<PeerGroup> peerGroupList=peerGroupService.findAll();
		request.setAttribute("peerGroupList", peerGroupList);
		List<User> salerList=userService.findAll();
		request.setAttribute("salerList", salerList);
		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("inputName", user.getName());
	
		request.setAttribute("occuMap", Param.getOccuType());
		return mapping.findForward("DirectSaveUI");
	}
	
	
	
	
	

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = new Customer();
		// a，拷贝同名属性
		BeanUtils.copyProperties(customer, actionForm);
		/**
		 * default 0
		 */
		customer.setUserType("2");
		customer.setStatus("0");
		
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
		User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
		customer.setSaler(saler);
		}
		
		customerService.save(customer);
		// 3, return
		return mapping.findForward("toList");
	}
	/** 添加 */
	public ActionForward addPeer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = new Customer();
		// a，拷贝同名属性
		BeanUtils.copyProperties(customer, actionForm);
		customer.setUserType("0");
		customer.setStatus("0");
		customer.setRemoteIp(request.getRemoteAddr());
		customer.setUpdateTime(NumberFormatTools.getCurrentTime());
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
		User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
		customer.setSaler(saler);
		}
		
		customerService.save(customer);
		// 3, return
		return mapping.findForward("toPeerList");
	}
	/** 添加 */
	public ActionForward addDirect(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = new Customer();
		// a，拷贝同名属性
		BeanUtils.copyProperties(customer, actionForm);
		customer.setUserType("1");
		customer.setRemoteIp(request.getRemoteAddr());
		customer.setUpdateTime(NumberFormatTools.getCurrentTime());
		customer.setStatus("0");
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
		User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
		customer.setSaler(saler);
		}
		
		customerService.save(customer);
		// 3, return
		return mapping.findForward("toDirectList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		// 3，ActionForm
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = customerService.getById(actionForm.getId());
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, customer);
		request.setAttribute("schoolName", actionForm.getSchoolName());
		request.setAttribute("schoolAddr", actionForm.getSchoolAddr());
		request.setAttribute("professional", actionForm.getProfessional());
		request.setAttribute("passwd", actionForm.getPasswd());
		request.setAttribute("confirmPasswd", actionForm.getConfirmPasswd());
		request.setAttribute("companyName", actionForm.getCompanyName());
		request.setAttribute("companyAddr", actionForm.getCompanyAddr());
		request.setAttribute("companyPhone", actionForm.getCompanyPhone());
		request.setAttribute("position", actionForm.getPosition());
		request.setAttribute("description", actionForm.getDescription());
		List<User> salerList=userService.findAll();
		request.setAttribute("salerList", salerList);
		request.setAttribute("occuMap", Param.getOccuType());
		request.setAttribute("occuId", actionForm.getOccupation());
		request.setAttribute("salerId", customer.getSaler()==null ?"":customer.getSaler().getId());
		request.setAttribute("inputName", customer.getInputName()==null ?user.getName():customer.getInputName());
		return mapping.findForward("editUI");
	}
	/** 修改页面 */
	public ActionForward editPeerUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		User user = (User) request.getSession().getAttribute("user");
		
		List<Lingqu> lingquList=visaLingquService.findAll();
		request.setAttribute("lingquList", lingquList);
		List<PeerGroup> peerGroupList=peerGroupService.findAll();
		request.setAttribute("peerGroupList", peerGroupList);

		List<User> salerList=userService.findAll();
		request.setAttribute("salerList", salerList);
		// 3，ActionForm
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = customerService.getById(actionForm.getId());
		
		
		Long[] customerIds = new Long[customer.getLingquSet().size()];
		int i = 0;
		for (Lingqu r : customer.getLingquSet()) {
			customerIds[i++] = r.getId();
		}
		actionForm.setCustomerIds(customerIds);
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, customer);
		request.setAttribute("peergroupId", customer.getPeerGroup()==null ?"":customer.getPeerGroup().getId());
		request.setAttribute("salerId", customer.getSaler()==null ?"":customer.getSaler().getId());
		request.setAttribute("inputName", customer.getInputName()==null ?user.getName():customer.getInputName());
		request.setAttribute("customerServicersList", customer.getCustomerServicers());
		request.setAttribute("linkManList", customer.getLinkMans());
		return mapping.findForward("editPeerUI");
	}
	/** 修改页面 */
	public ActionForward editDirectUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		List<User> salerList=userService.findAll();
		request.setAttribute("salerList", salerList);
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = customerService.getById(actionForm.getId());
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, customer);
		request.setAttribute("schoolName", actionForm.getSchoolName());
		request.setAttribute("schoolAddr", actionForm.getSchoolAddr());
		request.setAttribute("professional", actionForm.getProfessional());
		request.setAttribute("passwd", actionForm.getPasswd());
		request.setAttribute("confirmPasswd", actionForm.getConfirmPasswd());
		request.setAttribute("companyName", actionForm.getCompanyName());
		request.setAttribute("companyAddr", actionForm.getCompanyAddr());
		request.setAttribute("companyPhone", actionForm.getCompanyPhone());
		request.setAttribute("position", actionForm.getPosition());
		request.setAttribute("description", actionForm.getDescription());
		request.setAttribute("occuMap", Param.getOccuType());
		request.setAttribute("occuId", actionForm.getOccupation());
		request.setAttribute("salerId", customer.getSaler()==null ?"":customer.getSaler().getId());
		request.setAttribute("inputName", customer.getInputName()==null ?user.getName():customer.getInputName());
		return mapping.findForward("editDirectUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		User user=(User) request.getSession().getAttribute("user");
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = customerService.getById(actionForm.getId());
		// a，拷贝同名属性
		String status=customer.getStatus();
		actionForm.setStatus(status);
		BeanUtils.copyProperties(customer, actionForm);
		customer.setRemoteIp(request.getRemoteAddr());
		customer.setUpdateTime(NumberFormatTools.getCurrentTime());
		customer.setOccupation(request.getParameter("occupationChoice"));
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
		User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
		customer.setSaler(saler);
		}
		customerService.update(customer);
		// 3, return
		return mapping.findForward("toList");
	}
	/**保存并继续  重构*/
	public ActionForward savePeerAndGoOn(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer =null;
		if(actionForm.getId()>0)
		{
			 customer = customerService.getById(actionForm.getId());
		}
		else
		{
			customer=new Customer();
		}
		// a，拷贝同名属性
		BeanUtils.copyProperties(customer, actionForm);
		customer.setUserType("0");
		customer.setStatus("0");
		customer.setRemoteIp(request.getRemoteAddr());
		customer.setUpdateTime(NumberFormatTools.getCurrentTime());
		List<Lingqu> lingquList = visaLingquService.getByIds(actionForm.getCustomerIds());
		customer.setLingquSet(new HashSet<Lingqu>(lingquList));
		PeerGroup peerGroup=peerGroupService.getById(Long.valueOf(actionForm.getPeergroupId()));
		customer.setPeerGroup(peerGroup);
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
			User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
			customer.setSaler(saler);
		}
		
		if(actionForm.getId()>0)
		{
			
			customerService.updatePeer(customer);
			
			
		}
		else
		{
			customerService.save(customer);
			actionForm.setId(customer.getId());
		}
		/**
		 * 如果是新建form中就没有id需要set
		 */

		
		/**
		 * 回显页面属性
		 */
		List<PeerGroup> peerGroupList=peerGroupService.findAll();
		request.setAttribute("peerGroupList", peerGroupList);
		List<User> salerList=userService.findAll();
		request.setAttribute("salerList", salerList);
		
		Long[] customerIds = new Long[customer.getLingquSet().size()];
		int i = 0;
		for (Lingqu r : customer.getLingquSet()) {
			customerIds[i++] = r.getId();
		}
		actionForm.setCustomerIds(customerIds);
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, customer);
		request.setAttribute("peergroupId", customer.getPeerGroup()==null ?"":customer.getPeerGroup().getId());
		request.setAttribute("salerId", customer.getSaler()==null ?"":customer.getSaler().getId());
		request.setAttribute("customerServicersList", customer.getCustomerServicers());
		request.setAttribute("id", customer.getId());
		// 3, return
		return mapping.findForward("editPeerUI");
	}
	/** 修改 */
	public ActionForward editPeer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = customerService.getById(actionForm.getId());
		// a，拷贝同名属性
		BeanUtils.copyProperties(customer, actionForm);
		customer.setRemoteIp(request.getRemoteAddr());
		customer.setUpdateTime(NumberFormatTools.getCurrentTime());
		// 2, service.update()
		
		List<Lingqu> lingquList = visaLingquService.getByIds(actionForm.getCustomerIds());
		customer.setLingquSet(new HashSet<Lingqu>(lingquList));
		PeerGroup peerGroup=peerGroupService.getById(Long.valueOf(actionForm.getPeergroupId()));
		customer.setPeerGroup(peerGroup);
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
		User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
		customer.setSaler(saler);
		}
		
//		customerService.updatePeer(customer);
		
		// 3, return
		return mapping.findForward("toPeerList");
	}
	/** 修改 */
	public ActionForward editDirect(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		CustomerActionForm actionForm = (CustomerActionForm) form;
		Customer customer = customerService.getById(actionForm.getId());
		
		// a，拷贝同名属性
		String status=customer.getStatus();
		actionForm.setStatus(status);
		BeanUtils.copyProperties(customer, actionForm);
		customer.setRemoteIp(request.getRemoteAddr());
		customer.setUpdateTime(NumberFormatTools.getCurrentTime());
		customer.setOccupation(request.getParameter("occupationChoice"));
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
		User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
		customer.setSaler(saler);
		}
		// 2, service.update()
		customerService.update(customer);
		
		// 3, return
		return mapping.findForward("toDirectList");
	}
	
	
	
	/** 检测登录名是否可用（true表示可用，false表示不可用） */
	public ActionForward checkLoginName(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String name = request.getParameter("name");
		String mobliePhone = request.getParameter("mobliePhone");
		List<Customer> customerList = customerService.getByName(name,mobliePhone);
		String result = (customerList == null||customerList.size()==0) ? "false" : "true";
		response.getWriter().write(result);
		return null;
	}
	

	/** 登录页面 */
	public ActionForward loginUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("loginUI");
	}
	
	
	/** 分销系统订单查询 */
	public ActionForward peerRegisterUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("peerRegisterUI");
	}

	/** 登录 */
	public ActionForward login(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String userName = request.getParameter("userName");
		String password = request.getParameter("passwd");
		String randCode = request.getParameter("randCode");
		String serverCode = (String) request.getSession().getAttribute("rand");
		// 1.服务器端验证码有误 或 客户端验证码有误 或 两者都不相等
		if (StringUtils.isEmpty(serverCode) || StringUtils.isEmpty(randCode)
				|| !serverCode.equals(randCode)) {
			request.setAttribute("error", "请输入正确的验证码");
//		  	request.getRequestDispatcher("/loginUI.jsp").forward(request, response);
		  	return mapping.findForward("loginUI");
		}
		/**
		 * 用户个人信息
		 */
		Customer customer = customerService.getByLoginNameAndPassword(userName, password);
		if (customer == null) { // 登录失败
			ActionErrors errors = new ActionErrors();
			request.setAttribute("error", "用户名或密码不正确");
//			errors.add("login", new ActionMessage("用户名或密码不正确！", false));
			saveErrors(request, errors);
			return mapping.findForward("loginUI");
		} else {
			// 登录成功
			/**
			 * 7种状态
			 */
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
			request.getSession().setAttribute("customer", customer);
			
			List<Lingqu> lingquList=new ArrayList<Lingqu>();
			lingquList.addAll(customer.getLingquSet());
			request.getSession().setAttribute("user_lingquList", lingquList);
			
			request.getSession().setAttribute("nocheck", nocheck);
			request.getSession().setAttribute("process", process);
			request.getSession().setAttribute("finished", finished);
			request.getSession().setAttribute("showTree", "model");
			// 取出用户所有的权限，并放到session作用域中
			return mapping.findForward("index");
		}
	}
	/**
	 * 添加同业用户信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward addRegisterInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		CustomerActionForm actionForm = (CustomerActionForm) form;
		//同业客户
		Customer peer=new Customer();
		BeanUtils.copyProperties(peer, actionForm);
		peer.setUserType("0");
		peer.setRemoteIp(request.getRemoteAddr());
		peer.setUpdateTime(NumberFormatTools.getCurrentTime());
		/**
		 * 申请中
		 */
		peer.setStatus("2");
		customerService.save(peer);
		return mapping.findForward("addRegisterInfo");
	}


	/** 注销 */
	public ActionForward logout(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession().removeAttribute("customer");
		return mapping.findForward("logout");
	}
	/***
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward account_manage(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Customer customer = (Customer) request.getSession().getAttribute("customer");
		if(customer!=null)
		{
			customer=customerService.getById(customer.getId());
		}
		request.setAttribute("customer", customer);
		return mapping.findForward("account_manage");
	}
	/**
	 * 更新相应信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward account_manage_update(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		CustomerActionForm actionForm = (CustomerActionForm) form;
		//同业客户
		
		Customer customer = (Customer) request.getSession().getAttribute("customer");
		if(customer!=null)
		{
			customer=customerService.getById(customer.getId());
		}
		customer.setMobliePhone(actionForm.getMobliePhone());
		customer.setEmail(actionForm.getEmail());
		customer.setChatTools(actionForm.getChatTools());
		customer.setCompanyName(actionForm.getCompanyName());
		customer.setPosition(actionForm.getPosition());
		customer.setCompanyAddr(actionForm.getCompanyAddr());
		customer.setCompanyPhone(actionForm.getCompanyPhone());
		customer.setBusiness_content(actionForm.getBusiness_content());
		customerService.saveorupdate(customer);
		request.setAttribute("customer", customer);
		return mapping.findForward("account_manage");
	}
	public ActionForward account_manage_password(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("account_manage_password");
	}						
	public ActionForward account_manage_password_update(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		CustomerActionForm actionForm = (CustomerActionForm) form;
		//同业客户
		Customer customer = (Customer) request.getSession().getAttribute("customer");
		if(customer!=null)
		{
			customer=customerService.getById(customer.getId());
		}
		if(customer.getPasswd().equals(actionForm.getPasswd()))
		{
		customerService.saveorupdate(customer);
		}
		else
		{
			ActionErrors errors = new ActionErrors();
			errors.add("validate", new ActionMessage("密码不正确！", false));
			saveErrors(request, errors);
		}
		return mapping.findForward("account_manage_password_update");
	}
}