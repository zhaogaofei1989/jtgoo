<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
 <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
<script type="text/javascript">
function add()
{
var visaProductId=art.dialog.data('visaProductId');
var visaorderId=art.dialog.data('visaorderId');
window.location.href='CustomerAction.do?method=addCustomerUI&visaProductId='+visaProductId+'&visaorderId='+visaorderId;
}

</script>
</head>
<body>
<div>
<div class="top">
<select>
<option value="dataName">资料名称</option>
</select>
&nbsp;<input type="text"  style="width:80px;"/>
<select>
<option value="0" selected="selected">选择客户</option>
<c:forEach items="${cus_map}" var="cus_map">
<option value="${cus_map.value.id}">${cus_map.key}</option>
</c:forEach>
</select>
<input type="button" value="搜索"/>
<input type="button" value="添加新客户资料" onclick="add()"/>
</div>
<table class="am-table am-table-striped am-table-hover table-main">

<!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
            	<td>客户姓名</td>
                <td>职业</td>
                <td>资料类别</td>
                <td>资料名称</td>
                <td>原件</td>
                <td>复印件</td>
                <td>备注</td>
                <td>相关操作</td>
            </tr>
        </thead>
        <tbody id="TableData" class="dataContainer">
        <c:forEach items="${cusDatList}" var="cusDat">
        <tr>
        <td>${cusDat.customerName }</td>
        <td>
		<c:choose>
		<c:when test="${cusDat.type==1}">在职人员</c:when>
		<c:when test="${cusDat.type==2}">退休人员</c:when>
		<c:when test="${cusDat.type==3}">学生及未成年</c:when>
		<c:when test="${cusDat.type==4}">自由职业</c:when>
		<c:when test="${cusDat.type==5}">不分职业</c:when>
		</c:choose>
		</td>
        <td>${cusDat.datatypedetailTitle }</td>
        <td>${cusDat.datatypeName }</td>
        <td>${cusDat.original }</td>
        <td>${cusDat.copy}</td>
         <td>${cusDat.remarks }</td>
      <td>
		<html:link action="background/CustomerAction?method=editCustomerRelationUI&id=${cusDat.id}&visaProductId=${cusDat.visaProductId}&customerId=${cusDat.customerId}&visaorderId=${visaorderId}&type=${cusDat.type}">修改</html:link>
		<html:link action="background/CustomerAction?method=removeCustomerRelation&id=${cusDat.id}&visaProductId=${cusDat.visaProductId}&visaorderId=${visaorderId}" onclick="return delConfirm()">删除</html:link>
		</td>
        </tr>
        </c:forEach>
     
       
        </tbody>
</table>



</div>
</body>
</html>
