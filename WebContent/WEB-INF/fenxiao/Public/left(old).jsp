<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'left.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- ------菜单版块动态控制--------- -->
<script type="text/javascript">
	// param参数的名
	$(function() {
		$(".leve1").hide(100);
	     //		$("#visacenterModel").toggle(100);
		//	$("#orderModel").toggle(100);
		//	$("#dynamicModel").toggle(100);
		var showTree=$("#showTree").val();
		if(showTree!=='')
		{
		$("#"+showTree).toggle(100);
		}
		
	});
		function menuClick(top){
			$(".leve1").not( $(top).siblings("ul")).hide(100); // 把其它二级菜单都隐藏
			$(top).siblings("ul").toggle(100); // 切换当前二级菜单的可见状态
			
			var ulList=$(top).siblings("ul");
			if(ulList.length>0)
			{
			//遍历ul 下的li
			for(var i=0;i<ulList[0].children.length;i++)
			{
			var oldUrl=ulList[0].children[i].children[0].href;
			ulList[0].children[i].children[0].href=oldUrl+"&showTree="+ulList[0].id;
			}
			}
			
			
		}
</script>

  </head>
  
  <body>
  <input type="hidden" id="showTree" name="showTree" value="${showTree }"/>
 <!-- -----------------左边 菜单版块---------------- -->
<div class="left">
	<ul>
			<!-- 签证中心 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 签证中心 -</span>
				<ul class="leve1" id="visacenterModel">
					<li>
						<a href="${basePath}fenxiao/VisaProductFenXiaoAction.do?method=list"><span class="level2Style">签证中心</span></a>
					</li>
				</ul>
			</li>
			
			<!-- 签证订单管理 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 签证订单管理 -</span>
						<ul class="leve1" id="orderModel">
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=1"><span class="level2Style">已预定订单</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=2"><span class="level2Style">已收材料订单</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=3"><span class="level2Style">已审核订单</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=4"><span class="level2Style">已预约订单</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=5"><span class="level2Style">已面试送签</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=6"><span class="level2Style">已出签订单</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=7"><span class="level2Style">已寄回订单</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=8"><span class="level2Style">已完成订单</span></a></li>
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=9"><span class="level2Style">已付款订单</span></a></li>
					</ul>
			</li>
			
			<!-- 预约时间动态 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 预约时间动态 -</span>
				<ul class="leve1"  id="dynamicModel">
				<c:forEach var="lingqu" items="${user_lingquList}">
							<li><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=appointmentDynamicTimeList&lingquId=${lingqu.id }"><span class="level2Style">${lingqu.name }</span></a></li>
				</c:forEach>
				
				</ul>
			</li>
			
			<!-- 签证费/预约费 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 签证费/预约费 -</span>
				<ul class="leve1" id="visaFee">
					<li><span class="level2Style">签证费/预约费列表</span></li>
				</ul>
			</li>
			
			<!-- 保险中心 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 保险中心 -</span>
				<ul class="leve1" id="insurance_center">
					<li><a href="${basePath}fenxiao/InsuranceTypeFenXiaoAction.do?method=list"><span class="level2Style">保险产品</span></a></li>
					<li> <a href="${basePath}fenxiao/InsurancePackageFenXiaoAction.do?method=list"><span class="level2Style">套餐类型</span></a></li>
				</ul>
				
			</li>
			
			<!-- 线路中心 -->
		<!-- 	<li>
				<span class="level1Style" onclick="menuClick(this)">- 线路中心 -</span>
				<ul class="leve1">
					<li><span class="level2Style">旅游线路中心</span></li>
					<li><span class="level2Style">商旅会展中心</span></li>
					<li><span class="level2Style">特色项目中心</span></li>
				</ul>
			</li>
		 -->
		<!-- 线路订单管理 -->
		<!--	<li>
				<span class="level1Style" onclick="menuClick(this)">- 线路订单管理 -</span>
				<ul class="leve1">
					<li>
						<span class="level2Style" onclick="menuClick(this)">+ 线路订单列表</span>
						<ul class="leve2">
							<li><span class="level3Style">已经出发订单</span></li>
							<li><span class="level3Style">未出发订单</span></li>
						</ul>
					</li>
				</ul>
			</li>-->
		<!-- 其他订单 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 其他订单 -</span>
				<ul class="leve1" id="otherOrder">
					<li><span class="level2Style">机票订单</span></li>
					<li><span class="level2Style">酒店订单</span></li>
				</ul>
			</li>
			
		<!-- 用户管理 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 用户管理 -</span>
				<ul class="leve1" id="user">
					<li><a href="${basePath}fenxiao/PeerUserAction.do?method=account_manage"><span class="level2Style">我的资料</span></a></li>
					<li><a href="${basePath}fenxiao/PeerUserAction.do?method=account_manage_password"><span class="level2Style">修改密码</span></a></li>
					<li><a href="${basePath}fenxiao/CustomerServiceFenXiaoAction.do?method=list"><span class="level2Style">客服管理</span></a></li>
				</ul>
			</li>
		<!-- 联系方式 -->
			<li>
				<span class="level1Style" onclick="menuClick(this)">- 联系方式 -</span>
			</li>
		</ul>
</div>
  </body>
</html>

