<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>用户信息</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
<!-- content start -->
<div class="admin-content">

  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户管理</strong> / <small>密码修改</small></div>
  </div>

  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
        <html:form styleClass="am-form" styleId="myform" action="background/UserAction">
        <html:hidden property="method" value="updatePasswd"/>
    	<html:hidden property="id"/>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
          旧密码:
            </div>
            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
            <input type="password" name="oldpasswd" class="am-input-sm"/>
               <font style="font-weight: bold;"><html:errors/></font>
            </div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              新密码:
            </div>
            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
         <input type="password" id="newpasswd1" name="newpasswd1" class="am-input-sm"/>
            </div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              密码确认:
            </div>
            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
             <input type="password" name="newpasswd2" class="am-input-sm"/>
            </div>
          </div>

         

         
      
          
        </html:form>
      </div>

    </div>
  </div>

  <div class="am-margin">
    <button type="button" onclick="saveInfo()" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
  </div>
</div>
<!-- content end -->
<!--[if (gte IE 9)|!(IE)]><!-->
<script language="javascript" src="${basePath}js/jquery-1.7.js"  charset="utf-8"></script>
      <script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
</body>
</html>
<script type="text/javascript">
function saveInfo()
{
$("#myform").submit();

}


   $(function(){
   
   
	 $("#myform").validate({
 	onsubmit:true,// 是否在提交是验证 
	onfocusout:false,// 是否在获取焦点时验证 
	onkeyup :false,// 是否在敲击键盘时验证 
	        rules: {
	           		 oldpasswd:{
	            		 required: true
	            		 },
	           		 newpasswd1:{
	            		 required: true
	            		 },
	           		 newpasswd2:{
	            		 required: true,
	            		 equalTo:"#newpasswd1",
	            		 },
	       			 },
	        	messages: 
				{
					 oldpasswd: {
						required: "不能为空",
						  },
					 newpasswd1: {
						required: "不能为空",
						  },
					 newpasswd2: {
						required: "不能为空",
						equalTo:"两次输入的密码不同"
						  }
				},
			submitHandler: function(form) {
			form.submit();
			}
			});
			});
</script>
