package cn.jtgoo.cms.web.struts.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.VisaType;
import cn.jtgoo.cms.web.struts.formbean.VisaTypeActionForm;

public class VisaTypeAction extends BaseAction {


	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<VisaType> visatypeList = visaTypeService.findAllByStatus();
		request.setAttribute("visatypeList", visatypeList);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		visaTypeService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		VisaTypeActionForm actionForm = (VisaTypeActionForm) form;
		VisaType visatype = new VisaType();

		// a，拷贝同名属性
		BeanUtils.copyProperties(visatype, actionForm);

		// 2, service.save()
		visaTypeService.save(visatype);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {


		// 3，ActionForm
		VisaTypeActionForm actionForm = (VisaTypeActionForm) form;
		VisaType visatype = visaTypeService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, visatype);
	
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaTypeActionForm actionForm = (VisaTypeActionForm) form;
		VisaType visatype = visaTypeService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(visatype, actionForm);

		visaTypeService.update(visatype);

		// 3, return
		return mapping.findForward("toList");
	}



	

}