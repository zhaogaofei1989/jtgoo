package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jtgoo.cms.domain.InsurancePackage;
import cn.jtgoo.cms.service.InsurancePackageService;
import cn.jtgoo.cms.util.BeanFactory;
@SuppressWarnings("serial")
public class GetInsurancePackageInfo extends HttpServlet {
private  InsurancePackageService inps= BeanFactory.getImpl(InsurancePackageService.class);
	 
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
		response.setContentType("text/json; charset=utf-8");
		PrintWriter out = response.getWriter();
	    StringBuffer buffer=new StringBuffer();
	     
	    List<InsurancePackage> visaInsurancePackageList=inps.findAll();
		buffer.append("{\"Items\":[");
		for (InsurancePackage insurancePackage : visaInsurancePackageList) {
			buffer.append("{ \"name\": \"" + insurancePackage.getName());
			buffer.append("\", \"topid\": \"0" );
			buffer.append("\", \"colid\": \"" + insurancePackage.getId());
			buffer.append("\", \"value\": \"" + insurancePackage.getId());
			buffer.append("\", \"fun\" : \"function(){}"+"\"} ,");
		}
		buffer.toString().subSequence(0, buffer.length() - 1);
		buffer.delete(buffer.length() - 1, buffer.length());
		buffer.append("]}");
		System.out.println(buffer);
		out.print(buffer.toString());
		out.flush();
	    out.close();
	}
}
