package cn.jtgoo.cms.web.struts.fenxiaoaction;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
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
import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerToVisaProduct;
import cn.jtgoo.cms.domain.DataType;
import cn.jtgoo.cms.domain.DataTypeDetail;
import cn.jtgoo.cms.domain.Lingqu;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.domain.VisaType;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;
import cn.jtgoo.cms.util.StringHelper;
public class VisaProductFenXiaoAction extends BaseAction {
	/** 列表 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//七大洲
		List<Country> topCountryList=visaCountryService.findTopLevel();
		//领取
		List<Lingqu> lingquList=visaLingquService.findAllByStatus();
		//签证类型
		List<VisaType> visaTypeList=visaTypeService.findAllByStatus();
		request.setAttribute("topCountryList", topCountryList);
		request.setAttribute("lingquList", lingquList);
		request.setAttribute("visaTypeList", visaTypeList);
		return mapping.findForward("list");
	}
	//预约费用
	public ActionForward paid_order(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		PageBean	pageBean =null;
		HqlHelper hqlHelper = new HqlHelper(VisaProduct.class, "vo");
		User user=(User) request.getSession().getAttribute("user");
		if(user.getLoginName().equals("admin"))
		{
			hqlHelper.addWhereCondition("vo.quotationHasVisaPrice =?","0");
			pageBean= visaProductService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
		}
		else
		{
			user=userService.getById(user.getId());
			List list=new ArrayList();
			Set<Lingqu> lingquSet=user.getLingquSet();
			for(Lingqu lingqu:lingquSet)
			{
				list.add(lingqu.getId());
			}
			hqlHelper.addWhereCondition("vo.lingqu.id in (:alist)", list);
			hqlHelper.addWhereCondition("vo.quotationHasVisaPrice ", "1");
			pageBean = visaProductService.getPageBean(hqlHelper,
					getPageNum(request),getPageSize(request));
		}
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("paid_order");
	}
	
	
	/** 列表 */
	public ActionForward productView(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productId=request.getParameter("productId").trim();
		VisaProduct product=new VisaProduct();
		if(StringUtils.isNotEmpty(productId))
		{
			product=visaProductService.getById(Long.valueOf(productId));
		}
		
		Map<String, Set<DataType>> dataTypeMaps=new LinkedHashMap<String, Set<DataType>>();
		List<DataTypeDetail> dataTypeDetailList=new ArrayList<DataTypeDetail>();
		Set<DataType> dataTypeSet=null;
		for(int i=1;i<6;i++)
		{
		dataTypeSet=new HashSet<DataType>();
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
		
		
		VisaProduct  visaProduct=new VisaProduct();
		BeanUtils.copyProperties(visaProduct, product);
		
		
		
		/**************************************************************************************************/
		//将所有\r\n 替换为<br/>
		visaProduct.setLingquDivide(StringHelper.replace(product.getLingquDivide()));
		visaProduct.setWebSiteLink(StringHelper.replace(product.getWebSiteLink()));
		visaProduct.setBookingInformationNeeds(StringHelper.replace(product.getBookingInformationNeeds()));
		visaProduct.setConsularAndVisaCenterAddress(StringHelper.replace(product.getConsularAndVisaCenterAddress()));
		visaProduct.setHowToQueryVisaInfo(StringHelper.replace(product.getHowToQueryVisaInfo()));
		visaProduct.setGetVisaInfo(StringHelper.replace(product.getGetVisaInfo()));
		visaProduct.setVisaMaterials(StringHelper.replace(product.getVisaMaterials()));
		visaProduct.setSubmitApplicationAndInterview(StringHelper.replace(product.getSubmitApplicationAndInterview()));
		visaProduct.setVisaRemarks(StringHelper.replace(product.getVisaRemarks()));
		visaProduct.setDisclaimer(StringHelper.replace(product.getDisclaimer()));
		
		/**************************************************************************************************/
		
		System.out.println(dataTypeMaps);
		System.out.println(dataTypeSet);
		System.out.println(dataTypeDetailList);
		request.setAttribute("visaProduct", visaProduct);
		request.setAttribute("dataTypeMaps", dataTypeMaps);
		request.setAttribute("dataTypeDetailList", dataTypeDetailList);
		return mapping.findForward("productView");
	}
	
	
	/** 列表 */
	public ActionForward visaProductList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Customer customer = (Customer) request.getSession().getAttribute("customer");
		//七大洲
		List<Country> topCountryList=visaCountryService.findTopLevel();
		//领取
		List<Lingqu> lingquList=visaLingquService.findAllByStatus();
		//签证类型
		List<VisaType> visaTypeList=visaTypeService.findAllByStatus();
		//参数请求
		String countryId=request.getParameter("country_select");
		String lingquId=request.getParameter("lingqu_select");
		String visaTypeId=request.getParameter("visatype_select");
		HqlHelper hqlHelper = new HqlHelper(VisaProduct.class, "vo");
		hqlHelper.addWhereCondition("vo.del_status=?", "0");
		if(StringUtils.isNotEmpty(countryId))
		{
		hqlHelper.addWhereCondition("vo.country.id=?", Long.valueOf(countryId.trim()));
		}
		if(StringUtils.isNotEmpty(lingquId))
		{
		hqlHelper.addWhereCondition("vo.lingqu.id=?", Long.valueOf(lingquId.trim()));
		}
		if(StringUtils.isNotEmpty(visaTypeId))
		{
		hqlHelper.addWhereCondition("vo.type.id=?", Long.valueOf(visaTypeId.trim()));
		}
		PageBean	pageBean = visaProductService.getPageBean(hqlHelper,
				getPageNum(request),getPageSize(request));
		
		request.setAttribute("topCountryList", topCountryList);
		request.setAttribute("lingquList", lingquList);
		request.setAttribute("visaTypeList", visaTypeList);
		
		
		request.setAttribute("countryId", countryId);
		request.setAttribute("lingquId", lingquId);
		request.setAttribute("visaTypeId", visaTypeId);
		
		List<CustomerToVisaProduct> ctvpList = customerService.findAllByCustomerId(customer.getId());
		List<VisaProduct> visaproductList=new ArrayList<VisaProduct>();
		visaproductList.addAll(pageBean.getRecordList());
		for(VisaProduct vp:visaproductList)
		{
			for(CustomerToVisaProduct ctvp:ctvpList)
			{
				if(vp.getId().equals(ctvp.getVisaproductId()))
				{
					vp.setPrice(ctvp.getPrice());
					continue;
				}
			}
		}
		request.setAttribute("ctvpList", ctvpList);
		
		
		request.setAttribute("pageBean", pageBean);
		return mapping.findForward("visaProductList");
	}

}