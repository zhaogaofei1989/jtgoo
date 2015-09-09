<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>岗位列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
	<div class="admin-content">
		<div class="am-cf am-padding">
	   		<div class="am-fl am-cf">
	   			<strong class="am-text-primary am-text-lg">岗位管理</strong> / <small>岗位设置</small>
	   		</div>
    	</div>
    
    	<div class="am-g">
      		<div class="am-u-sm-12 am-u-md-6">
        		<div class="am-btn-toolbar">
          			<div class="am-btn-group am-btn-group-xs">
          				<iamp-identify:IAMPIdentify authid="01_01_05_00">
            				<button type="button" class="am-btn am-btn-default" onclick="createNew('RoleAction.do?method=addUI');"><span class="am-icon-plus"></span> 新建</button>
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
							<th>岗位名称</th>
							<th>岗位说明</th>
							<th class="table-set">相关操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${roleList}" var="role">
							<tr class="TableDetail1 template">
								<td>${role.name}&nbsp;</td>
								<td>${role.description}&nbsp;</td>
								<td>
									<iamp-identify:IAMPIdentify authid="01_01_04_00">
										<html:link action="background/RoleAction?method=delete&id=${role.id}" onclick="return confirm('确定要删除一条记录吗？？')">删除</html:link>
									</iamp-identify:IAMPIdentify>
									<iamp-identify:IAMPIdentify authid="01_01_03_00">
										<html:link action="background/RoleAction?method=editUI&id=${role.id}">修改</html:link>
									</iamp-identify:IAMPIdentify>
									<iamp-identify:IAMPIdentify authid="01_01_06_00">
										<html:link action="background/RoleAction?method=setPrivilegeUI&id=${role.id}">设置权限</html:link>
									</iamp-identify:IAMPIdentify>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<hr />
				<p>说明：</p>
			</div>
		</div>
	</div>
</body>
</html>
