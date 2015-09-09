<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>订单拆分</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>

<div class="admin-content">

  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">拆分订单</strong> </div>
  </div>
  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
       <html:form styleClass="am-form" action="background/VisaOrderAction" styleId="myform">
    	<html:hidden property="method" value="splitOrder"/>
    	<html:hidden styleId="visaorderId" property="id"/>
    	<c:forEach items="${visaOrder.customerSet}" var="customer">
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            <input class="inputcheckbox " name="ids" value="${customer.id}"  type="checkbox" />
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           ${customer.name }
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          </c:forEach>
          
        </html:form>
      </div>

    </div>
  </div>
  </div>
<!-- content end -->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${basePath}js/amazeui/jquery.min.js"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
</body>
</html>

<script type="text/javascript">
function select()
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






