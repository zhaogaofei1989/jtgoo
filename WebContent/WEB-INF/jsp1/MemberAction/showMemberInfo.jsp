<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<link href="${basePath}style/blue/table_form.css" rel="stylesheet" media="screen" />
</head>
<body>
 <html:form action="background/MemberAction">
<html:hidden property="method" value="editCustomer"/>
<input type="hidden" id="customerId" name="customerId" value="${customerId}"/>
<input type="hidden" id="visaProductId" name="visaProductId" value="${visaProductId }"/>
<input type="hidden" id="visaorderId" name="visaorderId" value="${visaorderId }"/>
<input type="hidden" id="id" name="id" value="${param.id }"/>
<div class="table-list">
<div class="common-form">
<fieldset>
<legend>
直接用户信息
</legend>
<table width="100%" class="table_form">
<tr><td width="120">用户名</td><td>${member.userName }</td></tr>
<tr><td width="120">姓名</td><td>${member.name}</td></tr>
<tr><td width="120">手机号码</td><td>${member.phone }</td></tr>
<tr><td width="120">QQ号码 </td><td>${member.chatTools }</td></tr>
<tr><td width="120">Email</td><td>${member.email }</td></tr>
<tr><td width="120">家庭地址</td><td>${member.address }</td></tr>
<tr><td width="120">销售</td><td>${member.saler.name }</td></tr>
<tr><td width="120">注册时间</td><td>${ member.regTime}</td></tr>
<tr><td width="120">职业</td><td>
<c:choose>
<c:when  test="${ member.occupation eq 1}">在职人员</c:when>
<c:when  test="${ member.occupation eq 2}">退休人员</c:when>
<c:when  test="${ member.occupation eq 3}">学生</c:when>
<c:when  test="${ member.occupation eq 4}">儿童</c:when>
<c:when  test="${ member.occupation eq 5}">自由职业</c:when>
</c:choose>

</td></tr>
</table>
</fieldset>


</div>
</div>
    
</html:form>
</body>
</html>
