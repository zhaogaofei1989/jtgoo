<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <title>岗位列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${pageContext.request.contextPath}/style/images/title_arrow.gif"/> 岗位管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
            	<td width="200px">岗位名称</td>
                <td width="300px">岗位说明</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${roleList}" var="role">
			<tr class="TableDetail1 template">
				<td>${role.name}&nbsp;</td>
				<td>${role.description}&nbsp;</td>
				<td><html:link action="background/RoleAction?method=delete&id=${role.id}" onclick="return confirm('确定要删除一条记录吗？？')">删除</html:link>
					<html:link action="background/RoleAction?method=editUI&id=${role.id}">修改</html:link>
					<html:link action="background/RoleAction?method=setPrivilegeUI&id=${role.id}">设置权限</html:link>
				</td>
			</tr>
		</c:forEach>
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
		    <div id="TableTail">
		        <div id="TableTail_inside">
		        	<input type="button" class="cmd" onclick="createNew('RoleAction.do?method=addUI');" value="新建"/>
		        </div>
		    </div>
</div>
</body>
</html>