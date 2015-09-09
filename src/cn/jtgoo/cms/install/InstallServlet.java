package cn.jtgoo.cms.install;
   
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.hibernate.tool.hbm2ddl.SchemaExport;

import cn.jtgoo.cms.cfg.Configuration;
import cn.jtgoo.cms.domain.Resource;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.service.ResourceService;
import cn.jtgoo.cms.service.UserService;
import cn.jtgoo.cms.util.BeanFactory;
import cn.jtgoo.cms.util.JdbcUtils;

public class InstallServlet extends HttpServlet {
   
	private UserService userService = BeanFactory.getImpl(UserService.class);
	private ResourceService resourceService = BeanFactory.getImpl(ResourceService.class);

	/**
	 * 安装，只能执行一次!!
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		boolean installed = Configuration.isInstalled();
		if (installed) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().write("已经执行过安装，不能再次执行！");
			return;
		}

		// ============================================================

		// 1，建表
		org.hibernate.cfg.Configuration cfg = new org.hibernate.cfg.Configuration().configure();
		SchemaExport schemaExport = new SchemaExport(cfg);
		// 第一个参数script： print the DDL to the console
		// 第二个参数export： export the script to the database
//		schemaExport.drop(true, true);
//		schemaExport.create(true, true);
	
		
		SAXReader saxReader = new SAXReader();
		saxReader.setEncoding("UTF-8");
		try {
	
		Document document = saxReader.read(InstallServlet.class.getClassLoader().getResourceAsStream("resource.xml"));
		// 解析xml 层级关系
		Element root = document.getRootElement();
		List<Element> level1List = root.elements("level1");
		//
		List<Resource> menu3List=new LinkedList<Resource>();
		for (Element level1 : level1List) {
				//level2
				Resource level1menu= new Resource(level1.attributeValue("name"), null, "", level1.attributeValue("tag"), null);
				resourceService.save(level1menu);
				List<Element> level2List = level1.elements("level2");
				{
					for (Element level2 : level2List)
					{
						
						Resource level2menu= new Resource(level2.attributeValue("name"), level2.attributeValue("url"), null, level2.attributeValue("tag"), level1menu);
						resourceService.save(level2menu);
						List<Element> level3List = level2.elements("level3");
						{
							for (Element level3 : level3List)
							{
								Resource level3menu= new Resource(level3.attributeValue("name"),level3.attributeValue("url"), null, level3.attributeValue("tag"), level2menu);
								resourceService.save(level3menu);
								System.out.println("level"+level3.attributeValue("name")+"--"+level3.attributeValue("url")+"---"+level3.attributeValue("tag"));
							}
						}
						
					}
					
				}
			
			System.out.println("level"+level1.attributeValue("name")+"--"+level1.attributeValue("url")+"---"+level1.attributeValue("tag"));
//			Resource menu1 = new Resource(level1.attributeValue("name"), null, "FUNC20082.gif", null); // 一级菜单

		}
		} catch (Exception e) {
;			e.printStackTrace();
			// TODO: handle exception
		}
//		// 2，创建超级管理员
//		User user = new User();
//		user.setLoginName("admin");
//		user.setName("超级管理员");
//		userService.save(user);
//
//		// 3，创建所有权限资源
//		
//		
//		
//		
//		Resource menu = new Resource("系统管理", null, "", null); // 一级菜单
//		Resource menu1 = new Resource("岗位管理", "/RoleAction.do?method=list", null, menu); // 二级菜单
//		Resource menu2 = new Resource("部门管理", "/DepartmentAction.do?method=list", null, menu); // 二级菜单
//		Resource menu3 = new Resource("后台用户管理", "/UserAction.do?method=list", null, menu); // 二级菜单
//		Resource menu4 = new Resource("同业用户管理", "/CustomerAction.do?method=peerlist", null, menu); // 二级菜单
//		Resource menu5 = new Resource("直接用户管理", "/CustomerAction.do?method=directlist", null, menu); // 二级菜单
//		resourceService.save(menu);
//		resourceService.save(menu1);
//		resourceService.save(menu2);
//		resourceService.save(menu3);
//		resourceService.save(menu4);
//		resourceService.save(menu5);
//
//		resourceService.save(new Resource("岗位列表", "/RoleAction.do?method=list", null, menu1)); // 超链接
//		resourceService.save(new Resource("岗位添加", "/RoleAction.do?method=add", null, menu1)); // 超链接
//		resourceService.save(new Resource("岗位修改", "/RoleAction.do?method=edit", null, menu1)); // 超链接
//		resourceService.save(new Resource("岗位删除", "/RoleAction.do?method=delete", null, menu1)); // 超链接
//
//		resourceService.save(new Resource("部门列表", "/DepartmentAction.do?method=list", null, menu2)); // 超链接
//		resourceService.save(new Resource("部门添加", "/DepartmentAction.do?method=add", null, menu2)); // 超链接
//		resourceService.save(new Resource("部门修改", "/DepartmentAction.do?method=edit", null, menu2)); // 超链接
//		resourceService.save(new Resource("部门删除", "/DepartmentAction.do?method=delete", null, menu2)); // 超链接
//
//		resourceService.save(new Resource("用户列表", "/UserAction.do?method=list", null, menu3)); // 超链接
//		resourceService.save(new Resource("用户添加", "/UserAction.do?method=add", null, menu3)); // 超链接
//		resourceService.save(new Resource("用户修改", "/UserAction.do?method=edit", null, menu3)); // 超链接
//		resourceService.save(new Resource("用户删除", "/UserAction.do?method=delete", null, menu3)); // 超链接
//
//		// ============================================================
//		
//		
//		//签证产品管理模块
//		menu = new Resource("签证中心", null, "", null); // 一级菜单
//		
//		menu1 = new Resource("资料类别设置", "/VisaDataTypeAction.do?method=list", null, menu); // 二级菜单
//		menu2 = new Resource("签证类型设置", "/VisaTypeAction.do?method=list", null, menu); // 二级菜单
//		menu3 = new Resource("签证领区设置", "/VisaLingquAction.do?method=list", null, menu); // 二级菜单
//	    menu4 = new Resource("签证国家设置", "/VisaCountryAction.do?method=list", null, menu); // 二级菜单
//		menu5 = new Resource("签证列表", "/VisaProductAction.do?method=list", null, menu); // 二级菜单
//		
//		resourceService.save(menu);
//		resourceService.save(menu1);
//		resourceService.save(menu2);
//		resourceService.save(menu3);
//		resourceService.save(menu4);
//		resourceService.save(menu5);
//		
//		resourceService.save(new Resource("资料类别设置", "/VisaDataTypeAction.do?method=list", null, menu1)); // 超链接
//		resourceService.save(new Resource("资料类别设置", "/VisaDataTypeAction.do?method=add", null, menu1)); // 超链接
//		resourceService.save(new Resource("资料类别设置", "/VisaDataTypeAction.do?method=edit", null, menu1)); // 超链接
//		resourceService.save(new Resource("资料类别设置", "/VisaDataTypeAction.do?method=delete", null, menu1)); // 超链接
//		resourceService.save(new Resource("签证类型设置", "/VisaTypeAction.do?method=list", null, menu2)); // 超链接
//		resourceService.save(new Resource("签证类型设置", "/VisaTypeAction.do?method=add", null, menu2)); // 超链接
//		resourceService.save(new Resource("签证类型设置", "/VisaTypeAction.do?method=edit", null, menu2)); // 超链接
//		resourceService.save(new Resource("签证类型设置", "/VisaTypeAction.do?method=delete", null, menu2)); // 超链接
//		resourceService.save(new Resource("签证领区列表", "/VisaLingquAction.do?method=list", null, menu3)); // 超链接
//		resourceService.save(new Resource("签证领区添加", "/VisaLingquAction.do?method=add", null, menu3)); // 超链接
//		resourceService.save(new Resource("签证领区修改", "/VisaLingquAction.do?method=edit", null, menu3)); // 超链接
//		resourceService.save(new Resource("签证领区删除", "/VisaLingquAction.do?method=delete", null, menu3)); // 超链接
//		resourceService.save(new Resource("签证国家设置", "/VisaCountryAction.do?method=list", null, menu4)); // 超链接
//		resourceService.save(new Resource("签证国家设置", "/VisaCountryAction.do?method=add", null, menu4)); // 超链接
//		resourceService.save(new Resource("签证国家设置", "/VisaCountryAction.do?method=edit", null, menu4)); // 超链接
//		resourceService.save(new Resource("签证国家设置", "/VisaCountryAction.do?method=delete", null, menu4)); // 超链接
//
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		//签证订单模块
//		menu = new Resource("签证订单管理", null, "FUNC20064.gif", null); // 一级菜单
//	    menu1 = new Resource("签证订单列表", "/VisaOrderAction.do?method=list", null, menu); // 二级菜单
//	    
//
//		resourceService.save(menu);
//		resourceService.save(menu1);
//		
//		
//	    resourceService.save(new Resource("签证列表", "/VisaOrderAction.do?method=list", null, menu1)); // 超链接
//	    resourceService.save(new Resource("签证添加", "/VisaOrderAction.do?method=add", null, menu1)); // 超链接
//	    resourceService.save(new Resource("签证修改", "/VisaOrderAction.do?method=edit", null, menu1)); // 超链接
//		resourceService.save(new Resource("签证删除", "/VisaOrderAction.do?method=delete", null, menu1)); // 超链接
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		// ============================================================
//		//客户信息模块
//		menu = new Resource("客户管理", null, "FUNC20001.gif", null); // 一级菜单
//	    menu1 = new Resource("客户信息列表", "/CustomerAction.do?method=list", null, menu); // 二级菜单
//	    
//
//		resourceService.save(menu);
//		resourceService.save(menu1);
//		
//		
//		
//	    resourceService.save(new Resource("客户列表", "/CustomerAction.do?method=list", null, menu1)); // 超链接
//	    resourceService.save(new Resource("客户添加", "/CustomerAction.do?method=add", null, menu1)); // 超链接
//	    resourceService.save(new Resource("客户修改", "/CustomerAction.do?method=edit", null, menu1)); // 超链接
//		resourceService.save(new Resource("客户删除", "/CustomerAction.do?method=delete", null, menu1)); // 超链接
//		
//		
//		
//
//		// ============================================================
//
//		// 安装后，把 installed 配置设为 true 并更新配置文件
//		Configuration.setInstalled(true);
//		Configuration.store(); // 保存配置
		
		
		
		response.setContentType("text/html; charset=utf-8");
		response.getWriter().write("安装成功!");
	}

}
