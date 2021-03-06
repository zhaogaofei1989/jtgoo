package cn.jtgoo.cms.web.struts.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Department;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.Resource;
import cn.jtgoo.cms.domain.Role;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.util.DepartmentUtils;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.UserActionForm;

public class UserAction extends BaseAction {
	private final transient Log log = LogFactory.getLog(getClass());

	/** 检测登录名是否可用（true表示可用，false表示不可用） */
	public ActionForward checkLoginName(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String loginName = request.getParameter("loginName");
		User user = userService.getByLoginName(new String(loginName
				.getBytes("iso8859-1"), "utf-8"));
		String result = (user == null) ? "true" : "false";
		response.getWriter().write(result);
		return null;
	}

	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HqlHelper hqlHelper = new HqlHelper(User.class, "c");
		hqlHelper.addWhereCondition("c.del_status=?", "0");
		PageBean pageBean = userService.getPageBean(hqlHelper,
				getPageNum(request), getPageSize(request));
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		userService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1，显示部门的树状列表
		List<Department> topList = departmentService.findTopLevel();
		List<Department> departmentList = DepartmentUtils
				.getAllDepartmentList(topList);
		request.setAttribute("departmentList", departmentList);

		// 2，岗位列表
		List<Role> roleList = roleService.findAll();
		request.setAttribute("roleList", roleList);

		return mapping.findForward("addUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> new User()
		UserActionForm actionForm = (UserActionForm) form;
		User user = new User();

		// a，拷贝同名属性
		BeanUtils.copyProperties(user, actionForm);
		// b, department
		Department department = departmentService.getById(actionForm
				.getDepartmentId());
		user.setDepartment(department);
		// c, roleSet
		List<Role> roleList = roleService.getByIds(actionForm.getRoleIds());
		user.setRoles(new HashSet<Role>(roleList));

		// 2, service.save()
		userService.save(user);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1，显示部门的树状列表
		List<Department> topList = departmentService.findTopLevel();
		List<Department> departmentList = DepartmentUtils
				.getAllDepartmentList(topList);
		request.setAttribute("departmentList", departmentList);

		List<Lingqu> lingquList = visaLingquService.findAllByStatus();
		request.setAttribute("lingquList", lingquList);

		// 2，岗位列表
		List<Role> roleList = roleService.findAll();
		request.setAttribute("roleList", roleList);

		// 3，ActionForm
		UserActionForm actionForm = (UserActionForm) form;
		User user = userService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, user);
		// b, departmentId
		if (user.getDepartment() != null) {
			actionForm.setDepartmentId(user.getDepartment().getId());
		}

		// c, roleSet
		Long[] roleIds = new Long[user.getRoles().size()];
		int index = 0;
		for (Role role : user.getRoles()) {
			roleIds[index] = role.getId();
			index++;
		}
		actionForm.setRoleIds(roleIds);

		Long[] userIds = new Long[user.getLingquSet().size()];
		int i = 0;
		for (Lingqu r : user.getLingquSet()) {
			userIds[i++] = r.getId();
		}
		actionForm.setUserIds(userIds);

		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> getById()
		UserActionForm actionForm = (UserActionForm) form;
		User user = userService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(user, actionForm);
		List<Lingqu> lingquList = visaLingquService.getByIds(actionForm
				.getUserIds());
		user.setLingquSet(new HashSet<Lingqu>(lingquList));
		// b, department
		Department department = departmentService.getById(actionForm
				.getDepartmentId());
		user.setDepartment(department);
		// c, roleSet
		List<Role> roleList = roleService.getByIds(actionForm.getRoleIds());
		user.setRoles(new HashSet<Role>(roleList));

		// 2, service.update()
		userService.update(user);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 初始化密码为1234 */
	public ActionForward initPassword(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		userService.initPassword(id);
		return mapping.findForward("toList");
	}

	// =========================================================

	/** 登录页面 */
	public ActionForward loginUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("loginUI");
	}

	/** 登录 */
	public ActionForward login(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String loginName = request.getParameter("loginName");
		String password = request.getParameter("password");
		Properties prop = System.getProperties();
		String os = prop.getProperty("os.name");
		System.out.println(os);
		User user = null;
		log.info(request.getContextPath());
		try {
			user = userService.getByLoginNameAndPassword(loginName, password);
		} catch (Exception e) {
			// throw new AppException("common.file");
			return mapping.findForward("loginUI");
		}

		if (user == null) { // 登录失败
			ActionErrors errors = new ActionErrors();
			errors.add("login", new ActionMessage("用户名或密码不正确！", false));
			saveErrors(request, errors);
			return mapping.findForward("loginUI");
		} else {
			// 登录成功
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("username", user.getLoginName());
			request.getSession().setAttribute("userId", user.getId());
			List<Lingqu> lingquList = new ArrayList<Lingqu>();
			lingquList.addAll(user.getLingquSet());
			request.getSession().setAttribute("lingquList", lingquList);

			// 取出用户所有的权限，并放到session作用域中
			Set<Resource> menuList = null; // 不要重复的元素
			if ("admin".equals(user.getLoginName())) {
				// 超级管理员有所有权限
				menuList = new LinkedHashSet<Resource>(resourceService
						.findAll());
			} else {
				menuList = new TreeSet<Resource>(); // 使用TreeSet，可以自动排序
				for (Role role : user.getRoles()) {
					menuList.addAll(role.getResources()); // Set集合没有顺序
				}
			}

			request.getSession().setAttribute("menuList", menuList);
			return mapping.findForward("index");
		}
	}

	/** 注销 */
	public ActionForward logout(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("menuList");
		return mapping.findForward("logout");
	}

	/** 注销 */
	public ActionForward updatePasswd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		User user = userService.getById(id);
		String newPasswd = request.getParameter("newpasswd1");
		String oldPasswd = request.getParameter("oldpasswd");
		if (StringUtils.isNotEmpty(oldPasswd)
				&& StringUtils.isNotEmpty(newPasswd)) {
			String oldPasswd_digest = DigestUtils.md5Hex(oldPasswd.trim());
			if (oldPasswd_digest.equals(user.getPassword())) {
				user.setPassword(DigestUtils.md5Hex(newPasswd.trim()));
			}
			{
				ActionErrors errors = new ActionErrors();
				errors.add("message1", new ActionMessage("密码不正确！", false));
				saveErrors(request, errors);
			}
		}

		return mapping.findForward("showPasswdUI");
	}

	public ActionForward updatePasswdUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("updatePasswdUI");
	}
}