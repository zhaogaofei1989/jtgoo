<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

　　<html:html locale="true">  
　　<head>  
　　 <title> Exception Handler</title>  
　　 <html:base />  
　　 </head>  
　　 <body>  
　　 <h1>系统出现一个意外</h1>  
　　 请将下面的提示信息反馈给你的系统管理员:<br>  
　　 <html:errors /> <!--将在这里显示”<span style="font-size: x-small; color: #0000ff;">你要添加的用户名称已经存在，请添加新的名称！</span>”-->  
　　 </body>  
　　</html:html>  