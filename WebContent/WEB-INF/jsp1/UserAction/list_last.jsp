<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <title>用户列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head"> 
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${pageContext.request.contextPath}/style/images/title_arrow.gif"/> 用户管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
      <form action="${basePath}background/UserAction.do?method=list" method="post">
   <html:hidden property="pageNum" value="1"/>
	<html:hidden property="pageSize" value="10"/>
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align=center valign=middle id=TableTitle>
                <td width="100">登录名</td>
                <td width="100">姓名</td>
                <td width="100">所属部门</td>
                <td width="200">岗位</td>
                <td>备注</td>
                <td>相关操作</td>
            </tr>
        </thead>
        
        <!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="user">
            <tr class="TableDetail1 template">
                <td>${user.loginName}&nbsp;</td>
                <td>${user.name}&nbsp;</td>
                <td>${user.department.name}&nbsp;</td>
                <td><c:forEach items="${user.roles}" var="role">${role.name}&nbsp;</c:forEach></td>
                <td>${user.description}&nbsp;</td>
                <td><html:link action="background/UserAction?method=delete&id=${user.id}" onclick="return delConfirm()">删除</html:link>
                    <html:link action="background/UserAction?method=editUI&id=${user.id}">修改</html:link>
					<html:link action="background/UserAction?method=initPassword&id=${user.id}" onclick="return window.confirm('您确定要初始化密码吗？')">初始化密码</html:link>
                </td>
            </tr>
        </c:forEach>
        
        </tbody>
    </table>
    </form>
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
 			<input type="button" class="cmd" onclick="createNew('UserAction.do?method=addUI');" value="新建"/>
        </div>
    </div>
</div>
<div class="Description">
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
	说明：<br />

</div>
</body>
</html>

