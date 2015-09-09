<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="${basePath}/js/colorpicker.js"></script>
	<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
	<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
</head>
<body>
 <!-- content start -->
	<div class="admin-content">
		<div class="am-cf am-padding">
      		<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">面试预约提醒 (${lingquVo.name })</strong></div>
    	</div>
     
    	<div class="am-g">
      		<div class="am-u-sm-12 am-u-md-6">
        		<div class="am-btn-toolbar">
          			<div class="am-btn-group am-btn-group-xs">
            			<button type="button" class="am-btn am-btn-default" onclick="return exportConfirm();"> 导出excel...</button>
          			</div>
        		</div>
      		</div>
      	</div>
      	
      	<div class="am-panel-hd" style="margin-left: 555px">
			<form action="${basePath}background/VisaOrderAction.do?method=interviewAppointmentList" method="post">
				<div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
					<ul class="am-nav am-nav-pills am-topbar-nav">
						<li>面试时间:&nbsp
							<input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})" />
							&nbsp;&nbsp;&nbsp;&nbsp</li>
						<li><input class="am-btn am-btn-default" type="submit" value="查询" /></li>
					</ul>
				</div>
				<html:hidden property="pageNum" value="1"/>
				<input type="hidden" id="lingquId" name="lingquId" value="${lingquVo.id }"/>
			</form>
		</div>

    <div class="am-g">
      <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th class="table-check">
                	<input type="checkbox" id="check_box" />
                </th>
				<th class="table-id">订单ID</th>
                <th class="table-title">订单状态</th>
                <th class="table-title">客户姓名</th>
                <th class="table-title">电话/手机</th>
                <th class="table-title">用户名</th>
                <th class="table-title">洲际/国家</th>
                <th class="table-title">签证类型</th>
                <th class="table-title">面试时间</th>
                <th class="table-title">销售人员</th>
                <th class="table-title">操作人员</th>
                <th class="table-title">送签人员</th>
                <th class="table-title">送签备注</th>
              </tr>
          	</thead>
			<tbody id="TableData">
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
						<td>
							<c:forEach items="${visaOrder.customerSet}" var="customer">
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
	        
			<div class="am-cf">
			  共 ${pageBean.recordCount }条记录
				<div class="am-fr">
				  <ul class="am-pagination">
				    <li class="am-disabled"><a href="#">«</a></li>
						<c:forEach begin="${pageBean.beginPageIndex}" end="${pageBean.endPageIndex}" var="num" >
							<c:if test="${pageBean.currentPage eq num}">
								<li class="am-active"><a href="${basePath}fenxiao/CustomerFenXiaoAction.do?method=contentUI&pageNum=${num }">${num }</a></li>
							</c:if>
							<c:if test="${pageBean.currentPage ne num}">
								<li><a  href="${basePath}fenxiao/CustomerFenXiaoAction.do?method=contentUI&pageNum=${num }">${num }</a></li>
							</c:if>
						</c:forEach>
					<li><a href="#">»</a></li>
				  </ul>
				</div>
			</div>
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
	var onoff = true;
	$('#check_box').click(function() {
		if(onoff) {
			$('[name=ids]').slice(0).prop('checked',true);
		} else {
			$('[name=ids]').slice(0).prop('checked',false);
		}
		onoff = !onoff;
	});
	
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
 
</script>
