<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body>
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 会员用户
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<div id="MainArea">
    <table cellspacing="0" cellpadding="0" class="TableStyle">
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
                <!--<td>联系人</td>  -->
                <td>会员用户名</td>
                <td>姓名</td>
                <td>手机号码</td>
                <td>邮箱</td>
                <td>注册时间</td>
                <td>最后登录时间</td>
              <!--  <td>订单数量</td> --> 
                <td>操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        <c:forEach items="${pageBean.recordList}" var="pageBean">
			<tr class="TableDetail1 template">
				<!--  <td>${pageBean.name }</td>-->
				<td>${pageBean.userName }</td>
				<td>${pageBean.name }</td>
				<td>${pageBean.mobliePhone}</td>
				<td>${pageBean.email}</td>
				<td>${pageBean.regTime }</td>
				<td>${pageBean.regTime}</td>
				<!--  <td>${pageBean}</td>-->
				<td>
					<!--<html:link action="background/MemberAction?method=editUI&id=${pageBean.id}">修改</html:link>-->
					<html:link action="background/MemberAction?method=delete&id=${pageBean.id}">删除</html:link>
				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
          <!--   	<input type="button" class="cmd" onclick="createNew('MemberAction.do?method=addUI&parentId=${parent.id}');" value="新建"/>  -->
        </div>
    </div>
</div>

<div class="Description">
	说明：<br />

</div>

</body>
</html>
