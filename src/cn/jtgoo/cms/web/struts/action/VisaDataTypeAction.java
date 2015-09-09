package cn.jtgoo.cms.web.struts.action;

import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.DataType;
import cn.jtgoo.cms.domain.Department;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.Role;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.util.DepartmentUtils;
import cn.jtgoo.cms.web.struts.formbean.UserActionForm;
import cn.jtgoo.cms.web.struts.formbean.VisaDataTypeActionForm;
import cn.jtgoo.cms.web.struts.formbean.VisaLingquActionForm;

public class VisaDataTypeAction extends BaseAction {


	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<DataType> datatypeList = visaDataTypeService.findAllByStatus();
		request.setAttribute("datatypeList", datatypeList);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		visaDataTypeService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		VisaDataTypeActionForm actionForm = (VisaDataTypeActionForm) form;
		DataType datatype = new DataType();

		// a，拷贝同名属性
		BeanUtils.copyProperties(datatype, actionForm);

		// 2, service.save()
		visaDataTypeService.save(datatype);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {


		// 3，ActionForm
		VisaDataTypeActionForm actionForm = (VisaDataTypeActionForm) form;
		DataType datatype = visaDataTypeService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, datatype);
	
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaDataTypeActionForm actionForm = (VisaDataTypeActionForm) form;
		DataType datatype = visaDataTypeService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(datatype, actionForm);

		visaDataTypeService.update(datatype);

		// 3, return
		return mapping.findForward("toList");
	}



	

}