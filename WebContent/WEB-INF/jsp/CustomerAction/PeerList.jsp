<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>同业用户列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
         <script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
         <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>

 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">同业用户管理</strong> / <small>同业用户列表</small></div>
    </div>
    
<div class="am-panel-hd">
<form action="${basePath}/background/CustomerAction.do?method=peerlistV2" method="post">
  <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav" style="margin: 0 0 10px 20px">
      <li>注册时间:
		<input type="text" name="startTime"  class="Wdate" style="width:100px;height: 22px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;height: 22px;"  value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>
	 </li>
      <li style="margin-left: 25px"><select name="status" style="border-style: solid; border-width: 1px; border-color: #999999">
		<option value="">状态</option>
		<option value="0">锁定</option>
		<option value="1">正常</option>
		</select>
		</li>
      <li style="margin-left: 25px">
      <select name="peergroup" style="border-style: solid; border-width: 1px; border-color: #999999">
	<option selected="selected" value="">会员组</option>
	<c:forEach items="${peerGroupList}" var="peerGroup">
	<option value="${peerGroup.name }">${peerGroup.name }</option>
	</c:forEach>
	</select>
	</li>
      <li style="margin-left: 25px">
		<select name="type" style="border-style: solid; border-width: 1px; border-color: #999999">
		<option selected="selected" value="1">用户名</option>
		<option value="2">邮箱</option>
		<option value="3">公司名称</option>
		<option value="4">联系人QQ号码</option>
		<option value="5">手机号码</option>
		<option value="6">销售人员</option>
		<option value="7">联系人姓名</option>
		</select>
        :
	</li>
      <li><input type="text"  name="obj" style="width:150px; border-style: solid; border-width: 1px; border-color: #999999" /></li>
      <li>&nbsp;&nbsp;<input type="submit" value="查询"/></li>
    </ul>
   </div>
      <html:hidden property="pageNum" value="1"/>
	<html:hidden property="pageSize" value="10"/>
  </form>

</div>
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
            <button type="button" class="am-btn am-btn-default" onclick="createNew('CustomerAction.do?method=addPeerUI');"><span class="am-icon-plus"></span> 新增</button>
            <button type="button" class="am-btn am-btn-default" onclick="return exportConfirm();"> 导出excel</button>
            <button type="button" class="am-btn am-btn-default" onclick="deleteBatch();"> 批量删除</button>
          </div>
        </div>
      </div>
    </div>
  
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/CustomerAction.do?method=peerlistV2" method="post">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th><input  type="checkbox" id="check_box"/></th>
         	    <th>用户编号</th>
                <th>用户名</th>
                <th>公司名称</th>
                <th>销售人员</th>
             	<th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
            <c:forEach items="${pageBean.recordList}" var="customer">
           	 <tr class="TableDetail1 template">
           	    <td><input class="checkbox1"   name="ids" value="${customer.id}"  type="checkbox" ></td>
             <td>${customer.serialNumber}&nbsp;</td>
				<td>${customer.userName}&nbsp;</td>
				<td>${customer.companyName}&nbsp;</td>
				<td>${customer.saler.name}&nbsp;</td>
				<td>
					<html:link action="background/CustomerAction?method=editPeerUI&id=${customer.id}">修改</html:link>
				</td>
            </tr>
    	    </c:forEach>
          </tbody>
        </table>
						<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
          <hr />
          <p>注：.....</p>
        </form>
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
