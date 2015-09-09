<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<script src="${basePath}js/jquery-1.11.1.js"></script>
<title>同业首页</title>
</head>
<body>
	<div class="header1">
		<jsp:include page="/WEB-INF/fenxiao/Public/header1.jsp" />
    </div>
    <div class="header2">
    	<jsp:include page="/WEB-INF/fenxiao/Public/header2.jsp" />
    </div>
    
    <div class="content">
    	<!----------- 左边菜单 ------------>
        	<jsp:include page="/WEB-INF/fenxiao/Public/left.jsp"/>
        <!----------------- 右边内容 ------------------>
        <div class="right">
        	<div class="dynamic_visa">
            	<h4><font>签证产品更新动态</font></h4>
            </div>
            <div class="dynamic_journey">
            	<h4><font>旅游产品更新动态</font></h4>
            </div>
            <div class="jour_img">
            	<img src="${basePath}/style/images/tongye/jourindex_img.gif" />
            </div>
            <div class="userinfo">
            	<h4><font>用户资料</font></h4>
            </div>
       	</div>
    </div>
    
    <div class="footer">
		<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>
