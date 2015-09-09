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
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 同业用户组管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
                <td>同业用户组名称</td>
                <td>领区查看</td>
                <td>会员数</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${peerGroupList}" var="peerGroup">
			<tr class="TableDetail1 template">
				<td>${peerGroup.name}&nbsp;</td>
				<td>${peerGroup.description}&nbsp;</td>
				<td>${peerGroup.customerSet eq null ? 0 : fn:length(peerGroup.customerSet) }&nbsp;</td>
				<td>
					<html:link action="background/PeerGroupAction?method=editUI&id=${peerGroup.id}">修改</html:link>
					<html:link action="background/PeerGroupAction?method=delete&id=${peerGroup.id}">删除</html:link>
				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
             	<input type="button" class="cmd" onclick="createNew('PeerGroupAction.do?method=addUI&parentId=${parent.id}');" value="新建"/>
        </div>
    </div>
</div>

<div class="Description">
	说明：<br />

</div>

</body>
</html>
