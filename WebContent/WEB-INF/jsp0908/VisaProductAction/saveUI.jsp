<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>签证产品设置</title>
	<meta   http-equiv= "Pragma"   content= "no-cache" />
	<meta   http-equiv= "Cache-Control"   content= "no-cache" />
	<meta   http-equiv= "Expires"   content= "0" /> 
	
 <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<link type="text/css" rel="stylesheet" href="${basePath}js/amazeui/css/amazeui.css" />
<link type="text/css" rel="stylesheet" href="${basePath}js/amazeui/css/admin.css" />
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
    height: 600,
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
<!-- start  admin-content div-->
<div class="admin-content">
	  <div class="am-cf am-padding">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证产品</strong> / <small>${param.id eq null ? '签证产品添加' : '签证产品修改'}</small></div>
	  </div>
  
<!--显示表单内容-->
<!--form div -->
  <div class="am-tabs am-margin" data-am-tabs>
        <html:form styleClass="am-form"  action="/background/VisaProductAction" styleId="myform">
    	<html:hidden property="method" styleId="methodId" value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id" styleId="id" value="${id}"/>
    	<html:hidden property="serialNumber"/>
    	<html:hidden styleId="countryName" property="countryName" value="${countryName}"/>
    	<html:hidden styleId="visaTypeName" property="visaTypeName" value="${visaTypeName}"/>
    	<html:hidden styleId="lingquName" property="lingquName" value="${lingquName}"/>
    	<html:hidden styleId="insurancePackageName" property="insurancePackageName" value="${insurancePackageName}"/>

   			<div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	签证名称
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="name" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
           </div>
          
          
           <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	签证国家
            </div>
            <div class="am-u-sm-8 am-u-md-4">
               <div id="colsel_country"></div>
                      <link href="${basePath}js/linkage/style/admin.css" rel="stylesheet" type="text/css"/>
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
      </script>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
           <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            签证类型
            </div>
            <div class="am-u-sm-8 am-u-md-4">
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
      </script>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          
          
           <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            送签领区
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            
           <c:choose>
           
           <c:when test="${param.id eq null}">
	     <select name='info[colsel_lingqu]' id='info[colsel_lingqu]'  multiple data-am-selected="{ btnSize: 'sm'}">
		<c:forEach items="${lingquList}" var="lingqu">
		<option value="${lingqu.id }">${lingqu.name }</option>
		</c:forEach>
		</select>
	       </c:when>
           <c:otherwise>
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
           </c:otherwise>
           </c:choose> 
           </div>
            
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          
           <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           保险
            </div>
            <div class="am-u-sm-8 am-u-md-4">
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
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          
         <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	是否需要面试
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           是  <html:radio property="isInterview" value="0"/>
           否  <html:radio property="isInterview" value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	是否需要预约
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           是  <html:radio property="isNeedToAppointment" value="0"/>
           否  <html:radio property="isNeedToAppointment" value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
            <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	签证申请周期
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="visaApplyCycle" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	一般签证有效期
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="visaValid" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	一般停留期
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="periodOfStay" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          
           <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	选择次数
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           单次  <html:radio property="oneToManySelect" value="0"/>
           多次  <html:radio property="oneToManySelect" value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	是否可以代领签证
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           是  <html:radio property="acceptType" value="0"/>
           否  <html:radio property="acceptType" value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            	报价是否含签证费
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           是  <html:radio property="quotationHasVisaPrice"  value="0"/>
           否  <html:radio property="quotationHasVisaPrice"  value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           领区划分
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" property="lingquDivide"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           网址链接
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" property="webSiteLink"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           预约需要的信息
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" property="bookingInformationNeeds"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           使领馆和签证中心地址
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" cols="15" property="consularAndVisaCenterAddress"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           如何进行签证查询
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" cols="15" property="howToQueryVisaInfo"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           签证的领取	
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" cols="15" property="getVisaInfo"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           材料特殊要求
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" cols="15" property="visaMaterials"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           递交申请及面试 
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" cols="15" property="submitApplicationAndInterview"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
     	 备注
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" cols="15" property="visaRemarks"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           免责声明
            </div>
            <div class="am-u-sm-8">
       			  <html:textarea rows="10" cols="15" property="disclaimer"/>
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
														<ol><li><br/></li></ol>
														</div>
						</div>    
						
<hr/>
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

          
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="submit"  class="am-btn am-btn-primary am-btn-xs"   value="保存" />
            <c:if test="${param.id ne null}">
            <input type="button" id="saveGoOn" class="am-btn am-btn-primary am-btn-xs"  onclick="return saveAndGoOn();"  value="保存并继续" />
            </c:if>
        </div>
        </html:form>
</div>


<div class="Description">
	
	 <p>注:1):文件上传成功后，在【图片】 文本框中填写图片的名称:如 china.jpg 
	 <br/>
	     2):该图片用于网页主页产品的展示,前台网站可动态加载最新的图片
	  </p>
	
</div>
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${basePath}js/amazeui/jquery.min.js"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
</body>
</html>
    <script type="text/javascript">
    
   //让新旧版本共存的jQuery	
  jQuery.noConflict(true);
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
    