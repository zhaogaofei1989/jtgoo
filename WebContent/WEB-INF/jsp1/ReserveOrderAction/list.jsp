<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<style type="text/css">
		tr:hover{background-color: #CEA}
</style>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 预定管理列表
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<div id="MainArea">
 <form action="${basePath}background/ReserveOrderAction.do?method=list" method="post">
   <html:hidden property="pageNum" value="1"/>
	<html:hidden property="pageSize" value="10"/>
    <table cellspacing="0" cellpadding="0" class="TableStyle">
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
            
                <td>编号</td>
                <td>产品名称</td>
                 <td>订单价格</td>
                <td>客户姓名</td>
                <td>联系电话</td>
                <td>邮箱</td>
                <td>出发城市</td>
                <td>成人客户数</td>
                <td>0-12岁人数</td>
                <td>备注</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
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
					<!--<html:link action="/ReserveOrderAction?method=editUI&id=${reserveOrder.id}">修改</html:link>-->
					<html:link action="background/ReserveOrderAction?method=delete&id=${reserveOrder.id}" onclick="return delConfirm()">删除</html:link>

				</td>
			</tr>
		</c:forEach>	
		
		
        </tbody>
    </table>
    </form>
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
<div class="Description">
	说明：<br />

</div>

</body>
</html>
