<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>签证产品设置</title>
	<meta   http-equiv= "Pragma"   content= "no-cache" />
	<meta   http-equiv= "Cache-Control"   content= "no-cache" />
	<meta   http-equiv= "Expires"   content= "0" /> 
	
    <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
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
<script type="text/javascript">
var swfu = '';
		$(document).ready(function(){
		swfu = new SWFUpload({
			flash_url:"${basePath}js/swfupload/swfupload.swf?"+Math.random(),
			upload_url:"UploadFileServlet.do",
			file_post_name : "Filedata",
			use_query_string : true,
			post_params:{"SWFUPLOADSESSID":"1393553074","dir":"product","type":"2","userid":"38","siteid":"1","dosubmit":"1","thumb_width":"0","thumb_height":"0","watermark_enable":"1","filetype_post":"gif|jpg|jpeg|png|bmp","swf_auth_key":"d2a5e4ef977c9e6b7759d75e5be77571","isadmin":"1","groupid":"8"},
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
			button_text_top_padding: 1,
			button_text_left_padding: 1,
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

function show_re(type)
{
	var pid=$("#id").val();
	var newrelation_ids="";
	$.getJSON("GetVisaDataTypeDetailInfo.do?pid="+pid+"&type="+type,function(json)
	{
			if(json==null)
			{
			alert("没有相关数据!");
			}
			else
			{
			$.each(json.Items, function(i, n){
				newrelation_ids += "<li id='"+n.id+"'>·<span>"+n.title+"</span></li>";
			});
				$("#student_text_"+type).html(newrelation_ids);
			}
	});

}
function uploadInfo(type)
{
var pid=$("#id").val();
art.dialog.open('VisaDataTypeDetailAction.do?method=list&pid='+pid+"&type="+type,
 { title: '添加在职人员所需资料',
    lock:true,
    width: 1000,
    height: 440,
    left: '10%',
    top: '3%'
});
	art.dialog.data('pid', pid);
	art.dialog.data('type',type);
}




</script>
</head>
<body>
<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 签证产品设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<!--显示表单内容-->
<div id="MainArea">
    <html:form action="/background/VisaProductAction" styleId="myform">
    	<html:hidden property="method" styleId="methodId" value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id" styleId="id" value="${id}"/>
    	<html:hidden property="serialNumber"/>
    	<html:hidden styleId="countryName" property="countryName" value="${countryName}"/>
    	<html:hidden styleId="visaTypeName" property="visaTypeName" value="${visaTypeName}"/>
    	<html:hidden styleId="lingquName" property="lingquName" value="${lingquName}"/>
    	<html:hidden styleId="insurancePackageName" property="insurancePackageName" value="${insurancePackageName}"/>
 
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder" id="table">
            <div class="ItemBlock">
                <table  cellpadding="0" cellspacing="0" class="mainForm">
             
                    <tr>
                        <td align="center">签证名称</td>
                        <td><html:text property="name" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
 <td align="center">签证国家</td> 
      <td>
      <div id="colsel_country"></div>
       <link href="${basePath}js/linkage/style/admin.css" rel="stylesheet" type="text/css">
      <script type="text/javascript" src="${basePath}js/linkage/js/mln.colselect.js">    </script>
<script type="text/javascript">
 $.ajax({
 url: "GetVisaCountryInfo.do", 
 dataType:'json',
 success: function(msg){
  var countryId=${countryId};
 
 if(countryId==-1)
 {
$("#colsel_country").mlnColsel(msg,{
				title:"签证国家分类",
				value:"-1",
				width:100
			});
 
 }
 else
 {
 var name=$("#countryName").val();
 $("#colsel_country").mlnColsel(msg,{
				title:name,
				value:countryId,
				width:100
			});
 }
 }});
      
      </script></td>
    </tr>
    <tr >
      <td align="center"> 签证类型	  </td>
      <td>
      	<div id="colsel_visatype"></div>
      <script type="text/javascript">
    $.ajax({
 url: "GetVisaTypeInfo.do", 
 dataType:'json',
 success: function(msg){
var visaTypeId=${visaTypeId};
if(visaTypeId==-1)
{
	$("#colsel_visatype").mlnColsel(msg,{
				title:"签证类型",
				value:"-1",
				width:100
			});
}
else
{
 var name=$("#visaTypeName").val();
	$("#colsel_visatype").mlnColsel(msg,{
				title:name,
				value:visaTypeId,
				width:100
			});
}
 }});
      </script></td>
    </tr>
 	<tr >
      <td align="center"> 送签领区	  </td>
      <td>
      <div id="colsel_lingqu"></div>
  <script type="text/javascript">
    $.ajax({
 url: "GetVisaLingquInfo.do", 
 dataType:'json',
 success: function(msg){
 var lingquId=${lingquId};
 if(lingquId==-1)
{
		$("#colsel_lingqu").mlnColsel(msg,{
				title:"签证领区",
				value:"-1",
				width:100
			});
}
else
{
 var name=$("#lingquName").val();
	$("#colsel_lingqu").mlnColsel(msg,{
				title:name,
				value:lingquId,
				width:100
			});
}
 }});
      </script>
      </td>
    </tr>
    
 <tr >
      <td align="center">保险	</td>
      <td>
      <div id="colsel_insurancePackage"></div>
  <script type="text/javascript">
    $.ajax({
 url: "GetInsurancePackageInfo.do", 
 dataType:'json',
 success: function(msg){
 var colsel_insurancePackageId=${insurancePackageId};
 if(colsel_insurancePackageId==-1)
{
		$("#colsel_insurancePackage").mlnColsel(msg,{
				title:"保险套餐",
				value:"-1",
				width:100
			});
}
else
{
 var name=$("#insurancePackageName").val();
	$("#colsel_insurancePackage").mlnColsel(msg,{
				title:name,
				value:colsel_insurancePackageId,
				width:100
			});
}
 }});
      </script>
      </td>
    </tr>
    
     
             <tr><td align="center">是否需要面试</td><td>是<html:radio property="isInterview" value="0"/>&nbsp;&nbsp;&nbsp;&nbsp;      否<html:radio property="isInterview" value="1"/></td></tr>
             <tr><td align="center">是否需要预约</td><td>是<html:radio property="isNeedToAppointment" value="0"/>&nbsp;&nbsp;&nbsp;&nbsp;      否<html:radio property="isNeedToAppointment" value="1"/></td></tr>
             <tr><td align="center">签证申请周期</td><td><html:text property="visaApplyCycle" styleClass="InputStyle"/></td></tr>
             <tr><td align="center">一般签证有效期</td><td><html:text property="visaValid" styleClass="InputStyle required"/></td></tr>
             <tr><td align="center"> 一般停留期 </td><td><html:text property="periodOfStay" styleClass="InputStyle"/></td></tr>
             <tr><td align="center">选择次数</td><td>单次<html:radio property="oneToManySelect" value="0"/>&nbsp;&nbsp;&nbsp;&nbsp;      多次<html:radio property="oneToManySelect" value="1"/></td></tr>
             <tr><td align="center">是否可以代领签证</td><td>是<html:radio property="acceptType" value="0"/>&nbsp;&nbsp;&nbsp;&nbsp;      否<html:radio property="acceptType" value="1"/></td></tr>
             <tr><td align="center">报价是否含签证费</td><td>是<html:radio property="quotationHasVisaPrice" value="0"/>&nbsp;&nbsp;&nbsp;&nbsp;      否<html:radio property="quotationHasVisaPrice" value="1"/></td></tr>
             <tr><td align="center">领区划分 </td><td><html:textarea cols="40" rows="4" styleClass="TextareaStyle" property="lingquDivide"/></td></tr>
             <tr><td align="center">网址链接	</td><td><html:textarea  cols="40" rows="4" styleClass="TextareaStyle" property="webSiteLink"/></td></tr>
             <tr><td align="center">预约需要的信息	</td><td><html:textarea  cols="40" rows="4" styleClass="TextareaStyle"  property="bookingInformationNeeds"/></td></tr>
             <tr><td align="center">使领馆和签证中心地址	</td><td><html:textarea  cols="40" rows="4" styleClass="TextareaStyle"  property="consularAndVisaCenterAddress"/></td></tr>
             <tr><td align="center">如何进行签证查询	</td><td><html:textarea cols="40" rows="4" styleClass="TextareaStyle"  property="howToQueryVisaInfo"/></td></tr>
             <tr><td align="center">签证的领取	</td><td><html:textarea cols="40" rows="4" styleClass="TextareaStyle"  property="getVisaInfo"/></td></tr>
             <tr><td align="center">签证材料准备	</td><td><html:textarea cols="40" rows="4" styleClass="TextareaStyle"  property="visaMaterials"/></td></tr>
             <tr><td align="center">递交申请及面试 		</td><td><html:textarea cols="40" rows="4" styleClass="TextareaStyle"  property="submitApplicationAndInterview"/></td></tr>
             <tr><td align="center">备注	</td><td><html:textarea cols="40" rows="4" styleClass="TextareaStyle"  property="visaRemarks"/></td></tr>
             <tr><td align="center">免责声明	</td><td><html:textarea cols="40" rows="4" styleClass="TextareaStyle"  property="disclaimer"/></td></tr>
                    
                    <c:if test="${param.id ne null}">
                       <tr>
                        <td>产品图片名称</td>
                        <td><html:text property="icon" styleClass="InputStyle"/> *</td>
                   	 </tr>
                    </c:if>
                <tr><td colspan="2">
 <div class="pad-10">
    					<div class="col-tab">
           <ul class="tabBut cu-li">
            <li id="tab_swf_1" class="on" onclick="SwapTab('swf','on','',5,1);">上传图片</li>
           </ul>
								         <div id="div_swf_1" class="content pad-10 ">
								        								<div>
																		<div class="addnew">
																		<span id="buttonPlaceHolder"></span>
																		</div>
																		<input type="button" id="btupload" value="开始上传" onclick="swfu.startUpload();"/>
								              						    <div id="nameTip" class="onShow">最多上传<font color="red"> 1</font> 个附件,单文件最大 <font color="red">1.95 MB</font></div>
														                <div class="bk3"></div>
														                <div class="lh24">支持 <font style="font-family: Arial, Helvetica, sans-serif">gif、jpg、jpeg、png、bmp、</font> 格式。</div>
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
           
<br />
<br />

<c:if test="${param.id ne null}">
<div class="col-tab">
						<ul class="tabBut cu-li">
						<li id="tab_setting_1" class="on" onclick="SwapTab('setting','on','',5,1)">在职人员</li>
						<li id="tab_setting_2"  onclick="SwapTab('setting','on','',5,2)">退休人员</li>
						<li id="tab_setting_3"  onclick="SwapTab('setting','on','',5,3)">学生及未成年人</li>
						<li id="tab_setting_4"  onclick="SwapTab('setting','on','',5,4)">自由职业</li>
						<li id="tab_setting_5"  onclick="SwapTab('setting','on','',5,5)">不分职业</li>
						</ul>
			
				<div id="div_setting_1" class="contentList pad-10">
				<ul class="list-dot" id="student_text_1"></ul>
				<input type="button" onclick="uploadInfo(1)" value="签证资料"/>
				<input type="button" onclick="show_re(1)" value="显示已有"/>
				</div>
				<div id="div_setting_2" class="contentList pad-10">
				<ul class="list-dot" id="student_text_2"></ul>
				<input type="button" onclick="uploadInfo(2)" value="签证资料"/>
				<input type="button" onclick="show_re(2)" value="显示已有"/>
				</div>
				<div id="div_setting_3" class="contentList pad-10">
				<ul class="list-dot" id="student_text_3"></ul>
				<input type="button" onclick="uploadInfo(3)" value="签证资料"/>
				<input type="button" onclick="show_re(3)" value="显示已有"/>
				</div>
				<div id="div_setting_4" class="contentList pad-10">
				<ul class="list-dot" id="student_text_4"></ul>
				<input type="button" onclick="uploadInfo(4)" value="签证资料"/>
				<input type="button" onclick="show_re(4)" value="显示已有"/>
				</div>
				<div id="div_setting_5" class="contentList pad-10">
				<ul class="list-dot" id="student_text_5"></ul>
				<input type="button" onclick="uploadInfo(5)" value="签证资料"/>
				<input type="button" onclick="show_re(5)" value="显示已有"/>
				</div>
</div></c:if>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="submit"  class="cmd"   value="保存" />
            <input type="button" id="saveGoOn" class="cmd"  onclick="return saveAndGoOn();"  value="保存并继续" />
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
			var colsel_country=document.getElementsByName("info[colsel_country]")[0].value;
			var colsel_visatype=document.getElementsByName("info[colsel_visatype]")[0].value;
			var colsel_lingqu=document.getElementsByName("info[colsel_lingqu]")[0].value;
			if(colsel_country==="-1")
			{
				alert("请选择国家!");
				return false;
			}
			if(colsel_visatype==="-1")
			{
				alert("请选择签证类型!");
				return false;
			}
			if(colsel_lingqu==="-1")
			{
				alert("请选择领区!");
				return false;
			}
			$("#InputDetailBar").showLoading(); 
			form.submit();
			 }
			}); });
    
    
    
    
 SwapTab('setting','on','',5,1);
function SwapTab(name,cls_show,cls_hide,cnt,cur){
    for(i=1;i<=cnt;i++){
		if(i==cur){
			 $('#div_'+name+'_'+i).show();
			 $('#tab_'+name+'_'+i).attr('class',cls_show);
		}else{
			 $('#div_'+name+'_'+i).hide();
			 $('#tab_'+name+'_'+i).attr('class',cls_hide);
		}
	}
}
    
    
    //添加并继续
function saveAndGoOn()
{


$("#methodId").val("saveAndGoOn");
$("#myform").submit();
//jQuery('#InputDetailBar').showLoading();
}

    </script>
    