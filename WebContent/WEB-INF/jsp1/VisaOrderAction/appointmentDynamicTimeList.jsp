<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
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
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 预约时间动态 (${lingquVo.name }) &nbsp;预约时间即时有效，以实际预约时间为准！
        </div>
        <div id="Title_End"></div>
    </div>
    <div>
</div>

<!-- <div id="QueryArea">
	<div style="height: 30px">
<form action="${basePath}VisaOrderAction.do?method=interviewAppointmentList" method="post">
面试时间:
<input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>

<input type="submit" value="查询"/>
<html:hidden property="pageNum" value="1"/>
<input type="hidden" id="lingquId" name="lingquId" value="${lingquId }"/>
</form>
</div>
</div> -->

<input type="hidden" id="lingquId" name="lingquId" value="${lingquVo.id }"/>
<div id="MainArea">
     
    <table  cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="center" valign="middle" id="TableTitle">
                <th width="35px;"><input type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>洲际</td>
                <td>国家</td>
                <td>签证类型</td>
                <td>最早日期</td>
                <td>备注</td>
                <td>更新人员</td>
                <td>更新日期</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">

       <c:forEach items="${zhouJiList}" var="zhouji">
        <c:forEach items="${pageBean.recordList}" var="visaOrder"  varStatus="status">
    
			<c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
			

		   	<tr class="odd">
			  <th width="35px;"><input class="inputcheckbox" name="ids" value="${visaOrder.id}"  type="checkbox" ></th>  
				<td>
				${ zhouji.name}
				</td>
					<td>
		
				${visaOrder.visaProduct.country.name}
				
				</td>
				<td>
		
				${visaOrder.visaProduct.type.name}
				
				</td>
				<td>
				</td>
				<td>
				</td>
				<td>
				</td>
				<td>
				</td>
			
			<!-- 	<td>
				<c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
				${ visaOrder.visaProduct.country.name}
				</c:if>
				</td>
				<td>
				<c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
				${ visaOrder.visaProduct.type.name}
				</c:if>
				</td>
				<td>
				<c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
				${ visaOrder.visaProduct.lingqu.name}
				</c:if>
				</td>
				<td>${ visaOrder.customer.saler.name}</td>
				<td>${ visaOrder.operator}</td>
				<td>${ visaOrder.sentToSignPeople}</td>
				<td>${ visaOrder.remarksReception}</td> -->
			</tr>
			</c:if>
		</c:forEach>	
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
