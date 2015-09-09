package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import cn.jtgoo.cms.domain.VisaProduct;
import cn.jtgoo.cms.service.VisaProductService;
import cn.jtgoo.cms.util.BeanFactory;

/**
 * @author alex
 *
 */
@SuppressWarnings("serial")
public class VisaAutoComplete extends HttpServlet {
	final static Logger logger = Logger.getLogger(VisaAutoComplete.class);
	private VisaProductService  visaProductService=BeanFactory.getImpl(VisaProductService.class);
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
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	    StringBuffer buffer=new StringBuffer();
	    logger.info("------------------------------"+request.getMethod());
		String keyword =request.getParameter("q");
	    List<VisaProduct> visaProductList= visaProductService.findByName(keyword);
		buffer.append("{\"obj\":[");
	   for(VisaProduct product:visaProductList)
	   {
			buffer.append("{ \"label\": \" " + product.getName());
			buffer.append("\", \"id\": \" " + product.getId());
			buffer.append("\", \"value\": \" " + product.getName()+" \"} ,");
//			buffer.append("\", \"customer\" : \" "+product.getName()+" \"} ,");
	   }
	    buffer.toString().subSequence(0, buffer.length()-1);
	    buffer.delete(buffer.length()-1, buffer.length());
		buffer.append("]}");
	    out.print(buffer.toString());
	    out.close();
	
	}

}
