package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jtgoo.cms.domain.DataTypeDetail;
import cn.jtgoo.cms.service.VisaDataTypeDetailService;
import cn.jtgoo.cms.util.BeanFactory;

public class GetVisaDataTypeDetailInfo extends HttpServlet {

	private VisaDataTypeDetailService visaDataTypeDetailService = BeanFactory
	.getImpl(VisaDataTypeDetailService.class);
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
	    String pId=request.getParameter("pid");
	    String type=request.getParameter("type");
	    System.out.println(pId);
	    List<DataTypeDetail> visaDataTypeDetailList=visaDataTypeDetailService.getListByPId(Long.valueOf(pId.trim()),type);
	    if(visaDataTypeDetailList!=null&&visaDataTypeDetailList.size()>0)
	    {
			buffer.append("{\"Items\":[");
			for (DataTypeDetail dataTypeDetail : visaDataTypeDetailList) {
				buffer.append("{ \"id\": \"" + dataTypeDetail.getId());
				buffer.append("\", \"title\" : \""+dataTypeDetail.getTitle()+"\"} ,");
			}
			buffer.toString().subSequence(0, buffer.length() - 1);
			buffer.delete(buffer.length() - 1, buffer.length());
			buffer.append("]}");	
	    }
//	    buffer.toString().subSequence(0, buffer.length()-1);
//	    buffer.delete(buffer.length()-1, buffer.length());
	    out.print(buffer.toString());
	    out.close();
	}
}
