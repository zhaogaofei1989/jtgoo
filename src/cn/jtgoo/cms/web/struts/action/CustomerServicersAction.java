package cn.jtgoo.cms.web.struts.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.web.struts.formbean.CustomerServicersActionForm;
public class CustomerServicersAction extends BaseAction {
	private final transient Log log = LogFactory.getLog(getClass());
	/** 检测登录名是否可用（true表示可用，false表示不可用） */

	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String peerId=request.getParameter("peerId");
		String userType=request.getParameter("userType");
		List<CustomerServicersVo> customerServicersList = customerServicers.findListByPeerId(Long.valueOf(peerId),userType);
		request.setAttribute("peerId", peerId);
		request.setAttribute("userType", userType);
		request.setAttribute("customerServicersList", customerServicersList);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		String peerId=request.getParameter("peerId");
		String userType=request.getParameter("userType");
		customerServicers.delete(id);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(af.getPath() + "&peerId=" + peerId+"&userType="+userType, af.getRedirect());
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String peerId=request.getParameter("peerId");
		String userType=request.getParameter("userType");
		request.setAttribute("peerId", peerId);
		request.setAttribute("userType", userType);
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		CustomerServicersActionForm actionForm = (CustomerServicersActionForm) form;
		CustomerServicersVo customerServicersVo = new CustomerServicersVo();

		// a，拷贝同名属性
		BeanUtils.copyProperties(customerServicersVo, actionForm);
		String peerId=request.getParameter("peerId");
		String userType=request.getParameter("userType");
		// 2, service.save()
		Customer customer=customerService.getById(Long.valueOf(peerId));
		
		customerServicersVo.setUserType(userType);
		customerServicersVo.setCustomer(customer);
		System.out.println(customerServicersVo.getName()+"........................"+customerServicersVo.getUserName());
		System.out.println(customerServicersVo.getCustomer().getCustomerServiceNames()+"........................");
		customerServicers.save(customerServicersVo);
		// 3, return
		
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(af.getPath() + "&peerId=" + peerId+"&userType="+userType, af.getRedirect());
		
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 3，ActionForm
		CustomerServicersActionForm actionForm = (CustomerServicersActionForm) form;
		CustomerServicersVo customerServicersVo= customerServicers.getById(Long.valueOf(request.getParameter("id")));
		BeanUtils.copyProperties(actionForm, customerServicersVo);
		String peerId=request.getParameter("peerId");
		String userType=request.getParameter("userType");
		request.setAttribute("peerId", peerId);
		request.setAttribute("userType", userType);
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		CustomerServicersActionForm actionForm = (CustomerServicersActionForm) form;
		CustomerServicersVo customerServicersVo = customerServicers.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(customerServicersVo, actionForm);
		
		String peerId=request.getParameter("peerId");
		String userType=request.getParameter("userType");
		customerServicersVo.setUserType(userType);
		customerServicers.update(customerServicersVo);
		request.setAttribute("peerId", peerId);
		request.setAttribute("userType", userType);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(af.getPath() + "&peerId=" + peerId+"&userType="+userType, af.getRedirect());
	}

	/** 修改 */
	public ActionForward showNameUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		CustomerServicersVo customerServicersVo=customerServicers.getById(Long.valueOf(id));
		CustomerServicersActionForm actionForm = (CustomerServicersActionForm) form;
		BeanUtils.copyProperties(actionForm, customerServicersVo);
		request.setAttribute("customerServicersVo", customerServicersVo);
		return mapping.findForward("showNameUI");
	}

}