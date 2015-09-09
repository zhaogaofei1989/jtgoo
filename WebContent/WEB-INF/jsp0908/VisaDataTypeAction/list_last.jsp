<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<style type="text/css">
		tr:hover{background-color: #CEA}
</style>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 资料类别设置
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
                <td>分类名称</td>
                <td>分类描述</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${datatypeList}" var="datatype">
			<tr class="TableDetail1 template">
				<td>${datatype.id}&nbsp;</td>
				<td>${datatype.name}&nbsp;</td>
				<td>${datatype.description}&nbsp;</td>
				<td>
					<html:link action="background/VisaDataTypeAction?method=editUI&id=${datatype.id}">修改</html:link>
					<html:link action="background/VisaDataTypeAction?method=delete&id=${datatype.id}">删除</html:link>

				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
        	<input type="button" class="cmd" onclick="createNew('VisaDataTypeAction.do?method=addUI');" value="新建"/>
       
        </div>
    </div>
</div>

<div class="Description">
<br />

</div>

</body>
</html>


