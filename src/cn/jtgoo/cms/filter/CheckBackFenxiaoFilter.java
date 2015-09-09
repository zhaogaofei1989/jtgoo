package cn.jtgoo.cms.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import cn.jtgoo.cms.domain.Customer;
import cn.jtgoo.cms.util.PrivilegeUtils;
public class CheckBackFenxiaoFilter implements Filter {
	public void destroy() {
	}
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		Customer customer = (Customer) req.getSession().getAttribute("customer"); // 当前登录用户
		/**
		 * 分销系统没有权限区分
		 */
		String url = req.getRequestURI();
		String method = req.getParameter("method"); // add, addUI, <null>
		if (method != null) {
			url = url + "?method=" + method;
		}
		url = PrivilegeUtils.getPrivilegeUrl(url, req); // 处理一下这个URL，获取正确格式的资源URL
		if(url.indexOf("fenxiao")>-1)
		{
		// 1，如果没有登录
		if (customer == null) {
			// 如果正在登录，就放行fenxiao/PeerUserAction
			System.out.println(url.equals("/fenxiao/PeerUserAction.do?method=addRegisterInfo"));
			if (url.startsWith("/fenxiao/PeerUserAction.do?method=login")) { // login, loginUI
				chain.doFilter(request, response);
			}
			else if (url.startsWith("/fenxiao/PeerUserAction.do?method=addRegisterInfo")) { // login, loginUI
				chain.doFilter(request, response);
				System.out.println("22");
			}
			
			// 如果不是使用登录，就转到登录页面
		else {
				request.getRequestDispatcher(
						"/fenxiao/PeerUserAction.do?method=loginUI").forward(request,
						response);
			}
		}
		else {
			//转发属性
			forwordAttr(request);
			chain.doFilter(request, response);
		}
	
		} 
		else {
			chain.doFilter(request, response);
		}
	}

	/**转发 展示的treeid
	 * @param request
	 */
	private void forwordAttr(ServletRequest request) {
		String tree=request.getParameter("showTree");
		if(null!=tree&&!tree.equals(""))
		{
			HttpServletRequest  httpRequest=(HttpServletRequest) request;
			httpRequest.getSession().setAttribute("showTree", tree);
		}
	}
	public void init(FilterConfig filterConfig) throws ServletException {

	}
}
