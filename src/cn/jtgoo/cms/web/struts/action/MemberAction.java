package cn.jtgoo.cms.web.struts.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.Member;
import cn.jtgoo.cms.domain.PeerGroup;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.enumvo.MemberTyeEnum;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.CustomerActionForm;
import cn.jtgoo.cms.web.struts.formbean.MemberActionForm;

/**
 * @author  作者 zhaogaofei
 * @version  创建时间：May 13, 2015 5:19:07 PM
 * @email   zhaogaofei2012@163.com 
 * 类说明
 * 会员用户
 * 直接用户和会员用户是一类性质的用户
 */
public class MemberAction extends BaseAction {


	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String param=request.getParameter("param");
		String searchvalue=request.getParameter("searchvalue");
//		String startTime=request.getParameter("startTime");
		if(StringUtils.isNotEmpty(searchvalue))
		{
			searchvalue="%"+searchvalue+"%";
		}
		HqlHelper hqlHelper = new HqlHelper(Member.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
		hqlHelper.addWhereCondition("vo.userType=?", String.valueOf(MemberTyeEnum.MEMBER_USER_TYPE.ordinal()));
//		hqlHelper.addWhereCondition("vo."+param+" like ?", searchvalue);
//	     if(startTime!=null&&startTime.trim().length()>0)
//			{
//				hqlHelper.addBetween(" AND vo.regTime ",startTime, request.getParameter("endTime"));
//			}
		
		PageBean	pageBean = memberService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		
		
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("list");
	}
	/** 列表 */
	public ActionForward directList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String param=request.getParameter("param");
		String searchvalue=request.getParameter("searchvalue");
//		String startTime=request.getParameter("startTime");
		if(StringUtils.isNotEmpty(searchvalue))
		{
			searchvalue="%"+searchvalue+"%";
		}
		HqlHelper hqlHelper = new HqlHelper(Member.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
		hqlHelper.addWhereCondition("vo.userType=?", String.valueOf(MemberTyeEnum.DIRECT_USER_TYPE.ordinal()));
//		hqlHelper.addWhereCondition("vo."+param+" like ?", searchvalue);
//	     if(startTime!=null&&startTime.trim().length()>0)
//			{
//				hqlHelper.addBetween(" AND vo.regTime ",startTime, request.getParameter("endTime"));
//			}
			
		PageBean	pageBean = memberService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("endTime", NumberFormatTools.getCurrentDay());
		return mapping.findForward("directList");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		memberService.delete(id);
		return mapping.findForward("toList");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		return mapping.findForward("saveUI");
	}
	/** 添加页面 */
	public ActionForward directAddUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Lingqu> lingquList=visaLingquService.findAllByStatus();
		request.setAttribute("lingquList", lingquList);
		List<PeerGroup> peerGroupList=peerGroupService.findAllByStatus();
		request.setAttribute("peerGroupList", peerGroupList);
		List<User> salerList=userService.findAllByStatus();
		request.setAttribute("salerList", salerList);
		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("inputName", user.getName());
	
		request.setAttribute("occuMap", Param.getOccuType());
		return mapping.findForward("directSaveUI");
	}
	public ActionForward directSaveUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("directSaveUI");
	}

	/** 添加 */
	public ActionForward directAdd(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		MemberActionForm actionForm = (MemberActionForm) form;
		Member member = new Member();

		// a，拷贝同名属性
		BeanUtils.copyProperties(member, actionForm);
		member.setUserType(String.valueOf(MemberTyeEnum.DIRECT_USER_TYPE.ordinal()));
		// 2, service.save()
		memberService.save(member);

		// 3, return
		return mapping.findForward("toDirectList");
	}

	/** 修改页面 */
	public ActionForward directEditUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {


		// 3，ActionForm
		MemberActionForm actionForm = (MemberActionForm) form;
		Member member = memberService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, member);
//		actionForm.setMemberCount(member.getCustomerSet()==null?0:peerGroup.getCustomerSet().size());
		
		
		
		
		
		User user = (User) request.getSession().getAttribute("user");
		List<User> salerList=userService.findAllByStatus();
		request.setAttribute("salerList", salerList);
	
		// a，拷贝同名属性
		request.setAttribute("schoolName", actionForm.getSchoolName());
		request.setAttribute("schoolAddr", actionForm.getSchoolAddr());
		request.setAttribute("professional", actionForm.getProfessional());
		request.setAttribute("passwd", actionForm.getPasswd());
		request.setAttribute("confirmPasswd", actionForm.getConfirmPasswd());
		request.setAttribute("companyName", actionForm.getCompanyName());
		request.setAttribute("companyAddr", actionForm.getCompanyAddr());
		request.setAttribute("companyPhone", actionForm.getCompanyPhone());
		request.setAttribute("position", actionForm.getPosition());
		request.setAttribute("description", actionForm.getDescription());
		request.setAttribute("occuMap", Param.getOccuType());
		request.setAttribute("occuId", actionForm.getOccupation());
		request.setAttribute("salerId", member.getSaler()==null ?"":member.getSaler().getId());
		request.setAttribute("inputName", member.getInputName()==null ?user.getName():member.getInputName());
		
		return mapping.findForward("directEditUI");
	}

	/** 修改 */
	public ActionForward directEdit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		MemberActionForm actionForm = (MemberActionForm) form;
		Member member = memberService.getById(actionForm.getId());

		// a，拷贝同名属性
		BeanUtils.copyProperties(member, actionForm);

		memberService.update(member);

		// 3, return
		return mapping.findForward("toDirectList");
	}
	public ActionForward showMemberInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long memberId=Long.parseLong(request.getParameter("customerId").trim());
		Member member=memberService.getById(memberId);
		MemberActionForm actionForm = (MemberActionForm) form;
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, member);
		request.setAttribute("member", member);
		return mapping.findForward("showMemberInfo");
	}
	


	

}