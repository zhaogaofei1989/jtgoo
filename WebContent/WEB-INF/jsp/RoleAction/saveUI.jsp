<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>岗位设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
	<div class="admin-content">
		<div class="am-cf am-padding">
		    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">岗位管理</strong> / <small>岗位设置</small>
		    </div>
		</div>

		<div class="am-tabs am-margin" data-am-tabs>
			<ul class="am-tabs-nav am-nav am-nav-tabs">
				<li><a class="am-active" href="#tab2">岗位设置</a></li>
			</ul>
			<div class="am-tabs-bd">
				<div class="am-tab-panel am-fade" id="tab2">
				   <html:form styleClass="am-form" styleId="myform" action="background/RoleAction">
		   				<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}" />
	 					<html:hidden property="id" />
						<div class="am-g am-margin-top">
		            		<div class="am-u-sm-4 am-u-md-2 am-text-right">
		             			岗位名称
		     	   			</div>
		     	   			<div class="am-u-sm-8 am-u-md-4">
              					<html:text  property="name" styleClass="am-input-sm"/>
            				</div>
            				<div class="am-hide-sm-only am-u-md-6">*</div>
            			</div>	
           			    <div class="am-g am-margin-top-sm">
            				<div class="am-u-sm-4 am-u-md-2 am-text-right">
              					岗位说明
            				</div>
				            <div class="am-u-sm-8 am-u-md-4 am-u-end">
				              <html:textarea property="description" rows="4"/>
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
	if($('.am-input-sm').val() == '' ) {
		alert("请输入岗位名称");
		$('.am-input-sm').focus();
		return;
	}
	$("#myform").submit();
}
</script>
