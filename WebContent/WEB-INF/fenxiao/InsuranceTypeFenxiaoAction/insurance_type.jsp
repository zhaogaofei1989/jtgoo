<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/insurance_style.css" />
<title>保险价格</title>
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
            <span><b>保险报价查询</b></span>
            <div class="sear_banner">
                <ul>
                </ul>
             </div>
                
            <div class="insurance">
                <table border="1" class="table_insurance">
        
                    <tr>
                        <th height="25px">保险公司</th>
                        <th>备注</th>
                    </tr>
                    
                <c:forEach var="insuranceType" items="${insuranceTypeList}">
                    <tr>
                        <td>${insuranceType.name }</td>
                        <td>${insuranceType.description }</td>
                    </tr>
                </c:forEach>
                </table>
            </div> 
    	</div>
	</div>
<!--  -----------------页脚部分--------------  -->
    <div class="footer">
    	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>

