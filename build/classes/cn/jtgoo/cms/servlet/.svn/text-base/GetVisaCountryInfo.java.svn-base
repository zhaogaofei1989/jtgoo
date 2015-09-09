package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.service.VisaCountryService;
import cn.jtgoo.cms.util.BeanFactory;

public class GetVisaCountryInfo extends HttpServlet {

	private VisaCountryService visaCountryService = BeanFactory
	.getImpl(VisaCountryService.class);
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
	    List<Country> topCountryList=visaCountryService.findTopLevel();
		buffer.append("{\"Items\":[");
		for (Country country : topCountryList) {
			buffer.append("{ \"name\": \"" + country.getName());
			buffer.append("\", \"topid\": \"0" );
			buffer.append("\", \"colid\": \"" + country.getId());
			buffer.append("\", \"value\": \"" + country.getId());
			buffer.append("\", \"fun\" : \"function(){}"+"\"} ,");
			for(Country children:country.getCoutryChild())
			{
					buffer.append("{ \"name\": \"" + children.getName());
					buffer.append("\", \"topid\": \""+children.getParent().getId() );
					buffer.append("\", \"colid\": \"" + children.getId());
					buffer.append("\", \"value\": \"" + children.getId());
					buffer.append("\", \"fun\" : \"function(){}"+"\"} ,");
				
			}
		}

		buffer.toString().subSequence(0, buffer.length() - 1);
		buffer.delete(buffer.length() - 1, buffer.length());
		buffer.append("]}");
		out.print(buffer.toString());
		System.out.println(buffer.toString());
		out.flush();
		out.close();
	}
}
