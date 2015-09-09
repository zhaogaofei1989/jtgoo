<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>同行价格设置列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 同行价格设置列表
        </div>
        <div id="Title_End"></div>
    </div>
</div>

   
<div class="top">
价格样表设置:
1000<input type="radio" name="r1" checked="checked" value="1000"/>
2000<input type="radio" name="r1" value="2000"/>
3000<input type="radio" name="r1" value="3000"/>
<input type="button" value="设置" onclick="selectObj()"/>
</div>
     <form action="${basePath}background/CustomerAction.do?method=savePeerProductPrice" method="post">
     <html:hidden property="pageNum" value="1"/>
	<html:hidden property="pageSize" value="10"/>
<div id="MainArea">
     <input type="hidden" name="id" value="${id }"/>
    <table cellspacing="0" cellpadding="0" class="TableStyle">
         <!-- 表头-->
        <thead> 
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
                <th width="35px;"><input  type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>签证产品编号</td>
            	<td>洲际</td>
                <td>签证产品名称</td>
                <td>同业价格</td>
                <td>受理类型</td>
                <td>报价是否含签证费</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="visaProduct">
			<tr class="TableDetail1 template">
				 <th width="35px;" style="vertical-align: middle;"><input class="inputcheckbox"   name="ids" value="${visaProduct.id}"  type="checkbox" ></th>
				<td>${visaProduct.id}&nbsp;</td>
				<td>${visaProduct.country.name}&nbsp;</td>
				<td>${visaProduct.name}&nbsp;</td>
				<td>
				  <input type="text" id="input_${visaProduct.id}" name="visaProductArraysPrice[${visaProduct.id }]" value="${ visaProduct.price}"/>
				</td>
				<td>
				<c:choose>
				<c:when test="${visaProduct.acceptType==0}">
				代送
				</c:when>
				<c:when test="${visaProduct.acceptType==1}">
				 包签
				</c:when>
				</c:choose>
				</td>
				<td>
				<c:choose>
				<c:when test="${visaProduct.acceptType==0}">
				是
				</c:when>
				<c:when test="${visaProduct.acceptType==1}">
				 否
				</c:when>
				</c:choose>
				</td>
			</tr>
		</c:forEach>	
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
           <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
<div class="Description">
	说明：<br />

</div>

</body>
</html>

<script type="text/javascript">
//全选、反选
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
}
function selectObj()
{

//   $("input[name=batch]").each(function() {  })
var arr=$("input:checkbox:checked");
var radioValue= $("input:radio:checked").val();
for(var i=0;i<arr.length;i++)
{

var obj=arr[i];
if(obj.name!='')
{
$("#input_"+obj.value).val(radioValue);
}
}
}
</script>
