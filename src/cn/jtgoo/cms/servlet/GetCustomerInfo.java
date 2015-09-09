package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.service.CustomerService;
import cn.jtgoo.cms.util.BeanFactory;

public class GetCustomerInfo extends HttpServlet {
  
	private CustomerService customerService = BeanFactory
	.getImpl(CustomerService.class);
	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
	    StringBuffer buffer=new StringBuffer();
	    String customerId=request.getParameter("customerId");
	    System.out.println(customerId);
	    Customer customer=customerService.getById(Long.valueOf(customerId.trim()));
	    System.out.println(customer);
	    buffer.toString().subSequence(0, buffer.length()-1);
	    buffer.delete(buffer.length()-1, buffer.length());
	    out.print(buffer.toString());
	    out.close();
	}
}
