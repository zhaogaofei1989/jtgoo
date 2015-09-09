<%@ page language="java" pageEncoding="UTF-8"%>
.<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>版块列表</title>
<%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
 <script language="javascript" type="text/javascript" src="${basePath}/js/colorpicker.js"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
<script type="text/javascript" src="${basePath}js/colResizable-1.3.min.js"></script>
<style type="text/css">
		tr:hover{background-color: #CEA}
			.explain-col { line-height:35px; margin:5px; padding:5px; word-spacing:1em;}
			.multiSelectOptions,.multiSelect {line-height:20px; margin:0px; padding:0px;}
			a.multiSelect { vertical-align:middle;}
</style>
</head>
<body>
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 面试预约提醒 (${lingquVo.name })
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<div id="QueryArea">
	<div style="height: 30px">
<form action="${basePath}background/VisaOrderAction.do?method=interviewAppointmentList" method="post">
面试时间:
<input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>

<input type="submit" value="查询"/>
<html:hidden property="pageNum" value="1"/>
<input type="hidden" id="lingquId" name="lingquId" value="${lingquVo.id }"/>
</form>
</div>
</div>
<div id="MainArea">
     
    <table  cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="center" valign="middle" id="TableTitle">
                <th width="35px;"><input type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>订单ID</td>
                <td>订单状态</td>
                <td>客户姓名</td>
                <td>电话/手机</td>
                <td>用户名</td>
                <td>洲际/国家</td>
                <td>签证类型</td>
                <td>面试时间</td>
                <td>销售人员</td>
                <td>操作人员</td>
                <td>送签人员</td>
                <td>送签备注</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="visaOrder"  varStatus="status">
			<tr class="odd">
			    <th width="35px;"><input class="inputcheckbox" name="ids" value="${visaOrder.id}"  type="checkbox" ></th>
				<td>${visaOrder.serialnumber}</td>
				<td>
				<c:choose>
				<c:when test="${visaOrder.status==0||visaOrder.status==null}">
				  未审核
				</c:when>
				<c:when test="${visaOrder.status==1}">
				已预订
				</c:when>
				<c:when test="${visaOrder.status==2}">
				已收到材料
				</c:when>
				<c:when test="${visaOrder.status==3}">
				已审核材料
				</c:when>
				<c:when test="${visaOrder.status==4}">
				已付款
				</c:when>
				<c:when test="${visaOrder.status==5}">
				已预约
				</c:when>
				<c:when test="${visaOrder.status==6}">
				已面试/送签
				</c:when>
				<c:when test="${visaOrder.status==7}">
				已出签
				</c:when>
				<c:when test="${visaOrder.status==8}">
				已寄回
				</c:when>
				<c:when test="${visaOrder.status==9}">
				已完成
				</c:when>
				</c:choose>

				</td>
				
				<td>
				  		 <c:forEach items="${visaOrder.customerSet}" var="customer">
				  		 <label style="font-weight:bolder;" onclick='showCustomerName(${visaOrder.visaProduct.id },${customer.id})'>
				  		 	  ${customer.name}
				  		 </label>
							<br/>
				  		 </c:forEach>
						</td>
				<td> <c:forEach items="${visaOrder.customerSet}" var="customer">
				  		  ${customer.phone}
						 <br/>
				  		 </c:forEach>
					</td>
				<td>${ visaOrder.customer.name}</td>
				<td>${ visaOrder.visaProduct.country.name}</td>
				<td>${ visaOrder.visaProduct.type.name}</td>
				<td>${ visaOrder.interviewTime}</td>
				<td>${ visaOrder.customer.saler.name}</td>
				<td>${ visaOrder.operator}</td>
				<td>${ visaOrder.sentToSignPeople}</td>
				<td>${ visaOrder.remarksReception}</td>
			</tr>
		</c:forEach>	
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
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

//全选、反选
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
}


//导出pdf
function exportConfirm()
{

var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){
//openUrl("VisaOrderAction.do?method=exportExcel&id="+idArr);
window.location.href="VisaOrderAction.do?method=exportExcel&label=002&id="+idArr+"&lingquId="+$("#lingquId").val();

}
else
{
alert("您还没有选中任何订单!")
}
}
function exportConfirm2()
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});

if(idArr.length>0)
{
$.ajax({
 url: "VisaOrderAction.do?method=exportExcel&id="+idArr, 
 success: function(msg){
alert("生成成功!");
 }
});
}
else
{
alert("您还没有选中任何订单!")
}


 
}
function showCustomerName(visaProductId,cuid)
{
art.dialog.open('CustomerAction.do?method=showCustomerNameDetailUI&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '其他信息',
    width: 800,
    height: 440,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    },
    cancel: function()
    {
    this.close();
    }
});
}

function showCustomerId(visaProductId,cuid)
{
art.dialog.open('CustomerAction.do?method=showCustomerIdDetailUI&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '客户详情',
    width: 800,
    height: 440,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    
    },
    cancel: function()
    {
    this.close();
    }
});
}


function showCustomerInfo(visaProductId,cuid)
{
art.dialog.open('CustomerAction.do?method=showCustomerInfo&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '客户详情',
    width: 800,
    height: 440,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    },
    cancel: function()
    {
    this.close();
    }
});
}


function showCustomerCompanyInfo(visaProductId,cuid)
{
art.dialog.open('CustomerAction.do?method=showCustomerCompanyInfo&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '客户详情',
    width: 800,
    height: 440,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    },
    cancel: function()
    {
    this.close();
    }
});
}
    $(function(){  
      $("table").colResizable();  
    });  



</script>
