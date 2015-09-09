<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>上传界面</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <style type="text/css">
    html{_overflow-y:scroll}
    </style>
    <link href="http://www.jtgoo.com/statics/js/swfupload/swfupload.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" type="text/javascript" src="http://www.jtgoo.com/statics/js/swfupload/swfupload.js"></script>
    <script language="JavaScript" type="text/javascript" src="http://www.jtgoo.com/statics/js/swfupload/fileprogress.js"></script>
    <script language="JavaScript" type="text/javascript" src="http://www.jtgoo.com/statics/js/swfupload/handlers.js"></script>
    <script type="text/javascript">
var swfu = '';
		$(document).ready(function(){
		swfu = new SWFUpload({
			flash_url:"http://www.jtgoo.com/statics/js/swfupload/swfupload.swf?"+Math.random(),
			upload_url:"http://www.jtgoo.com/index.php?m=attachment&c=attachments&a=swfupload&dosubmit=1",
			file_post_name : "Filedata",
			post_params:{"SWFUPLOADSESSID":"1393553074","module":"content","catid":"15","userid":"38","siteid":"1","dosubmit":"1","thumb_width":"0","thumb_height":"0","watermark_enable":"1","filetype_post":"gif|jpg|jpeg|png|bmp|docx|doc|pdf","swf_auth_key":"d2a5e4ef977c9e6b7759d75e5be77571","isadmin":"1","groupid":"8"},
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
		})</script>
    
    
</head>
<body>
<div class="pad-10">
    <div class="col-tab">
        <ul class="tabBut cu-li">
            <li id="tab_swf_1" class="on" onclick="SwapTab('swf','on','',5,1);">上传附件</li>
                                </ul>
         <div id="div_swf_1" class="content pad-10 ">
        	<div>
				<div class="addnew" id="addnew">
					<object id="SWFUpload_0" type="application/x-shockwave-flash" data="http://www.jtgoo.com/statics/js/swfupload/swfupload.swf?0.5216083019040525&amp;preventswfcaching=1393553070230" width="75" height="28" class="swfupload"><param name="wmode" value="transparent"><param name="movie" value="http://www.jtgoo.com/statics/js/swfupload/swfupload.swf?0.5216083019040525&amp;preventswfcaching=1393553070230"><param name="quality" value="high"><param name="menu" value="false"><param name="allowScriptAccess" value="always"><param name="flashvars" value="movieName=SWFUpload_0&amp;uploadURL=http%3A%2F%2Fwww.jtgoo.com%2Findex.php%3Fm%3Dattachment%26c%3Dattachments%26a%3Dswfupload%26dosubmit%3D1&amp;useQueryString=false&amp;requeueOnError=false&amp;httpSuccess=&amp;assumeSuccessTimeout=0&amp;params=SWFUPLOADSESSID%3D1393553074%26amp%3Bmodule%3Dcontent%26amp%3Bcatid%3D15%26amp%3Buserid%3D38%26amp%3Bsiteid%3D1%26amp%3Bdosubmit%3D1%26amp%3Bthumb_width%3D0%26amp%3Bthumb_height%3D0%26amp%3Bwatermark_enable%3D1%26amp%3Bfiletype_post%3Dgif%257Cjpg%257Cjpeg%257Cpng%257Cbmp%257Cdocx%257Cdoc%257Cpdf%26amp%3Bswf_auth_key%3Dd2a5e4ef977c9e6b7759d75e5be77571%26amp%3Bisadmin%3D1%26amp%3Bgroupid%3D8&amp;filePostName=Filedata&amp;fileTypes=*.gif%3B*.jpg%3B*.jpeg%3B*.png%3B*.bmp%3B*.docx%3B*.doc%3B*.pdf&amp;fileTypesDescription=All%20Files&amp;fileSizeLimit=2000&amp;fileUploadLimit=10&amp;fileQueueLimit=0&amp;debugEnabled=false&amp;buttonImageURL=%2F&amp;buttonWidth=75&amp;buttonHeight=28&amp;buttonText=&amp;buttonTextTopPadding=3&amp;buttonTextLeftPadding=12&amp;buttonTextStyle=&amp;buttonAction=-110&amp;buttonDisabled=false&amp;buttonCursor=-2"></object>
				</div>
				<input type="button" id="btupload" value="开始上传" onclick="swfu.startUpload();">
                <div id="nameTip" class="onShow">最多上传<font color="red"> 10</font> 个附件,单文件最大 <font color="red">1.95 MB</font></div>
                <div class="bk3"></div>
                <div class="lh24">支持 <font style="font-family: Arial, Helvetica, sans-serif">gif、jpg、jpeg、png、bmp、docx、doc、pdf</font> 格式。</div><input type="checkbox" id="watermark_enable" value="1" onclick="change_params()"> 添加水印
        	</div> 	
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
    
    
    	<div id="divLoadingContent" class="content" style="background-color: #FFFF66; border-top: solid 4px #FF9966; border-bottom: solid 4px #FF9966; margin: 10px 25px; padding: 10px 15px; display: none;">
			SWFUpload is loading. Please wait a moment...
		</div>
		<div id="divLongLoading" class="content" style="background-color: #FFFF66; border-top: solid 4px #FF9966; border-bottom: solid 4px #FF9966; margin: 10px 25px; padding: 10px 15px; display: none;">
			SWFUpload is taking a long time to load or the load has failed.  Please make sure that the Flash Plugin is enabled and that a working version of the Adobe Flash Player is installed.
		</div>
		<div id="divAlternateContent" class="content" style="background-color: #FFFF66; border-top: solid 4px #FF9966; border-bottom: solid 4px #FF9966; margin: 10px 25px; padding: 10px 15px; display: none;">
			We're sorry.  SWFUpload could not load.  You may need to install or upgrade Flash Player.
			Visit the <a href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash">Adobe website</a> to get the Flash Player.
		</div>
    
    
    
    
<!-- swf -->
</div>

<script type="text/javascript">
if ($.browser.mozilla) {
	window.onload=function(){
	  if (location.href.indexOf("&rand=")<0) {
			location.href=location.href+"&rand="+Math.random();
		}
	}
}
function imgWrap(obj){
	$(obj).hasClass('on') ? $(obj).removeClass("on") : $(obj).addClass("on");
}

function SwapTab(name,cls_show,cls_hide,cnt,cur) {
    for(i=1;i<=cnt;i++){
		if(i==cur){
			 $('#div_'+name+'_'+i).show();
			 $('#tab_'+name+'_'+i).addClass(cls_show);
			 $('#tab_'+name+'_'+i).removeClass(cls_hide);
		}else{
			 $('#div_'+name+'_'+i).hide();
			 $('#tab_'+name+'_'+i).removeClass(cls_show);
			 $('#tab_'+name+'_'+i).addClass(cls_hide);
		}
	}
}

function addonlinefile(obj) {
	var strs = $(obj).val() ? '|'+ $(obj).val() :'';
	$('#att-status').html(strs);
}

function change_params(){
	if($('#watermark_enable').attr('checked')) {
		swfu.addPostParam('watermark_enable', '1');
	} else {
		swfu.removePostParam('watermark_enable');
	}
}
function set_iframe(id,src){
	$("#"+id).attr("src",src); 
}
function album_cancel(obj,id,source){
	var src = $(obj).children("img").attr("path");
	var filename = $(obj).attr('title');
	if($(obj).hasClass('on')){
		$(obj).removeClass("on");
		var imgstr = $("#att-status").html();
		var length = $("a[class='on']").children("img").length;
		var strs = filenames = '';
		$.get('index.php?m=attachment&c=attachments&a=swfupload_json_del&aid='+id+'&src='+source+'&filename='+filename);
		for(var i=0;i<length;i++){
			strs += '|'+$("a[class='on']").children("img").eq(i).attr('path');
			filenames += '|'+$("a[class='on']").children("img").eq(i).attr('title');
		}
		$('#att-status').html(strs);
		$('#att-status').html(filenames);
	} else {
		var num = $('#att-status').html().split('|').length;
		var file_upload_limit = '10';
		if(num > file_upload_limit) {alert('不能选择超过'+file_upload_limit+'个附件'); return false;}
		$(obj).addClass("on");
		$.get('index.php?m=attachment&c=attachments&a=swfupload_json&aid='+id+'&src='+source+'&filename='+filename);
		$('#att-status').append('|'+src);
		$('#att-name').append('|'+filename);
	}
}
</script>
</div>

</body>
</html>
