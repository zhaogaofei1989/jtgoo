package cn.jtgoo.cms.web.struts.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.PeerGroup;
import cn.jtgoo.cms.web.struts.formbean.PeerGroupActionForm;

public class PeerGroupAction extends BaseAction {


	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<PeerGroup> peerGroupList = peerGroupService.findAllByStatus();
		request.setAttribute("peerGroupList", peerGroupList);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		peerGroupService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		PeerGroupActionForm actionForm = (PeerGroupActionForm) form;
		PeerGroup peerGroup = new PeerGroup();

		// a，拷贝同名属性
		BeanUtils.copyProperties(peerGroup, actionForm);

		// 2, service.save()
		peerGroupService.save(peerGroup);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {


		// 3，ActionForm
		PeerGroupActionForm actionForm = (PeerGroupActionForm) form;
		PeerGroup peerGroup = peerGroupService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, peerGroup);
		actionForm.setMemberCount(peerGroup.getCustomerSet()==null?0:peerGroup.getCustomerSet().size());
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		PeerGroupActionForm actionForm = (PeerGroupActionForm) form;
		PeerGroup peerGroup = peerGroupService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(peerGroup, actionForm);

		peerGroupService.update(peerGroup);

		// 3, return
		return mapping.findForward("toList");
	}



	

}