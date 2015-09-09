<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>签证订单</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
     <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
 <link type="text/css" rel="stylesheet" href="${basePath}js/table/tablesaw.css" />
  <script language="javascript" src="${basePath}js/table/tablesaw.js"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
</head>
<body style="font-size: 1.2rem;">
 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证订单管理</strong> / <small>签证订单列表</small></div>
    </div>
    
<div class="am-panel-hd">
<form action="${basePath}/background/VisaOrderAction.do?method=list" method="post">
  <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav">
      <li> &nbsp;订单编号: <input type="text" id="serialnumber" name="serialnumber" style="width:120px;"/>
	 订单状态:
      <select  name='visa_status[]' id='visa_status' multiple="multiple"  multiple data-am-selected="{ btnSize: 'sm'}">
	<option value="">请选择</option>
	<c:forEach items="${statusList}" var="statu">
	<option value="${statu.key}">${statu.value }</option>
	</c:forEach>
	</select>
	  	 销售: 
		<select name="search_single" data-am-selected="{ btnSize: 'sm'}">
		<option value="">请选择</option>
		<c:forEach items="${userList}" var="user">
		<option value="${user.name}">${user.name }</option>
		</c:forEach>
		</select>
	  	 录入员: 
		<select name="search_single" data-am-selected="{ btnSize: 'sm'}">
		<option value="">请选择</option>
		<c:forEach items="${userList}" var="user">
		<option value="${user.name}">${user.name }</option>
		</c:forEach>
		</select>
		 </li>
		 <li>操作员: 
		<select name="operator" data-am-selected="{ btnSize: 'sm'}">
		<option value="">请选择</option>
		<c:forEach items="${userList}" var="user">
		<option value="${user.name}">${user.name }</option>
		</c:forEach>
		</select>
     
	  	 送签员: 
		<select name="sentToSignPeople" data-am-selected="{ btnSize: 'sm'}">
		<option value="">请选择</option>
		<option value="">请选择</option>
		<c:forEach items="${userList}" var="user">
		<option value="${user.name}">${user.name }</option>
		</c:forEach>
		</select>
     
  
      洲际/国家: <select name='visa_country[]' id='visa_country' multiple data-am-selected="{maxHeight: 200, btnSize: 'sm'}">
		<c:forEach items="${countryList}" var="country">
		<option value="${country.id }" disabled="disabled">${country.name }</option>
		<c:forEach items="${country.coutryChild}" var="child">
		<option value="${child.id }">  &nbsp;┣${child.name }</option>
		</c:forEach>
		</c:forEach>
	</select>

      类型:
	 <select  name='visa_type[]' id='visa_type' multiple data-am-selected="{ btnSize: 'sm'}">
	<c:forEach items="${visaTypeList}" var="visaType">
	<option value="${visaType.id }">${visaType.name }</option>
	</c:forEach>
	</select>
	<li>领区:
	 <select name='visa_lingqu[]' id='visa_lingqu' multiple data-am-selected="{ btnSize: 'sm'}">
	<c:forEach items="${lingquList}" var="lingqu">
	<option value="${lingqu.id }">${lingqu.name }</option>
	</c:forEach>
	</select>
	面试时间: <input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>&nbsp;
     客户信息:
 	 <select name="customerparam" id="customerparam" data-am-selected="{ btnSize: 'sm'}">
	<option selected="selected" value="">客户联系方式</option>
	<option value="name">客户姓名</option>
	<option value="serialNumber">客户编号</option>
	<option value="mobliePhone">手机号码</option>
	<option value="phone">家庭电话</option>
	<option value="address">家庭住址</option>
	<option value="chatTools">QQ</option>
	<option value="companyName">用户单位</option>
	</select>:
	<input type="text" name="search_linkmanparam" style="width:100px;"/>
	</li>
	<li>
      联系人:
	<select name="linkmanparam" id="linkmanparam" data-am-selected="{ btnSize: 'sm'}">
	<option selected="selected" value="">联系人联系方式</option>
	<option value="name">姓名</option>
	<option value="mobliePhone">手机号码</option>
	<option value="chatTools">QQ</option>
	<option value="email">邮箱</option>
	</select>:
	<input type="text" name="search_customerparam" style="width:100px;"/>
	&nbsp;
	<span>
	全/补全:
	</span>
	不全:<input  type="radio" name="dataIsComplete" value="0"/>
	全:<input  type="radio" name="dataIsComplete" value="1"/>
	
&nbsp;
已经收款/未收款:
未收款:<input  type="radio" name="isChart" value="0"/>
已收款:<input  type="radio" name="isChart" value="9"/>
是否代买保险:
否:<input  type="radio" name="buyInsurance" value="0"/>
是:<input  type="radio" name="buyInsurance" value="1"/>
<input type="submit" value="查询"/>
      </li>
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
          	<iamp-identify:IAMPIdentify authid="04_04_05_00">
            	<button type="button" class="am-btn am-btn-default" onclick="createNew();"><span class="am-icon-plus"></span> 新增</button>
            </iamp-identify:IAMPIdentify>
            <iamp-identify:IAMPIdentify authid="04_04_06_00">
            	<button type="button" class="am-btn am-btn-default" onclick="return exportConfirm();"><span></span>导出excel</button>
          	</iamp-identify:IAMPIdentify>
          </div>
        </div>
      </div>
    </div>
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table-centered am-table am-table-bordered am-table-striped am-table-compact am-table-hover tablesaw"  data-tablesaw-mode="columntoggle" id="table">
            <thead>
              <tr>
            	<th scope="col" data-tablesaw-sortable-col data-tablesaw-priority="persist"><input  type="checkbox" id="check_box"/></th>
            	<th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="1">订单编号</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="2">订单状态</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="3">客户姓名</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="4">手机号码</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="5">用户姓名</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="19">联系人</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="7">国家</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="8">领区</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="9">签证类型</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="10">全/不全</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="11">销售人员</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="12">操作人员</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="13">送签人员</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="14">收入</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="15">支出</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="16">利润</th>
                <th data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="17">确认价格</th>
           	  <th class="table-set" data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="18">操作</th>
              </tr>
          </thead>
           <tbody>
            <c:forEach items="${pageBean.recordList}" var="visaOrder"  varStatus="status">
             <tr class="TableDetail1 template">
             <td><input class="checkbox1"   name="ids" value="${visaOrder.id}"  type="checkbox" ></td>
			 <td><label style="font-weight:bolder;" onclick="showVisaOrderInfo(${visaOrder.id })">
				${visaOrder.serialnumber}
				</label>
			</td>
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
				已预约
				</c:when>
				<c:when test="${visaOrder.status==5}">
				已面试/送签
				</c:when>
				<c:when test="${visaOrder.status==6}">
				已出签
				</c:when>
				<c:when test="${visaOrder.status==7}">
				已寄回
				</c:when>
				<c:when test="${visaOrder.status==8}">
				已完成
				</c:when>
				<c:when test="${visaOrder.status==9}">
				已付款
				</c:when>
				</c:choose>
				</td>
				<td> <c:forEach items="${visaOrder.customerSet}" var="customer">
				  		 <label style="font-weight:bolder;" onclick='showCustomerName(${visaOrder.visaProduct.id },${customer.id})'>
				  		 	  ${customer.name}
				  		 </label>
							<br/>
				  		 </c:forEach>
				 </td>
				<td><c:forEach items="${visaOrder.customerSet}" var="customer">
				  		  ${customer.phone}
						 <br/>
				  		 </c:forEach>
				</td>
				<td>
				<c:choose>
				<c:when test="${visaOrder.user_type eq 0}">
				<label style="font-weight:bolder;" onclick='showCustomerInfo(${visaOrder.visaProduct.id },${visaOrder.customer.id})'>
				${ visaOrder.customer.userName}
				</label>
				</c:when>
				<c:when test="${visaOrder.user_type eq 1}">
				<label style="font-weight:bolder;" onclick='showMemberInfo(${visaOrder.visaProduct.id },${visaOrder.member.id})'>
				${ visaOrder.member.userName}
				</label>
				</c:when>
				</c:choose>
				</td>
				
				<td>
				<label style="font-weight:bolder;" onclick="showName(${visaOrder.customerServicers eq null ?'':visaOrder.customerServicers.id})">${visaOrder.customerServicers eq null ?'':visaOrder.customerServicers.name }<br/></label>
				</td>
				<td> ${visaOrder.visaProduct.country.name} </td>
				<td> ${visaOrder.visaProduct.lingqu.name} </td>
				<td> ${visaOrder.visaProduct.type.name} </td>
				<td>
					<c:choose>
					<c:when test="${visaOrder.dataIsComplete eq 0}">
					不全
					</c:when>
					<c:when test="${visaOrder.dataIsComplete eq 1}">
					全
					</c:when>
					</c:choose>
				</td>
				<td>${ visaOrder.single}</td>
				<td>${ visaOrder.operator}</td>
				<td>${ visaOrder.sentToSignPeople}</td>
				<td>${ visaOrder.orderReceivedPrice}</td>
				<td>${ visaOrder.profit}</td>
				<td>${ visaOrder.orderPrice}</td>
				<td>${ visaOrder.orderSurePrice}</td>
				<td>
					<iamp-identify:IAMPIdentify authid="04_04_03_00">
						<html:link action="/background/VisaOrderAction?method=editUI&id=${visaOrder.id}">修改</html:link>
					</iamp-identify:IAMPIdentify>
					<iamp-identify:IAMPIdentify authid="04_04_04_00">
						<html:link action="/background/VisaOrderAction?method=delete&id=${visaOrder.id}" onclick="return delConfirm()">删除</html:link>
					</iamp-identify:IAMPIdentify>
					<c:if test="${ fn:length(visaOrder.customerSet) >1}">
					<label onclick="spiltorder(${visaOrder.id})">拆分订单</label>
					</c:if>
				</td>
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
window.location.href="${basePath}/background/VisaOrderAction.do?method=addUI";

}


//拆分订单
function spiltorder(orderId)
{
var d=art.dialog.open('${basePath}background/VisaOrderAction.do?method=splitOrderUI&id='+orderId,
{
	title: '拆分订单',
    width: 800,
    height: 640,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
   var d=this.iframe.contentDocument;
   var orderId=d.getElementById("visaorderId").value;
   var ids=d.getElementsByName("ids");
   var checkStr="";
   for(var i=0;i<ids.length;i++)
   {
    if(ids[i].checked == true)
    {
    checkStr=checkStr+ids[i].value+",";
    }
   }
   //由于checkStr 是用,分割的,因此最后一个,分号是多余的,需要 减一
   var checkLength=checkStr.split(",").length-1;
 
   if(checkStr=="")
   {
     alert("请至少选择一个客户！");
   }
   else if(checkLength==ids.length)
   {
   alert("选择客户人数必须小于总人数!")
   }
else
{

$.ajax({
 url: "${basePath}/background/VisaOrderAction.do?method=splitOrder&id="+orderId+"&customerIds="+checkStr, 
 success: function(msg){
 
alert("拆分成功!");
window.location.href="${basePath}/background/VisaOrderAction.do?method=list";

 }
});

}
   
   //用js 代码实现获取ids的信息,拆分后获取状态,如果是成功,就关闭当前dialog 否则就弹出失败
	
    },
    cancel: function()
    {
    this.close();
    }
    
});




}
//全选、反选
function selectAllId(checkedValue){
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
window.location.href="${basePath}/background/VisaOrderAction.do?method=exportExcel&label=001&id="+idArr;

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
 url: "${basePath}/background/VisaOrderAction.do?method=exportExcel&id="+idArr, 
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
art.dialog.open('${basePath}/background/CustomerAction.do?method=showCustomerNameDetailUI&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '其他信息',
    width: 800,
    height: 640,
    left: '50%',
    top: '2%',
    lock:true,
    button: [
        {
            name: '打印pdf',
            callback: function () {
           var printData=this.iframe.contentDocument.getElementById("printpdf").innerHTML;
           this.iframe.contentWindow.print();
           this.close();
            },
            focus: true
        }]
});
}

function showCustomerInfo(visaProductId,cuid)
{
art.dialog.open('${basePath}/background/CustomerAction.do?method=showCustomerInfo&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '用户详情',
    width: 800,
    height: 440,
    left: '50%',
    top: '2%',
    lock:true
});
}
function showMemberInfo(visaProductId,cuid)
{
art.dialog.open('${basePath}/background/MemberAction.do?method=showMemberInfo&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '用户详情',
    width: 800,
    height: 440,
    left: '50%',
    top: '2%',
    lock:true
});
}


function showVisaOrderInfo(orderId)
{
art.dialog.open('${basePath}/background/VisaOrderAction.do?method=showVisaOrderInfo&orderId='+orderId,
{
    title: '订单详情',
    width: '100%',
    height: 440,
    left: '50%',
     top: '2%',
    lock:true
});
}
function showName(id)
{
art.dialog.open('${basePath}/background/CustomerServicersAction.do?method=showNameUI&id='+id+'&type=0',
{
    title: '联系人信息',
    width: 600,
    height: 340,
    left: '50%',
    top: '10%',
    lock:true
});
}



</script>
