<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}style/fenxiao/style_order.css" />
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
<title>产品预订</title>
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
        <b>签证中心</b>
        <span>>>&nbsp;${visaProduct.country.parent.name }&nbsp;>></span>
        <span>${visaProduct.name}&nbsp;>></span>
        <span>预订</span>
           <form id="order_form" name="order_form" action="fenxiao/VisaOrderFenXiaoAction.do?method=reserveOrder" method="post" >
           <input  type="hidden" name="productId" id="productId" value="${ visaProduct.id}"/>
        <div class="order">
            <span>订单所属客服：</span>
            <select id="service_select" name="service_select" style="width:120px; height:20px;
                border:1px solid #C9D4E0;" name="choose">
                <option value="">请选择</option>
                <c:forEach var="customer" items="${customerServices}">
                   <option value="${customer.id}">${customer.name}</option>
                </c:forEach>
            </select>
            
            <table border="1" class="table_order">
                <tr>
                    <th width="75px" height="35px">价格分类</th>
                    <th>价格（元/人）</th>
                    <th>6-12岁价格(元/人)</th>
                    <th>0-6岁价格(元/人)</th>
                </tr>
                <tr>
                    <th height="25px">同业价格</th>
                    <td>${visaProduct.price eq null?0.0:visaProduct.price}</td>
                    <td>${visaProduct.price eq null?0.0:visaProduct.price}</td>
                    <td>${visaProduct.price eq null?0.0:visaProduct.price}</td>
                </tr>
                <tr>
                    <th height="25px">签证费</th>
                      <td>${visaProduct.visaFee}</td>
                    <td>${visaProduct.visaFee1}</td>
                    <td>${visaProduct.visaFee2}</td>
                </tr>
                <tr>
                    <th height="25px">预约费</th>
                  <td>${visaProduct.bookFee}</td>
                    <td>${visaProduct.bookFee1}</td>
                    <td>${visaProduct.bookFee2}</td>
                </tr>
                <tr>
                    <th height="25px">保险费</th>
                    <td>${visaProduct.insurancePackage eq null ? "":visaProduct.insurancePackage.price1}</td>
                    <td>${visaProduct.insurancePackage eq null ? "":visaProduct.insurancePackage.price2}</td>
                    <td>${visaProduct.insurancePackage eq null ? "":visaProduct.insurancePackage.price3}</td>
                </tr>
                <tr>
                    <th height="25px">总费用</th>
                    <td colspan="6">=(同业价格+签证费+预约费+保险费公式)*成人人数+（同业价格+签证费+预约费+保险费公式)*6-12人数）+（同业价格+签证费+预约费+保险费公式)*0-6人数</td>
                </tr>
                <tr>
                    <th height="25px">申请人姓名</th>
                    <td>添加客户<img onclick="addCustomer()" src="${basePath}/style/images/glyphicons-433-plus.png"/></td>
                    <td colspan="5"><span id="applyName"></span></td>
                </tr>
                <tr>
                    <th height="25px">备注</th>
                    <td colspan="6">(录入客人的一些情况和需求，价格信息备注无效。)</td>
                </tr>
            </table>
                  
            <div class="order_net">
                <span>网上预定</span>
       
                    <label>人数：</label><input type="number" value="0" ="num" name="num" size="6"/>
                    <label>6-12岁：</label><input type="number" value="0" id="num1" name="num1" size="6"/>
                    <label>0-6岁：</label><input type="number" value="0" id="num2" name="num2" size="6"/><br />
                    <input type="submit" value="" name="dosubmit" />
            </div>
        </div>
                 </form>
    </div>
</div>


<!--  -----------------页脚部分--------------  -->
<div class="footer">
	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
</div>
</body>
</html>
<script type="text/javascript">
  $(function(){
 $("#order_form").validate({
 	onsubmit:true,// 是否在提交是验证 
	onfocusout:false,// 是否在获取焦点时验证 
	onkeyup :false,// 是否在敲击键盘时验证 
	        rules: {
	           			 service_select:{
	            		 required: true
	            		 },
	           			 num:{
	            		 required: true,
	            		 min:0
	            		 },
	           			 num1:{
	            		 required: true,
	            		  min:0
	            		 },
	           			 num2:{
	            		 required: true,
	            		 min:0
	            		 },
	       		 },
	        	messages: 
				{
						 service_select: {
							required: " 不能为空",
						  },
						 num: {
						required: " 不能为空",
						min: " 必须大于0"
						  },
						 num1: {
						required: " 不能为空",
						min: " 必须大于0"
						  },
						 num2: {
						required: " 不能为空",
						min: " 必须大于0"
						  }
				},
			submitHandler: function(form) {
			
				form.submit();
			 }
			}); });



function addCustomer()
{
art.dialog.open('fenxiao/CustomerFenXiaoAction.do?method=list',
{
    title: '选择客户信息',
    width: 900,
    height: 600,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    //取出iframe 中的id，和name
      var ss= this.iframe.contentWindow.document;
   	  var $top= $(this.iframe.contentWindow.document.getElementById("top").contentDocument || document.frames['mainFrame'].document);
   	  var li_list=$top.contents().find("#ul_tab li");
   	  var strId="";
   	  var strName="";
   	  for(var i=0;i<li_list.length;i++)
   	  {
   	  strId+=li_list[i].id+"&nbsp";
   	  strName+=li_list[i].innerText+"&nbsp";
   	  $("#order_form").append("<input type='hidden' name='customerIds' value='"+li_list[i].id+"'/>")
   	  }
   	  $("#applyName").html(strName);
    },
});
}

</script>
