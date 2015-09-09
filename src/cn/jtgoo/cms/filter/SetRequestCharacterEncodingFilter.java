package cn.jtgoo.cms.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SetRequestCharacterEncodingFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// This method must be called prior to reading request parameters or reading input using getReader(). 
		request.setCharacterEncoding("utf-8"); // 只对POST方式有效
		request.getParameter("name");
		HttpServletResponse resp = (HttpServletResponse) response;
		resp.setHeader("Pragma","No-cache");   
		resp.setHeader("Cache-Control","no-cache");   
		resp.setDateHeader("Expires", 0);    
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {

	}

}
