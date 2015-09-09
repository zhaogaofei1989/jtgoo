package cn.jtgoo.cms.web.struts.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.InsuranceType;
import cn.jtgoo.cms.web.struts.formbean.InsuranceTypeActionForm;

/**
 * @author aa
 *保险 类型action
 */
public class InsuranceTypeAction extends BaseAction {
	private static final Logger logger = Logger.getLogger(InsuranceTypeAction.class);
	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<InsuranceType> insuranceTypeList = insuranceTypeService.findAllByStatus();
		request.setAttribute("insuranceTypeList", insuranceTypeList);
		return mapping.findForward("list");
	}
	public ActionForward list_json(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		List<InsuranceType> insuranceTypeList = insuranceTypeService.findAllByStatus();
		StringBuffer buffer=new StringBuffer();
		if(insuranceTypeList!=null&&insuranceTypeList.size()>0)
		{
			buffer.append("{\"Items\":[");
			for (InsuranceType insuranceType : insuranceTypeList) {
				buffer.append("{ \"name\": \"" + insuranceType.getName());
				buffer.append("\", \"topid\": \"0" );
				buffer.append("\", \"colid\": \"" + insuranceType.getId());
				buffer.append("\", \"value\": \"" + insuranceType.getId());
				buffer.append("\", \"fun\" : \"function(){}"+"\"} ,");
			}
			buffer.toString().subSequence(0, buffer.length() - 1);
			buffer.delete(buffer.length() - 1, buffer.length());
			buffer.append("]}");
			out.print(buffer.toString());
			logger.info(buffer);
		}
		return null;
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		insuranceTypeService.delete(id);
		return mapping.findForward("toList");
	}
	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		InsuranceTypeActionForm actionForm = (InsuranceTypeActionForm) form;
		InsuranceType insuranceType = new InsuranceType();

		// a，拷贝同名属性
		BeanUtils.copyProperties(insuranceType, actionForm);

		// 2, service.save()
		insuranceTypeService.save(insuranceType);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {


		// 3，ActionForm
		InsuranceTypeActionForm actionForm = (InsuranceTypeActionForm) form;
		InsuranceType insuranceType = insuranceTypeService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, insuranceType);
	
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		InsuranceTypeActionForm actionForm = (InsuranceTypeActionForm) form;
		InsuranceType insuranceType = insuranceTypeService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(insuranceType, actionForm);

		insuranceTypeService.update(insuranceType);

		// 3, return
		return mapping.findForward("toList");
	}



	

}