package cn.jtgoo.cms.filter;

import java.io.IOException;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jtgoo.cms.domain.Resource;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.util.PrivilegeUtils;

public class CheckBackGroundFilter implements Filter {

	public void destroy() {
	}   

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		req.setAttribute("decorator", "none");
		resp.setHeader("Cache-Control","no-cache"); //HTTP 1.1
		resp.setHeader("Pragma","no-cache"); //HTTP 1.0
		resp.setDateHeader ("Expires", 0); //prevents caching at the proxy server
		User user = (User) req.getSession().getAttribute("user"); // 当前登录用户
		// 获取当前访问的URL，当前登录用户
		String url = req.getRequestURI(); // "/ItcastOA/UserAction.do"
		String method = req.getParameter("method"); // add, addUI, <null>
		if (method != null) {
			url = url + "?method=" + method;
		}
		url = PrivilegeUtils.getPrivilegeUrl(url, req); // 处理一下这个URL，获取正确格式的资源URL

		
							// 1，如果没有登录
							if (user == null) {
								// 如果正在登录，就放行
								if (url.startsWith("/background/UserAction.do?method=login")) { // login, loginUI
									chain.doFilter(request, response);
								}
								//特殊处理，该url 在火狐浏览器中 会出现验证异常，因此临时在url 放行
								else if (url.startsWith("/background/UploadFileServlet.do")) { // login, loginUI
									chain.doFilter(request, response);
								}
								// 如果不是使用登录，就转到登录页面
								else {
									request.getRequestDispatcher("/background/UserAction.do?method=loginUI").forward(request, response);
								}
							}
							// 2，如果已登录
							else {
								// 如果有权限，就放行
								Set<Resource> userPrivilegeList = (Set<Resource>) req.getSession().getAttribute("menuList");
								if (PrivilegeUtils.hasPrivilege(user, userPrivilegeList, url)) {
									// 放行
									chain.doFilter(request, response);
								} else {
									// 如果没权限，就提示没有权限
									resp.sendRedirect(req.getContextPath() + "/noPrivilege.jsp");
								}
							}
		
	}
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
}
