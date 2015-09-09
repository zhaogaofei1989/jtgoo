<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>版块列表</title>
<%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
 <script language="javascript" type="text/javascript" src="${basePath}/js/colorpicker.js"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
  <script type="text/javascript" src="${basePath}js/colResizable/colResizable-1.5.min.js"></script>
<script src="${basePath}js/multi/jquery.bgiframe.min.js" type="text/javascript"></script>
<script src="${basePath}js/multi/jquery.multiSelect.js" type="text/javascript"></script>
<link href="${basePath}js/multi/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
<link href="${basePath}style/loadingbar/showLoading.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${basePath}js/jquery.showLoading.js"></script>
<style type="text/css">
		tr:hover{background-color: #CEA}
			.explain-col { line-height:35px; margin:5px; padding:5px; word-spacing:1em;}
			.multiSelectOptions,.multiSelect {line-height:20px; margin:0px; padding:0px;}
			a.multiSelect { vertical-align:middle;}
</style>
<script type="text/javascript">
			$(document).ready( function() {
				// Default options
				$("#visa_status").multiSelect({selectAllText:'全选/反选',oneOrMoreSelected:'已选中%条',noneSelected:'请选择'});
				$("#visa_country").multiSelect({selectAllText:'全选/反选',oneOrMoreSelected:'已选中%条',noneSelected:'请选择'});
				$("#visa_type").multiSelect({selectAllText:'全选/反选',oneOrMoreSelected:'已选中%条',noneSelected:'请选择'});
				$("#visa_lingqu").multiSelect({selectAllText:'全选/反选',oneOrMoreSelected:'已选中%条',noneSelected:'请选择'});
				// Show test data
				
			});
		</script>
	
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 签证订单管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<form action="${basePath}background/VisaOrderAction.do?method=list" method="post">
<div class="top">
订单编号:<input type="text" id="serialnumber" name="serialnumber" style="width:80px;"/>

订单状态:<select  name='visa_status[]' id='visa_status' multiple="multiple">
<c:forEach items="${statusList}" var="statu">
<option value="">请选择</option>
<option value="${statu.key}">${statu.value }</option>
</c:forEach>
</select>
销售: 
<select name="search_single">
<option value="">请选择</option>
<c:forEach items="${userList}" var="user">
<option value="${user.name}">${user.name }</option>
</c:forEach>
</select>
录入员:
<select name="recorder">
<option value="">请选择</option>
<c:forEach items="${userList}" var="user">
<option value="${user.name}">${user.name }</option>
</c:forEach>
</select>
操作员:
<select name="operator">
<option value="">请选择</option>
<c:forEach items="${userList}" var="user">
<option value="${user.name}">${user.name }</option>
</c:forEach>
</select>
送签员:
<select name="sentToSignPeople">
<option value="">请选择</option>
<c:forEach items="${userList}" var="user">
<option value="${user.name}">${user.name }</option>
</c:forEach>
</select>

洲际/国家:
<select  name='visa_country[]' id='visa_country' multiple="multiple">
<c:forEach items="${countryList}" var="country">
<option value="${country.id }">${country.name }</option>
<c:forEach items="${country.coutryChild}" var="child">
<option value="${child.id }">┣&nbsp;${child.name }</option>
</c:forEach>
</c:forEach>
</select>
类型:
<select  name='visa_type[]' id='visa_type' multiple="multiple">
<c:forEach items="${visaTypeList}" var="visaType">
<option value="${visaType.id }">${visaType.name }</option>
</c:forEach>
</select>

领区:<select  name='visa_lingqu[]' id='visa_lingqu' multiple="multiple">
<c:forEach items="${lingquList}" var="lingqu">
<option value="${lingqu.id }">${lingqu.name }</option>
</c:forEach>
</select>&nbsp;&nbsp;

面试时间:
<input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>

<select name="customerparam" id="customerparam">
<option selected="selected" value="">客户联系方式</option>
<option value="name">客户姓名</option>
<option value="serialNumber">客户编号</option>
<option value="mobliePhone">手机号码</option>
<option value="phone">家庭电话</option>
<option value="address">家庭住址</option>
<option value="chatTools">QQ</option>
<option value="companyName">用户单位</option>
</select>:
<input type="text" name="search_customerparam" style="width:100px;"/>
联系人: 
<select name="linkmanparam" id="linkmanparam">
<option selected="selected" value="">联系人联系方式</option>
<option value="name">姓名</option>
<option value="mobliePhone">手机号码</option>
<option value="chatTools">QQ</option>
<option value="email">邮箱</option>
</select>:
<input type="text" name="search_linkmanparam" style="width:100px;"/>
全/补全:
不全:<input  type="radio" name="dataIsComplete" value="0"/>
全:<input  type="radio" name="dataIsComplete" value="1"/>
已经收款/未收款:
未收款:<input  type="radio" name="isChart" value="0"/>
已收款:<input  type="radio" name="isChart" value="9"/>
<!--  
拒签/通过:
否:<input  type="radio" name="isRefusal" value="0"/>
是:<input  type="radio" name="isRefusal" value="1"/>
-->
是否代买保险:
否:<input  type="radio" name="buyInsurance" value="0"/>
是:<input  type="radio" name="buyInsurance" value="1"/>
<input type="submit" value="查询"/>
<html:hidden property="pageNum" value="1"/>
</div>
</form>
<div id="MainArea">
     
    <table  id="table" cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="center" valign="middle" id="TableTitle" width="100%" border="0" cellpadding="0" cellspacing="0">
                <th width="35px;"><input type="checkbox" id="check_box" onclick="selectAllId(this.checked);"></th>
            	<td>订单编号</td>
                <td>订单状态</td>
                <td>客户姓名</td>
                <td>手机号码</td>
                <td>用户姓名</td>
                <td>联系人</td>
                <td>国家</td>
                <td>领区</td>
                <td>签证类型</td>
                <td>全/不全</td>
                <td>销售人员</td>
                <td>操作人员</td>
                <td>送签人员</td>
                <td>收入</td>
                <td>支出</td>
                <td>利润</td>
                <td>确认价格</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="visaOrder"  varStatus="status">
			<tr class="odd">
			    <th width="35px;"><input class="inputcheckbox" name="ids" value="${visaOrder.id}"  type="checkbox" ></th>
				<td>
				<label style="font-weight:bolder;" onclick="showVisaOrderInfo(${visaOrder.id })">
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
				  	<td><c:forEach items="${visaOrder.customerSet}" var="customer">
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
				<td>${ visaOrder.visaProduct.country.name}</td>
				<td>${ visaOrder.visaProduct.lingqu.name}</td>
				<td>${ visaOrder.visaProduct.type.name}</td>
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
					<html:link action="/background/VisaOrderAction?method=editUI&id=${visaOrder.id}">修改</html:link>
					<html:link action="/background/VisaOrderAction?method=delete&id=${visaOrder.id}" onclick="return delConfirm()">删除</html:link>
					<c:if test="${ fn:length(visaOrder.customerSet) >1}">
						<label onclick="spiltorder(${visaOrder.id})">拆分订单</label>
					</c:if>
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
      $("#table").colResizable({
		liveDrag:true, 
		postbackSafe:true,
		partialRefresh:true
      });  
    });  

	function createNew() {
		window.location.href="${basePath}/background/VisaOrderAction.do?method=addUI";
	}


	//拆分订单
	function spiltorder(orderId) {
		var d=art.dialog.open('${basePath}background/VisaOrderAction.do?method=splitOrderUI&id='+orderId,
	{
		title: '拆分订单',
	    width: 600,
	    height: 240,
	    left: '50%',
	    top: '10%',
	    lock:true,
	    ok: function() {
		   var d=this.iframe.contentDocument;
		   var orderId=d.getElementById("visaorderId").value;
		   var ids=d.getElementsByName("ids");
		   var checkStr="";
			for(var i=0;i<ids.length;i++) {
				if(ids[i].checked == true) {
					checkStr=checkStr+ids[i].value+",";
				}
			}
   		//由于checkStr 是用,分割的,因此最后一个,分号是多余的,需要 减一
   		var checkLength=checkStr.split(",").length-1;
 
   		if(checkStr=="") {
     		alert("请至少选择一个客户！");
   		}
   		else if(checkLength==ids.length) {
   			alert("选择客户人数必须小于总人数!")
   		} else {
			$.ajax({
 			url: "${basePath}/background/VisaOrderAction.do?method=splitOrder&id="+orderId+"&customerIds="+checkStr, 
 			success: function(msg) {
				alert("拆分成功!");
				window.location.href="${basePath}/background/VisaOrderAction.do?method=list";
			}	
		});
		}
   
   //用js 代码实现获取ids的信息,拆分后获取状态,如果是成功,就关闭当前dialog 否则就弹出失败
	
    	},
    	cancel: function() {
    		this.close();
    	}  
		});
	}
	
	//全选、反选
	function selectAllId(checkedValue) {
		$("[name=ids]").attr("checked", checkedValue);
	}


	//导出pdf
	function exportConfirm() {
		var idArr='';
		$('input[name="ids"]:checkbox:checked').each(function(){
			idArr+=$(this).val()+','; 
		});
		if(idArr.length>0){
			//openUrl("VisaOrderAction.do?method=exportExcel&id="+idArr);
			window.location.href="${basePath}/background/VisaOrderAction.do?method=exportExcel&label=001&id="+idArr;
		} else {
			alert("您还没有选中任何订单!")
		}
	}
	
	function exportConfirm2() {
		var idArr='';
		$('input[name="ids"]:checkbox:checked').each(function() {
			idArr+=$(this).val()+','; 
		});
		if(idArr.length>0) {
			$.ajax({
 				url: "${basePath}/background/VisaOrderAction.do?method=exportExcel&id="+idArr, 
 				success: function(msg) {
					alert("生成成功!");
 				}
			});
		} else {
			alert("您还没有选中任何订单!")
		}
	}
	
	function showCustomerName(visaProductId,cuid) {
		art.dialog.open('${basePath}/background/CustomerAction.do?method=showCustomerNameDetailUI&visaProductId='+visaProductId+'&customerId='+cuid,
		{
		    title: '其他信息',
		    width: 800,
		    height: 440,
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

	function showCustomerInfo(visaProductId,cuid) {
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
	
	function showMemberInfo(visaProductId,cuid) {
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

	function showVisaOrderInfo(orderId) {
		art.dialog.open('${basePath}/background/VisaOrderAction.do?method=showVisaOrderInfo&orderId='+orderId,
		{
	    title: '订单详情',
	    width: '100%',
	   height: 440,
	     left: '50%',
	      top: '2%',
	     lock: true
		});
	}

	function showName(id) {
		art.dialog.open('${basePath}/background/CustomerServicersAction.do?method=showNameUI&id='+id+'&type=0',
		{
		    title: '联系人信息',
		    width: 400,
		    height: 240,
		    left: '50%',
		    top: '10%',
		    lock:true
		});
	}

/**

function showCustomerCompanyInfo(visaProductId,cuid)
{
art.dialog.open('CustomerAction.do?method=showCustomerCompanyInfo&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '客户详情',
    width: 800,
    height: 440,
    left: '50%',
    top: '2%',
    lock:true,
    ok: function()
    {
    },
    cancel: function()
    {
    this.close();
    }
});
}**/
</script>
