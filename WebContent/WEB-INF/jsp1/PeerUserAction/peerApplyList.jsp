<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>同业用户申请管理</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">同业用户申请管理</strong> / <small>同业用户申请列表</small></div>
    </div>
    
<div class="am-panel-hd">
</div>
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
          </div>
        </div>
      </div>
    </div>
  
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
         	    <td>联系人</td>
                <td>联系人号码</td>
                <td>联系人QQ</td>
                <td>公司名称</td>
                <td>公司地址</td>
                <td>公司电话</td>
                <td>职务</td>
              </tr>
          </thead>
          <tbody>
            <c:forEach items="${pageBean.recordList}" var="pageBean">
           	 <tr>
             	<td>${pageBean.name }</td>
				<td>${pageBean.phone }</td>
				<td>${pageBean.email }</td>
				<td>${pageBean.companyName }</td>
				<td>${pageBean.companyAddr }</td>
				<td>${pageBean.companyPhone }</td>
				<td>${pageBean.position }</td>
				<!--  <td>${pageBean.name }</td>-->
				<td>
				<!-- 	<html:link action="/PeerGroupAction?method=editUI&id=${pageBean.id}">修改</html:link>
					<html:link action="/PeerGroupAction?method=delete&id=${pageBean.id}">删除</html:link> -->
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
window.location.href="CustomerAction.do?method=exportExcel&id="+idArr+'&type=0';
}
else
{
alert("您还没有选中任何订单!")
}
}
function showName(id)
{
art.dialog.open('CustomerServicersAction.do?method=showNameUI&id='+id+'&type=0',
{
    title: '客服信息',
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

function  deleteBatch()
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0)
{
 if(confirm("确定要删除所选数据吗？"))
 	{
window.location.href="CustomerAction.do?method=deleteBatch&ids="+idArr+"&ctype=0";
	}
}
else
{
alert("您还没有选中任何用户!");

}
}

</script>
