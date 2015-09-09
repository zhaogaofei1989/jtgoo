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
<script type="text/javascript" src="${basePath}/js/jquery-1.7.js"></script>
<link href="${basePath}style/blue/table_form.css" rel="stylesheet" media="screen" />
</head>
<body id="printDiv">
<div class="table-list">
<div class="common-form">
<fieldset>
	<legend>签证材料</legend>
	<table width="100%" class="table_form">
		<tr>
		<td>产品名称：${product.name}</td>
        <td>签证国家：${product.country.name}</td>
		<td>签证类型：${product.type.name}</td>
		</tr>
		<tr>
        <td>领区：${product.lingqu.name}</td>
        <td>是否需要预约:
		<c:choose>
		<c:when test="${product.isNeedToAppointment eq 0}">
		是
		</c:when>
		<c:when test="${product.isNeedToAppointment eq 1}">
		否
		</c:when>
		</c:choose>        
        </td>
        <td>是否面试:
       <c:choose>
		<c:when test="${product.isInterview eq 0}">
		是
		</c:when>
		<c:when test="${product.isInterview eq 1}">
		否
		</c:when>
		</c:choose>  
		</td>
		</tr>
	  <tr>
        <td>签证申请周期：${product.visaApplyCycle}</td>
        <td>一般签证有效期:${product.visaValid}</td>
        <td>一般签证停留期：${product.periodOfStay}</td>
		</tr>
		 <tr>
        <td>入境次数：
               <c:choose>
		<c:when test="${product.oneToManySelect eq 0}">
		单次
		</c:when>
		<c:when test="${product.oneToManySelect eq 1}">
		多次
		</c:when>
		</c:choose>  
     </td>
        <td>受理情况:</td>
        <td>是否可以带领签证：
            <c:choose>
      <c:when test="${product.acceptType eq 0}">
		是
		</c:when>
		<c:when test="${product.acceptType eq 1}">
		否
		</c:when>
		</c:choose>
        </td>
		</tr>
		<tr>
        <td  colspan=3>报价是否含签证费：
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>领区划分：</h4>
        <hr></hr>
        <br/>
        ${product.lingquDivide }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>网址连接：</h4>
            <hr></hr>
        ${product.webSiteLink }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>预约需要的信息：</h4>
                   <hr></hr>
        ${product.bookingInformationNeeds }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>使领馆和签证中心地址： </h4>    <hr></hr>
        ${product.consularAndVisaCenterAddress }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>签证查询：  </h4>   <hr></hr>
        ${product.howToQueryVisaInfo }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>签证的领区：  </h4>   <hr></hr>
        ${product.getVisaInfo }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>签证材料准备：  </h4>   <hr></hr>
        ${product.visaMaterials }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>递交申请及面试：  </h4>   <hr></hr>
        ${product.submitApplicationAndInterview }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>备注：   </h4>  <hr></hr>
        ${product.visaRemarks }
   	  </td>
		</tr>
		<tr>
        <td  colspan=3><h4>免责条款：</h4>     <hr></hr>
        ${product.disclaimer }
   	  </td>
		</tr>
	<tr>
      <td  colspan=3 align="center">
       <input  type="button" value="打印pdf" onclick="printPdf()"/>
   	  </td>
		</tr>
	</table>
	</fieldset>
	</div>
	</div>
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

    