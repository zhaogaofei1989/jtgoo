package cn.jtgoo.cms.web.struts.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.IOUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.json.JSONObject;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Attachment;
import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.domain.VisaOrder;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.exception.AppException;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.AttachmentActionForm;

public class AttachmentAction extends BaseAction {

	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		PageBean pageBean = null;
		HqlHelper hqlHelper = new HqlHelper(Attachment.class, "vo");
		User user = (User) request.getSession().getAttribute("user");
		if (user.getLoginName().equals("admin")) {
			pageBean = attachmentService.getPageBean(hqlHelper,
					getPageNum(request), getPageSize(request));
		} else {
			user = userService.getById(user.getId());
			pageBean = attachmentService.getPageBean(hqlHelper,
					getPageNum(request), getPageSize(request));
		}
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		Attachment attachment = attachmentService.getById(id);
		attachmentService.delete(id);
		if (attachment != null) {
			File file = new File(attachment.getPath());
			if (file.exists()) {
				file.delete();
			}
		}

		return mapping.findForward("toList");
	}

	/** 删除 */
	public ActionForward deleteBatch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String[] ids = request.getParameter("ids").split(",");
		Long[] idArr = new Long[ids.length];
		/**
		 * 得到所有name 为uploads 的属性
		 */
		for (int i = 0; i < ids.length; i++) {
			idArr[i] = Long.valueOf(ids[i].trim());
		}

		List<Attachment> attachmentList = attachmentService.getByIds(idArr);
		/**
		 * 先删库，再删文件
		 */
		attachmentService.delete(idArr);

		if (attachmentList != null && attachmentList.size() > 0) {
			for (Attachment attachment : attachmentList) {
				File file = new File(attachment.getPath());
				if (file.exists()) {
					file.delete();
				}
			}
		}

		return mapping.findForward("toList");
	}

	/** 删除 */
	public ActionForward listByVisaProductId(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Long visaProductId = Long.parseLong(request
				.getParameter("visaProductId"));
		VisaProduct product = visaProductService.getById(visaProductId);
		request.setAttribute("attachmentList", product.getAttachmentSet());
		request.setAttribute("productName", product.getName());
		return mapping.findForward("listByVisaProductId");
	}

	/** 下载申请的文档 */
	public ActionForward download(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		Attachment attachment = attachmentService.getById(id);
		// 指定默认的文件名
		String name = attachment.getName();
		if (request.getHeader("User-Agent").toLowerCase().indexOf("firefox") > 0) {
			name = new String(name.getBytes("UTF-8"), "ISO8859-1");
		}
		// IE
		else {
			name = URLEncoder.encode(name, "UTF-8");
		}

		FileInputStream in  = null;
		// 输出文件内容
		try {
			in= new FileInputStream(Param.upload_filepath+attachment.getPath());
			/**
			 * 下载提示框
			 */
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\""
					+ name + "\"");
			/**
			 * 读取文件流
			 */
			IOUtils.copy(in, response.getOutputStream());
		} catch (Exception e) {
			throw new AppException("common.file");
		}
		finally {
			IOUtils.closeQuietly(in);
		}
		return null;
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List<VisaProduct> visaProductList = visaProductService.findAll();
		List<Country> topLevel = visaCountryService.findTopLevel();
		// TODO 应在页面中显示树状结构

		// 准备ActionForm
		request.setAttribute("topLevel", topLevel);
		request.setAttribute("visaProductList", visaProductList);

		AttachmentActionForm actionForm = (AttachmentActionForm) form;
		Long[] resourceIds = new Long[visaProductList.size()];
		int i = 0;
		for (VisaProduct r : visaProductList) {
			resourceIds[i++] = r.getId();
		}
		actionForm.setResourceIds(resourceIds);
		return mapping.findForward("addUI");
	}

	/** 上传页面 */
	public ActionForward uploadUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List<VisaProduct> visaProductList = visaProductService.findAll();
		List<Country> topLevel = visaCountryService.findTopLevel();
		// TODO 应在页面中显示树状结构

		// 准备ActionForm
		request.setAttribute("topLevel", topLevel);
		request.setAttribute("visaProductList", visaProductList);

		AttachmentActionForm actionForm = (AttachmentActionForm) form;
		Long[] resourceIds = new Long[visaProductList.size()];
		int i = 0;
		for (VisaProduct r : visaProductList) {
			resourceIds[i++] = r.getId();
		}
		actionForm.setResourceIds(resourceIds);
		return mapping.findForward("uploadUI");
	}

	public ActionForward upload(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AttachmentActionForm actionForm = (AttachmentActionForm) form;

		Attachment attachment = attachmentService.getById(actionForm.getId());

		// attachment.setResources(new HashSet<Resource>(resourceList));

		// 2, service.update()
		attachmentService.update(attachment);

		return mapping.findForward("upload");
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> new User()
		AttachmentActionForm actionForm = (AttachmentActionForm) form;
		if (actionForm.getIds() != null && actionForm.getIds().length() > 0) {

			/**
			 * 可能有多个id
			 */
			String[] arrays = actionForm.getIds().split(",");
			Long[] idArr = new Long[arrays.length];
			/**
			 * 得到所有name 为uploads 的属性
			 */
			String[] attNames = request.getParameterValues("uploads");
			for (int i = 0; i < arrays.length; i++) {
				idArr[i] = Long.valueOf(arrays[i].trim());
			}
			List<Attachment> attachmentList = attachmentService.getByIds(idArr);
			for (int k = 0; k < attachmentList.size(); k++) {
				List<VisaProduct> visaProductList = visaProductService
						.getByIds(actionForm.getResourceIds());
				attachmentList.get(k).setProductSet(
						new HashSet<VisaProduct>(visaProductList));
				if (attNames != null && attNames.length > 0) {
					attachmentList.get(k).setName(attNames[k]);
				} else {
					attachmentList.get(k).setName(actionForm.getName());
				}
				attachmentService.update(attachmentList.get(k));
			}

		}
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AttachmentActionForm actionForm = (AttachmentActionForm) form;
		Attachment attachment = attachmentService.getById(actionForm.getId());
		BeanUtils.copyProperties(actionForm, attachment);
		List<VisaProduct> visaProductList = visaProductService.findAll();
		List<Country> topLevel = visaCountryService.findTopLevel();
		// TODO 应在页面中显示树状结构

		// 准备ActionForm
		request.setAttribute("topLevel", topLevel);
		request.setAttribute("visaProductList", visaProductList);

		Long[] resourceIds = new Long[attachment.getProductSet().size()];
		int i = 0;
		for (VisaProduct r : attachment.getProductSet()) {
			resourceIds[i++] = r.getId();
		}
		actionForm.setResourceIds(resourceIds);

		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> new User()
		AttachmentActionForm actionForm = (AttachmentActionForm) form;
		if (actionForm.getId() > 0) {
			Attachment attachment = attachmentService.getById(actionForm
					.getId());
			List<VisaProduct> visaProductList = visaProductService
					.getByIds(actionForm.getResourceIds());
			attachment.setProductSet(new HashSet<VisaProduct>(visaProductList));
			attachmentService.update(attachment);
		}
		return mapping.findForward("toList");
	}
	
	
	public ActionForward getJSONInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		String id=request.getParameter("id");
		VisaOrder visaOrder=visaOrderService.getById(Long.valueOf(id.trim()));
		 JSONObject object=new JSONObject();
		 object.put("id", id);
		 object.put("path", visaOrder.getVisaorder_attachment().getPath());
		 object.put("name", visaOrder.getVisaorder_attachment().getName());
		 out.print(object);
		 out.flush();
         out.close();
		return null;
	}
}