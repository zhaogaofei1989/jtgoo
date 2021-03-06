<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
        <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
          <script type="text/javascript" src="${basePath}js/colResizable-1.3.min.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 客户管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<div id="QueryArea">
<div style="height: 30px">
<form action="${basePath}background/CustomerAction.do?method=list" method="post">
<select name="param" id="param">
<option selected="selected" value="name">客户姓名</option>
<option value="serialNumber">客户编号</option>
<option value="mobliePhone">手机号码</option>
<option value="phone">电话号码</option>
<option value="address">家庭住址</option>
<option value="chatTools">QQ</option>
</select>
<input id="searchvalue" name="searchvalue" type="text" value=""  style="width:150px;"/>
<input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>
<input type="submit" value="搜索"/>
   <html:hidden property="pageNum" value="1"/>
	<html:hidden property="pageSize" value="10"/>
</form>
</div>
</div>
<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
               <th width="35px;"><input  type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>客户编号</td>
                <td>客户名称</td>
                <td>手机号码</td>
                <td>家庭电话</td>
                <td>QQ/MSN</td>
                <td>邮箱地址</td>
                <td>销售人员</td>
                <td>输入人员</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
         
        <c:forEach items="${pageBean.recordList}" var="customer"  varStatus="status">
			<tr class="TableDetail1 template">
				 <th width="35px;" style="vertical-align: middle;"><input class="inputcheckbox"   name="ids" value="${customer.id}"  type="checkbox" ></th>
				<td>${customer.serialNumber}&nbsp;</td>
				<td>${customer.name}&nbsp;</td>
				<td>${customer.mobliePhone}&nbsp;</td>
				<td>${customer.phone}&nbsp;</td>
				<td>${customer.chatTools}&nbsp;</td>
				<td>${customer.email}&nbsp;</td>
				<td>${customer.saler.name}&nbsp;</td>
				<td>${customer.operator}</td>
				<td>
					<html:link action="background/CustomerAction?method=editUI&id=${customer.id}">修改</html:link>
				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
                <input type="button" class="cmd" onclick="createNew();" value="新建"/>
                <input type="button" class="cmd" onclick="return exportConfirm();" value="导出excel"/>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
<div class="Description">
	说明：<br />

</div>

</body>
</html>

<script type="text/javascript">
   $(function(){  
      $("table").colResizable();  
    });  
function createNew()
{
window.location.href="CustomerAction.do?method=addUI";
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

