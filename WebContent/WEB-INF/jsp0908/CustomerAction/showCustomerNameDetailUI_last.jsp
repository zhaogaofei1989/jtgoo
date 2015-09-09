<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<link href="${basePath}style/blue/table_form.css" rel="stylesheet" media="screen" />
<style type="text/css">
.table_form td{
width: 20%;
}
</style>
</head>
<body>
 <html:form action="background/CustomerAction">
<html:hidden property="method" value="editCustomer"/>
<input type="hidden" id="customerId" name="customerId" value="${customerId}"/>
<input type="hidden" id="visaProductId" name="visaProductId" value="${visaProductId }"/>
<input type="hidden" id="visaorderId" name="visaorderId" value="${visaorderId }"/>
<input type="hidden" id="id" name="id" value="${param.id }"/>
<div class="table-list" id="printpdf">
<div class="common-form">
<fieldset>
<legend>客户详情</legend>
 <table width="100%" class="table_form">
 <tr><td>客户姓名</td><td>${customer.name }</td><td>手机号</td><td>${customer.mobliePhone}</td><td>职业类型</td><td>2222</td></tr>
 <tr><td>国家</td><td>${visaProduct.country.name }</td><td>类型</td><td>${visaProduct.type.name }</td><td>领区</td><td>${visaProduct.lingqu.name }</td></tr>
 </table>
 </fieldset>
 
 <table  width="100%" class="table_form">
   <tr><td>提供的文件</td><td>原件</td><td>复印件</td><td>备注</td></tr>
   </table>
   <c:forEach items="${set}" var="info">
   <fieldset>
	<legend><font color="red">${info}</font></legend>
	<table  width="100%" class="table_form">
    <c:forEach var="cusDat" items="${cusDatList}">
    <c:if test="${info eq cusDat.datatypeName}">
    <tr>
      <td>${cusDat.datatypedetailTitle}</td>   <td>${cusDat.original}</td>   <td>${cusDat.copy}</td>   <td>${cusDat.remarks}</td>
    </tr>
    </c:if>
    </c:forEach>
 </table>
	</fieldset>
   </c:forEach>
 
<!--  <fieldset>
	<legend>资料详情</legend>
  <table width="100%" class="table_form">
  <thead><th>提供的文件</th><th>资料名称</th><th>原件</th><th>复印件</th><th>备注</th></thead>
    <c:forEach var="cusDat" items="${cusDatList}">
    <tr>
    <td>${cusDat.datatypeName}</td>   <td>${cusDat.datatypedetailTitle}</td>   <td>${cusDat.original}</td>   <td>${cusDat.copy}</td>   <td>${cusDat.remarks}</td>
    </tr>
    </c:forEach>
 </table>
 </fieldset>-->
 <!--  
  <c:forEach items="${set}" var="s">
   <tr><td>
   <font color="red">${s}</font>
   </td>
 </tr>
 <c:forEach var="cusDat" items="${cusDatList}">
<c:if test="${s eq cusDat.datatypeName}">
<tr>
<td>${cusDat.customerName}</td>
<td>在职人员</td>
<td>
${cusDat.datatypeName }
</td>
<td>
${cusDat.datatypedetailTitle }
</td>
<td>
${cusDat.original }
</td>
<td>
${cusDat.copy }
</td>
<td>
${cusDat.remarks }
</td>
</tr>
</c:if>
</c:forEach>
   </c:forEach>
 </table>-->
</div>
</div>
</html:form>
</body>
</html>

  