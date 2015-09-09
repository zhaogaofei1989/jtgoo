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
	<div class="head_logo">
        <img src="${basePath}/style/images/tongye/head_logo.gif" />
        <ul>
            <li style="color: red">${customer.userName} 欢迎登录同业分销系统!</li>
            <li>你的身份是<strong>同业用户</strong></li>
            <li><a href="http://127.0.0.1:8080/jtgooCMS/static/login-ty.html">退出登录</a></li>
            <li><a href="http://toplife.gotoip55.com/index.php?m=member&c=index">同业系统首页</a></li>
            <li><a href="http://127.0.0.1:8080/jtgooCMS/static/index.html">网站主页</a></li>
        </ul>
        <p class="orders_notice">最新签证订单：未审核 
        <a href="${basePath}/fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=0">${nocheck }</a> 个，已确认 <a href="${basePath}/fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=8">${finished }</a> 个，正在处理中 <a href="${basePath}/fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=1|2|3|4|5|6|7">${process }</a> 个; 最新线路订单：未审核 <a href="#">0</a> 个，已确认 <a href="#">0</a> 个，已付款 <a href="#">0</a> 个，处理中 <a href="#">0</a> 个;</p>
    </div>
    <div class="head_notice">
        <p class="notice1">
            <a id="noti_data1" href="javascript:announce('46','持有美国签证可免签入境国')">持有美国签证可免签入境国</a>
            <a id="noti_data2" href="http://toplife.gotoip55.com/index.php?m=member&c=index&a=announcelist">[更多公告...]</a>
        </p>
        <p class="notice2">
            <a href="http://toplife.gotoip55.com/index.php?m=message&amp;c=index&amp;a=send">[更多通知...]</a>
        </p>
    </div>
</body>
</html>