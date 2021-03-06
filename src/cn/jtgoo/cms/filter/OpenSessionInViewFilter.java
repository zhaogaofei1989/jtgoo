package cn.jtgoo.cms.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.hibernate.Session;

import cn.jtgoo.cms.util.HibernateUtils;

public class OpenSessionInViewFilter implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// // 方案一：前面打开，后面关闭
		// Session session = HibernateUtils.getCurrentSession();
		// Transaction tx = null;
		// try {
		// tx = session.beginTransaction(); // 开始事务
		// chain.doFilter(request, response); // ActionServlet --> Action --> Service
		// tx.commit(); // 提交事务
		// } catch (Exception e) {
		// tx.rollback(); // 回滚事务
		// throw new RuntimeException(e);
		// } finally {
		// HibernateUtils.closeCurrentSession();
		// }

		// ===========================================

		// 方案二：在第一次做数据库操作时打开，在这里只做关闭的操作（如果打开了）
		try {
			chain.doFilter(request, response); // ActionServlet --> Action --> Service

			// 前面使用Session，才需要提交事务
			Session session = HibernateUtils.getCurrentSession();
			if (session != null) {
				session.getTransaction().commit(); // 提交事务
			}
		} catch (Exception e) {
			Session session = HibernateUtils.getCurrentSession();
			if (session.getTransaction() != null) {
				session.getTransaction().rollback(); // 回滚事务
			}
			throw new RuntimeException(e);
		} finally {
			Session session = HibernateUtils.getCurrentSession();
			if (session != null) {
				HibernateUtils.closeCurrentSession();
			}
		}
	}
	public void init(FilterConfig filterConfig) throws ServletException {
	}

}
