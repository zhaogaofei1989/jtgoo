<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>上传界面</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<script language="javascript" src="${basePath}/script/jquery_treeview/jquery.treeview.js"></script>
<link type="text/css" rel="stylesheet" href="${basePath}/style/blue/file.css" />
<link type="text/css" rel="stylesheet" href="${basePath}/script/jquery_treeview/jquery.treeview.css" />
    
    
    
    
<link href="${basePath}/js/swfupload/swfupload.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>

<script type="text/javascript" src="${basePath}js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="${basePath}js/swfupload/handlers.js"></script>
<script type="text/javascript">


 		// 选择所有
function selectAll(checkedValue){
    		$("[name=resourceIds]").attr("checked", checkedValue);
}
    	
    	$(function(){
    		// 绑定click事件
    		$("[name=resourceIds]").click(function(){
    		
    			// 当前的选中状态
    			var checkedValue = this.checked;
    			// 1，选中一个权限时：
    			if(checkedValue){
				     // a，应该选中他的所有直系上级
				     $(this).parents("li").children("[name=resourceIds]").attr("checked", checkedValue);
				     
				     // b，应该选中他的所有直系下级
				     $(this).siblings("ul").find("[name=resourceIds]").attr("checked", checkedValue);
				}
				// 2，取消选择一个权限时：
				else{
				     // a，应该取消选择 他的所有直系下级
				     $(this).siblings("ul").find("[name=resourceIds]").attr("checked", checkedValue);
				     
				     // b，如果同级的权限都是未选择状态，就应该取消选中他的直接上级，并递归向上做这个操作
				     if( $(this).parent("li").siblings("li").children("[name=resourceIds]:checked").size() == 0 ){
				     	$(this).parent("li").parent("ul").siblings("[name=resourceIds]").attr("checked", checkedValue);
				     	
				     	// 上级的上级也要进行同样的操作（仅当前为第三级时才可以）
				     	if( $(this).parent("li").parent("ul").parent("li").siblings("li").children("[name=resourceIds]:checked").size() == 0 ){
				     		$(this).parent("li").parent("ul").parent("li").parent("ul").siblings("[name=resourceIds]").attr("checked", checkedValue);
				     	}
				     }
				}
    		});
    	
    	
    		$("#tree").treeview();
    	});

var swfu = '';
		$(document).ready(function(){
		swfu = new SWFUpload({
			flash_url:"${basePath}js/swfupload/swfupload.swf?"+Math.random(),
			upload_url:"UploadFileServlet.do",
			file_post_name : "Filedata",
			use_query_string : true,
			post_params:{"SWFUPLOADSESSID":"1393553074","dataTypeDetailId":"content","catid":"15","userid":"38","siteid":"1","dosubmit":"1","dir":"attchment","type":"1","watermark_enable":"1","filetype_post":"gif|jpg|jpeg|png|bmp|docx|doc|pdf","swf_auth_key":"d2a5e4ef977c9e6b7759d75e5be77571","isadmin":"1","groupid":"8"},
			file_size_limit:"2000",
			file_types:"*.gif;*.jpg;*.jpeg;*.png;*.bmp;*.docx;*.doc;*.pdf",
			file_types_description:"All Files",
			file_upload_limit:"10",
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
<body onload="selectAll(false)">

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
  <html:form action="background/AttachmentAction">
  <html:hidden property="method" value="upload"/>
   <html:hidden property="id" value="${param.id}"/>
						<!--  	<ul id="tree">
							<c:forEach items="${topLevel}" var="top">
								<li>
									<label for="cb_${top.id}">${top.name}</label>
									<c:forEach items="${visaProductList}" var="product">
										<html:multibox property="resourceIds" value="${product.id}" styleId="cb_${product.id}"/>
										<label for="cb_${product.id}">${product.name}</label><br>
									</c:forEach>
								</li></c:forEach>
							</ul>-->
	
	
	        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
					<!--表头-->
					<thead>
						<tr align="LEFT" valign="MIDDLE" id="TableTitle">
							<td width="300px" style="padding-left: 7px;">
								<!-- 如果把全选元素的id指定为selectAll，并且有函数selectAll()，就会有错。因为有一种用法：可以直接用id引用元素 -->
								<input type="checkbox" id="cbSelectAll" onclick="selectAll(this.checked)"/>
								<label for="cbSelectAll">全选</label>
							</td>
						</tr>
					</thead>
                   
			   		<!--显示数据列表-->
					<tbody id="TableData">
						<tr class="TableDetail1">
							<!-- 显示权限树 -->
							<td>
							<!-- 显示顶级 -->
							<ul id="tree"><c:forEach items="${topLevel}" var="top">
								<li>
									<label for="cb_${top.id}">${top.name}</label>
										<ul>
											<c:forEach items="${top.coutryChild}" var="children">	
											<li>
														<label for="cb_${children.id}">${children.name}</label><br>	
														
															 <ul><%-- 显示第二级 --%>
															<c:forEach items="${visaProductList}" var="visaProduct">	
															<li>
															<c:if test="${children.id eq visaProduct.country.id}">
																		      <html:multibox property="resourceIds" value="${visaProduct.id}" styleId="cb_${visaProduct.id}"/>
																				<label for="cb_${visaProduct.id}">${visaProduct.name}</label><br>			
															</c:if>
															
															</li>
															
															</c:forEach>
															</ul>	
														
																
											</li>
											</c:forEach>
										</ul>
														
									
								</li></c:forEach>
							</ul>
							
							</td>
						</tr>
					</tbody>
                </table>
            </div>
        </div>
        
             <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
             <input type="button" class="cmd" value="保存并新增" onclick="saveAndAdd();"/>
        </div>
		</html:form>
	
	
	
	
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
