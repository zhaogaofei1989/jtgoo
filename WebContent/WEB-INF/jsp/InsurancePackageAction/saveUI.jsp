<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setAttribute("basePath",  basePath);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>保险套餐设置</title>
	<script language="javascript" src="${basePath}js/jquery-1.7.js"  charset="utf-8"></script>
	<script language="javascript" src="${basePath}/script/pageCommon.js" charset="utf-8"></script>
	<script language="javascript" src="${basePath}/script/PageUtils.js" charset="utf-8"></script>
	<link type="text/css" rel="stylesheet" href="${basePath}js/amazeui/css/amazeui.css" />
	<link type="text/css" rel="stylesheet" href="${basePath}js/amazeui/css/admin.css" />
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>  
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="This is my page"/>
	<link type="text/css" rel="stylesheet" href="${basePath}/style/blue/pageCommon.css" />
	<script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
	<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
	<script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
	<script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
	<link href="${basePath}style/loadingbar/showLoading.css" rel="stylesheet" media="screen" />
	<script type="text/javascript" src="${basePath}js/jquery.showLoading.js"></script>
	<link href="${basePath}/js/swfupload/swfupload.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${basePath}js/swfupload/swfupload.js"></script>
	<script type="text/javascript" src="${basePath}js/swfupload/fileprogress.js"></script>
	<script type="text/javascript" src="${basePath}js/swfupload/handlers.js"></script>
	<link href="${basePath}js/linkage/style/admin.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${basePath}js/linkage/js/mln.colselect.js"></script>
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
<!-- content start -->
<div class="admin-content">
  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">套餐管理</strong> / <small>保险套餐设置</small></div>
  </div>
  
  <div class="am-tabs am-margin" data-am-tabs>
        <html:form styleClass="am-form"  action="background/InsurancePackageAction" styleId="myform">
    	<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}" />
    	<html:hidden property="id" />
        <input type="hidden" id="insuranceType_name" name="insuranceType_name" value="${insuranceType_name}" />
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	套餐类型
            </div>
            <div id="colsel_insuranceType" class="am-u-sm-8 am-u-md-4">
            	<script type="text/javascript" src="${basePath}js/linkage/js/mln.colselect.js"></script>
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
				</script>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
         </div>
            
		<div class="am-g am-margin-top">
			<div class="am-u-sm-4 am-u-md-2 am-text-right">
				套餐名称
			</div>
			<div class="am-u-sm-8 am-u-md-4">
				<html:text property="name" styleClass="am-input-sm"/> 
			</div>
			<div class="am-hide-sm-only am-u-md-6">*</div>
		</div>
		
		<div class="am-g am-margin-top">
			<div class="am-u-sm-4 am-u-md-2 am-text-right">
				成人保险费用
			</div>
			<div class="am-u-sm-8 am-u-md-4">
				<html:text property="price1" styleClass="am-input-sm"/> 
			</div>
			<div class="am-hide-sm-only am-u-md-6">*</div>
		</div>
		
		<div class="am-g am-margin-top">
			<div class="am-u-sm-4 am-u-md-2 am-text-right">
				0-6岁儿童保险费用
			</div>
			<div class="am-u-sm-8 am-u-md-4">
				<html:text property="price2" styleClass="am-input-sm"/> 
			</div>
			<div class="am-hide-sm-only am-u-md-6">*</div>
		</div>
		
		<div class="am-g am-margin-top">
			<div class="am-u-sm-4 am-u-md-2 am-text-right">
				6-12岁儿童保险费用
			</div>
			<div class="am-u-sm-8 am-u-md-4">
				<html:text property="price3" styleClass="am-input-sm"/> 
			</div>
			<div class="am-hide-sm-only am-u-md-6">*</div>
		</div>

        <div class="am-g am-margin-top">
          <div class="am-u-sm-4 am-u-md-2 am-text-right">
				描述
          </div>
          <div class="am-u-sm-8">
     			  <html:textarea rows="10" cols="15" property="description"/>
          </div>
          <div class="am-hide-sm-only am-u-md-6"></div>
        </div>
        
		<c:if test="${param.id ne null}">
		     <div class="am-g am-margin-top">
		       <div class="am-u-sm-4 am-u-md-2 am-text-right">
		        	附件
		       </div>
		       <div class="am-u-sm-8 am-u-md-4">
		       <html:text property="path" styleClass="am-input-sm" />
		       </div>
		       <div class="am-hide-sm-only am-u-md-6">*</div>
		     </div>
		</c:if>  
     </html:form>
  </div>
      
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
					<div class="lh24">支持 <font style="font-family: Arial, Helvetica, sans-serif">gif、jpg、jpeg、png、bmp</font> 格式。</div>
					<div class="bk10"></div>
					<fieldset class="blue pad-10" id="swfupload">
						<legend>列表</legend>
						<ul class="attachment-list" id="fsUploadProgress"></ul>
					</fieldset>
				</div>
				<div id="att-status" class="hidden"></div>
				<div id="att-status-del" class="hidden"></div>
				<div id="att-name" class="hidden"></div>
				<!-- swf -->
			</div>
			<ol><li><br/></li></ol>
		</div>
	</div>
	<hr/>
	<div class="am-margin">
		<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="saveInfo()">保&nbsp;&nbsp;&nbsp;&nbsp;存</button>
	    <button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="javascript:history.go(-1);"
	    >返&nbsp;&nbsp;&nbsp;&nbsp;回</button>
	    <p style="margin-left: 35px;font-size: 12px">说明：<br />
			1、新添加的版块默认显示在最下面（sortOrder值最大）。
		</p>
	</div>
</div>
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
