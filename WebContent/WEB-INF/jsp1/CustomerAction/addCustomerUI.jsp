<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
 <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
<link rel="stylesheet" type="text/css" href="${basePath}style/blue/jquery.autocomplete.css"></link>
<script type="text/javascript" src="${basePath}js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
</head>
<body>
 <html:form action="background/CustomerAction" styleId="myform">
<html:hidden property="method" value="addCustomer"/>
<div>
<input type="hidden" id="customerId" name="customerId" value="${customerId}"/>
<input type="hidden" id="visaProductId" name="visaProductId" value="${visaProductId }"/>
<input type="hidden" id="visaorderId" name="visaorderId" value="${visaorderId }"/>
<input type="hidden" id="title" name="title" value="${ title}"/>
<input type="hidden" id="hidden_name" name="hidden_name" value=""/>

<table cellspacing="0" cellpadding="0" class="TableStyle">
<tr><td>职业</td><td><select name="type" id="type" onchange="changeInfo(this.options[this.options.selectedIndex].value)">
  <c:forEach items="${occuMap}" var="item"> 
  <option  value="${item.key}" ${item.key==type?'selected':''}>${item.value}</option>
  </c:forEach> 
</select></td>
<td>客户</td>
<td>
  <style>
            .customernameDiv{ margin-top:0px; font-size:14px; position:relative; }
            #search_div_customername_id{ position:relative; top:0px; border:1px solid #dfdfdf; text-align:left; padding:1px; left:0px;*left:0px; width:263px;*width:260px; background-color:#FFF; display:none; font-size:12px; height:100px; overflow-y:scroll;}
            #search_div_customername_id li{ line-height:24px;cursor:pointer}
            #search_div_customername_id li a{  padding-left:6px;display:block}
            #search_div_customername_id li a:hover, #search_div_customername_id li:hover{ background-color:#e2eaff}
            </style>
          <div id="customernameDiv">
    <input type="text" id="customerName" name="customerName" onfocus="if(this.value == this.defaultValue) this.value = ''" onblur="if(this.value.replace(' ','') == '') this.value = this.defaultValue;" value="${customerName}" class="InputStyle required"/>
        <ul id="search_div_customername_id"></ul>
    </div>
</td>
</tr>
</table>
</br>
<div id="mainDiv">
 <table class="TableStyle" cellpadding="0" cellspacing="0" id="table"> 
 <thead><tr><td>资料名称</td><td>原件</td><td>复印件</td><td>备注</td></tr></thead>
 <tbody>
 <c:forEach items="${dataTypeDetailList}" var="dataTypeDetail">
 <tr>
 <td>${dataTypeDetail.title}</td>
 <td><input type="text" name="dataTypeDetail[original]"/></td>
 <td><input type="text" name="dataTypeDetail[copy]" /></td>
 <td><input type="text" name="dataTypeDetail[remarks]"/></td>
 <td><input type="hidden" name="dataTypeDetailId" value="${ dataTypeDetail.id}"/></td>
 <td><input type="hidden" name="dataTypeDetailTitle" value="${ dataTypeDetail.title}"/></td>
 </tr>
 </c:forEach>
 </tbody>
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
  $(function(){
  			//界面验证
			validateUI();
				});	
			
//界面表单验证
function validateUI()

{
 $("#myform").validate({
 	onsubmit:true,// 是否在提交是验证 
	onfocusout:false,// 是否在获取焦点时验证 
	onkeyup :false,// 是否在敲击键盘时验证 
        rules: {
            customerName:{
            		 required: true
            		 },
       		 },
        	messages: 
			{
			 customerName: {
					required: "不能为空",
					  }
			},
			submitHandler: function(form) { 
			
		
			//检测  签证产品的真实性
			var customerName=$("#customerName").val().replace(/(^\s+)|(\s+$)/g, "");
			var hidden_name=$("#hidden_name").val().replace(/(^\s+)|(\s+$)/g, "");
			if(customerName!==hidden_name)
			{
			alert("该用户不存在，请重新查询！");
			return false;
			}
			
			if(hidden_name==='')
			{
		    alert("用户信息不能为空！");
			return false;
			}	
			 if($('#table tr').length===1)
			 {
			 
			 alert("没有可保存的数据");
			 return false;
			 
			 }
			form.submit();
			},
			 invalidHandler: function(form, validator) {  //不通过回调 
			 return false; 
          } ,
			
    });

}


 function search_customername_id(title,id)
                {
                    $("#customerName").val(title);
                    $("#hidden_name").val(title);
                   $("#customerId").val(id);
                    $('#search_div_customername_id').hide();
                }
function  customername_search_ajax(){
				var value =$("#customerName").val();
				if (value.length > 0){
				
				
				
					$.ajax({  
				               	    url: 'GetVisaCustomerInfo.do',  
				               		type: 'POST',
				               		dataType : 'json',
				                    data : {
				                    q:value
										},
						success : function(data, textStatus, jqXHR) {
						if (data != null) {
							var str = '';
							$.each(data.obj, function(i,n){
								str += '<li onclick=\'search_customername_id("'+n.label+'","'+n.id+'");\'>'+n.label+'</li>';
							});
							$('#search_div_customername_id').html(str);
							$('#search_div_customername_id').show();
						} else {
							$('#search_div_customername_id').hide();
						}
						}
					});
				} else {
					$('#search_div_customername_id').hide();
				} 
}

$(document).ready(function(){
$('#customerName').keyup(function(){
	 customername_search_ajax();
				});
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
     /**   $("#mainDiv").append(json[i].id+">>>>>>>>>>"+json[i].title);**/
     $("#table tbody").append("<tr><td>"+json[i].title+"</td><td><input type='text' name='dataTypeDetail[original]'/></td><td><input type='text' name='dataTypeDetail[copy]'/></td><td><input type='text' name='dataTypeDetail[remarks]'/></td><td><input type='hidden' value='"+json[i].id+"' name='dataTypeDetailId'/></td><td><input type='hidden' value='"+json[i].title+"' name='dataTypeDetailTitle'/></td></tr>")
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
