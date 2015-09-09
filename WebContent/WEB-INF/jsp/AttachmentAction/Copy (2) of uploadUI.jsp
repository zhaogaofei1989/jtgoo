<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>上传界面</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<link href="${basePath}/js/swfupload/swfupload.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
	<script language="javascript" src="${basePath}/script/jquery_treeview/jquery.treeview.js"></script>
	<link type="text/css" rel="stylesheet" href="${basePath}/style/blue/file.css" />
	<link type="text/css" rel="stylesheet" href="${basePath}/script/jquery_treeview/jquery.treeview.css" />

<script type="text/javascript" src="${basePath}js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/handlers.js"></script>
<script type="text/javascript">
var swfu = '';
		$(document).ready(function(){
		swfu = new SWFUpload({
			flash_url:"${basePath}js/swfupload/swfupload.swf?"+Math.random(),
			upload_url:"UploadFileServlet",
			file_post_name : "Filedata",
			post_params:{"SWFUPLOADSESSID":"1393553074","dataTypeDetailId":"content","catid":"15","userid":"38","siteid":"1","dosubmit":"1","thumb_width":"0","thumb_height":"0","watermark_enable":"1","filetype_post":"gif|jpg|jpeg|png|bmp|docx|doc|pdf","swf_auth_key":"d2a5e4ef977c9e6b7759d75e5be77571","isadmin":"1","groupid":"8"},
			file_size_limit:"2000",
			file_types:"*.gif;*.jpg;*.jpeg;*.png;*.bmp;*.docx;*.doc;*.pdf",
			file_types_description:"All Files",
			file_upload_limit:"10",
			custom_settings : {progressTarget : "fsUploadProgress",cancelButtonId : "btnCancel"},
			button_image_url: "",
			button_width: 75,
			button_height: 28,
			button_placeholder_id: "buttonPlaceHolder",
			button_text_style: "",
			button_text_top_padding: 3,
			button_text_left_padding: 12,
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
		})
</script>
    
    
</head>
<body>

<div class="pad-10">
<input type="button" class="cmd" value="选择产品" onclick="selectProduct()"/>
<hr></hr>
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
								              						    <div id="nameTip" class="onShow">最多上传<font color="red"> 10</font> 个附件,单文件最大 <font color="red">1.95 MB</font></div>
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
								
	<hr></hr>
	
	
	<!-- 显示顶级 -->
							<ul id="tree">
							<c:forEach items="${topLevel}" var="top">
								<li>
									<label for="cb_${top.id}">${top.name}</label>
									<c:forEach items="${visaProductList}" var="product">
									</c:forEach>
								</li></c:forEach>
							</ul>
</div>
								


</body>
</html>
<script type="text/javascript">
function selectProduct()
{
art.dialog.open('AttachmentAction.do?method=selectProductUI',
 {  title: '选择产品',
    width: 600,
    height: 340,
    left: '50%',
    top: '3%',
    lock:true,
   ok:function()
   {
     }
     
  }  );


}


</script>
