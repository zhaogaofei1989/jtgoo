package cn.jtgoo.cms.util;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.Transaction;

import cn.jtgoo.cms.domain.Resource;
import cn.jtgoo.cms.domain.User;

public class PrivilegeUtils {

	/**
	 * 所有需要控制的URL列表
	 */
	private static List<String> allPrivilegeUrlList; //   
	private static List<String> allPrivilegeTagList; //   

	static {
		// 初始化时加载所有的权限URL
		Session session = HibernateUtils.openSession();
		Transaction tx = session.beginTransaction();
		//url 列表
		allPrivilegeUrlList = session.createQuery("SELECT r.url FROM Resource r WHERE r.url IS NOT NULL").list();
		//id 列表
		allPrivilegeTagList = session.createQuery("SELECT r.tag FROM Resource r WHERE r.url IS NOT NULL").list();
		tx.commit();
		HibernateUtils.closeCurrentSession();
	}

	/**
	 * 把一个完整的URL变成判断权限所用的URL的格式并返回
	 * 
	 * @param url
	 * @param request
	 * @return
	 */
	public static String getPrivilegeUrl(String url, HttpServletRequest request) {
		// 1，去掉前面的contextPath
		String contextPath = request.getContextPath();
		url = url.substring(contextPath.length());

		// 2，去掉配置的action属性（URL）后的多余参数
		if (url.indexOf("&") != -1) {
			url = url.substring(0, url.indexOf("&"));
		}

		// 3，如果有UI，则去掉
		if (url.endsWith("UI")) {
			url = url.substring(0, url.length() - 2);
		}

		// 4，如果有多个连着的'/'，就替换为一个
		url = url.replaceAll("//+", "/");
		
		return url;
	}

	public static boolean hasButtonPrivilege(User user, Set<Resource> userPrivilegeList, String property) {
		if (!allPrivilegeTagList.contains(property.trim())) {
			return true;
		}
		// 3，超级管理员有所有的权限
		if ("admin".equals(user.getLoginName())) {
			return true;
		}
		// 4，普通用户，得判断一下
		for (Resource resource : userPrivilegeList) {
			if (property.trim().equals(resource.getTag().toString()) ) {
				if(resource.getChildren()==null||resource.getChildren().size()==0)
				{
					resource.setChildren(null);
				}
				return true;
			}
		}
		return false;

	}
	
	/**
	 * 判断指定用户是否有指定URL的访问权限
	 * 
	 * @param user
	 * @param userPrivilegeList
	 * @param url
	 * @return
	 */
	public static boolean hasPrivilege(User user, Set<Resource> userPrivilegeList, String url) {
		// 1，未登录用户，只可以使用登录功能，返回false
		if (user == null) {
			if (url.startsWith("/background/UserAction.do?method=login")) { // login, loginUI
				return true;
			} else {
				return false;
			}
		}

		// 2，登录用户，如果当前url不是需要控制的权限，即只需登录即可使用，就返回tree
		if (!allPrivilegeUrlList.contains(url)) {
			return true;
		}

		// 3，超级管理员有所有的权限
		if ("admin".equals(user.getLoginName())) {
			return true;
		}

		// 4，普通用户，得判断一下
		for (Resource resource : userPrivilegeList) {
			if (url.equals(resource.getUrl())) {
//				if(resource.getChildren()==null||resource.getChildren().size()==0)
//				{
//					resource.setChildren(null);
//				}
				return true;
			}
		}
		return false;
	}
}
