<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>客户列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
      <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">客户管理</strong> / <small>客户列表</small></div>
    </div>
    
<div class="am-panel-hd">
<form action="${basePath}background/CustomerAction.do?method=list" method="post">
  <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav">
      <li><select name="param" id="param">
	<option selected="selected" value="name">客户姓名</option>
	<option value="serialNumber">客户编号</option>
	<option value="mobliePhone">手机号码</option>
	<option value="phone">电话号码</option>
	<option value="address">家庭住址</option>
	<option value="chatTools">QQ</option>
	</select>
	</li>
      <li><input id="searchvalue" name="searchvalue" type="text" value=""  style="width:150px;"/></li>
      <li><input type="text" name="startTime"  class="Wdate" style="width:100px;height: 27px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/>--</li>
      <li><input name="endTime" type="text" class="Wdate" style="width:100px;height: 27px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>&nbsp;</li>
      <li><input type="submit" value="搜索"/></li>
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
            <button type="button" class="am-btn am-btn-default" onclick="createNew();"><span class="am-icon-plus"></span> 新增</button>
            <button type="button" class="am-btn am-btn-default" onclick="return exportConfirm();"><span></span> 导出</button>
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
             <th>客户编号</th><th>客户名称</th><th>手机号码</th><th>座机</th><th>QQ/MSN</th><th>email</th><th>销售</th><th>输入人员</th><th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
           <c:forEach items="${pageBean.recordList}" var="customer"  varStatus="status">
            <tr class="TableDetail1 template">
                <td><input class="checkbox1"   name="ids" value="${customer.id}"  type="checkbox" ></td>
                <td>${customer.serialNumber}&nbsp;</td>
				<td>${customer.name}&nbsp;</td>
				<td>${customer.mobliePhone}&nbsp;</td>
				<td>${customer.phone}&nbsp;</td>
				<td>${customer.chatTools}&nbsp;</td>
				<td>${customer.email}&nbsp;</td>
				<td>${customer.saler.name}&nbsp;</td>
				<td>${customer.inputName}</td>
				<td><html:link action="background/CustomerAction?method=editUI&id=${customer.id}">修改</html:link></td>
            </tr>
    	    </c:forEach>
          </tbody>
        </table>
			<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
          <hr/>
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

