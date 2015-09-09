<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>保险类型设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
	<div class="admin-content">
		<div class="am-cf am-padding">
		    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">保险服务</strong> / <small>保险产品管理</small>
		    </div>
		</div>

		<div class="am-tabs am-margin" data-am-tabs>
			<ul class="am-tabs-nav am-nav am-nav-tabs">
				<li class="am-active"><a href="#tab1">保险类型设置</a></li>
			</ul>
			
			<div class="am-tabs-bd">
				<div class="am-tab-panel am-fade am-in am-active" id="tab1">
					<html:form styleClass="am-form" action="/background/InsuranceTypeAction" styleId="myform">
				    	<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}"/>
				    	<html:hidden property="id"/>
	        			<div class="am-g am-margin-top">
				            <div class="am-u-sm-4 am-u-md-2 am-text-right">
				              	保险名称
				            </div>
				            <div class="am-u-sm-8 am-u-md-4">
				              	<html:text property="name" /> 
				            </div>
            				<div class="am-hide-sm-only am-u-md-6">*</div>
          				</div>
          				
          				<div class="am-g am-margin-top-sm">
            				<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
              					相关描述
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
			新添加的版块默认显示在最下面（sortOrder值最大）。
		</p>
	</div>
    	
		<!-- content end -->
	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="${basePath}js/amazeui/jquery.min.js"></script>
	<!--<![endif]-->
	<script src="${basePath}js/amazeui/amazeui.js"></script>
</body>
</html>
<script type="text/javascript">
	function saveInfo() {
		$("#myform").submit();
	}
</script>

<script type="text/javascript">
	$(function(){
		$("#myform").validate({
		 	onsubmit:true,// 是否在提交是验证 
			onfocusout:false,// 是否在获取焦点时验证 
			onkeyup :false,// 是否在敲击键盘时验证 
			        rules: {
			            name:{
			            		 required: true
			            		 },
			       		 },
			        	messages: 
						{
						 name: {
								required: "不能为空",
								  }
						},
					submitHandler: function(form) {
					form.submit();
				 }
	}); });
</script>
