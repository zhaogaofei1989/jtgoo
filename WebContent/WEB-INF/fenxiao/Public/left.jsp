<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
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
<!--  <script type="text/javascript">
		$(function() {
			$('.leve1').hide();
			$('.level1Style').click(function() {
				var click=$(this);
				var $this = $(this).siblings();
				$this.toggle('fast');
				$('.level1Style').siblings().not($this).hide('fast');
				
				
				//遍历ul 下的li
				for(var i=0;i<click.children.length;i++)
				{
				var oldUrl=click.children[i].children[0].href;
				click.children[i].children[0].href=oldUrl+"&showTree="+click.id;
				
				}
			});
		});
    </script>-->
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
			var oldUrl=ulList[0].children[i].children[0].children[0].href;
			ulList[0].children[i].children[0].children[0].href=oldUrl+"&showTree="+ulList[0].id;
			}
			}
			
			
		}
</script>

</head>

<body>
	<input type="hidden" id="showTree" name="showTree" value="${showTree }" />
	<div class="left">
        <ul>
            <!-- 签证中心 -->
            <li>
                <span class="level1Style" onclick="menuClick(this)">- 签证中心 -</span>
                <ul class="leve1" id="visacenterModel">
                    <li>
                        <span class="level2Style"><a href="${basePath}fenxiao/VisaProductFenXiaoAction.do?method=list">签证中心</a></span>
                    </li>
                </ul>
            </li>
            
            <!-- 签证订单管理 -->
            <li>
                <span class="level1Style" onclick="menuClick(this)">- 签证订单管理 -</span>
                <ul class="leve1" id="orderModel">
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=1">已预定订单</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=2">已收材料订单</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=3">已审核订单</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=4">已预约订单</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=5">已面试送签</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=6">已出签订单</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=7">已寄回订单</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=8">已完成订单</a></span></li>
                            <li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=9">已付款订单</a></span></li>
                </ul>
            </li>
            
            <!-- 预约时间动态 -->
            <li>
                <span class="level1Style" onclick="menuClick(this)">- 预约时间动态 -</span>
                <ul class="leve1" id="dynamicModel">
					<c:forEach var="lingqu" items="${user_lingquList}">
						<li><span class="level2Style"><a href="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=appointmentDynamicTimeList&lingquId=${lingqu.id }">${lingqu.name }</a></span></li>
					</c:forEach>
                </ul>
            </li>
            
            <!-- 签证费/预约费 -->
            <li>
                <span class="level1Style" onclick="menuClick(this)">- 签证费/预约费 -</span>
                <ul class="leve1" id="visaFee">
                    <li><span class="level2Style"><a href="${basePath}fenxiao/VisaProductFenXiaoAction.do?method=paid_order">签证费/预约费列表</a></span></li>
                </ul>
            </li>
            
            <!-- 保险中心 -->
            <li>
                <span class="level1Style" onclick="menuClick(this)">- 保险中心 -</span>
                <ul class="leve1" id="insurance_center">
                    <li><span class="level2Style"><a href="${basePath}fenxiao/InsuranceTypeFenXiaoAction.do?method=list">保险产品</a></span></li>
                    <li><span class="level2Style"><a href="${basePath}fenxiao/InsurancePackageFenXiaoAction.do?method=list">套餐类型</a></span></li>
                </ul>
            </li>
            
            <!-- 线路中心 -->
          <!--  <li>
                <span class="level1Style" onclick="menuClick(this)">- 线路中心 -</span>
                <ul class="leve1">
                    <li><span class="level2Style"><a href="#">旅游线路中心</a></span></li>
                    <li><span class="level2Style">商旅会展中心</span></li>
                    <li><span class="level2Style">特色项目中心</span></li>
                </ul>
            </li>
          -->
        <!-- 线路订单管理 -->
          <!--   <li>
                <span class="level1Style" onclick="menuClick(this)">- 线路订单管理 -</span>
                <ul class="leve1">
                    <li><span class="level2Style"><a href="#">线路订单列表</a></span></li>
                    <li><span class="level2Style">已经出发订单</span></li>
                    <li><span class="level2Style">未出发订单</span></li>
                </ul>
            </li>
         -->
        <!-- 其他订单 -->
          <!--   <li>
                <span class="level1Style" onclick="menuClick(this)">- 其他订单 -</span>
                <ul class="leve1" id="otherOrder">
                    <li><span class="level2Style"><a href="#">机票订单</a></span></li>
                    <li><span class="level2Style"><a href="#">酒店订单</a></span></li>
                </ul>
            </li>
           -->  
        <!-- 用户管理 -->
            <li>
                <span class="level1Style" onclick="menuClick(this)">- 用户管理 -</span>
                <ul class="leve1" id="user">
                    <li><span class="level2Style"><a href="${basePath}fenxiao/PeerUserAction.do?method=account_manage">我的资料</a></span></li>
                    <li><span class="level2Style"><a href="${basePath}fenxiao/PeerUserAction.do?method=account_manage_password">修改密码</a></span></li>
                    <li><span class="level2Style"><a href="${basePath}fenxiao/CustomerServiceFenXiaoAction.do?method=list">客服管理</a></span></li>
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