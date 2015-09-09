package org.apache.struts.taglib.html;


import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import cn.jtgoo.cms.domain.Resource;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.util.PrivilegeUtils;


/**
 * 这个自定义标签作用是：对需要鉴权的按钮或链接进行鉴权
 * @author zhaogaofei 
 * @version 1.0.0 18 Mar 2012
 */
public class IAMPIdentifyTag extends BodyTagSupport {
    /**
     * 序列号
     */
    private static final long serialVersionUID = 1L;

    /**
     * 用于日志输出
     */

    /**
     * 标签需要的参数，权限点
     */
    private String authid;

    /**执行该类时，会执行该方法
     * 返回值:
     * EVAL_BODY_INCLUDE 表示会包含标签体中的内容
     * SKIP_BODY         表示不会包含标签体中的内容
     */
    public int doStartTag() throws JspException {
        // 获取到传进来的权限点
        // 判断当前用户是否有该权限点
        // 从session中获取拉拉的接口对象
        // 然后把权限点放入接口对象中
        // 根据接口对象返回的boolean值，就可以判断，该用户是否有看该权限点的权限。
    	User user = (User) pageContext.getSession().getAttribute("user");
		Set<Resource> userPrivilegeList = (Set<Resource>) pageContext.getSession().getAttribute("menuList");

		if (PrivilegeUtils.hasButtonPrivilege(user, userPrivilegeList, authid)) {
			return EVAL_BODY_INCLUDE; 
		}
        // 没有权限，就不显示包含的内容
        return SKIP_BODY;
    }

    public String getAuthid() {
        return authid;
    }

    public void setAuthid(String authid) {
        this.authid = authid;
    }

}
