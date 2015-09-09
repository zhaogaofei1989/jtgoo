package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jtgoo.cms.domain.CustomerServicersVo;
import cn.jtgoo.cms.service.CustomerServicersService;
import cn.jtgoo.cms.util.BeanFactory;
/**
 * 客服查询
 * @author alex
 *
 */
@SuppressWarnings("serial")
public class CustomerServicersAutoComplete extends HttpServlet {
	private CustomerServicersService customerServicers = BeanFactory
			.getImpl(CustomerServicersService.class);
	

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		String keyword = new String(request.getParameter("q").getBytes("iso-8859-1"),"UTF-8");
		/**
		 * 查询用户信息
		 *拼接成json 数组
		 */
		List<CustomerServicersVo> customerList = customerServicers.findAllByName(keyword);
		StringBuffer buffer = new StringBuffer();
		buffer.append("{\"obj\":[");
		for (CustomerServicersVo cs : customerList) {
			buffer.append("{ \"label\": \" " + cs.getName());
			buffer.append("\", \"id\": \" " + cs.getId());
			buffer.append("\", \"value\": \" " + cs.getName());
			buffer.append("\", \"customer\" : \" "+cs.getName()+" \"} ,");
		}
		buffer.toString().subSequence(0, buffer.length() - 1);
		buffer.delete(buffer.length() - 1, buffer.length());
		buffer.append("]}");
		out.print(buffer.toString());
		out.flush();
		out.close();
	}

}
