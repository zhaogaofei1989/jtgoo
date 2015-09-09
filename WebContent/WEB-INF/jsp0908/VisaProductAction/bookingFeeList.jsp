<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>预约费用管理</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">预约费用管理</strong> / <small>预约费用列表</small></div>
    </div>
    
<div class="am-panel-hd">
</div>
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
          	<iamp-identify:IAMPIdentify authid="03_06_01_03">
            	<button type="button" class="am-btn am-btn-default" onclick="return exportConfirm(1);"><span></span> 导出</button>
            </iamp-identify:IAMPIdentify>
            <iamp-identify:IAMPIdentify authid="03_06_01_04">
            	<button type="button" class="am-btn am-btn-default" onclick="deleteBatch();"><span></span> 批量删除</button>
          	</iamp-identify:IAMPIdentify>
          </div>
        </div>
      </div>
    </div>
  
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th><input  type="checkbox" id="check_box"/></th>
            	<th>ID</th>
                <th>名称</th>
                <th>洲际/国家</th>
                <th>领区</th>
                <th>类型</th>
                <th>签证费|0-6岁|6-12岁</th>
                <th>预约费|0-6岁|6-12岁</th>
                <th>备注</th>
            	<th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
                  <c:forEach items="${pageBean.recordList}" var="visaProduct">
           		 <tr>
             	 <td><input class="checkbox1"   name="ids" value="${visaProduct.id}"  type="checkbox" ></td>
            	 <td>${visaProduct.serialNumber}&nbsp;</td>
				<td>${visaProduct.name}&nbsp;</td>
				<td>${visaProduct.country.name}&nbsp;</td>
				<td>${visaProduct.lingqu.name}&nbsp;</td>
				<td>${visaProduct.type.name}&nbsp;</td>
				<td>${visaProduct.visaFee eq null ?0.0:visaProduct.visaFee}|${visaProduct.visaFee1 eq null ?0.0:visaProduct.visaFee1}|${visaProduct.visaFee2  eq null ?0.0:visaProduct.visaFee2}</td>
				<td>${visaProduct.bookFee eq null ?0.0:visaProduct.bookFee}|${visaProduct.bookFee1 eq null ?0.0:visaProduct.bookFee1}|${visaProduct.bookFee2 eq null ?0.0:visaProduct.bookFee2}</td>
				<td><span name="showTip" title="${visaProduct.visaRemarks}"><img src="${basePath}/style/images/search.gif" /></span></td>
				<td>
					<iamp-identify:IAMPIdentify authid="03_06_01_02"> 
						<html:link action="/background/VisaProductAction?method=bookingFeeEditUI&id=${visaProduct.id}">修改</html:link>
					</iamp-identify:IAMPIdentify>
				</td>
           	 </tr>
    	    </c:forEach>
          </tbody>
        </table>
			<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
          <hr />
          <p>注：.....</p>
      </div>
    </div>
  </div>
  
  <!-- content end -->


<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${basePath}js/amazeui/jquery.min.js"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
<script src="${basePath}js/amazeui/app.js"></script>
</body>
</html>

<script type="text/javascript">

//全选、反选
$(document).ready(function() {
$('#check_box').click(function(event) { //on click 
if(this.checked) { // check select status
$('.checkbox1').each(function() { //loop through each checkbox
this.checked = true; //select all checkboxes with class "checkbox1" 
});
}else{
$('.checkbox1').each(function() { //loop through each checkbox
this.checked = false; //deselect all checkboxes with class "checkbox1" 
}); 
}
});

});

$(function(){
			$("span[name='showTip']").poshytip();
		});
function createNew()
{
window.location.href="VisaProductAction.do?method=addUI";
}
//全选、反选
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
}

//导出pdf
function exportConfirm(showId)
{

var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){
//openUrl("VisaOrderAction.do?method=exportExcel&id="+idArr);

window.open("VisaProductAction.do?method=exportPDF&id="+idArr+"&showId="+showId);
}
else
{
alert("您还没有选中任何订单!")
}
}


function  deleteBatch()
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){

 if(confirm("确定要删除所选数据吗？"))
 {
window.location.href="VisaProductAction.do?method=deleteBatch&ids="+idArr;
}
}
else
{
alert("您还没有选中任何用户!");
}

}
</script>