<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>签证产品预订</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
 <!-- content start -->
	<div class="admin-content">
		<div class="am-cf am-padding">
      		<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证产品预订</strong> / <small>预定管理列表</small></div>
    	</div>

    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/ReserveOrderAction.do?method=list" method="post">
        	<html:hidden property="pageNum" value="1" />
			<html:hidden property="pageSize" value="10" />
	        <table class="am-table am-table-striped am-table-hover table-main">
	            <thead>
	              <tr>
	                <th>编号</th>
	                <th>产品名称</th>
	                 <th>订单价格</th>
	                <th>客户姓名</th>
	                <th>联系电话</th>
	                <th>邮箱</th>
	                <th>出发城市</th>
	                <th>成人客户数</th>
	                <th>0-12岁人数</th>
	                <th>备注</th>
	                <th class="table-set">相关操作</th>
	              </tr>
	          	</thead>
	          	<tbody>
					<c:forEach items="${pageBean.recordList}" var="reserveOrder">
						<tr class="TableDetail1 template">
							<td>${reserveOrder.id}&nbsp;</td>
							<td>${reserveOrder.product_name}&nbsp;</td>
							<td>${reserveOrder.order_price}&nbsp;</td>
							<td>${reserveOrder.customer_name}&nbsp;</td>
							<td>${reserveOrder.mobile_phone}&nbsp;</td>
							<td>${reserveOrder.mail}&nbsp;</td>
							<td>${reserveOrder.city}&nbsp;</td>
							<td>${reserveOrder.number_of_people1}&nbsp;</td>
							<td>${reserveOrder.number_of_people2}&nbsp;</td>
							<td>${reserveOrder.remark}&nbsp;</td>
							<td>
								<iamp-identify:IAMPIdentify authid="10_02_01_00">
									<html:link action="background/ReserveOrderAction?method=delete&id=${reserveOrder.id}" onclick="return delConfirm()">删除</html:link>
								</iamp-identify:IAMPIdentify>
							</td>
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
    		</form>
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