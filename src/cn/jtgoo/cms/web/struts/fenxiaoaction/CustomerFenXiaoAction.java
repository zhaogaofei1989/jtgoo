package cn.jtgoo.cms.web.struts.fenxiaoaction;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.enumvo.CustomerTypeEnum;
import cn.jtgoo.cms.enumvo.VisaOrderStatusEnum;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.CustomerServicersActionForm;
public class CustomerFenXiaoAction extends BaseAction {
	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String searchvalue=request.getParameter("searchvalue");
		if(StringUtils.isNotEmpty(searchvalue))
		{
			searchvalue="%"+searchvalue+"%";
		}
		HqlHelper hqlHelper = new HqlHelper(" FROM  Customer vo");
		hqlHelper.addWhereCondition("vo.userType=?", "2");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
		PageBean pageBean = customerService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
		request.setAttribute("pageBean", pageBean);
		System.out.println(pageBean.getCurrentPage()+"---------------");
		return mapping.findForward("list");
	}
	/** 列表 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Customer customer = (Customer) request.getSession().getAttribute("customer"); 
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
		return mapping.findForward("addUI");
	}
	
	/** 列表 */
	@SuppressWarnings("unused")
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String customerservicerId=request.getParameter("id");
		CustomerServicersActionForm actionForm=new CustomerServicersActionForm();
		CustomerServicersVo customerServicersVo=customerServicers.getById(Long.valueOf(customerservicerId.trim()));
		BeanUtils.copyProperties(actionForm, customerServicersVo);
		Long id=Long.valueOf(request.getParameter("id").trim());
		request.setAttribute("customerServicersVo", customerServicersVo);
		return mapping.findForward("updateUI");
	}
	
	public ActionForward contentUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String searchvalue=request.getParameter("searchvalue");
		
		HqlHelper hqlHelper = new HqlHelper(" FROM  Customer vo");
		hqlHelper.addWhereCondition("vo.userType=?", "2");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
		if(StringUtils.isNotEmpty(searchvalue))
		{
			searchvalue="%"+searchvalue+"%";
			hqlHelper.addWhereCondition("vo.name like ? ", searchvalue);
		}
		PageBean	pageBean = customerService.getPageBean(hqlHelper,getPageNum(request),getPageSize(request));
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("contentUI");
	}
	
	public ActionForward topUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("topUI");
	}
	
	
	/** 列表 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Customer customer = (Customer) request.getSession().getAttribute("customer"); 
		CustomerServicersActionForm actionForm = (CustomerServicersActionForm) form;
		CustomerServicersVo customerServicersVo=new CustomerServicersVo();
		customerServicersVo.setName(actionForm.getName());
		customerServicersVo.setMobliePhone(actionForm.getMobliePhone());
		customerServicersVo.setChatTools(actionForm.getChatTools());
		customerServicersVo.setCompanyName(actionForm.getCompanyName());
		customerServicersVo.setCompanyAddr(actionForm.getCompanyAddr());
		customerServicersVo.setCompanyPhone(actionForm.getCompanyPhone());
		customerServicersVo.setCustomer(customerService.getById(customer.getId()));
		customerServicersVo.setRegTime(NumberFormatTools.getCurrentTime());
//	Customer dbvo=customerService.getById(cu)
		customerServicers.save(customerServicersVo);
		
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
		return mapping.findForward("toList");
	}
	
	
	/** 列表 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	Customer customer = (Customer) request.getSession().getAttribute("customer"); 
	CustomerServicersActionForm actionForm = (CustomerServicersActionForm) form;
	CustomerServicersVo customerServicersVo=customerServicers.getById(actionForm.getId());
	if(customerServicersVo!=null)
	{
	customerServicersVo.setName(actionForm.getName());
	customerServicersVo.setMobliePhone(actionForm.getMobliePhone());
	customerServicersVo.setChatTools(actionForm.getChatTools());
	customerServicersVo.setCompanyName(actionForm.getCompanyName());
	customerServicersVo.setCompanyAddr(actionForm.getCompanyAddr());
	customerServicersVo.setCompanyPhone(actionForm.getCompanyPhone());
	customerServicersVo.setRegTime(NumberFormatTools.getCurrentTime());
	customerServicers.update(customerServicersVo);
	}
	
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
		return mapping.findForward("toList");
	}
	
}