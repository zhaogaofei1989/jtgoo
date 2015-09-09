<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
 <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
<link href="${basePath}style/blue/table_form.css" rel="stylesheet" media="screen" />
</head>
<body>
 <html:form action="background/CustomerAction">
<html:hidden property="method" value="editCustomer"/>
<input type="hidden" id="customerId" name="customerId" value="${customerId}"/>
<input type="hidden" id="visaProductId" name="visaProductId" value="${visaProductId }"/>
<input type="hidden" id="visaorderId" name="visaorderId" value="${visaorderId }"/>
<input type="hidden" id="id" name="id" value="${param.id }"/>
<div class="table-list">
<div class="common-form">
<c:choose>
<c:when test="${customer.userType ==0}">
<fieldset>
<legend>
同业用户信息
</legend>
<table width="100%" class="table_form am-table am-table-striped am-table-hover table-main" style="font-size: 0.8em;">
<tr><td width="120">用户名</td><td>${customer.userName }</td></tr>
<tr><td width="120">公司名称</td><td>${customer.companyName }</td></tr>
<tr><td width="120">公司地址</td><td>${customer.companyAddr}</td></tr>
<tr><td width="120">公司电话 </td><td>${customer.companyPhone }</td></tr>
<tr><td width="120">销售</td><td>${customer.saler.name }</td></tr>
<tr><td width="120">同业用户组</td><td>${customer.peerGroup.name }</td></tr>
<tr><td width="120">注册日期</td><td>${customer.regTime }</td></tr>
<tr><td width="120">领区选择</td><td>
<c:forEach var="lingqu" items="${customer.lingquSet}">
${lingqu.name } &nbsp; 
</c:forEach>
</td></tr>
<tr><td width="120">联系人</td><td>
<c:forEach var="css" items="${customer.customerServicers}">
${css.name} &nbsp; 
</c:forEach>
</td></tr>
</table>
</fieldset>
</c:when>
<c:when test="${customer.userType ==1}">
<fieldset>
<legend>
直接用户信息
</legend>
<table width="100%" class="table_form am-table am-table-striped am-table-hover table-main" style="font-size: 0.8em;">
<tr><td width="120">用户名</td><td>${customer.userName }</td></tr>
<tr><td width="120">姓名</td><td>${customer.name}</td></tr>
<tr><td width="120">手机号码</td><td>${customer.phone }</td></tr>
<tr><td width="120">QQ号码 </td><td>${customer.chatTools }</td></tr>
<tr><td width="120">Email</td><td>${customer.email }</td></tr>
<tr><td width="120">家庭地址</td><td>${customer.address }</td></tr>
<tr><td width="120">销售</td><td>${customer.saler.name }</td></tr>
<tr><td width="120">注册时间</td><td>${ customer.regTime}</td></tr>
<tr><td width="120">职业</td><td>
<c:choose>
<c:when  test="${ customer.occupation eq 1}">在职人员</c:when>
<c:when  test="${ customer.occupation eq 2}">退休人员</c:when>
<c:when  test="${ customer.occupation eq 3}">学生</c:when>
<c:when  test="${ customer.occupation eq 4}">儿童</c:when>
<c:when  test="${ customer.occupation eq 5}">自由职业</c:when>
</c:choose>

</td></tr>
</table>
</fieldset>
</c:when>
</c:choose>

</div>
</div>
    
</html:form>
</body>
</html>
