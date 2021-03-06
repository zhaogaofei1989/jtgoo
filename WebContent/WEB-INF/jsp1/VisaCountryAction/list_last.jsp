<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">  
<style type="text/css">
		tr:hover{background-color: #CEA}
</style>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 签证国家管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<div id="MainArea">
 <form action="${basePath}background/VisaCountryAction.do?method=list" method="post">
   <html:hidden property="pageNum" value="1"/>
	<html:hidden property="pageSize" value="10"/>
    <table cellspacing="0" cellpadding="0" class="TableStyle">
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
                <td>分类名称</td>
                <td>分类描述</td>
                 <td>路径</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${topList}" var="top">
           	<tr class="TableDetail1 template"><td>${top.name}&nbsp;</td>  <td>${country.description}&nbsp;</td>   <td>${top.icon}</td> <td>	<html:link action="background/VisaCountryAction?method=editUI&id=${top.id}">修改</html:link>
           	<html:link action="background/VisaCountryAction?method=delete&id=${top.id}" onclick="return delConfirm()">删除</html:link>
           	</td></tr>
           	 <c:forEach items="${pageBean.recordList}" var="country">
           	<c:if test="${top.id eq country.parent.id }">
           	<tr class="TableDetail1 template">
			   <td>&nbsp;┣${country.name}&nbsp;</td>
				<td>${country.description}&nbsp;</td>
				<td>${country.icon}</td>
				<td>
					<html:link action="background/VisaCountryAction?method=editUI&id=${country.id}&pageNum=${pageBean.currentPage }">修改</html:link>
					<html:link action="background/VisaCountryAction?method=delete&id=${country.id}&pageNum=${pageBean.currentPage }" onclick="return delConfirm()">删除</html:link>
				</td>
			</tr>
           	</c:if>
					</c:forEach>
		</c:forEach>	
		
        </tbody>
    </table>
    </form>
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
               <input type="button" class="cmd" onclick="createNew('VisaCountryAction.do?method=addUI');" value="新建"/>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
<div class="Description">
	说明：<br />

</div>

</body>
</html>
