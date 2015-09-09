<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>上传界面</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>

<link href="${basePath}/js/swfupload/swfupload.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${basePath}js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/handlers.js"></script>

    
    
</head>
<body>
<input type="hidden" id="tt" name="tt" value="${attchmentId}"/>
<input type="hidden" id="orderId" name="orderId" value="${orderId}"/>
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
				<input type="button" id="btupload" value="开始上传" onclick="swfu.startUpload();">
                <div id="nameTip" class="onShow">最多上传<font color="red"> 10</font> 个附件,单文件最大 <font color="red">20 MB</font></div>
                <div class="bk3"></div>
                <div class="lh24">支持 <font style="font-family: Arial, Helvetica, sans-serif">rar、zip</font> 格式。</div>
                <!--  <input type="checkbox" id="watermark_enable" value="1" onclick="change_params()"> 添加水印</div> 	-->
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
</div><ol><li><br></li></ol>

</div>

</body>
</html>


<script type="text/javascript">
var attchmentId=$("#tt").val();
var orderId=$("#orderId").val();
var swfu = '';
		$(document).ready(function(){
		swfu = new SWFUpload({
			flash_url:"${basePath}js/swfupload/swfupload.swf?"+Math.random(),
			upload_url:"UploadFileServlet.do",
			file_post_name : "Filedata",
			use_query_string : true,
			post_params:{"SWFUPLOADSESSID":"1393553074","attchmentId":attchmentId,"dir":"visaorder_attchment","type":"3","orderId":orderId,"dosubmit":"1","thumb_width":"0","thumb_height":"0"},
			file_size_limit:"20000",
			file_types:"*.zip;*.rar;",
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
		})
</script>
