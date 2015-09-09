<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <title>部门列表</title>
	<%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
</head>
<body>
 
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${pageContext.request.contextPath}/style/images/title_arrow.gif"/> 部门管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align=center valign=middle id=TableTitle>
            	<td width="150px">部门名称</td>
				<td width="150px">上级部门名称</td>
				<td width="200px">职能说明</td>
				<td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${departmentList}" var="department">
			<tr class="TableDetail1 template">
				<td><html:link action="background/DepartmentAction?method=list&parentId=${department.id}"> <label style="font-weight:bolder;">${department.name}</label></html:link>&nbsp;</td>
				<td>${department.parent.name}&nbsp;</td>
				<td>${department.description}&nbsp;</td>
				<td>
				    <html:link action="background/DepartmentAction?method=delete&id=${department.id}&parentId=${department.parent.id}" onclick="return window.confirm('这将删除所有的下级部门，您确定要删除吗？')">删除</html:link>
					<html:link action="background/DepartmentAction?method=editUI&id=${department.id}">修改</html:link>
				</td>
			</tr>
		</c:forEach>	
			
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
            	<input type="button" class="cmd" onclick="createNew('DepartmentAction.do?method=addUI&parentId=${parent.id}');" value="新建"/>
            <!-- 返回上一级 -->
            <c:if test="${parent ne null}">
            
            	<input type="button" class="cmd" onclick="createNew('DepartmentAction.do?method=list&parentId=${parent.parent.id}');" value="返回上一级"/>
            </c:if>
        </div>
    </div> 
</div>

<!--说明-->	
<div id="Description"> 
	说明：<br />
	1，列表页面只显示一层的（同级的）部门数据，默认显示最顶级的部门列表。<br />
	2，点击部门名称，可以查看此部门相应的下级部门列表。<br />
	3，删除部门时，同时删除此部门的所有下级部门。
</div>

</body>
</html>
