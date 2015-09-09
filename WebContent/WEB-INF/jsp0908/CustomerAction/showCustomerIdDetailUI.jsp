<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setAttribute("basePath",  basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="${basePath}style/blue/reset.css" rel="stylesheet" type="text/css" />
<link href="${basePath}style/blue/zh-cn-system.css" rel="stylesheet" type="text/css" />
<link href="${basePath}style/blue/table_form.css" rel="stylesheet" type="text/css" />
<style>
.input-text { background:none;
border:0px;}
input {border:0px;}
</style>
</head>
<body>
 <html:form action="background/CustomerAction">
<html:hidden property="method" value="editCustomer"/>
<input type="hidden" id="customerId" name="customerId" value="${customerId}"/>
<input type="hidden" id="visaProductId" name="visaProductId" value="${visaProductId }"/>
<input type="hidden" id="visaorderId" name="visaorderId" value="${visaorderId }"/>
<input type="hidden" id="id" name="id" value="${param.id }"/>

<div class="addContent" style="width:560px;">
    <div class="col-auto">
    	<div class="col-1">
        	<div class="content pad-6">
<table width="100%" cellspacing="0" class="table_form am-table am-table-striped am-table-hover table-main">
<tr><td width="120">客户编号</td><td>${customer.serialNumber }</td></tr>
<tr><td width="120">*客户姓名</td><td>${customer.name }</td></tr>
<tr><td width="120">手机号码</td><td>${customer.phone }</td></tr>
<tr><td width="120">家庭电话</td><td>${customer.mobliePhone }</td></tr>
<tr><td width="120">QQ/MSN</td><td>${customer.chatTools }</td></tr>
<tr><td width="120">邮箱地址</td><td>${customer.email }</td></tr>
<tr><td width="120">家庭地址</td><td>${customer.address }</td></tr>
<tr><td width="120">公司名称</td><td>${customer.companyName }</td></tr>
<tr><td width="120">公司地址</td><td>${customer.companyAddr }</td></tr>
<tr><td width="120">公司电话</td><td>${customer.companyPhone }</td></tr>
<tr><td width="120">职务</td><td>${customer.position }</td></tr>
 </table>

</div>
</div>
    </div>
	</div>
</html:form>
</body>
</html>
