<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>部门信息</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
	<div class="admin-content">
		<div class="am-cf am-padding">
		    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">部门管理</strong> / <small>部门信息设置</small>
		    </div>
		</div>

		<div class="am-tabs am-margin" data-am-tabs>
			<ul class="am-tabs-nav am-nav am-nav-tabs">
				<li class="am-active"><a href="#tab1">部门信息设置</a></li>
			</ul>
			
			<div class="am-tabs-bd">
				<div class="am-tab-panel am-fade am-in am-active" id="tab1">
					<html:form styleClass="am-form" styleId="myform" action="background/DepartmentAction">
						<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}" />
    					<html:hidden property="id" />
						<div class="am-g am-margin-top">
	          				<div class="am-u-sm-4 am-u-md-2 am-text-right">上级部门</div>
	       					<div class="am-u-sm-8 am-u-md-10">
				            	<select data-am-selected="{maxHeight:100}" id="parentId" name="parentId">
				              		 <option value="">请选择部门</option>
				              		<c:forEach items="${departmentList}" var="department">
				              			<option value="${department.id}" ${department.id==pid?'selected':''}>${department.name}</option>
				              		</c:forEach>
				              		
				              		
				            	</select>
	       					</div>
	        			</div>
	        			
	        			<div class="am-g am-margin-top">
				            <div class="am-u-sm-4 am-u-md-2 am-text-right">
				              	部门名称
				            </div>
				            <div class="am-u-sm-8 am-u-md-4">
				              <html:text property="name" styleClass="am-input-sm"/>
				            </div>
            				<div class="am-hide-sm-only am-u-md-6">*</div>
          				</div>
          				
          				<div class="am-g am-margin-top-sm">
            				<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
              					职能说明
            				</div>
            				<div class="am-u-sm-12 am-u-md-10">
              					<html:textarea property="description" rows="10"/>
            				</div>
          				</div>
	        		</html:form>
				</div>
			</div>
		</div>
		
		<div class="am-margin">
    		<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="saveInfo()">保&nbsp;&nbsp;&nbsp;&nbsp;存</button>
    		<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="javascript:history.go(-1);"
    		>返&nbsp;&nbsp;&nbsp;&nbsp;回</button>
  		</div>
  		<p style="margin-left: 35px;font-size: 12px">说明：<br />
			1、上级部门的列表是有层次结构的（树形）。<br />
			2、如果是修改：上级部门列表中不能显示当前修改的部门及其子孙部门。因为不能选择自已或自已的子部门作为上级部门。
		</p>
	</div>
    	
		<!-- content end -->
	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="${basePath}js/amazeui/jquery.min.js"></script>
	<!--<![endif]-->
	<script src="${basePath}js/amazeui/amazeui.js"></script>
	<script src="${basePath}js/amazeui/app.js"></script>
</body>
</html>
<script type="text/javascript">
function saveInfo() {
	$("#myform").submit();
}
</script>


