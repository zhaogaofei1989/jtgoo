package cn.jtgoo.cms.web.struts.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.DataType;
import cn.jtgoo.cms.domain.DataTypeDetail;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.Role;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.web.struts.formbean.VisaDataTypeDetailActionForm;

public class VisaDataTypeDetailAction extends BaseAction {

	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List<DataTypeDetail> datatypeDetailList;
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		if (type != null && type.length() > 0) {
			datatypeDetailList = visaDataTypeDetailService.getListByPId(Long
					.valueOf(pid.trim()), type);
		} else {
			datatypeDetailList = visaDataTypeDetailService.findAllByStatus();
		}
		Map<DataType, List<DataTypeDetail>> maps=new LinkedHashMap<DataType, List<DataTypeDetail>>();
		for(DataTypeDetail dataTypeDetail:datatypeDetailList)
		{
			if(!maps.containsKey(dataTypeDetail.getDataType()))
			{
				maps.put(dataTypeDetail.getDataType(), new ArrayList<DataTypeDetail>());
			}
			maps.get(dataTypeDetail.getDataType()).add(dataTypeDetail);
			System.out.println();
			System.out.println(dataTypeDetail.getTitle()+"-------"+dataTypeDetail.getDataType().getName()+"----"+dataTypeDetail.getSort());
		}
		
		request.setAttribute("datatypeDetailList", maps);
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		return mapping.findForward("list");
	}

	/** 删除 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		Long pid = Long.parseLong(request.getParameter("pid"));
		Long type = Long.parseLong(request.getParameter("type"));
		if (id != null) {
			visaDataTypeDetailService.delete(id);
		}
		List<DataTypeDetail> datatypeDetailList = visaDataTypeDetailService
				.getListByPId(pid, "1");
		request.setAttribute("datatypeDetailList", datatypeDetailList);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}

	public ActionForward saveSort(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println(request.getParameterValues("sort"));
		System.out.println(request.getParameterValues("arrids"));
		Long[] idArray = NumberFormatTools.arrayconverToLongarray(request
				.getParameterValues("arrids"));
		Integer[] sortArray = NumberFormatTools
				.arrayconverToIntegerarray(request.getParameterValues("sort"));
		Long pid = Long.parseLong(request.getParameter("pid"));
		Long type = Long.parseLong(request.getParameter("type"));
		List<DataTypeDetail> datatypeDetailList = visaDataTypeDetailService
				.getByIds(idArray);
		for (int i = 0; i < datatypeDetailList.size(); i++) {
			
			for(int j=0;j<idArray.length;j++)
			{
				System.out.println(datatypeDetailList.get(i).getId().longValue()+"---"+idArray[j]);
				System.out.println(datatypeDetailList.get(i).getId().longValue()==idArray[j].longValue());
				if(datatypeDetailList.get(i).getId().longValue()==idArray[j].longValue())
				{
				datatypeDetailList.get(i).setSort(Integer.valueOf(sortArray[j]));
				break;
				}
			}

		}
//		request.setAttribute("datatypeDetailList", datatypeDetailList);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}

	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List<DataType> datatypeList=visaDataTypeService.findAllByStatus();
		request.setAttribute("datatypeList", datatypeList);
		String pid = request.getParameter("pid");
		request.setAttribute("pid", pid);
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		request.setAttribute("visadataTypeId", -1);
		return mapping.findForward("saveUI");
	}

	/** 复制到其他职业 */
	public ActionForward copyRefreshUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String[] ids = request.getParameter("ids").split(",");
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		String occ=request.getParameter("occ");
		Long[] idArr=NumberFormatTools.arrayconverToLongarray(ids);
		List<DataTypeDetail> dataTypeDetailList = visaDataTypeDetailService.getByIds(idArr);
		if (dataTypeDetailList != null&&dataTypeDetailList.size()>0) {
			for(DataTypeDetail dataTypeDetail:dataTypeDetailList)
			{
			DataTypeDetail newDataTypeDetail = new DataTypeDetail();
			// a，拷贝同名属性
			BeanUtils.copyProperties(newDataTypeDetail, dataTypeDetail);
			newDataTypeDetail.setId(null);
			newDataTypeDetail.setCustomerSet(null);
			newDataTypeDetail.setType(occ);
			visaDataTypeDetailService.save(newDataTypeDetail);
		}
		}
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}
	
	
	/** 复制到其他职业 */
	public ActionForward copyTargetUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		String ids = request.getParameter("ids");
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		//排序
		Map<String, String> occuMap=new LinkedHashMap<String, String>();
		occuMap.put("1", "在职人员");
		occuMap.put("2", "退休人员");
		occuMap.put("3", "学生及未成年");
		occuMap.put("4","自由职业");
		occuMap.put("5", "不分职业");
		request.setAttribute("occuMap", occuMap);
		request.setAttribute("ids", ids);
		return mapping.findForward("copyTargetUI");
	}
	/** 复制到其他签证产品 */
	public ActionForward copyTargetVisaProduct(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		//资料数组下标
		String ids = request.getParameter("ids");
		//签证产品数据下标
		String[] productsIds = request.getParameterValues("productsIds");
		
		List<VisaProduct> visaProductList=visaProductService.getByIds(NumberFormatTools.converToLong(productsIds));
		List<DataTypeDetail> dataTypeDetailList=visaDataTypeDetailService.getByIds(NumberFormatTools.converToLong(ids.split(",")));
		DataTypeDetail dataTypeDetail=null;
		if(visaProductList!=null&&visaProductList.size()>0)
		{
			
			for(VisaProduct product:visaProductList)
			{
				
				//查询对象信息
			
					if(dataTypeDetailList!=null&&dataTypeDetailList.size()>0)
						{
							//for
							for(DataTypeDetail d:dataTypeDetailList)
							{
								dataTypeDetail= new DataTypeDetail();
								BeanUtils.copyProperties(dataTypeDetail, d);
								dataTypeDetail.setId(null);
								dataTypeDetail.setCustomerSet(null);
								dataTypeDetail.setVisaProduct(null);
								visaDataTypeDetailService.save(dataTypeDetail);
								product.getDataTypeDetailSet().add(dataTypeDetail);
								visaProductService.save(product);
							}
						
				}
		
				
			}
			
		}

		
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		request.setAttribute("ids", ids);
		
		
		
		
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}
	public ActionForward copyTargetVisaProductUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String ids = request.getParameter("ids");
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		
		//排序
		PageBean	pageBean =null;
		User user=(User) request.getSession().getAttribute("user");
	   	HqlHelper hqlHelper = new HqlHelper(VisaProduct.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
			user=userService.getById(user.getId());
			if(user.getLoginName().equals("admin"))
			{
				hqlHelper.addOrderProperty("vo.updateTime", true);
				pageBean= visaProductService.getPageBean(hqlHelper,
						getPageNum(request),getPageSize(request));
			}
			else
			{
				List<String> list=new LinkedList<String>();
				Set<Lingqu> lingquSet=user.getLingquSet();
				for(Lingqu lingqu:lingquSet)
				{
					list.add(lingqu.getId().toString());
				}
				for(Role role:user.getRoles())
				{
					if(role.getName().equals("管理员"))
					{
						break;
					}
				}
				if(list!=null&&list.size()>0)
				{
				hqlHelper.addWhereCondition("vo.lingqu.id in(", list==null?"":NumberFormatTools.convertListToString(list)+")");
				hqlHelper.addOrderProperty("vo.updateTime", true);
				pageBean = visaProductService.getPageBean(hqlHelper,
						getPageNum(request),getPageSize(request));
				}
			}
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("ids", ids);
		return mapping.findForward("copyTargetVisaProductUI");
	}

	/** 保存并新增 */
	public ActionForward saveAndAdd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		VisaDataTypeDetailActionForm actionForm = (VisaDataTypeDetailActionForm) form;
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		String visadatatypeId = request
				.getParameter("colsel_visadatatype");
		VisaProduct visaProduct = visaProductService.getById(Long.parseLong(pid
				.trim()));
		DataTypeDetail dataTypeDetail = new DataTypeDetail();
		// a，拷贝同名属性
		BeanUtils.copyProperties(dataTypeDetail, actionForm);

		// 2, service.save()
		DataType dataType = visaDataTypeService.getById(Long
				.parseLong(visadatatypeId.trim()));
		if (dataType != null) {
			dataTypeDetail.setDataType(dataType);
		}
		if (visaProduct != null) {
			dataTypeDetail.setVisaProduct(visaProduct);
		}
		dataTypeDetail.setType(type);
		visaDataTypeDetailService.update(dataTypeDetail);
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		request.setAttribute("visadataTypeId", -1);
		ActionForward af = mapping.findForward("addUI");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> new User()
		VisaDataTypeDetailActionForm actionForm = (VisaDataTypeDetailActionForm) form;
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		String visadatatypeId = request
				.getParameter("colsel_visadatatype");
		VisaProduct visaProduct = visaProductService.getById(Long.parseLong(pid
				.trim()));
		DataTypeDetail dataTypeDetail = new DataTypeDetail();
		// a，拷贝同名属性
		BeanUtils.copyProperties(dataTypeDetail, actionForm);

		// 2, service.save()
		DataType dataType = visaDataTypeService.getById(Long
				.parseLong(visadatatypeId.trim()));
		if (dataType != null) {
			dataTypeDetail.setDataType(dataType);
		}
		if (visaProduct != null) {
			dataTypeDetail.setVisaProduct(visaProduct);
		}
		dataTypeDetail.setSort(visaProduct.getDataTypeDetailSet().size() + 1);
		dataTypeDetail.setType(type);
		visaDataTypeDetailService.save(dataTypeDetail);
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Long pid = Long.parseLong(request.getParameter("pid"));
		Long type = Long.parseLong(request.getParameter("type"));
		// 3，ActionForm
		VisaDataTypeDetailActionForm actionForm = (VisaDataTypeDetailActionForm) form;
		DataTypeDetail dataTypeDetail = visaDataTypeDetailService
				.getById(actionForm.getId());
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, dataTypeDetail);
		List<DataType> datatypeList=visaDataTypeService.findAllByStatus();
		request.setAttribute("datatypeList", datatypeList);
		// request.setAttribute("attachmentList",
		// dataTypeDetail.getAttachment());
		request.setAttribute("visadataTypeId", dataTypeDetail.getDataType().getId());
		request.setAttribute("visadataTypeName", dataTypeDetail.getDataType()
				.getName());

		request.setAttribute("pid", pid);
		request.setAttribute("type", type);

		return mapping.findForward("editUI");
	}

	/** 修改页面 */
	public ActionForward redirctUI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 3，ActionForm
		String id = request.getParameter("parentId");
		System.out.println(id);
		VisaDataTypeDetailActionForm actionForm = (VisaDataTypeDetailActionForm) form;
		DataTypeDetail dataTypeDetail = visaDataTypeDetailService.getById(Long
				.valueOf(id.trim()));
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, dataTypeDetail);
		// request.setAttribute("attachmentList",
		// dataTypeDetail.getAttachment());
		request.setAttribute("visadataTypeId", dataTypeDetail.getDataType()
				.getId());
		request.setAttribute("visadataTypeName", dataTypeDetail.getDataType()
				.getName());
		request.setAttribute("id", actionForm.getId());
		return mapping.findForward("redirctUI");

	}

	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 1, actionForm --> getById()
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		VisaDataTypeDetailActionForm actionForm = (VisaDataTypeDetailActionForm) form;
		DataTypeDetail dataTypeDetail = visaDataTypeDetailService
				.getById(actionForm.getId());

		// a，拷贝同名属性visadataTypeId
		// BeanUtils.copyProperties(dataTypeDetail, actionForm);
		String vdtId = request.getParameter("colsel_visadatatype");
		DataType dataType = visaDataTypeService.getById(Long.valueOf(vdtId));
		dataTypeDetail.setDataType(dataType);
		dataTypeDetail.setContent(actionForm.getContent());
		dataTypeDetail.setTitle(actionForm.getTitle());
		dataTypeDetail.setSign(actionForm.getSign());
		visaDataTypeDetailService.update(dataTypeDetail);
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}

	/** 删除 */
	public ActionForward deleteBatch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String[] ids = request.getParameter("ids").split(",");
		String pid = request.getParameter("pid");
		String type = request.getParameter("type");
		try {
			Long[] idArr = new Long[ids.length];
			for (int i = 0; i < ids.length; i++) {
				idArr[i] = Long.valueOf(ids[i].trim());
			}
			visaDataTypeDetailService.delete(idArr);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		request.setAttribute("pid", pid);
		request.setAttribute("type", type);
		ActionForward af = mapping.findForward("toList");
		return new ActionForward(
				af.getPath() + "&pid=" + pid + "&type=" + type, af
						.getRedirect());
	}
}