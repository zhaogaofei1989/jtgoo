package cn.jtgoo.cms.web.struts.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.jtgoo.cms.base.BaseAction;
import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.DataType;
import cn.jtgoo.cms.domain.DataTypeDetail;
import cn.jtgoo.cms.domain.InsurancePackage;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.Role;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.domain.VisaType;
import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.NumberFormatTools;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.util.StringHelper;
import cn.jtgoo.cms.web.struts.formbean.VisaProductActionForm;

public class VisaProductAction extends BaseAction {


	/** 列表 */
	@SuppressWarnings("unchecked")
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	 	PageBean	pageBean =null;
		User user=(User) request.getSession().getAttribute("user");
	   	HqlHelper hqlHelper = new HqlHelper(VisaProduct.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
	   	String countryId=request.getParameter("countrySelect");
	         String visaTypeId=request.getParameter("visaTypeSelect");
			 String lingquId=request.getParameter("lingquSelect");
		 if(StringUtils.isEmpty(countryId))
		 {
			 countryId="";
		 }
		 if(StringUtils.isEmpty(visaTypeId))
		 {
			 visaTypeId="";
		 }
		 if(StringUtils.isEmpty(lingquId))
		 {	 lingquId="";
		 }
		hqlHelper.addWhereCondition("vo.country.id = ? ",countryId==""?"":Long.valueOf(countryId))
		.addWhereCondition("vo.type.id = ? ",visaTypeId==""?"":Long.valueOf(visaTypeId))
		.addWhereCondition("vo.lingqu.id = ? ",lingquId==""?"":Long.valueOf(lingquId));
		String name=request.getParameter("visaProductName");
		System.out.println(request.getParameterNames());
		if(StringUtils.isNotEmpty(name))
		{
			name="%"+name+"%";
			hqlHelper.addWhereCondition("vo.name like  ? ",name);
		}
	
		/**
		 * 重新查询
		 * 
		 */
		/**
		 * 判断用户角色是否有管理员
		 */
		 boolean hasAdmin=false;
		 user=userService.getById(user.getId());
		if(user.getLoginName().equals("admin"))
		{
			hasAdmin=true;
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
					hasAdmin=true;
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

		/** 
		 * 国家集合
		 */
		List<Country> countryList = visaCountryService.findTopLevel();
		request.setAttribute("countryList", countryList);
		/**
		 * 类型集合
		 */
		List<VisaType>visaTypeList=visaTypeService.findAll();
		request.setAttribute("visaTypeList", visaTypeList);
		/**
		 * 领区集合
		 */
		List<Lingqu> lingquList=visaLingquService.findAll();
		request.setAttribute("lingquList", lingquList);
		
		request.setAttribute("hasAdmin", hasAdmin);
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("list");
	}


	/**不可轻易 删除产品,
	 * 产品与订单是相互关联的
	 * 一个产品对应多个订单
	 * 一旦删除产品就会导致订单查询出问题
	 * 删除前首先保证订单已经没有关联了
	 *  */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		VisaProduct deleteProduct=visaProductService.getById(id);
		if(deleteProduct!=null)
		{
		if(deleteProduct.getVisaOrderSet().size()>0)
		{
			request.setAttribute("message", "与订单关系有关联");
		}
		else if(deleteProduct.getAttachmentSet().size()>0)
		{
			request.setAttribute("message", "与附件有关联");
		}
		else if(deleteProduct.getDataTypeDetailSet().size()>0)
		{
			request.setAttribute("message", "与数据资料有关联");
		}
		else if(deleteProduct.getCustomerSet().size()>0)
		{
			request.setAttribute("message", "与用户价格有关联关系");
		}
		}
			visaProductService.delete(id);

		return mapping.findForward("toList");
	}


	
	/** 预约费用 */
	public ActionForward bookingFeeList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		PageBean	pageBean =null;
		HqlHelper hqlHelper = new HqlHelper(VisaProduct.class, "vo");
		User user=(User) request.getSession().getAttribute("user");
		hqlHelper.addWhereCondition("vo.quotationHasVisaPrice =?","0");
		if(user.getLoginName().equals("admin"))
		{
			pageBean= visaProductService.getPageBean(hqlHelper,
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
			hqlHelper.addWhereCondition("vo.lingqu.id in(", list==null?"":NumberFormatTools.convertListToString(list)+")");
			pageBean = visaProductService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
			}
		
		}
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("bookingFeeList");
	}

	/** 添加页面 */
	public ActionForward bookingFeeEditUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 3，ActionForm
		VisaProductActionForm actionForm = (VisaProductActionForm) form;
		VisaProduct visaProduct = visaProductService.getById(actionForm.getId());
		// a，拷贝同名属性
		BeanUtils.copyProperties(actionForm, visaProduct);
		request.setAttribute("id", visaProduct.getId());
		return mapping.findForward("bookingFeeEditUI");
	}
	/** 添加页面 */
	public ActionForward addUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("countryId",-1);
		request.setAttribute("lingquId",-1);
		request.setAttribute("visaTypeId", -1);
		request.setAttribute("insurancePackageId", -1);
		request.setAttribute("visaTypeName", "");
		List<Lingqu> lingquList=visaLingquService.findAll();
		request.setAttribute("lingquList", lingquList);
		return mapping.findForward("saveUI");
	}
	
	

	/**复制产品 */
	public ActionForward copyRefreshUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		try {
			if(StringUtils.isNotEmpty(id.trim()))
			{
				VisaProduct product=visaProductService.getById(Long.valueOf(id.trim()));
				VisaProduct newVisaProduct=new VisaProduct();
				if(product!=null)
				{
					BeanUtils.copyProperties(newVisaProduct, product);
					newVisaProduct.setId(null);
					newVisaProduct.setVisaOrderSet(null);
					newVisaProduct.setDataTypeDetailSet(null);
					
					/**
					 * 查询有资料类型信息
					 */
					Set<DataTypeDetail> dataTypeDetailList=new LinkedHashSet<DataTypeDetail>();
					/**
					 * 有必要写保存多个实例的方法
					 */
					for(DataTypeDetail dataTypeDetail:product.getDataTypeDetailSet())
					{
						DataTypeDetail newdetail=new DataTypeDetail();
						BeanUtils.copyProperties(newdetail, dataTypeDetail);
						newdetail.setId(null);
						/**
						 * 设置类型
						 */
						newdetail.setDataType(visaDataTypeService.getById(dataTypeDetail.getDataType().getId()));
						newdetail.setCustomerSet(null);
						newdetail.setVisaProduct(null);
						dataTypeDetailList.add(newdetail);
					}
					visaDataTypeDetailService.saveDataTypeDetailList(new ArrayList<DataTypeDetail>(dataTypeDetailList));
					/**
					 * 批量保存datatypedetail 对象
					 */
					newVisaProduct.setDataTypeDetailSet(dataTypeDetailList);
					newVisaProduct.setCustomerSet(null);
					newVisaProduct.setAttachmentSet(null);
					newVisaProduct.setName("复制 "+newVisaProduct.getName());
					visaProductService.save(newVisaProduct);
					String formatNumber=NumberFormatTools.formatNumber(newVisaProduct.getId().toString(),"0000000");
					newVisaProduct.setSerialNumber(Param.visaProductPre+"-"+formatNumber);
				}
			}
		} catch (Exception e) {
		response.setStatus(500);
		e.printStackTrace();
		throw e;
		}
		return mapping.findForward("toList");
	}
	
	
	
	
	

	/** 添加 */
	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> new User()
		String colsel_country=request.getParameter("info[colsel_country]");
		String colsel_visatype=request.getParameter("info[colsel_visatype]");
//		String colsel_lingqu=request.getParameter("info[colsel_lingqu]");


		String colsel_insurancePackage=request.getParameter("info[colsel_insurancePackage]");
		/**
		 * 如果value的值>0
		 * 证明客户有选择
		 */
		Country country=visaCountryService.getById(Long.valueOf(colsel_country.trim()));
		VisaType visatype=visaTypeService.getById(Long.valueOf(colsel_visatype.trim()));
	
		//保险可谓空
	
		VisaProductActionForm actionForm = (VisaProductActionForm) form;
		VisaProduct visaProduct = new VisaProduct();
		
	
		
		
		// a，拷贝同名属性
		BeanUtils.copyProperties(visaProduct, actionForm);
		visaProduct.setCountry(country);
		visaProduct.setType(visatype);
		if(StringUtils.isNotEmpty(colsel_insurancePackage))
		{
		InsurancePackage insurancePackage=insurancePackageService.getById(Long.valueOf(colsel_insurancePackage.trim()));
		visaProduct.setInsurancePackage(insurancePackage);
		}
		visaProduct.setUpdateTime(NumberFormatTools.getCurrentTime());
		
		
		//icon
		String[] filename=request.getParameterValues("uploads");
		//删掉原来的图片
		
		File delFile=new File(request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/")+visaProduct.getIcon());
		if(delFile.exists())
		{
			delFile.delete();
		}
		
		if(filename!=null&&filename.length>0)
		{
			/**
			 * 取第一个
			 */
			visaProduct.setIcon("/"+Param.upload_filepath+Param.product+filename[0]);
		}
		else
		{
			visaProduct.setIcon(actionForm.getIcon());
		}
		
		//icon
		
		String[] lingqu_arr=request.getParameterValues("info[colsel_lingqu]");
		//新增领区可能有一个或者多个
		if(lingqu_arr!=null&&lingqu_arr.length>0)
		{
				List<VisaProduct> list=new ArrayList<VisaProduct>(lingqu_arr.length);
				for(int i=0;i<lingqu_arr.length;i++)
				{
					VisaProduct vp=new VisaProduct();
					BeanUtils.copyProperties(vp,visaProduct);
					Lingqu lingqu=visaLingquService.getById(Long.valueOf(lingqu_arr[i].trim()));
					vp.setLingqu(lingqu);
					list.add(vp);
				}
			//循环保存
			for(VisaProduct product:list)
			{
				visaProductService.save(product);
			}
			
		}
	
		
	
		// 3, return
		return mapping.findForward("toList");
	}

	/** 修改页面 */
	public ActionForward editUI(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 3，ActionForm
		VisaProductActionForm actionForm = (VisaProductActionForm) form;
		VisaProduct visaProduct = visaProductService.getById(actionForm.getId());
		// a，拷贝同名属性
	
		BeanUtils.copyProperties(actionForm, visaProduct);
		request.setAttribute("id", visaProduct.getId());
		request.setAttribute("countryId",visaProduct.getCountry().getId());
		request.setAttribute("countryName",visaProduct.getCountry().getName());
		request.setAttribute("lingquId",visaProduct.getLingqu().getId());
		request.setAttribute("lingquName",visaProduct.getLingqu().getName());
		request.setAttribute("visaTypeId", visaProduct.getType().getId());
		request.setAttribute("visaTypeName", visaProduct.getType().getName());
		request.setAttribute("insurancePackageId", visaProduct.getInsurancePackage()==null?-1:visaProduct.getInsurancePackage().getId());
		request.setAttribute("insurancePackageName",  visaProduct.getInsurancePackage()==null?"请选择保险":visaProduct.getInsurancePackage().getName());
//		List<Lingqu> lingquList=visaLingquService.findAll();
//		request.setAttribute("lingquList", lingquList);
		return mapping.findForward("editUI");
	}

	/** 修改 */
	public ActionForward bookFeeEditContinue(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaProductActionForm actionForm = (VisaProductActionForm) form;
		VisaProduct visaProduct =visaProductService.getById(actionForm.getId());
		// a，拷贝同名属性
		visaProduct.setBookFee(actionForm.getBookFee());
		visaProduct.setBookFee1(actionForm.getBookFee1());
		visaProduct.setBookFee2(actionForm.getBookFee2());
		visaProduct.setVisaFee(actionForm.getVisaFee());
		visaProduct.setVisaFee1(actionForm.getVisaFee1());
		visaProduct.setVisaFee2(actionForm.getVisaFee2());
		visaProductService.update(visaProduct);
		request.setAttribute("id", visaProduct.getId());
		// 3, return							 
		return mapping.findForward("bookingFeeEditUI");
	}
	/** 修改 */
	public ActionForward bookFeeEdit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaProductActionForm actionForm = (VisaProductActionForm) form;
		VisaProduct visaProduct =visaProductService.getById(actionForm.getId());
		// a，拷贝同名属性
		visaProduct.setBookFee(actionForm.getBookFee());
		visaProduct.setBookFee1(actionForm.getBookFee1());
		visaProduct.setBookFee2(actionForm.getBookFee2());
		visaProduct.setVisaFee(actionForm.getVisaFee());
		visaProduct.setVisaFee1(actionForm.getVisaFee1());
		visaProduct.setVisaFee2(actionForm.getVisaFee2());
		visaProductService.update(visaProduct);
		// 3, return							 
		return mapping.findForward("toBookingFeeList");
	}
	/** 修改 */
	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaProductActionForm actionForm = (VisaProductActionForm) form;
		VisaProduct visaProduct =visaProductService.getById(actionForm.getId());
		
		// a，拷贝同名属性
		BeanUtils.copyProperties(visaProduct, actionForm);
		String colsel_country=request.getParameter("info[colsel_country]");
		String colsel_visatype=request.getParameter("info[colsel_visatype]");
		String colsel_lingqu=request.getParameter("info[colsel_lingqu]");
		String[] cc=request.getParameterValues("info[colsel_lingqu]");
		System.out.println(cc);
		String colsel_insurancePackage=request.getParameter("info[colsel_insurancePackage]");
		/**
		 * 如果value的值>0
		 * 证明客户有选择
		 */
		Country country=visaCountryService.getById(Long.valueOf(colsel_country.trim()));
		VisaType visatype=visaTypeService.getById(Long.valueOf(colsel_visatype.trim()));
		Lingqu lingqu=visaLingquService.getById(Long.valueOf(colsel_lingqu.trim()));
		visaProduct.setCountry(country);
		visaProduct.setType(visatype);
		visaProduct.setLingqu(lingqu);
		if(StringUtils.isNotEmpty(colsel_insurancePackage))
		{
		InsurancePackage insurancePackage=insurancePackageService.getById(Long.valueOf(colsel_insurancePackage.trim()));
		visaProduct.setInsurancePackage(insurancePackage);
		}
		visaProduct.setUpdateTime(NumberFormatTools.getCurrentTime());
		// 2, service.update()
		
		
		
		//icon
		String[] filename=request.getParameterValues("uploads");
		//删掉原来的图片
		
		File delFile=new File(request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/")+visaProduct.getIcon());
		if(delFile.exists())
		{
			delFile.delete();
		}
		
		if(filename!=null&&filename.length>0)
		{
			/**
			 * 取第一个
			 */
			visaProduct.setIcon("/"+Param.upload_filepath+Param.product+filename[0]);
		}
		else
		{
			visaProduct.setIcon(actionForm.getIcon());
		}
		
		visaProductService.update(visaProduct);
		
		// 3, return
		return mapping.findForward("toList");
	}

	/** 保存并继续*/
	public ActionForward saveAndGoOn(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1, actionForm --> getById()
		VisaProductActionForm actionForm = (VisaProductActionForm) form;
		VisaProduct visaProduct =visaProductService.getById(actionForm.getId());
		/**
		 * 2中情况,1visaProduct 为 null,证明是新增2 visaProduct 不为null是保存
		 */
		// a，拷贝同名属性
		if(visaProduct==null)
		{
			visaProduct=new VisaProduct();
		}
		
		BeanUtils.copyProperties(visaProduct, actionForm);
		String colsel_country=request.getParameter("info[colsel_country]");
		String colsel_visatype=request.getParameter("info[colsel_visatype]");
		String colsel_lingqu=request.getParameter("info[colsel_lingqu]");
		String colsel_insurancePackage=request.getParameter("info[colsel_insurancePackage]");
		/**
		 * 如果value的值>0
		 * 证明客户有选择
		 */
		Country country=visaCountryService.getById(Long.valueOf(colsel_country.trim()));
		VisaType visatype=visaTypeService.getById(Long.valueOf(colsel_visatype.trim()));

		InsurancePackage insurancePackage=insurancePackageService.getById(Long.valueOf(colsel_insurancePackage.trim()));
		visaProduct.setCountry(country);
		visaProduct.setType(visatype);
		visaProduct.setInsurancePackage(insurancePackage);
		// 2, service.update()
		visaProduct.setUpdateTime(NumberFormatTools.getCurrentTime());
		
	
		Lingqu lingqu=visaLingquService.getById(Long.valueOf(colsel_lingqu.trim()));
		visaProduct.setLingqu(lingqu);
		visaProductService.save(visaProduct);
		//		String formatNumber=NumberFormatTools.formatNumber(visaProduct.getId().toString(),"0000000");
//		visaProduct.setSerialNumber(Param.visaProductPre+"-"+formatNumber);
		
		//icon
		String[] filename=request.getParameterValues("uploads");
		//删掉原来的图片
		
		File delFile=new File(request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/")+visaProduct.getIcon());
		if(delFile.exists())
		{
			delFile.delete();
		}
		
		if(filename!=null&&filename.length>0)
		{
			/**
			 * 取第一个
			 */
			visaProduct.setIcon("/"+Param.upload_filepath+Param.product+filename[0]);
		}
		else
		{
			visaProduct.setIcon(actionForm.getIcon());
		}
		
		
		

		/**
		 * 设置所有的数据
		 */
		request.setAttribute("id", visaProduct.getId());
		request.setAttribute("countryId",visaProduct.getCountry().getId());
		request.setAttribute("countryName",visaProduct.getCountry().getName());
		request.setAttribute("lingquId",visaProduct.getLingqu().getId());
		request.setAttribute("lingquName",visaProduct.getLingqu().getName());
		request.setAttribute("visaTypeId", visaProduct.getType().getId());
		request.setAttribute("visaTypeName", visaProduct.getType().getName());
		request.setAttribute("insurancePackageId", visaProduct.getInsurancePackage()==null?-1:visaProduct.getInsurancePackage().getId());
		request.setAttribute("insurancePackageName",  visaProduct.getInsurancePackage()==null?"保险套餐":visaProduct.getInsurancePackage().getName());
		
		// 3, return
		return mapping.findForward("editUI");
	}
	
	
	public ActionForward exportPDF(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String ids = request.getParameter("id");
		String occuId = request.getParameter("occuId");
		if(StringUtils.isEmpty(occuId))
		{
			/**
			 * 默认为在职人员
			 */
			occuId="1";
		}
		VisaProduct product = new VisaProduct();
		if (StringUtils.isNotEmpty(ids)) {
			String[] array = ids.split(",");
			Long[] idArr = new Long[array.length];
			for (int i = 0; i < array.length; i++) {
				idArr[i] = Long.valueOf(array[i].toString());
			}
			if(idArr.length>0)
			{
				 product = visaProductService.getById(idArr[0]);
			}
		
		}
		
		/**
		 * 将与产品关联的所有资料进行分组
		 */
		Map<String, Set<DataType>> dataTypeMaps=new LinkedHashMap<String, Set<DataType>>();
		List<DataTypeDetail> dataTypeDetailList=new LinkedList<DataTypeDetail>();
		Set<DataType> dataTypeSet=null;
		for(int i=1;i<6;i++)
		{
		dataTypeSet=new LinkedHashSet<DataType>();
		dataTypeSet.clear();
		for(DataTypeDetail dataTypeDetail:product.getDataTypeDetailSet())
		{
			if(dataTypeDetail.getType().equals(String.valueOf(i)))
			{
		 	 dataTypeSet.add(dataTypeDetail.getDataType());
		 	 dataTypeDetailList.add( dataTypeDetail);
			}
		}
		dataTypeMaps.put(i+"", dataTypeSet);
		}
		//排序
		request.setAttribute("occuMap", Param.getOccuType());
		//反射product 对象
		
		//当前product vo的状态为持久化状态
		VisaProduct  tempVisaProduct=new VisaProduct();
		BeanUtils.copyProperties(tempVisaProduct, product);
		
		
		
		/**************************************************************************************************/
		//将所有\r\n 替换为<br/>
		tempVisaProduct.setLingquDivide(StringHelper.replace(product.getLingquDivide()));
		tempVisaProduct.setWebSiteLink(StringHelper.replace(product.getWebSiteLink()));
		tempVisaProduct.setBookingInformationNeeds(StringHelper.replace(product.getBookingInformationNeeds()));
		tempVisaProduct.setConsularAndVisaCenterAddress(StringHelper.replace(product.getConsularAndVisaCenterAddress()));
		tempVisaProduct.setHowToQueryVisaInfo(StringHelper.replace(product.getHowToQueryVisaInfo()));
		tempVisaProduct.setGetVisaInfo(StringHelper.replace(product.getGetVisaInfo()));
		tempVisaProduct.setVisaMaterials(StringHelper.replace(product.getVisaMaterials()));
		tempVisaProduct.setSubmitApplicationAndInterview(StringHelper.replace(product.getSubmitApplicationAndInterview()));
		tempVisaProduct.setVisaRemarks(StringHelper.replace(product.getVisaRemarks()));
		tempVisaProduct.setDisclaimer(StringHelper.replace(product.getDisclaimer()));
		
		/**************************************************************************************************/
		
		request.setAttribute("occuId",occuId);
		request.setAttribute("product", tempVisaProduct);
		request.setAttribute("dataTypeMaps", dataTypeMaps);
		request.setAttribute("dataTypeDetailList", dataTypeDetailList);
		String showId = request.getParameter("showId");
		if(showId.equals("1"))
		{
			return mapping.findForward("exportPDF1");
		}
		else if(showId.equals("2"))
		{
			return mapping.findForward("exportPDF2");
		}
		else if(showId.equals("3"))
		{
			return mapping.findForward("exportPDF3");
		}
		else if(showId.equals("4"))
		{
			return mapping.findForward("exportPDF4");
		}
		return null;
	}
}