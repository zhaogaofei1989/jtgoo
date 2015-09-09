<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="${basePath}static/js/jquery-1.7.2.js"></script>
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/paid_order.css" />
<title>已付款订单</title>
</head>
<body>

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
     
     <div class="display_tab">
     	<table border="1">
        	<tr>
            	<th width="120px">编号</th>
                <th>签证产品名称</th>
                <th>国家</th>
            	<th>领区</th>
                <th>类型</th>
                <th>签证费</th>
                <th>预约费</th>
            </tr>
            <c:forEach var="vo" items="${pageBean.recordList}">
            <tr>
                 	<td><a href="client_order.html">${vo.serialNumber }</a></td>
                 	<td>${vo.name}</td>
                 	<td>${vo.country.name}</td>
                 	<td>${vo.lingqu.name}</td>
                 	<td>${vo.type.name}</td>
                 	<td>${visaProduct.visaFee eq null ?0.0:visaProduct.visaFee}|${visaProduct.visaFee1 eq null ?0.0:visaProduct.visaFee1}|${visaProduct.visaFee2  eq null ?0.0:visaProduct.visaFee2}</td>
				<td>${visaProduct.bookFee eq null ?0.0:visaProduct.bookFee}|${visaProduct.bookFee1 eq null ?0.0:visaProduct.bookFee1}|${visaProduct.bookFee2 eq null ?0.0:visaProduct.bookFee2}</td>
           </tr>
            </c:forEach>
        </table>	
     </div>
     
</div>



<!--  -----------------页脚部分--------------  -->
<div class="footer">
	    <p>
			<a target="_blank" href="http://toplife.gotoip55.com/about.html">关于我们</a>
			<a target="_blank" href="http://toplife.gotoip55.com/login_ty.html">同业系统</a>
			<a target="_blank" href="http://toplife.gotoip55.com/visalists-8-1.html">签证服务</a>
			<span><a target="_blank" href="http://toplife.gotoip55.com/show-7-61-1.html">付款方式</a></span>
    	</p>
    	<p>专业旅游签证公司，钧通商旅帮你忙</p>
</div>

</div>
</body>
</html>

