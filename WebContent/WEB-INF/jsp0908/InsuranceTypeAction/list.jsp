<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
 <!-- content start -->
	<div class="admin-content">
		<div class="am-cf am-padding">
      		<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">保险服务</strong> / <small>保险产品管理</small></div>
    	</div>

    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
          	<iamp-identify:IAMPIdentify authid="09_01_05_00">
            	<button type="button" class="am-btn am-btn-default" onclick="createNew('InsuranceTypeAction.do?method=addUI');"><span class="am-icon-plus"></span> 新增</button>
          	</iamp-identify:IAMPIdentify>
          </div>
        </div>
      </div>
    </div>

    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/InsuranceTypeAction.do?method=list" method="post">
        	<html:hidden property="pageNum" value="1" />
			<html:hidden property="pageSize" value="10" />
	        <table class="am-table am-table-striped am-table-hover table-main">
	        	<thead>
            		<tr>
		            	<th class="table-id">ID</th>
		                <th class="table-title">保险名称</th>
		                <th class="table-title">保险描述</th>
		                <th class="table-set">相关操作</th>
            		</tr>
        		</thead>

				<!--显示数据列表-->
		        <tbody>
			        <c:forEach items="${insuranceTypeList}" var="insurance">
						<tr class="TableDetail1 template">
							<td>${insurance.id}&nbsp;</td>
							<td>${insurance.name}&nbsp;</td>
							<td>${insurance.description}&nbsp;</td>
							<td>
								<iamp-identify:IAMPIdentify authid="009_01_03_00">
									<html:link action="/background/InsuranceTypeAction?method=editUI&id=${insurance.id}">修改</html:link>
								</iamp-identify:IAMPIdentify>
								<iamp-identify:IAMPIdentify authid="09_01_04_00">
									<html:link action="/background/InsuranceTypeAction?method=delete&id=${insurance.id}">删除</html:link>
								</iamp-identify:IAMPIdentify>
							</td>
						</tr>
					</c:forEach>
		        </tbody>
	        </table>

	        <hr />
	        <p>说明：</p>
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