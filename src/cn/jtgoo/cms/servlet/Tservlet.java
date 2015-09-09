package cn.jtgoo.cms.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Tservlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws IOException 
	 * @throws ServletException 
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	doPost(request,response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<String> list = new ArrayList<String>();
		list.add("个人材料");
		list.add("公共材料");
		list.add("学生证明");
		list.add("公共材料");
		list.add("公共材料");
		list.add("公共材料");
		list.add("结婚材料");
		list.add("公共材料");
		list.add("公共材料");
		Set<String> set = new HashSet<String>();
		for (String key : list) {
			set.add(key);
		}

		Iterator it = set.iterator();
		while (it.hasNext()) {
			System.out.println(it.next());

		}
		request.setAttribute("list", list);
		request.setAttribute("set", set);
		request.getRequestDispatcher("MyJsp.jsp").forward(request, response);

	}

}
