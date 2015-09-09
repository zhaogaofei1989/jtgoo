<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
    <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 同业用户
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<form action="${basePath}/background/CustomerAction.do?method=peerlistV2" method="post">
<div class="top">
注册时间:
<input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>
<select name="status">
<option value="">状态</option>
<option value="0">锁定</option>
<option value="1">正常</option>
</select>
<!--  
<select name="review">
<option selected="selected">审核</option>
<option>已审核</option>
<option>为审核</option>
</select>
-->
<select name="peergroup">
<option selected="selected" value="">会员组</option>
<c:forEach items="${peerGroupList}" var="peerGroup">
<option value="${peerGroup.name }">${peerGroup.name }</option>
</c:forEach>
</select>
<select name="type">
<option selected="selected" value="1">用户名</option>
<option value="2">邮箱</option>
<option value="3">公司名称</option>
<option value="4">联系人QQ号码</option>
<option value="5">手机号码</option>
<option value="6">销售人员</option>
<option value="7">联系人姓名</option>
</select>
<input type="text"  name="obj" style="width:150px;"/>
<input type="submit" value="搜索"/>
<html:hidden property="pageNum" value="1"/>
<html:hidden property="pageSize" value="10"/>
</div>
</form>
<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
               <th width="35px;"><input  type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>用户编号</td>
                <td>用户名</td>
                <td>公司名称</td>
                <td>联系人姓名</td>
                <td>联系人手机</td>
                <td>领区</td>
                <td>销售人员</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="customer">
			<tr class="TableDetail1 template">
			 <th width="35px;" style="vertical-align: middle;"><input class="inputcheckbox"   name="ids" value="${customer.id}"  type="checkbox" ></th>
				<td>${customer.serialNumber}&nbsp;</td>
				<td>${customer.userName}&nbsp;</td>
				<td>${customer.companyName}&nbsp;</td>
				<td>	<c:forEach items="${customer.customerServicers}" var="cur">
				<label style="font-weight:bolder;" onclick="showName(${cur.id})">${cur.name }</br></label>
				    </c:forEach></td>
				<td>	
				<c:forEach items="${customer.customerServicers}" var="cur">
				<label>${cur.mobliePhone }</br></label>
				    </c:forEach></td>
				<td>
				       <c:forEach items="${customer.lingquSet}" var="lingqu">
				       	${lingqu.name}&nbsp;
				       </c:forEach>
				</td>
				<td>${customer.saler.name}&nbsp;</td>
				<td>
					<html:link action="background/CustomerAction?method=editPeerUI&id=${customer.id}">修改</html:link>
				</td>
			</tr>
		</c:forEach>	
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">								
         		<input type="button" class="cmd" onclick="createNew('CustomerAction.do?method=addPeerUI');" value="新建"/>
               <input type="button" class="cmd" onclick="return exportConfirm();" value="导出excel"/>
                 <input type="button" class="cmd" onclick="deleteBatch();" value="批量删除"/> 
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
