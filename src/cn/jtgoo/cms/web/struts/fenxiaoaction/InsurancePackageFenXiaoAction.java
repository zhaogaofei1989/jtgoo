package cn.jtgoo.cms.web.struts.fenxiaoaction;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.BaoXianAttachment;
import cn.jtgoo.cms.domain.InsurancePackage;
import cn.jtgoo.cms.domain.InsuranceType;
import cn.jtgoo.cms.exception.AppException;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.InsurancePackageActionForm;

public class InsurancePackageFenXiaoAction extends BaseAction {

	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HqlHelper hqlHelper = new HqlHelper(InsurancePackage.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", String
				.valueOf(Delstatus.ACTIVE.ordinal()));
		// 参数传递
		String insurance_type = request.getParameter("insurance_type");
		if (StringUtils.isNotEmpty(insurance_type)) {
			hqlHelper.addWhereCondition("vo.insuranceType.id=?", Long
					.valueOf(insurance_type.trim()));
		}
		String insurance_package = request.getParameter("insurance_package");
		if (StringUtils.isNotEmpty(insurance_type)) {
			hqlHelper.addWhereCondition("vo.id=?",Long
					.valueOf(insurance_package.trim()));
		}

		PageBean pageBean = insurancePackageService.getPageBean(hqlHelper,
				getPageNum(request), getPageSize(request));
		// 所有保险公司信息
		List<InsuranceType> insuranceTypeList = insuranceTypeService
				.findAllByStatus();
		request.setAttribute("insuranceTypeList", insuranceTypeList);

		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("list");
	}

	/** 列表 */
	@SuppressWarnings("unchecked")
	public ActionForward getInfoByInsuranceTypeId(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String insuranceTypeId = request.getParameter("insuranceTypeId");
		if (StringUtils.isNotEmpty(insuranceTypeId)) {
			List<InsurancePackage> insurancePackageList = insurancePackageService.findByInsuranceTypeId(Long.valueOf(insuranceTypeId.trim()));
			StringBuffer buffer=new StringBuffer();
			  if(insurancePackageList!=null&&insurancePackageList.size()>0)
			    {
					buffer.append("{\"Items\":[");
					for (InsurancePackage insurancePackage : insurancePackageList) {
						buffer.append("{ \"id\": \"" + insurancePackage.getId());
						buffer.append("\", \"name\" : \""+insurancePackage.getName()+"\"} ,");
					}
					buffer.toString().subSequence(0, buffer.length() - 1);
					buffer.delete(buffer.length() - 1, buffer.length());
					buffer.append("]}");	
			    }
				response.setContentType("text/json; charset=utf-8");
				PrintWriter out = response.getWriter();
			    out.print(buffer.toString());
			    out.flush();
			    out.close();
		}
		return null;
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		// 先删对象，再删除附件
		InsurancePackage insurancePackage = insurancePackageService.getById(id);
		if (insurancePackage.getBaoxian_att_id() != null
				&& baoXianattachmentService.getById(insurancePackage
						.getBaoxian_att_id()) != null) {

			baoXianattachmentService.delete(insurancePackage
					.getBaoxian_att_id());
		}
		insurancePackageService.delete(id);
		return mapping.findForward("toList");
	}

	/** 删除 */
	public ActionForward getBaoxianInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long baoxian_att_id = Long.parseLong(request.getParameter("baoxian_att_id"));
		BaoXianAttachment baoXianAttachment=baoXianattachmentService.getById(baoxian_att_id);
		if(baoXianAttachment!=null)
		{
			File	file= new File(Param.upload_filepath+baoXianAttachment.getPath());
			if(!file.exists())
			{
				throw new AppException("common.file");
			}
			request.setAttribute("baoXianAttachment", baoXianAttachment.getPath());
		}

		return mapping.findForward("pdfview");
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setAttribute("insuranceType_id", -1);
		return mapping.findForward("saveUI");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> new User()
		String colsel_insuranceType = request
				.getParameter("info[colsel_insuranceType]");
		InsurancePackageActionForm actionForm = (InsurancePackageActionForm) form;
		InsurancePackage insurancePackage = new InsurancePackage();
		// a，拷贝同名属性
		BeanUtils.copyProperties(insurancePackage, actionForm);
		if (StringUtils.isNotEmpty(colsel_insuranceType.toString())) {
			InsuranceType insuranceType = insuranceTypeService.getById(Long
					.valueOf(colsel_insuranceType.trim()));
			insurancePackage.setInsuranceType(insuranceType);
		}

		/**
		 * 附件上传
		 */
		String attachmentIds = request.getParameter("attIds");
		String uploads = request.getParameter("uploads");
		if (StringUtils.isNotEmpty(attachmentIds)) {
			System.out.println(attachmentIds);
			BaoXianAttachment attachment = baoXianattachmentService
					.getById(Long.valueOf(attachmentIds.trim()));
			attachment.setName(uploads);

			if (attachment != null) {
				insurancePackage.setBaoxian_att_id(attachment.getId());
				insurancePackage.setPath(attachment.getName());
			}
			baoXianattachmentService.save(attachment);
			// 此时附件已经上传，如果附件字段为空，保险附件对象的名称就为，上传的附件名称
			// 如果不为空，就用附件字段的名称
		}

		// 2, service.save()
		insurancePackageService.save(insurancePackage);

		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 3，ActionForm
		InsurancePackageActionForm actionForm = (InsurancePackageActionForm) form;
		InsurancePackage insurancePackage = insurancePackageService
				.getById(actionForm.getId());
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, insurancePackage);
		request.setAttribute("insurancePackage", insurancePackage);
		request.setAttribute("insuranceType_name", insurancePackage
				.getInsuranceType().getName());
		request.setAttribute("insuranceType_id", insurancePackage
				.getInsuranceType().getId());
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> getById()
		InsurancePackageActionForm actionForm = (InsurancePackageActionForm) form;
		InsurancePackage insurancePackage = insurancePackageService
				.getById(actionForm.getId());

		String attachmentIds = request.getParameter("attIds");
		String uploads = request.getParameter("uploads");
		if (StringUtils.isNotEmpty(attachmentIds)) {
			System.out.println(attachmentIds);
			BaoXianAttachment attachment = baoXianattachmentService
					.getById(Long.valueOf(attachmentIds.trim()));
			attachment.setName(uploads);
			if (attachment != null) {
				insurancePackage.setBaoxian_att_id(attachment.getId());
				insurancePackage.setPath(attachment.getName());
			}
			baoXianattachmentService.save(attachment);
			// 此时附件已经上传，如果附件字段为空，保险附件对象的名称就为，上传的附件名称
			// 如果不为空，就用附件字段的名称
		} else {
			BaoXianAttachment attachment = baoXianattachmentService
					.getById(insurancePackage.getBaoxian_att_id());
			attachment.setName(actionForm.getPath());
			baoXianattachmentService.save(attachment);
		}
		// a，拷贝同名属性
		BeanUtils.copyProperties(insurancePackage, actionForm);
		insurancePackageService.update(insurancePackage);

		// 3, return
		return mapping.findForward("toList");
	}

}