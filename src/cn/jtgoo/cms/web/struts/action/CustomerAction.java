package cn.jtgoo.cms.web.struts.action;

import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.json.JSONObject;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.CusDat;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.domain.CustomerToVisaProduct;
import cn.jtgoo.cms.domain.DataTypeDetail;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.PeerGroup;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.enumvo.CustomerTypeEnum;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.CustomerOcc;
import cn.jtgoo.cms.util.ExportUtils;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.CustomerActionForm;

public class CustomerAction extends BaseAction {


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
		hqlHelper.addWhereCondition("vo.userType=?",String.valueOf(CustomerTypeEnum.MEMBER_USER_TYPE.ordinal()));
		hqlHelper.addWhereCondition("vo."+param+" like ?", searchvalue==null?"":searchvalue.trim());
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
	
	/** 列表 */
	public ActionForward getAllCustomerName(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/json; charset=utf-8");
		String visaorderId=request.getParameter("visaorderId");
		PrintWriter out = response.getWriter();
		StringBuffer buffer=new StringBuffer();
		List<CusDat> cusDatList = visaDataTypeDetailService.findListByOrderId(Long.valueOf(visaorderId));
		cusDatList=removeDuplicateWithOrder(cusDatList);
		buffer.append("{\"Items\":[");
		for (CusDat cusDat : cusDatList) {
			buffer.append("{ \"name\": \"" + cusDat.getCustomerName());
			buffer.append("\", \"visaorderId\": \"" +visaorderId);
			buffer.append("\", \"visaProductId\": \"" +cusDat.getVisaProductId());
			buffer.append("\", \"customerId\": \"" + cusDat.getCustomerId()+"\"},");
		}
		buffer.delete(buffer.length() - 1, buffer.length());
		buffer.append("]}");		
		out.print(buffer);
		 out.flush();
         out.close();
		return null;
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
				.addWhereCondition("vo.userType=?",String.valueOf(CustomerTypeEnum.PEER_USER_TYPE.ordinal()))
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
//		CustomerActionForm customer = (CustomerActionForm) form;
				HqlHelper hqlHelper = new HqlHelper(Customer.class, "vo")
				.addWhereCondition("vo.userType=?", String.valueOf(CustomerTypeEnum.PEER_USER_TYPE.ordinal()))
				.addWhereCondition("vo.del_status=?", String.valueOf(Delstatus.ACTIVE.ordinal()))
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
//		CustomerActionForm customer = (CustomerActionForm) form;
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
	   hqlHelper.addWhereCondition("vo.userType=?", String.valueOf(CustomerTypeEnum.PEER_USER_TYPE.ordinal()))
				.addWhereCondition("vo.del_status=?", String.valueOf(Delstatus.ACTIVE.ordinal()))
//				.addWhereCondition("vo.status=?", "1")
				.addWhereCondition("vo.peerGroup.name=?",  request.getParameter("peergroup"))
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
				
		     System.out.println(hqlHelper);
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
		request.setAttribute("occuMap", CustomerOcc.getOccInfo());
		
		return mapping.findForward("saveUI");
	}
	
	public ActionForward updateVisaResultUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String visaorderId=request.getParameter("visaorderId");
		List<CusDat> cusDatList=visaDataTypeDetailService.findListByOrderId(Long.valueOf(visaorderId));
		cusDatList=removeDuplicateWithOrder(cusDatList);
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("visaorderId", visaorderId);
		return mapping.findForward("updateVisaResultUI");
	}
	public ActionForward saveVisaResult(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 Map<String,String> map=new HashMap<String, String>();
		  Set<String> key = request.getParameterMap().keySet();
	        for (Iterator it = key.iterator(); it.hasNext();) {
	            String str = (String) it.next();
	            if(StringUtils.isNotEmpty(str)&&str.startsWith("visaResult["))
	            {
	            	map.put(str.substring(str.indexOf("[")+1, str.indexOf("]")), request.getParameter(str));
	            }
	        }
		
		Long visaorderId=Long.parseLong(request.getParameter("visaorderId").trim());
//		customerService.saveVisaResult(visaorderId, map);
		List<CusDat> cusDatList=visaDataTypeDetailService.findListByOrderId(Long.valueOf(visaorderId));
		cusDatList=removeDuplicateWithOrder(cusDatList);
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("visaorderId", visaorderId);
		return mapping.findForward("updateVisaResultUI");
	}
	
	/** 修改 */
	public ActionForward customerUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String visaProductId=request.getParameter("visaProductId");
		String visaorderId=request.getParameter("visaorderId");
		List<CusDat> cusDatList=visaDataTypeDetailService.findListByVisaPid(Long.valueOf(visaProductId),Long.valueOf(visaorderId));
		request.setAttribute("cusDatList", cusDatList);
		Map<String, CusDat> cus_map=new HashMap<String, CusDat>();
		for(CusDat cusDat:cusDatList)
		{
			System.out.println(cusDat.getCustomerName());
			cus_map.put(cusDat.getCustomerName(), cusDat);
		}
		request.setAttribute("cus_map", cus_map);
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
	/**
	 * ajax 请求
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward refusedVisaResult(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		String id=request.getParameter("id");
		CusDat cusDat=visaDataTypeDetailService.findCusDatByid(id);
		String reason = new String(request.getParameter("reason").getBytes("iso-8859-1"),"UTF-8");
		String analysis = new String(request.getParameter("analysis").getBytes("iso-8859-1"),"UTF-8");
		String results = new String(request.getParameter("results").getBytes("iso-8859-1"),"UTF-8");
		cusDat.setReason(reason);
		cusDat.setAnalysis(analysis);
		cusDat.setResults(results);
		visaDataTypeDetailService.updateCusDat(cusDat);
		 JSONObject object=new JSONObject();
		 object.put("id", id);
		 object.put("reason", reason);
		 object.put("analysis", analysis);
		 object.put("results", results);
		 out.print(object);
		 out.flush();
         out.close();
		return null;
		
	}
	/** 修改 */
	public ActionForward removeCustomerRelation(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		customerService.removeCustomerRelation(Long.valueOf(id));
		String visaProductId=request.getParameter("visaProductId");
		String visaorderId=request.getParameter("visaorderId");
		List<CusDat> cusDatList=visaDataTypeDetailService.findListByVisaPid(Long.valueOf(visaProductId),Long.valueOf(visaorderId));
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("visaorderId", visaorderId);
		return mapping.findForward("customerUI");
	}
	/** 修改 */
	public ActionForward editCustomerRelationUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String visaProductId=request.getParameter("visaProductId");
		
		VisaProduct visaProduct=visaProductService.getById(Long.valueOf(visaProductId.trim()));
		System.out.println(visaProduct.getDataTypeDetailSet());
		String visaorderId=request.getParameter("visaorderId");
		String customerId=request.getParameter("customerId");
		Customer customer=customerService.getById(Long.valueOf(customerId));
		String id=request.getParameter("id");
		String type=request.getParameter("type");
		List<CusDat> dataTypeDetailList=visaDataTypeDetailService.getListByvisaOrderId(Long.valueOf(id.trim()),type);
		request.setAttribute("dataTypeDetailList", dataTypeDetailList);
		request.setAttribute("visaProductId", visaProductId);
		request.setAttribute("visaorderId", visaorderId);
		if(customerId!=null&&customerId.length()>0)
		{
		request.setAttribute("customerId", Integer.valueOf(customerId));
		request.setAttribute("customerName", customer.getName());
		}
		else
		{
			request.setAttribute("customerId", -1);
			request.setAttribute("customerName", "");
		}
		request.setAttribute("type", type);
		Map<String, CusDat> cus_map=new HashMap<String, CusDat>();
		for(CusDat cusDat:dataTypeDetailList)
		{
			cus_map.put(cusDat.getCustomerName(), cusDat);
		}
		request.setAttribute("cus_map", cus_map);
		request.setAttribute("occuMap", CustomerOcc.getOccInfo());
		return mapping.findForward("editCustomerRelationUI");
	}
	/** 修改 */
	public ActionForward addCustomerUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String visaProductId=request.getParameter("visaProductId");
		String visaorderId=request.getParameter("visaorderId");
		System.out.println(visaProductId);
		List<DataTypeDetail> dataTypeDetailList=visaDataTypeDetailService.getListByPId(Long.valueOf(visaProductId.trim()),"1");

		if(dataTypeDetailList!=null&&dataTypeDetailList.size()>0)
		{
			request.setAttribute("title", dataTypeDetailList.get(0).getTitle());
		}
		else
		{
			request.setAttribute("title", "");
		}
		request.setAttribute("visaProductId", visaProductId);
		request.setAttribute("visaorderId", visaorderId);
		request.setAttribute("dataTypeDetailList", dataTypeDetailList);
		request.setAttribute("customerId", -1);
		request.setAttribute("occuMap", CustomerOcc.getOccInfo());
		return mapping.findForward("addCustomerUI");
	}
	/** 修改 */
	public ActionForward addCustomer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String type=request.getParameter("type");
		String[] dataTypeDetailId=request.getParameterValues("dataTypeDetailId");
		String[] dataTypeDetail_original=request.getParameterValues("dataTypeDetail[original]");
		String[] dataTypeDetail_copy=request.getParameterValues("dataTypeDetail[copy]");
		String[] dataTypeDetail_remarks=request.getParameterValues("dataTypeDetail[remarks]");
		String[] dataTypeDetail_title=request.getParameterValues("dataTypeDetailTitle");
		Long visaProductId=Long.parseLong(request.getParameter("visaProductId").trim());
		Long customerId=Long.parseLong(request.getParameter("customerId").trim());
		String customerName=request.getParameter("customerName").trim();
		Long visaOrderId=Long.parseLong(request.getParameter("visaorderId").trim());
		/**
		 * 特殊处理
		 * 将一对一的关系当作一对一处理
		 *去值时只需要去第一个记录就可以
		 */
		List<CusDat> dtdList=new ArrayList<CusDat>();
		if(dataTypeDetailId!=null&&dataTypeDetailId.length>0)
		{
			for(int i=0;i<dataTypeDetailId.length;i++)
			{
				CusDat cus=new CusDat();
				cus.setDatatypeDetailId(Long.valueOf(dataTypeDetailId[i]));
				cus.setOriginal(dataTypeDetail_original[i]);
				cus.setCopy(dataTypeDetail_copy[i]);
				cus.setRemarks(dataTypeDetail_remarks[i]);
				cus.setDatatypedetailTitle(dataTypeDetail_title[i]);
				cus.setType(type);
				dtdList.add(cus);
			}
		}
		customerService.saveCustomertoDatatype(visaProductId,customerId,dtdList,visaOrderId,customerName);
		List<CusDat> cusDatList=visaDataTypeDetailService.findListByVisaPid(Long.valueOf(visaProductId),visaOrderId);
		Map<String, CusDat> cus_map=new HashMap<String, CusDat>();
		for(CusDat cusDat:cusDatList)
		{
			System.out.println(cusDat.getCustomerName());
			cus_map.put(cusDat.getCustomerName(), cusDat);
		}
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("cus_map", cus_map);
		request.setAttribute("visaorderId", visaOrderId);;
		return mapping.findForward("customerUI");
	}
	/** 修改 */
	public ActionForward showCustomerNameDetailUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long visaProductId=Long.parseLong(request.getParameter("visaProductId").trim());
		Long customerId=Long.parseLong(request.getParameter("customerId").trim());
		VisaProduct visaProduct=visaProductService.getById(visaProductId);
		Customer customer=customerService.getById(customerId);
		List<CusDat> cusDatList=visaDataTypeDetailService.findCusByPidAndCid(Long.valueOf(visaProductId),customerId);
		Set<String> set = new HashSet<String>();
		for (CusDat cus : cusDatList) {
			set.add(cus.getDatatypeName());
		}
		request.setAttribute("cusDatList", cusDatList);
		request.setAttribute("visaProduct", visaProduct);
		request.setAttribute("customer", customer);
		request.setAttribute("set", set);
		return mapping.findForward("showNameDetailInfo");
		
	}
	public ActionForward showCustomerIdDetailUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long customerId=Long.parseLong(request.getParameter("customerId").trim());
		Customer customer=customerService.getById(customerId);
		CustomerActionForm actionForm = (CustomerActionForm) form;
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, customer);
		request.setAttribute("customer", customer);
		return mapping.findForward("showIdDetailInfo");
	}
	public ActionForward showCustomerCompanyInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long customerId=Long.parseLong(request.getParameter("customerId").trim());
		Customer customer=customerService.getById(customerId);
		CustomerActionForm actionForm = (CustomerActionForm) form;
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, customer);
		request.setAttribute("customer", customer);
		return mapping.findForward("showCustomerCompanyInfo");
	}
	public ActionForward showCustomerInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long customerId=Long.parseLong(request.getParameter("customerId").trim());
		Customer customer=customerService.getById(customerId);
		CustomerActionForm actionForm = (CustomerActionForm) form;
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, customer);
		request.setAttribute("customer", customer);
		return mapping.findForward("showCustomerInfo");
	}
	
	
	
	
	/** 修改 */
	public ActionForward editCustomer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String type=request.getParameter("type");
		String[] dataTypeDetailId=request.getParameterValues("dataTypeDetailId");
		String[] dataTypeDetail_original=request.getParameterValues("dataTypeDetail[original]");
		String[] dataTypeDetail_copy=request.getParameterValues("dataTypeDetail[copy]");
		String[] dataTypeDetail_remarks=request.getParameterValues("dataTypeDetail[remarks]");
		String[] dataTypeDetail_title=request.getParameterValues("dataTypeDetailTitle");
		Long customerId=Long.parseLong(request.getParameter("customerId").trim());
		Long id=Long.parseLong(request.getParameter("id").trim());
		Long visaorderId=Long.parseLong(request.getParameter("visaorderId").trim());
		Long visaProductId=Long.parseLong(request.getParameter("visaProductId").trim());
		/**
		 * 特殊处理
		 * 将一对一的关系当作一对一处理
		 *取值时只需要去第一个记录就可以
		 */
	
		
			List<CusDat> dtdList=new ArrayList<CusDat>();
		    if(dataTypeDetailId!=null&&dataTypeDetailId.length>0)
		    {
		    	for(int i=0;i<dataTypeDetailId.length;i++)
		    	{
		    		CusDat dataTypeDetail=new CusDat();
		    		dataTypeDetail.setDatatypeDetailId(Long.valueOf(dataTypeDetailId[i]));
		    		dataTypeDetail.setOriginal(dataTypeDetail_original[i]);
		    		dataTypeDetail.setCopy(dataTypeDetail_copy[i]);
		    		dataTypeDetail.setRemarks(dataTypeDetail_remarks[i]);
		    		dataTypeDetail.setDatatypedetailTitle(dataTypeDetail_title[i]);
		    		dataTypeDetail.setType(type);
		    		dtdList.add(dataTypeDetail);
		    	}
		    }
		    customerService.updateCustomertoDatatype(visaProductId,customerId,dtdList,id);
		    
			List<CusDat> cusDatList=visaDataTypeDetailService.findListByVisaPid(Long.valueOf(visaProductId),visaorderId);
			request.setAttribute("cusDatList", cusDatList);
			Map<String, CusDat> cus_map=new HashMap<String, CusDat>();
			for(CusDat cusDat:cusDatList)
			{
				cus_map.put(cusDat.getCustomerName(), cusDat);
			}
			request.setAttribute("cus_map", cus_map);
			request.setAttribute("visaorderId", visaorderId);
			request.setAttribute("occuMap", CustomerOcc.getOccInfo());
			return mapping.findForward("customerUI");
		    
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
		request.setAttribute("occuMap", Param.getOccuType());
		request.setAttribute("occuId", "1");
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
		customer.setUserType(String.valueOf(CustomerTypeEnum.MEMBER_USER_TYPE.ordinal()));
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
		if(StringUtils.isNotEmpty(actionForm.getPeergroupId()))
		{
		PeerGroup peerGroup=peerGroupService.getById(Long.valueOf(actionForm.getPeergroupId()));
		customer.setPeerGroup(peerGroup);
		}
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

		List<User> salerList=userService.findAllByStatus();
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
		request.setAttribute("occuMap", Param.getOccuType());
		request.setAttribute("occuId", actionForm.getOccupation());
		request.setAttribute("peergroupId", customer.getPeerGroup()==null ?"":customer.getPeerGroup().getId());
		request.setAttribute("salerId", customer.getSaler()==null ?"":customer.getSaler().getId());
		request.setAttribute("inputName", customer.getInputName()==null ?user.getName():customer.getInputName());
		request.setAttribute("customerServicersList", customer.getCustomerServicers());
		request.setAttribute("linkManList", customer.getLinkMans());
		request.setAttribute("object", customer);
		
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
		String serinumber=customer.getSerialNumber()==null?"KH-"+NumberFormatTools.formatNumber(String.valueOf(customer.getId()), "000000"):customer.getSerialNumber();
		BeanUtils.copyProperties(customer, actionForm);
		customer.setUserType("0");
		customer.setStatus("0");
		customer.setSerialNumber(serinumber);
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
		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("lingquList", lingquList);
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
		request.setAttribute("inputName", customer.getInputName()==null ?user.getName():customer.getInputName());
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
		//保留serinumber
		String serinumber=customer.getSerialNumber()==null?"KH-"+NumberFormatTools.formatNumber(String.valueOf(customer.getId()), "000000"):customer.getSerialNumber();
		BeanUtils.copyProperties(customer, actionForm);
		customer.setSerialNumber(serinumber);
		customer.setRemoteIp(request.getRemoteAddr());
		customer.setUpdateTime(NumberFormatTools.getCurrentTime());
		
		// 2, service.update()
		
		List<Lingqu> lingquList = visaLingquService.getByIds(actionForm.getCustomerIds());
		customer.setLingquSet(new HashSet<Lingqu>(lingquList));
		if(StringUtils.isNotEmpty(actionForm.getPeergroupId()))
		{
		PeerGroup peerGroup=peerGroupService.getById(Long.valueOf(actionForm.getPeergroupId()));
		customer.setPeerGroup(peerGroup);
		}
		if(actionForm.getSalerId()!=null&&actionForm.getSalerId().length()>0)
		{
		User saler=userService.getById(Long.valueOf(actionForm.getSalerId()));
		customer.setSaler(saler);
		}
		customerService.updatePeer(customer);
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
	/**
	 * 同行价格设置
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward peerPriceSetingVisaUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String peerId=request.getParameter("peerId").trim();
		showPriceInfo(request,peerId);
		return mapping.findForward("peerPriceSetingVisaUI");
	}

	private void showPriceInfo( HttpServletRequest request,String id) {
		Customer customer=customerService.getById(Long.valueOf(id));
		HqlHelper hqlHelper = new HqlHelper(VisaProduct.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
		List list=new ArrayList();
		Set<Lingqu> lingquSet=customer.getLingquSet();
		for(Lingqu lingqu:lingquSet)
		{
			list.add(lingqu.getId());
		}
		if(list!=null&&list.size()>0)
		{
			hqlHelper.addWhereCondition("vo.lingqu.id in (:alist)", list);
		}
		else
		{
			hqlHelper.addWhereCondition("vo.lingqu.id=?",0L);
		}
//		hqlHelper.addWhereCondition(condition, paramValues)
		PageBean pageBean= visaProductService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		System.out.println(pageBean.getRecordCount());
		//查询出同业用户所属的领区，然后显示
		Long customerId=Long.parseLong(id);
		List<CustomerToVisaProduct> ctvpList = customerService.findAllByCustomerId(customerId);
		List<VisaProduct> visaproductList=new ArrayList<VisaProduct>();
		visaproductList.addAll(pageBean.getRecordList());
		for(VisaProduct vp:visaproductList)
		{
			for(CustomerToVisaProduct ctvp:ctvpList)
			{
				if(vp.getId().equals(ctvp.getVisaproductId()))
				{
					vp.setPrice(ctvp.getPrice());
					continue;
				}
			}
		}
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("ctvpList", ctvpList);
		request.setAttribute("id", id);
	}
	public ActionForward peerRelationSaveUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		return mapping.findForward("peerRelationSaveUI");
	}
	public ActionForward savePeerProductPrice(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 Map<String,String> map=new HashMap<String, String>();
		  Set<String> key = request.getParameterMap().keySet();
	        for (Iterator it = key.iterator(); it.hasNext();) {
	            String str = (String) it.next();
	            if(StringUtils.isNotEmpty(str)&&str.startsWith("visaProductArraysPrice["))
	            {
	            	map.put(str.substring(str.indexOf("[")+1, str.indexOf("]")), request.getParameter(str));
	            }
	        }
		Long id=Long.parseLong(request.getParameter("id").trim());
		customerService.saveCustomertertoProduct(id, map);
		showPriceInfo(request,request.getParameter("id"));
		return mapping.findForward("peerPriceSetingVisaUI");
	}

	@SuppressWarnings("unchecked")
	public static List removeDuplicateWithOrder(List list) {  
	    Map<String,CusDat> maps=new LinkedHashMap<String, CusDat>();
	    List newList = new ArrayList();  
	    for (Iterator iter = list.iterator(); iter.hasNext();) {  
	    	CusDat element =(CusDat) iter.next();  
	        maps.put(element.getCustomerId().toString(), element);
	    }  
	    newList.addAll(maps.values());
	    return newList;  
	}

	public ActionForward exportExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String ids = request.getParameter("id");
		String type = request.getParameter("type");
		List<Customer> customerList = new ArrayList<Customer>();
		if (StringUtils.isNotEmpty(ids)) {
			String[] array = ids.split(",");
			Long[] idArr = new Long[array.length];
			for (int i = 0; i < array.length; i++) {
				idArr[i] = Long.valueOf(array[i].toString());
			}
			customerList = customerService.getByIds(idArr);
		}
		// 导出
		String name =exportExcel(request,customerList,type);
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=\""
				+new String(name.getBytes("utf-8"), "ISO8859-1") + "\"");
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
	public static String exportExcel(HttpServletRequest request,List<Customer> customerList,String type) {
		ExportUtils utils = new ExportUtils();
		List<String[]> list = new ArrayList<String[]>();
		String titleName="";
		if(type.equals("0"))
		{
		 titleName="同业用户报表";
		utils.setTitle(titleName);// 添加报表标题
		String[] title = { "用户编号",  "用户名", "公司名称","公司地址","公司电话", "销售人员","联系人姓名","手机号码", "公司座机","QQ号码","Email","会员组", "领区" };
		utils.setHeader(title);
		for (Customer customer : customerList) {
			String customerLingqu = "";
			String linkMans = "";
			String linkPhones = "";
			String linkMobilePhones = "";
			String linkQQs = "";
			String linkEmails = "";
			int i=0;
			for(Lingqu lingqu:customer.getLingquSet())
			{
				customerLingqu=customerLingqu+lingqu.getName()+" ";
			}
			for(CustomerServicersVo csv:customer.getCustomerServicers())
			{
				if(i==customer.getCustomerServicers().size()-1)
				{
					linkMans=linkMans+csv.getName();
					linkPhones=linkPhones+csv.getPhone();
					linkMobilePhones=linkMobilePhones+csv.getMobliePhone();
					linkQQs=linkQQs+csv.getChatTools();
					linkEmails=linkEmails+csv.getEmail();
					
				}
				else
				{
					linkMans=linkMans+csv.getName()+"\n";
					linkPhones=linkPhones+csv.getPhone()+"\n";
					linkMobilePhones=linkMobilePhones+csv.getMobliePhone()+"\n";
					linkQQs=linkQQs+csv.getChatTools()+"\n";
					linkEmails=linkEmails+csv.getEmail()+"\n";
				}
			
				i++;
			}
			
			
			/**
			 * cusdat 表中拒签原因的字段都是一样的，只需要取出第一条记录的数据就可以
			 */
			String statusValue=customer.getStatus();
			if(statusValue.equals("0"))
			{
				statusValue="锁定";
			}
			else
			{
				statusValue="解锁";
			}
			list.add(new String[] { customer.getSerialNumber(), customer.getUserName(),
					customer.getCompanyName(),
					customer.getCompanyAddr(),
					customer.getCompanyPhone(),
					customer.getSaler()==null?"":customer.getSaler().getName(),
					linkMans,
					linkPhones,
					linkMobilePhones,
					linkQQs,
					linkEmails,
					customerLingqu,
				    statusValue,
			         customer.getPeerGroup()==null?"":customer.getPeerGroup().getName()});
		}
		}
		
		else if(type.equals("1"))
		{
			 titleName="直接用户报表";
			utils.setTitle(titleName);// 添加报表标题
			String[] title = { "用户编号",  "姓名", "手机", "QQ号码","Email", "家庭地址","家庭电话",
					"销售人员", "输入人员", "状态", "输入日期","职业状态" };
			utils.setHeader(title);
				for (Customer customer : customerList) {
					String customerLingqu = "";
					for(Lingqu lingqu:customer.getLingquSet())
					{
						customerLingqu=customerLingqu+lingqu.getName()+" ";
					}
					/**
					 * cusdat 表中拒签原因的字段都是一样的，只需要取出第一条记录的数据就可以
					 */
					String statusValue=customer.getStatus();
					if(statusValue.equals("0"))
					{
						statusValue="锁定";
					}
					else
					{
						statusValue="解锁";
					}
					
					String occu=customer.getOccupation();
					
					if(occu.equals("1"))
					{
						occu="在职人员";
					}
					else if(occu.equals("2"))
					{
						occu="退休人员";
					}
					else if(occu.equals("3"))
					{
						occu="学生及未成年";
					}
					else if(occu.equals("4"))
					{
						occu="自由职业";
					}
					else if(occu.equals("5"))
					{
						occu="不分职业";
					}
					
					else
					{
						occu="其他";
					}
					
					
										list.add(new String[] { customer.getSerialNumber(), customer.getUserName(),
												customer.getMobliePhone(),customer.getChatTools(), customer.getEmail(),
												customer.getAddress(),customer.getPhone(),
												customer.getSaler()==null?"":customer.getSaler().getName(),
												customer.getInputName(),
												 statusValue,
												customer.getRegTime(),occu});
				}
		}
		
		else if(type.equals("2"))
		{
			 titleName="客户报表";
			utils.setTitle(titleName);// 添加报表标题
			String[] title = {   "姓名", "手机","电话","QQ/MSN","邮箱", "领区",
					"注册时间" };
			utils.setHeader(title);
			
			for (Customer customer : customerList) {
				String customerLingqu = "";
				for(Lingqu lingqu:customer.getLingquSet())
				{
					customerLingqu=customerLingqu+lingqu.getName()+" ";
				}
				list.add(new String[] {  customer.getName(),
						customer.getPhone(), 
						customer.getChatTools(),
						customer.getMobliePhone(),customer.getEmail(),
				       customerLingqu,customer.getRegTime()});
				
			}
		}
		// 添加报表的查询字段名称
		// String[] fname={"开始时间","结束时间","操作用户"};
		// deh.setF_name(fname);//没有查询字段则直接赋值null
		// 添加报表的查询字段值
		// String[] fvalue={"2012-01-03","2012-01-11","admin","2013-05-06"};
		// deh.setF_value(fvalue);//没有查询字段则直接赋值null
		utils.setIsVerticalFreeze(true);// 是否对header进行冻结，让表头随着滚动条而滚动。默认：false
		String file = titleName+NumberFormatTools.getCurrentDay() + ".xls";
		utils.write(list, request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/")+Param.excelPath,file);// 第一个参数：数据集合；第二个参数：存储路径（我这里是本地路径），如果是在servlet中则是：request.getSession().getServletContext().getRealPath("/")+"项目中的文件夹名字/workOrder.xls";
		return  request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/")+Param.excelPath+file;
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
	


	
	/** 分销系统订单查询 */
	public ActionForward customerOrderList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String status=request.getParameter("status");
		System.out.println(status);
		HqlHelper hqlHelper = new HqlHelper(" FROM  VisaOrder vo  left join vo.customerSet c");
		hqlHelper.addSelectProperty("vo");
//		hqlHelper.addWhereCondition("c.id=? ", customer.getId());
		hqlHelper.addWhereCondition("vo.status=? ", status);
		PageBean pageBean = visaOrderService.getPageBean(hqlHelper,	getPageNum(request),getPageSize(request));
		System.out.println(pageBean);
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("customerOrderList");
	}

	
}