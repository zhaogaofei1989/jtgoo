<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>订单拆分</title>
 <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
</head>
<body>

<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/>订单拆分
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div id="MainArea">
    <html:form action="background/VisaOrderAction" styleId="myform">
    	<html:hidden property="method" value="splitOrder"/>
    	<html:hidden styleId="visaorderId" property="id"/>
    	
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder" id="table">
   <div class="ItemBlock">
    <table>
    	<c:forEach items="${visaOrder.customerSet}" var="customer">
   				  <tr>
             		   <td><input class="inputcheckbox " name="ids" value="${customer.id}"  type="checkbox" > &nbsp;${customer.name }</td>
               
                    </tr>
    	</c:forEach>
                    </table>
            </div>
        </div>
        <!-- 表单操作 -->
        <div id="InputDetailBar">
        </div>
    </html:form>
</div>

<div class="Description">
	说明：<br />
	1、请先保存当前状态，否则无法执行下一步操作<br />
</div>

</body>
</html>

<script type="text/javascript">
fuction select()
{
var orderId=$("#visaorderId").val();
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
alert(idArr);
if(idArr.length>0){
openUrl("VisaOrderAction.do?method=splitOrder&id="+orderId+"&customerIds="+idArr);
}
else
{
alert("您还没有选中任何客户!")
return false;
}


}


</script>






