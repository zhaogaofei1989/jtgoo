

<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>保险类型设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
  <script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
</head>
<body>

<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 保险类型设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div id="MainArea">
    <html:form action="/background/InsuranceTypeAction" styleId="myform">
    	<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id"/>
    
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
             
                    <tr>
                        <td>保险名称</td>
                        <td><html:text property="name" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>相关描述</td>
                        <td><html:textarea property="description" styleClass="TextareaStyle"/> *</td>
                    </tr>
                 
             
                </table>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
        </div>
    </html:form>
</div>

<div class="Description">
	说明：<br />
	1，新添加的版块默认显示在最下面（sortOrder值最大）。<br />
</div>

</body>
</html>
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