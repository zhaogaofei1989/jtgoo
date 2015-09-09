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
<title>钧通商旅</title>
<link rel="stylesheet" type="text/css" href="${basePath}style/blue/base.css"/>
<link rel="stylesheet" type="text/css" href="${basePath}style/blue/ExportTablePage.css"/>
</head>
<body>
<div id="printDiv">
	<div id="top">
    	<img src="${basePath}style/images/ExportTableHeader.jpg" />
    </div>
    <div id="MainTable">
    	<h1>订单一览表</h1>
        <table cellspacing="0" id="tableFirst">
        	<caption>日期：2014-05-13</caption>
            <thead>
            	<tr>
                	<th>订单编号</th>
                	<td>订单状态</td>
                	<td>客户姓名</td>
                	<td>手机号码</td>
                	<td>用户名称</td>
                	<td>联系人</td>
                	<td>联系方式</td>
                	<td>签证产品名称</td>
                	<td>接单员</td>
                	<td>操作员</td>
                	<td>送签员</td>
                </tr>
            </thead>
            
            <tbody>
			<c:forEach items="${orderList}" var="visaOrder">
			         <tr>          
                	<th>${visaOrder.serialnumber}<br /><br /></th>
                	<td>
                	<c:choose>
				<c:when test="${visaOrder.status==0||visaOrder.status==null}">
				  未审核
				</c:when>
				<c:when test="${visaOrder.status==1}">
				已预订
				</c:when>
				<c:when test="${visaOrder.status==2}">
				已收到材料
				</c:when>
				<c:when test="${visaOrder.status==3}">
				已审核材料
				</c:when>
				<c:when test="${visaOrder.status==4}">
				已付款
				</c:when>
				<c:when test="${visaOrder.status==5}">
				已预约
				</c:when>
				<c:when test="${visaOrder.status==6}">
				已面试/送签
				</c:when>
				<c:when test="${visaOrder.status==7}">
				已出签
				</c:when>
				<c:when test="${visaOrder.status==8}">
				已寄回
				</c:when>
				<c:when test="${visaOrder.status==9}">
				已完成
				</c:when>
				</c:choose>
				<br /><br /></td>
				
                	<td>
                	<c:forEach items="${visaOrder.customerList}" var="customerNames"  varStatus="status">
                	   ${customerNames.name }<br/>
                	</c:forEach>
                	<br /></td>
                	<td>
					<c:forEach items="${visaOrder.customerList}" var="customerPhones"  varStatus="status">
                	 ${customerPhones.phone }<br/>
                	</c:forEach>
					<br /></td>
                	<td>${visaOrder.customer.userName }<br /><br /></td>
                	<td>${visaOrder.customService }<br /><br /></td>
                	<td>${visaOrder.customerServersPhone }<br /></td>
                	<td>${visaOrder.visaProduct.name}</td>
                	<td>${visaOrder.single}</td>
                	<td>${visaOrder.sentToSignPeople}</td>
                	<td>${visaOrder.operator}</td>
                </tr>
                </c:forEach>
          </tbody>
    
        </table>
        
        
    </div>
      <div id="PageFooter">
        	<span>服务热线：4000-987-0008</span>
            <b>网址：www.jtgoo.com</b>
        </div>
        </div>
   <p  class="noprint" style=" float:right; margin-right:120px;"><a href="#" onclick="printPdf()"><img src="${basePath}style/images/print.jpg" /></a></p>

</body>
</html>

<script type="text/javascript">
function printPdf()
{
var printData = document.getElementById("printDiv").innerHTML; 
window.document.body.innerHTML = printData;
window.print();
}
</script>

    