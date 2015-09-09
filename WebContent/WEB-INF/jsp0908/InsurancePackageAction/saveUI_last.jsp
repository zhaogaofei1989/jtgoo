<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>保险套餐设置</title>
 <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
  <script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
    <link href="${basePath}/js/swfupload/swfupload.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${basePath}js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/handlers.js"></script>
<script type="text/javascript">
var swfu = '';
		$(document).ready(function(){
		swfu = new SWFUpload({
			flash_url:"${basePath}js/swfupload/swfupload.swf?"+Math.random(),
			upload_url:"UploadFileServlet.do",
			file_post_name : "Filedata",
			use_query_string : true,
			post_params:{"SWFUPLOADSESSID":"1393553074","dir":"baoxian","catid":"15","userid":"38","type":"2","dosubmit":"1","thumb_width":"0","thumb_height":"0","watermark_enable":"1","filetype_post":"gif|jpg|jpeg|png|bmp|docx|doc|pdf","swf_auth_key":"d2a5e4ef977c9e6b7759d75e5be77571","isadmin":"1","groupid":"8"},
			file_size_limit:"2000",
			file_types:"*.gif;*.jpg;*.jpeg;*.png;*.bmp;*.pdf;*.doc;*.gif;",
			file_types_description:"All Files",
			file_upload_limit:"1",
			custom_settings : {progressTarget : "fsUploadProgress",cancelButtonId : "btnCancel"},
			button_image_url: "${basePath}js/swfupload/images/swfBnt.png",
			button_width: 75,
			button_height: 28,
			button_placeholder_id: "buttonPlaceHolder",
			button_text_style: "",
			button_text_top_padding: 30,
			button_text_left_padding: 20,
			button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
			button_cursor: SWFUpload.CURSOR.HAND,
			file_dialog_start_handler : fileDialogStart,
			file_queued_handler : fileQueued,
			file_queue_error_handler:fileQueueError,
			file_dialog_complete_handler:fileDialogComplete,
			upload_progress_handler:uploadProgress,
			upload_error_handler:uploadError,
			upload_success_handler:uploadSuccess,
			upload_complete_handler:uploadComplete
			});
		});
    </script>
</head>
<body>

<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 保险套餐设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div id="MainArea">
    <html:form action="background/InsurancePackageAction" styleId="myform">
    	<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id"/>
       <input type="hidden" id="insuranceType_name" name="insuranceType_name" value="${insuranceType_name}"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
     <tr>
        <td>套餐类型</td> 
      <td>
      <div id="colsel_insuranceType"></div>
       <link href="${basePath}js/linkage/style/admin.css" rel="stylesheet" type="text/css">
      <script type="text/javascript" src="${basePath}js/linkage/js/mln.colselect.js">    </script>
<script type="text/javascript">
  $.ajax({
 url: "InsuranceTypeAction.do?method=list_json", 
 dataType:'json',
 success: function(data){
 var insuranceType_id=${insuranceType_id};
 if(insuranceType_id==-1)
 {
$("#colsel_insuranceType").mlnColsel(data,{
				title:"保险产品分类",
				value:"-1",
				width:100
			});
 }
 else
 { 
 var name=$("#insuranceType_name").val();
 $("#colsel_insuranceType").mlnColsel(data,{
				title:name,
				value:insuranceType_id,
				width:100
			});
 }}
 });
      
      </script></td>
                    </tr>
                    
                     <tr>
                        <td>套餐名称</td>
                        <td><html:text property="name" styleClass="InputStyle"/> *</td>
                    </tr>
                     <tr>
                        <td>成人保险费用</td>
                        <td><html:text property="price1" styleClass="InputStyle"/> *</td>
                    </tr>
                     <tr>
                        <td>0-6岁儿童保险费用</td>
                        <td><html:text property="price2" styleClass="InputStyle"/> *</td>
                    </tr>
                     <tr>
                        <td>6-12岁儿童保险费用</td>
                        <td><html:text property="price3" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>描述</td>
                        <td><html:textarea property="description" styleClass="TextareaStyle"/> *</td>
                    </tr>
                 
             	<c:if test="${param.id ne null}">
                       <tr>
                        <td>附件</td>
                        <td><html:text property="path" styleClass="InputStyle required"/> *</td>
                   	 </tr>
                    </c:if>
                    
                    <tr><td colspan="2">
	 <div class="pad-10">
    					<div class="col-tab">
           <ul class="tabBut cu-li">
            <li id="tab_swf_1" class="on" onclick="SwapTab('swf','on','',5,1);">上传附件</li>
           </ul>
								         <div id="div_swf_1" class="content pad-10 ">
								        								<div>
																		<div class="addnew">
																		<span id="buttonPlaceHolder"></span>
																		</div>
																		<input type="button" id="btupload" value="开始上传" onclick="swfu.startUpload();"/>
								              						    <div id="nameTip" class="onShow">最多上传<font color="red"> 1</font> 个附件,单文件最大 <font color="red">1.95 MB</font></div>
														                <div class="bk3"></div>
														                <div class="lh24">支持 <font style="font-family: Arial, Helvetica, sans-serif">gif、jpg、jpeg、png、bmp、docx、doc、pdf</font> 格式。</div>
																     	<div class="bk10"></div>
																        	<fieldset class="blue pad-10" id="swfupload">
																        	<legend>列表</legend>
																        	<ul class="attachment-list" id="fsUploadProgress">    
																        	</ul>
																    		</fieldset>
																    	</div>
																		    <div id="att-status" class="hidden"></div>
																		     <div id="att-status-del" class="hidden"></div>
																		    <div id="att-name" class="hidden"></div>
											<!-- swf -->
												</div>
								<ol><li><br></li></ol>
								</div>
								</div>
								
                    </td></tr>
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
	            price1:{
	            		 required: true,
	            		 number:true
	            		 },
	            price2:{
	            		 required: true,
	            		 number:true
	            		 },
	            price3:{
	            		 required: true,
	            		 number:true
	            		 },
	       		 },
	        	messages: 
				{
				 name: {
						required: "不能为空",
						
						  },
				 price1: {
						required: "不能为空",
						number: "必须输入合法的数字(负数，小数)"
						  },
				 price2: {
						required: "不能为空",
						number: "必须输入合法的数字(负数，小数)"
						  },
				 price3: {
						required: "不能为空",
						number: "必须输入合法的数字(负数，小数)"
						  },
				},
			submitHandler: function(form) {
			form.submit();
			 }
			}); });
    </script>
    