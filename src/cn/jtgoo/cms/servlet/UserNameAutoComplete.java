package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.json.JsonHierarchicalStreamDriver;

import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.domain.Member;
import cn.jtgoo.cms.jsonconvert.Classes;
import cn.jtgoo.cms.jsonconvert.CustomerJson;
import cn.jtgoo.cms.jsonconvert.CustomerServiceJson;
import cn.jtgoo.cms.service.CustomerService;
import cn.jtgoo.cms.service.CustomerServicersService;
import cn.jtgoo.cms.service.MemberService;
import cn.jtgoo.cms.util.BeanFactory;

@SuppressWarnings("serial")
public class UserNameAutoComplete extends HttpServlet {
	final static Logger logger = Logger.getLogger(UserNameAutoComplete.class);
	private CustomerService customerService = BeanFactory
	.getImpl(CustomerService.class);
	private MemberService memberService = BeanFactory
	.getImpl(MemberService.class);
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");    
		PrintWriter out = response.getWriter();
		Classes obj=new Classes();
		XStream stream = new XStream(new JsonHierarchicalStreamDriver());
		/**
		 * usertype is peer user or director user
		 */
		String userType = request.getParameter("userType");
		/**
		 * input text keyword
		 */
	    logger.info("------------------------------"+request.getMethod());
		String keyword =request.getParameter("q");
	  
		String field = "userName";
		// 同业用户按照 name 进行查询
		// 直接用户按照username
		if (StringUtils.isBlank(userType)) {
			userType = "0";
		}
		/**
		 * 查询用户信息 拼接成json 数组
		 */
		try {
			
	
		if(userType.equals("0"))
		{
 			List<Customer> customerList = customerService.findAllByUserType(
					userType, field, keyword);
		
			List<CustomerJson> customerJsonlist=new ArrayList<CustomerJson>();
			List<CustomerServiceJson> customerServiceJsonlist;
			for (Customer cs : customerList) {
				customerServiceJsonlist=	new ArrayList<CustomerServiceJson>();
				CustomerJson customerJson=new CustomerJson();
				customerJson.setId(cs.getId().toString());
				customerJson.setLabel(cs.getUserName());
				customerJson.setValue(cs.getUserName());
				for(CustomerServicersVo customerServicersVo:cs.getCustomerServicers())
				{
					CustomerServiceJson customerserviceJson=new CustomerServiceJson();
					customerserviceJson.setId(customerServicersVo.getId().toString());
					customerserviceJson.setLabel(customerServicersVo.getName());
					customerserviceJson.setValue(customerServicersVo.getName());
					customerServiceJsonlist.add(customerserviceJson);
				}
				customerJson.setCustomerservices(customerServiceJsonlist);
				customerJsonlist.add(customerJson);
			}
			obj.setCustomers(customerJsonlist);
			stream.processAnnotations(Classes.class);
			
		}
			else if(userType.equals("1"))
		{
				List<Member> memberList = memberService.findAllByUserType("name", keyword);
				List<CustomerJson> customerJsonlist=new ArrayList<CustomerJson>();
				List<CustomerServiceJson> customerServiceJsonlist;
				for (Member cs : memberList) {
					customerServiceJsonlist=	new ArrayList<CustomerServiceJson>();
					CustomerJson customerJson=new CustomerJson();
					customerJson.setId(cs.getId().toString());
					customerJson.setLabel(cs.getName());
					customerJson.setValue(cs.getName());
					for(CustomerServicersVo customerServicersVo:cs.getCustomerServicers())
					{
						CustomerServiceJson customerserviceJson=new CustomerServiceJson();
						customerserviceJson.setId(customerServicersVo.getId().toString());
						customerserviceJson.setLabel(customerServicersVo.getName());
						customerserviceJson.setValue(customerServicersVo.getName());
						customerServiceJsonlist.add(customerserviceJson);
					}
					customerJson.setCustomerservices(customerServiceJsonlist);
					customerJsonlist.add(customerJson);
				}
				obj.setCustomers(customerJsonlist);
				stream.processAnnotations(Classes.class);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.print(stream.toXML(obj));
		out.flush();
		out.close();
	}

}
