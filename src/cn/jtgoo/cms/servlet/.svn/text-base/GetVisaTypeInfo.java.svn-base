package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jtgoo.cms.domain.VisaType;
import cn.jtgoo.cms.service.VisaTypeService;
import cn.jtgoo.cms.util.BeanFactory;

@SuppressWarnings("serial")
public class GetVisaTypeInfo extends HttpServlet {

	private VisaTypeService visaTypeService = BeanFactory
	.getImpl(VisaTypeService.class);
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
	    
	    List<VisaType> visaTypeList=visaTypeService.findAll();
		buffer.append("{\"Items\":[");
		for (VisaType visaType : visaTypeList) {
			buffer.append("{ \"name\": \"" + visaType.getName());
			buffer.append("\", \"topid\": \"0" );
			buffer.append("\", \"colid\": \"" + visaType.getId());
			buffer.append("\", \"value\": \"" + visaType.getId());
			buffer.append("\", \"fun\" : \"function(){}"+"\"} ,");
		}
		buffer.toString().subSequence(0, buffer.length() - 1);
		buffer.delete(buffer.length() - 1, buffer.length());
		//   [{"name":'111','child','222'},{"name":'2222'}]
		buffer.append("]}");
		System.out.println(buffer);
		out.print(buffer.toString());
		//{"obj":[{ "label": " 国泰", "value": " 国泰", "customer" : "苏打绿" } ]}
		out.flush();
		out.close();
	}
}
