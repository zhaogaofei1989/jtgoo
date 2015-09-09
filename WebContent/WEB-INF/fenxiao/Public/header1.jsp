<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
</head>

<body>
    <img class="img1" src="${basePath}/style/images/tongye/banner2.gif" />
    <span>4000-987-088</span>
    <a href="http://wpa.qq.com/msgrd?v=3&uin=&site=qq&menu=yes"><img class="img2" src="${basePath}/style/images/tongye/qq.gif" /></a>
</body>
</html>