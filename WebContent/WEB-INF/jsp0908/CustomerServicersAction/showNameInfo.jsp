<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>客服列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
      <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">客服管理</strong> / <small>客服信息</small></div>
    </div>
    
<div class="am-panel-hd">

</div>
 
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th>姓名</th><th>手机</th><th>公司座机</th><th>QQ/MSN</th><th>email</th><th>联系人职务</th>
              </tr>
          </thead>
          <tbody>
            <tr class="TableDetail1 template">
                <td>${customerServicersVo.name}&nbsp;</td>
				<td>${customerServicersVo.mobliePhone}&nbsp;</td>
				<td>${customerServicersVo.companyPhone}&nbsp;</td>
				<td>${customerServicersVo.chatTools}&nbsp;</td>
				<td>${customerServicersVo.email}&nbsp;</td>
				<td>${customerServicersVo.position}&nbsp;</td>
            </tr>
          </tbody>
        </table>
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

function createNew()
{
window.location.href="CustomerAction.do?method=addUI";
}

//导出pdf
function exportConfirm(showId)
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){
//openUrl("CustomerAction.do?method=exportExcel&id="+idArr);
//window.open("VisaProductAction.do?method=exportPDF&id="+idArr+"&showId="+showId);
window.location.href="CustomerAction.do?method=exportExcel&id="+idArr+"&type=2";
}
else
{
alert("您还没有选中任何订单!")
}
}
function showName(id)
{
art.dialog.open('CustomerServicersAction.do?method=showNameUI&type=0&id='+id,
{
    title: '客户信息',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    lock:true,
    cancel: function()
    {
    this.close();
    }
});
}
</script>

