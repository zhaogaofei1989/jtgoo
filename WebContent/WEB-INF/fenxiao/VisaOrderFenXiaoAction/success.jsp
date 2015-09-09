<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="${basePath}static/js/jquery-1.7.2.js"></script>
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}style/fenxiao/style_order.css" />
<title>产品预订</title>
</head>
<body>
<!-- -----------头部---------------- -->
	<div class="header1">
		<jsp:include page="/WEB-INF/fenxiao/Public/header1.jsp" />
    </div>
    <div class="header2">
    	<jsp:include page="/WEB-INF/fenxiao/Public/header2.jsp" />
    </div>

<div class="content">
        <!-- -----------------左边菜单版块---------------- -->
	<jsp:include page="/WEB-INF/fenxiao/Public/left.jsp"/>
<!--  -----------------右边内容部分--------------  -->
    <div class="right">
        <div class="order">
				<h1>订单已预定成功,等待管理员审核</h1>
        </div>
    </div>
</div>


<!--  -----------------页脚部分--------------  -->
<div class="footer">
	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
</div>
</body>
</html>

