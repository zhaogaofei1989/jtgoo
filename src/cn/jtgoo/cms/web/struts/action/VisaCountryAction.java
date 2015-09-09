package cn.jtgoo.cms.web.struts.action;

import java.io.File;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.DepartmentUtils;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.VisaCountryActionForm;

public class VisaCountryAction extends BaseAction {

	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HqlHelper hqlHelper = new HqlHelper(Country.class, "c");
		hqlHelper.addWhereParent(" c.parent IS NOT NULL").addOrderProperty(
				"c.parent.id", true);
		hqlHelper.addWhereCondition("c.del_status=?", String
				.valueOf(Delstatus.ACTIVE.ordinal()));
		// 显示部门的树状列表
		PageBean pageBean = customerService.getPageBean(hqlHelper,
				getPageNum(request), getPageSize(request));
		request.setAttribute("maps",sortCountryList(pageBean.getRecordList()));
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		visaCountryService.delete(id);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(af.getPath() + "&pageNum="
				+ request.getParameter("pageNum"), af.getRedirect());
	}
	public ActionForward checkName(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String name =request.getParameter("name");
		Country country = visaCountryService.findByName(name);
		String result = (country == null) ? "true" : "false";
		response.getWriter().write(result);
		return null;
	}

	/** 删除 */
	public ActionForward findCountryListByTopId(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Long topId = Long.parseLong(request.getParameter("topId"));
		System.out.println(topId);
		// visaCountryService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 显示部门的树状列表
		List<Country> topList = visaCountryService.findTopLevel();
		List<Country> countryList = DepartmentUtils.getAllCountryList(topList);
		request.setAttribute("countryList", countryList);
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> new Department()
		VisaCountryActionForm actionForm = (VisaCountryActionForm) form;
		Country country = new Country();
		Country parent = visaCountryService.getById(actionForm.getParentId());
		country.setName(actionForm.getName());
		country.setDescription(actionForm.getDescription());
		country.setIcon(actionForm.getIcon());
//		String[] filename = request.getParameterValues("uploads");
//		if (filename != null && filename.length > 0) {
//			/**
//			 * 取第一个
//			 */
//			country.setIcon("/" + Param.country + filename[0]);
//		}
		// 修改文件名
		country.setParent(parent);
		// 2, service.save()
		visaCountryService.save(country);

		// 3, return
		String parentId = request.getParameter("parentId");
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(af.getPath() + "&parentId=" + parentId, af
				.getRedirect());
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		VisaCountryActionForm actionForm = (VisaCountryActionForm) form;
		Country country = visaCountryService.getById(actionForm.getId());

		// 显示部门的树状列表
		List<Country> topList = visaCountryService.findTopLevel();
		List<Country> countryList = DepartmentUtils.getAllCountryList(topList);
		// 从集合中移除当前修改的部门及其子孙部门
		DepartmentUtils.removeCountryAndChildren(countryList, country);
		request.setAttribute("countryList", countryList);

		// 准备 ActionForm
		actionForm.setName(country.getName());
		actionForm.setIcon(country.getIcon());
		actionForm.setDescription(country.getDescription());
		if (country.getParent() != null) {
			actionForm.setParentId(country.getParent().getId());
		}
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> getById()
		VisaCountryActionForm actionForm = (VisaCountryActionForm) form;
		Country country = visaCountryService.getById(actionForm.getId());
		Country parent = visaCountryService.getById(actionForm.getParentId());
		country.setName(actionForm.getName());
		country.setDescription(actionForm.getDescription());
		String[] filename = request.getParameterValues("uploads");
		// 删掉原来的图片

		File delFile = new File(request.getSession().getServletContext()
				.getRealPath("/").replaceAll("\\\\", "/")
				+ country.getIcon());
		if (delFile.exists()) {
			delFile.delete();
		}

		if (filename != null && filename.length > 0) {
			/**
			 * 取第一个
			 */
			country.setIcon("/" + Param.country + filename[0]);
		} else {
			country.setIcon(actionForm.getIcon());
		}
		country.setParent(parent);

		// 2, service.update()
		visaCountryService.update(country);

		// 3, return
		String parentId = request.getParameter("parentId");
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(af.getPath() + "&parentId=" + parentId, af
				.getRedirect());
	}

	private static Map<Country, List<Country>>  sortCountryList(List<Country> list) {
		
		Map<Country, List<Country>> map=new LinkedHashMap<Country, List<Country>>();
		List<Country> link=null;
		for(Country c:list)
		{
			System.out.println(c.getParent().getName());
			if(map.get(c.getParent())==null)
			{	link=new LinkedList<Country>();
				map.put(c.getParent(),link);
				map.get(c.getParent()).add(c);
			}
			else
			{
				if(map.containsKey(c.getParent()))
				{
					map.get(c.getParent()).add(c);
				}
			}
		}
		return map;
	}

}