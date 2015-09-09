<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>

</head>
<body>
<form action="${basePath}background/InsurancePackageAction.do?method=list" method="post">
<html:hidden property="pageNum" value="1"/>
<html:hidden property="pageSize" value="${pageBean.pageSize eq null ? 10 :pageBean.pageSize }"/>
</form>
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13"   height="13" src="${basePath}/style/images/title_arrow.gif"/>保险套餐管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
            	<td>ID</td>
                <td>套餐类型</td>
                <td>套餐名称</td>
                <td>附件</td>
                <td>描述</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="pageBean">
			<tr class="TableDetail1 template">
				<td>${pageBean.id}&nbsp;</td>
				<td>${pageBean.insuranceType.name}&nbsp;</td>
				<td>${pageBean.name}&nbsp;</td>
				<td><a href="${basePath}background/InsurancePackageAction.do?method=getBaoxianInfo&baoxian_att_id=${ pageBean.baoxian_att_id}" target="_blank">${pageBean.path}&nbsp;</a></td>
				<td>${pageBean.description}&nbsp;</td>
				<td>
					<html:link action="/background/InsurancePackageAction?method=editUI&id=${pageBean.id}">修改</html:link>
					<html:link action="/background/InsurancePackageAction?method=delete&id=${pageBean.id}">删除</html:link>
				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
        <input type="button" class="cmd" onclick="createNew('InsurancePackageAction.do?method=addUI');" value="新建"/>
        </div>
    </div>
</div>

<div class="Description">
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
<div class="Description">
<br />

</div>

</body>
</html>
