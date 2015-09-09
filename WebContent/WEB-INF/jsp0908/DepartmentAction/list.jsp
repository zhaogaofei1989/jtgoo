<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>部门列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
	<div class="admin-content">
		<div class="am-cf am-padding">
	   		<div class="am-fl am-cf">
	   			<strong class="am-text-primary am-text-lg">部门管理</strong> / <small>部门设置</small>
	   		</div>
    	</div>
    
    	<div class="am-g">
      		<div class="am-u-sm-12 am-u-md-6">
        		<div class="am-btn-toolbar">
          			<div class="am-btn-group am-btn-group-xs">
          				<iamp-identify:IAMPIdentify authid="01_02_05_00">
            				<button type="button" class="am-btn am-btn-default" onclick="createNew('DepartmentAction.do?method=addUI&parentId=${parent.id}');"><span class="am-icon-plus"></span> 新建</button>
          				</iamp-identify:IAMPIdentify>
          			</div>
        		</div>
      		</div>
    	</div>
    	
		<div class="am-g">
			<div class="am-u-sm-12">
				<table class="am-table am-table-striped am-table-hover table-main">
					<thead>
						<tr>
							<th class="table-title">部门名称</th>
							<th class="table-title">上级部门名称</th>
							<th class="table-title">职能说明</th>
							<th class="table-set">相关操作</th>
						</tr>
					</thead>
					<tbody>
				        <c:forEach items="${departmentList}" var="department">
							<tr class="TableDetail1 template">
								<td><html:link action="background/DepartmentAction?method=list&parentId=${department.id}"> <label style="font-weight:bolder;">${department.name}</label></html:link>&nbsp;</td>
								<td>${department.parent.name}&nbsp;</td>
								<td>${department.description}&nbsp;</td>
								<td>
									<iamp-identify:IAMPIdentify authid="01_02_04_00">
								    	<html:link action="background/DepartmentAction?method=delete&id=${department.id}&parentId=${department.parent.id}" onclick="return window.confirm('这将删除所有的下级部门，您确定要删除吗？')">删除</html:link>
									</iamp-identify:IAMPIdentify>
									<iamp-identify:IAMPIdentify authid="01_03_03_00">
										<html:link action="background/DepartmentAction?method=editUI&id=${department.id}">修改</html:link>
									</iamp-identify:IAMPIdentify>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<hr />
				<p style="font-size: 12px">说明：<br />
					1、列表页面只显示一层的（同级的）部门数据，默认显示最顶级的部门列表。<br />
					2、点击部门名称，可以查看此部门相应的下级部门列表。<br />
					3、删除部门时，同时删除此部门的所有下级部门。
				</p>
			</div>
		</div>
	</div>
		<!--[if (gte IE 9)|!(IE)]><!-->
		<script src="${basePath}js/amazeui/jquery.min.js"></script>
		<!--<![endif]-->
		<script src="${basePath}js/amazeui/amazeui.js"></script>
		<script src="${basePath}js/amazeui/app.js"></script>
</body>
</html>
