<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title">&nbsp;<!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 版块管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
            	<td width="250px">版块名称</td>
                <td width="300px">版块说明</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${forumList}" var="forum">
			<tr class="TableDetail1 template">
				<td>${forum.name}&nbsp;</td>
				<td>${forum.description}&nbsp;</td>
				<td><html:link action="/ForumManageAction?method=delete&id=${forum.id}" onclick="return delConfirm()">删除</html:link>
					<html:link action="/ForumManageAction?method=editUI&id=${forum.id}">修改</html:link>
					<html:link action="/ForumManageAction?method=moveUp&id=${forum.id}">上移</html:link>
					<html:link action="/ForumManageAction?method=moveDown&id=${forum.id}">下移</html:link>
				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
            <html:link action="/ForumManageAction?method=addUI"><img src="${basePath}/style/images/createNew.png" /></html:link>
        </div>
    </div>
</div>

<div class="Description">
	说明：<br />
	1，显示的列表按其sortOrder值升序排列。<br />
	2，可以通过上移与下移功能调整顺序。最上面的不能上移，最下面的不能下移。<br />
</div>

</body>
</html>
