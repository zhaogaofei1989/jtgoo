<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<link rel="stylesheet" type="text/css" href="${basePath}style/blue/jquery.autocomplete.css"></link>
<script type="text/javascript" src="${basePath}js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
</head>
<body>
 <html:form action="background/CustomerAction">
<html:hidden property="method" value="editCustomer"/>
<div>
<input type="hidden" id="customerId" name="customerId" value="${customerId}"/>

<input type="hidden" id="visaProductId" name="visaProductId" value="${visaProductId }"/>
<input type="hidden" id="visaorderId" name="visaorderId" value="${visaorderId }"/>
<input type="hidden" id="id" name="id" value="${param.id }"/>

<table cellspacing="0" cellpadding="0" class="TableStyle">
<tr><td>职业</td><td>
<select onchange="changeInfo(this.options[this.options.selectedIndex].value)" id="type" name="type">
  <option  value="">请选择</option>
  <c:forEach items="${occuMap}" var="item"> 
  <option  value="${item.key}" ${item.key==type?'selected':''}>${item.value}</option>
  </c:forEach> 
</select></td>
<td>客户</td>
<td>
   <input type="text" id="customerName" readonly="readonly" name="customerName" value="${customerName}" class="InputStyle required"/>
</td>
</tr>
</table>
<br/>
<div id="mainDiv">
 <table class="TableStyle" cellpadding="0" cellspacing="0" id="table"> 
 <thead><tr><td>资料名称 ${dataTypeDetail.original}</td><td>原件</td><td>复印件</td><td>备注</td></tr></thead>
 <c:forEach items="${dataTypeDetailList}" var="dataTypeDetail">
 <tr>
 <td>${dataTypeDetail.datatypedetailTitle}</td>
 <td><input type="text" name="dataTypeDetail[original]" value="${ dataTypeDetail.original}"/></td>
 <td><input type="text" name="dataTypeDetail[copy]" value="${ dataTypeDetail.copy}"/></td>
 <td><input type="text" name="dataTypeDetail[remarks]" value="${ dataTypeDetail.remarks}"/></td>
 <td><input type="hidden" name="dataTypeDetailId" value="${ dataTypeDetail.id}"/></td>
 </tr>
 </c:forEach>
 </table>
</div>
</div>
    <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
        </div>
</html:form>
</body>
</html>
<script type="text/javascript">

$(document).ready(function(){


//occu value
var type=$("#type").val();
if(type==="")
{
changeInfo(1);
$("#type").val(1)
}

$.ajax({
 url: "GetVisaCustomerInfo.do", 
 dataType:'json',
 success: function(msg){
 if(msg!==null)
 {
    var info=msg.Items;
            $('#customerName').AutoComplete({
                'data': info,
                'width':280,
                'listStyle': 'custom',
                'maxHeight': 480,
                'createItemHandler': function(index, data)
                {
                 return "<span style='color:green;'>--"+data.label+"--</span>";  // 文本显示为绿色，并在前后使用'--'包裹
                },
			 'afterSelectedHandler': function(data)
				 {
			  $("#customerId").val(data.id);
			   }
 });
 }

     }});
  });


function changeInfo(index)
{
var pid=$("#visaProductId").val();
if(pid!=null)
{
$.ajax({
 url: "GetVisaDataTypeDetailInfo.do?pid="+pid+"&type="+index, 
 dataType:'json',
 success: function(msg){ 
 if(msg!=null)
 {
 $("#table tbody").html("");
 var  json = eval(msg.Items);
 for(var i=0; i<json.length; i++)
  {
     $("#table").append("<tr><td>"+json[i].title+"</td><td><input type='text' name='dataTypeDetail[original]'/></td><td><input type='text' name='dataTypeDetail[copy]'/></td><td><input type='text' name='dataTypeDetail[remarks]'/></td><td><input type='hidden' value='"+json[i].id+"' name='dataTypeDetailId'/></td><td><input type='hidden' value='"+json[i].title+"' name='dataTypeDetailTitle'/></td></tr>")
  }
 }
 else
 {
 $("#table tbody").html("");
 }
 }
 });
}
}



</script>
