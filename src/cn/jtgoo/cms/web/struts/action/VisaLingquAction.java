package cn.jtgoo.cms.web.struts.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.VisaLingquActionForm;

public class VisaLingquAction extends BaseAction {


	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		User user=(User) request.getSession().getAttribute("user");
	   	HqlHelper hqlHelper = new HqlHelper(Lingqu.class, "c");
		hqlHelper.addWhereCondition("c.del_status=?", "0");
		PageBean	pageBean =null;
		if(user.getLoginName().equals("admin"))
		{
	
		 pageBean= visaLingquService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
		}
		else
		{
			user=userService.getById(user.getId());
			List<String> list=new ArrayList<String>();
			Set<Lingqu> lingquSet=user.getLingquSet();
			for(Lingqu lingqu:lingquSet)
			{
				list.add(lingqu.getId().toString());
			}
			if(list!=null&&list.size()>0)
			{
			hqlHelper.addWhereCondition("c.id in( ", list==null?")":NumberFormatTools.convertListToString(list)+")");
			pageBean= visaLingquService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
			}
		
		}
	

		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		visaLingquService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		VisaLingquActionForm actionForm = (VisaLingquActionForm) form;
		Lingqu lingqu = new Lingqu();

		// a，拷贝同名属性
		BeanUtils.copyProperties(lingqu, actionForm);

		// 2, service.save()
		/**
		 * 预约面试提醒功能列表,
		 * 每添加一个新的功能列表，就会触发存储过程或者触发器
		 */
		visaLingquService.save(lingqu);
		

		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {


		// 3，ActionForm
		VisaLingquActionForm actionForm = (VisaLingquActionForm) form;
		Lingqu lingqu = visaLingquService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, lingqu);
	
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaLingquActionForm actionForm = (VisaLingquActionForm) form;
		Lingqu lingqu = visaLingquService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(lingqu, actionForm);

		visaLingquService.update(lingqu);

		// 3, return
		return mapping.findForward("toList");
	}



	

}