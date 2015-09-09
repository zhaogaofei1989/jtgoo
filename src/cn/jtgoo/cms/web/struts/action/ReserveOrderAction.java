package cn.jtgoo.cms.web.struts.action;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.ReserveOrder;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.DepartmentUtils;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.ReserveOrderActionForm;
import cn.jtgoo.cms.web.struts.formbean.VisaCountryActionForm;

public class ReserveOrderAction extends BaseAction {


	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HqlHelper hqlHelper = new HqlHelper(ReserveOrder.class, "c");
		hqlHelper.addWhereCondition("c.del_status=?", "0");
		// 显示部门的树状列表
		PageBean	pageBean = reserveOrderService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		reserveOrderService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new Department()
		ReserveOrderActionForm reserveOrderForm = (ReserveOrderActionForm) form;
		ReserveOrder reserveOrder = new ReserveOrder();
		BeanUtils.copyProperties(reserveOrder, reserveOrderForm);
		reserveOrderService.save(reserveOrder);
		System.out.println("json response...");
		return null;
		// 3, return
	//	return new ActionForward(af.getPath() + "&parentId=" + parentId, af.getRedirect());
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

//
//		VisaCountryActionForm actionForm = (VisaCountryActionForm) form;
//		Country country = visaCountryService.getById(actionForm.getId());
//
//		// 显示部门的树状列表
//		List<Country> topList = visaCountryService.findTopLevel();
//		List<Country> countryList = DepartmentUtils.getAllCountryList(topList);
//		// 从集合中移除当前修改的部门及其子孙部门
//		DepartmentUtils.removeCountryAndChildren(countryList, country);
//		request.setAttribute("countryList", countryList);
//
//		// 准备 ActionForm
//		actionForm.setName(country.getName());
//		actionForm.setIcon(country.getIcon());
//		actionForm.setDescription(country.getDescription());
//		if (country.getParent() != null) {
//			actionForm.setParentId(country.getParent().getId());
//		}
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaCountryActionForm actionForm = (VisaCountryActionForm) form;
		Country country = visaCountryService.getById(actionForm.getId());

		Country parent = visaCountryService.getById(actionForm.getParentId());
		country.setName(actionForm.getName());
		country.setDescription(actionForm.getDescription());
		String[] filename=request.getParameterValues("uploads");
		//删掉原来的图片
		
//		File delFile=new File(Param.attachmentPath+country.getIcon());
//		if(delFile.exists())
//		{
//			delFile.delete();
//		}
//		
//		if(filename!=null&&filename.length>0)
//		{
//			/**
//			 * 取第一个
//			 */
//			country.setIcon("/"+Param.upload_filepath+Param.country+filename[0]);
//		}
//		else
//		{
//			country.setIcon(actionForm.getIcon());
//		}
//		country.setParent(parent);

		// 2, service.update()
		visaCountryService.update(country);
		

		// 3, return
		String parentId = request.getParameter("parentId");
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(af.getPath() + "&parentId=" + parentId, af.getRedirect());
	}



	

}