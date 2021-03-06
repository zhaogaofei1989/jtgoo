package cn.jtgoo.cms.base;
 
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.actions.DispatchAction;

import cn.jtgoo.cms.service.AttachmentService;
import cn.jtgoo.cms.service.BaoXianAttachmentService;
import cn.jtgoo.cms.service.CustomerService;
import cn.jtgoo.cms.service.CustomerServicersService;
import cn.jtgoo.cms.service.DepartmentService;
import cn.jtgoo.cms.service.InsurancePackageService;
import cn.jtgoo.cms.service.InsuranceTypeService;
import cn.jtgoo.cms.service.MemberService;
import cn.jtgoo.cms.service.PeerGroupService;
import cn.jtgoo.cms.service.ReserveOrderService;
import cn.jtgoo.cms.service.ResourceService;
import cn.jtgoo.cms.service.RoleService;
import cn.jtgoo.cms.service.UserService;
import cn.jtgoo.cms.service.VisaCountryService;
import cn.jtgoo.cms.service.VisaDataTypeDetailService;
import cn.jtgoo.cms.service.VisaDataTypeService;
import cn.jtgoo.cms.service.VisaLingquService;
import cn.jtgoo.cms.service.VisaOrderService;
import cn.jtgoo.cms.service.VisaProductService;
import cn.jtgoo.cms.service.VisaTypeService;
import cn.jtgoo.cms.util.BeanFactory;

public class BaseAction extends DispatchAction{

	protected UserService userService = BeanFactory.getImpl(UserService.class);
	protected RoleService roleService = BeanFactory.getImpl(RoleService.class);
	protected DepartmentService departmentService = BeanFactory.getImpl(DepartmentService.class);
	protected ResourceService resourceService = BeanFactory.getImpl(ResourceService.class);
	protected CustomerService customerService = BeanFactory.getImpl(CustomerService.class);
	protected VisaLingquService visaLingquService = BeanFactory.getImpl(VisaLingquService.class);
	protected VisaDataTypeService visaDataTypeService = BeanFactory.getImpl(VisaDataTypeService.class);
	protected VisaDataTypeDetailService visaDataTypeDetailService = BeanFactory.getImpl(VisaDataTypeDetailService.class);
	protected VisaTypeService visaTypeService = BeanFactory.getImpl(VisaTypeService.class);
	protected VisaCountryService visaCountryService = BeanFactory.getImpl(VisaCountryService.class);
	protected VisaOrderService visaOrderService = BeanFactory.getImpl(VisaOrderService.class);
	protected VisaProductService visaProductService = BeanFactory.getImpl(VisaProductService.class);
	protected AttachmentService attachmentService = BeanFactory.getImpl(AttachmentService.class);
	protected BaoXianAttachmentService baoXianattachmentService = BeanFactory.getImpl(BaoXianAttachmentService.class);
	protected PeerGroupService peerGroupService = BeanFactory.getImpl(PeerGroupService.class);
	protected CustomerServicersService customerServicers = BeanFactory.getImpl(CustomerServicersService.class);
	protected ReserveOrderService reserveOrderService = BeanFactory.getImpl(ReserveOrderService.class);
	protected InsurancePackageService insurancePackageService = BeanFactory.getImpl(InsurancePackageService.class);
	protected InsuranceTypeService insuranceTypeService = BeanFactory.getImpl(InsuranceTypeService.class);
	protected MemberService memberService = BeanFactory.getImpl(MemberService.class);
	/**  
	 * 获取当前要查看的页码，默认为1
	 * 
	 * @param request
	 * @return
	 */
	protected int getPageNum(HttpServletRequest request) {
		try {
			return Integer.parseInt(request.getParameter("pageNum"));
		} catch (NumberFormatException e) {
			return 1;
		}
	}
	
	
	/**  
	 * 获取当前要查看的页码，默认为10
	 * 
	 * @param request
	 * @return
	 */
	protected int getPageSize(HttpServletRequest request) {
		try {
			return Integer.parseInt(request.getParameter("pageSize"));
		} catch (NumberFormatException e) {
			return 10;
		}
	}
}
