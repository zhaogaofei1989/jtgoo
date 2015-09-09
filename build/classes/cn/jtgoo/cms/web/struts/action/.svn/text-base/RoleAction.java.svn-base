package cn.jtgoo.cms.web.struts.action;

import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Resource;
import cn.jtgoo.cms.domain.Role;
import cn.jtgoo.cms.web.struts.formbean.RoleActionForm;

public class RoleAction extends BaseAction {

	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Role> roleList = roleService.findAll();
		request.setAttribute("roleList", roleList);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		roleService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1，actionForm --> new Role()
		RoleActionForm actionForm = (RoleActionForm) form;
		Role role = new Role();

		role.setName(actionForm.getName());
		role.setDescription(actionForm.getDescription());

		// 2，serivce.save()
		roleService.save(role);

		// 3，return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RoleActionForm actionForm = (RoleActionForm) form;
		Role role = roleService.getById(actionForm.getId()); // 传递了id参数，并且ActionForm中有id属性，就可以封装与获得。

		actionForm.setName(role.getName());
		actionForm.setDescription(role.getDescription());

		return mapping.findForward("saveUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		RoleActionForm actionForm = (RoleActionForm) form;
		Role role = roleService.getById(actionForm.getId());

		role.setName(actionForm.getName());
		role.setDescription(actionForm.getDescription());

		// 2, service.update()
		roleService.update(role);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 设置权限页面 */
	public ActionForward setPrivilegeUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO 应在页面中显示树状结构
		List<Resource> topResourceList = resourceService.findTopLevel();
		request.setAttribute("topResourceList", topResourceList);

		// 准备ActionForm
		RoleActionForm actionForm = (RoleActionForm) form;
		Role role = roleService.getById(actionForm.getId());

		Long[] resourceIds = new Long[role.getResources().size()];
		int i = 0;
		for (Resource r : role.getResources()) {
			resourceIds[i++] = r.getId();
		}
		actionForm.setResourceIds(resourceIds);

		return mapping.findForward("setPrivilegeUI");
	}

	/** 设置权限 */
	public ActionForward setPrivilege(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> getById()
		RoleActionForm actionForm = (RoleActionForm) form;
		Role role = roleService.getById(actionForm.getId());

		List<Resource> resourceList = resourceService.getByIds(actionForm.getResourceIds());
		role.setResources(new HashSet<Resource>(resourceList));

		// 2, service.update()
		roleService.update(role);

		// 3, return
		return mapping.findForward("toList");
	}

}
