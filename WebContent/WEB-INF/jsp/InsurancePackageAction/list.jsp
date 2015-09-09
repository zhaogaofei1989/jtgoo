<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>保险服务</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
 <!-- content start -->
	<div class="admin-content">
		<div class="am-cf am-padding">
      		<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">保险服务</strong> / <small>套餐管理</small></div>
    	</div>

    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
	          <iamp-identify:IAMPIdentify authid="09_02_05_00">
	            <button type="button" class="am-btn am-btn-default" onclick="createNew('InsurancePackageAction.do?method=addUI');"><span class="am-icon-plus"></span> 新增</button>
	          </iamp-identify:IAMPIdentify>
          </div>
        </div>
      </div>
    </div>

    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/InsurancePackageAction.do?method=list" method="post">
			<html:hidden property="pageNum" value="1"/>
			<html:hidden property="pageSize" value="${pageBean.pageSize eq null ? 10 :pageBean.pageSize }"/>
	        <table class="am-table am-table-striped am-table-hover table-main">
	            <thead>
	              <tr>
	                <th class="table-id">ID</th>
	                <th class="table-title">套餐类型</th>
	                <th class="table-title">套餐名称</th>
	                <th class="table-title">附件</th>
	                <th class="table-title">描述</th>
	                <th class="table-set">相关操作</th>
	              </tr>
	          	</thead>
	          	<tbody>
			        <c:forEach items="${pageBean.recordList}" var="pageBean">
						<tr class="TableDetail1 template">
							<td>${pageBean.id}&nbsp;</td>
							<td>${pageBean.insuranceType.name}&nbsp;</td>
							<td>${pageBean.name}&nbsp;</td>
							<td><a href="${basePath}background/InsurancePackageAction.do?method=getBaoxianInfo&baoxian_att_id=${ pageBean.baoxian_att_id}" target="_blank">${pageBean.path}&nbsp;</a></td>
							<td>${pageBean.description}&nbsp;</td>
							<td>
								<iamp-identify:IAMPIdentify authid="09_02_03_00">
									<html:link action="/background/InsurancePackageAction?method=editUI&id=${pageBean.id}">修改</html:link>
								</iamp-identify:IAMPIdentify>
								<iamp-identify:IAMPIdentify authid="09_02_04_00">
									<html:link action="/background/InsurancePackageAction?method=delete&id=${pageBean.id}">删除</html:link>
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