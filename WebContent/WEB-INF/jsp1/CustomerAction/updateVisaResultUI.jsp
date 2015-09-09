<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>签证结果设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/>签证结果设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>

     <form action="${basePath}background/CustomerAction.do?method=saveVisaResult" method="post">
<div id="MainArea">
     <input type="hidden" name="visaorderId" value="${visaorderId }"/>
    <table cellspacing="0" cellpadding="0" class="TableStyle">
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
            	<td>编号</td>
            	<td>客户名称</td>
                <td>签证状态</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${cusDatList}" var="cusDat">
        				        
			<tr class="TableDetail1 template">
				<td>${cusDat.customerId}&nbsp;</td>
				<td>${cusDat.customerName}&nbsp;</td>
				<td>
			<select name="visaResult[${cusDat.id }]" onchange="changeResult(this.value);">
			<c:choose>
			<c:when test="${cusDat.visastatus==1}">
			<option selected="selected" value="1">通过</option>
			<option value="0">拒绝</option>
			</c:when>
			<c:when test="${cusDat.visastatus==0}">
			<option selected="selected" value="0">拒绝</option>
			<option value="1">通过</option>
			</c:when>
  			 <c:otherwise>
			<option selected="selected"></option>
			<option value="0">拒绝</option>
			<option value="1">通过</option>
			</c:otherwise>
			</c:choose>
			</select>
			<c:if test="${cusDat.visastatus==0}"><html:link action="CustomerAction?method=refusedVisaResultUI&id=${cusDat.id}"><label>拒签原因</label></html:link></c:if>
		
				</td>
			</tr>
		</c:forEach>	
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
           <input type="image" src="${basePath}/style/images/save.png"/>
        </div>
    </div>
</div>
</form>
<div class="Description">
	说明：<br />

</div>

</body>
</html>

<script type="text/javascript">
function changeResult(value)
{

if(value==0)
{


}


}
</script>
