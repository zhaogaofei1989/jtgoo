<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>签证国家设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
<link href="${basePath}/js/swfupload/swfupload.css" rel="stylesheet" type="text/css"/>
<link type="text/css" rel="stylesheet" href="${basePath}/style/blue/pageCommon.css" />
  <script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
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
			post_params:{"SWFUPLOADSESSID":"1393553074","dir":"country","type":"1","userid":"38","siteid":"1","dosubmit":"1","thumb_width":"0","thumb_height":"0","watermark_enable":"1","filetype_post":"gif|jpg|jpeg|png|bmp","swf_auth_key":"d2a5e4ef977c9e6b7759d75e5be77571","isadmin":"1","groupid":"8"},
			file_size_limit:"2000",
			file_types:"*.gif;*.jpg;*.jpeg;*.png;*.bmp;",
			file_types_description:"All Files",
			file_upload_limit:"1",
			custom_settings : {progressTarget : "fsUploadProgress",cancelButtonId : "btnCancel"},
			button_image_url: "",
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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证国家</strong> / <small>${param.id eq null ? '签证国家添加' : '签证国家修改'}</small></div>
  </div>
  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
        <html:form styleClass="am-form" action="/background/VisaCountryAction" styleId="myform">
    	 	<html:hidden property="method"  value="${param.id eq null ? 'add' : 'edit'}"/>
    		<html:hidden property="id"/>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            分类名称
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           	 <html:select property="parentId" styleClass="SelectStyle">
                                <html:option value="">请选择分类</html:option>
                                <c:forEach items="${countryList}" var="country">
                                	<html:option value="${country.id}">${country.name}</html:option>
                                </c:forEach>
                            </html:select>
            
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            分类名称
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="name" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             分类描述
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:textarea rows="10" property="description" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
     <c:if test="${param.id ne null}">
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             图片
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="icon" styleClass="am-input-sm"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
  </c:if>
        </html:form>
      </div>

    </div>
  </div>
  
  

<div class="pad-10">
    					<div class="col-tab">
           <ul class="tabBut cu-li">
            <li id="tab_swf_1" class="on" onclick="SwapTab('swf','on','',5,1);">上传国旗图片</li>
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
																        	<ul class="attachment-list" id="fsUploadProgress">    
																        	</ul>
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
  
  <div class="am-margin">
    <button type="button" onclick="saveInfo()" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
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
function saveInfo()
{
$("#myform").submit();

}
</script>
