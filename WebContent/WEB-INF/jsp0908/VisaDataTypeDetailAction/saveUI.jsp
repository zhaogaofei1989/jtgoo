<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>添加在职人员所需签证资料</title>
 <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>

 <script type="text/javascript" src="${basePath}js/cke/basic/ckeditor.js"></script>
<style type="text/css">
	td{
	padding-left: 15px;
	}
</style>
</head>
<body>


  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">在职人员所需签证资料</strong>  </div>
    </div>

 <div class="am-tabs am-margin" data-am-tabs>
 

      <html:form action="background/VisaDataTypeDetailAction"  styleId="myform">
    	<html:hidden property="method" styleId="methodId"  value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id"/>
    	<html:hidden styleId="pid" property="pid" value="${pid }"/>
    	<html:hidden styleId="type" property="type" value="${type }"/>
        <html:hidden styleId="visadataTypeName" property="visadataTypeName" value="${visadataTypeName}"/>
        
        <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            是否标记
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            &nbsp;
                       是 <html:radio property="sign"  styleId="sign0" value="0" onclick="alter(this.value)" />
                       否 <html:radio property="sign"  styleId="sign1" value="1" onclick="alter(this.value)" />
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
        <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
          资料分类
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		<select name="colsel_visadatatype" id="colsel_visadatatype">
		<option value="-1">请选择</option>
		<c:forEach items="${datatypeList}" var="vo">
		<option name="resize1option" value="${vo.id}" ${vo.id==visadataTypeId?'selected':''}>${vo.name}</option>
		</c:forEach>
		</select>
            
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
        
        
        
           <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           标题
            </div>
            <div class="am-u-sm-8 am-u-md-4">
          <html:text property="title" styleId="title"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
        
        
           <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           内容
            </div>
            <div class="am-u-sm-8 am-u-md-4">
        <html:textarea property="content"  styleClass="ckeditor"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
   
	
	
 
      </html:form>
      
   		<div id="InputDetailBar">
             <input type="button" class="am-btn am-btn-primary am-btn-xs" onclick="saveInfo()" value="保存"/>
             <input type="button" class="am-btn am-btn-primary am-btn-xs" value="保存并新增" onclick="saveAndAdd();"/>
        </div>
     
      </div>
      
</div>
     
    	<!--[if (gte IE 9)|!(IE)]><!-->
<script language="javascript" src="${basePath}js/jquery-1.7.js"  charset="utf-8"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
</body>
</html>
   <script type="text/javascript">
     $(function(){
 $("#myform").validate({
 	onsubmit:true,// 是否在提交是验证 
	onfocusout:false,// 是否在获取焦点时验证 
	onkeyup :false,// 是否在敲击键盘时验证 
	        rules: {
	           		 title:{
	            		 required: true
	            		 },
	       		 },
	        	messages: 
				{
					 title: {
						required: "不能为空",
						  }
				},
			submitHandler: function(form) {
			var x=document.getElementById("colsel_visadatatype").value;
			if(x==="-1")
			{
				alert("请选择资料分类!");
				return false;
			}
			form.submit();
			 }
			}); });

   //选择是同业用户还是普通用户
function alter(value)
{
if(value==0)
{

$("#sign0").attr('checked',true );
}
else 
{
$("#sign1").attr('checked',true );
}
}
   
   
       //添加并继续
function saveAndAdd()
{
$("#methodId").val("saveAndAdd");

$("#myform").submit();
}
    
   
   function saveInfo()
{
$("#myform").submit();

}
   
   
function uploadInfo()
{

var pid=$("#pid").val();
art.dialog.open('AttachmentAction.do?method=uploadUI&dataTypeDetailId='+pid,
 {  title: '上传文件',
    width: 500,
    height: 240,
    left: '50%',
    top: '3%',
    lock:true,
   ok:function()
   {
   var iframe = this.iframe.contentWindow;
    /**该dialog 是附件列表  iframe.$("#tt").html("222222");**/
   var liList=iframe.$("#fsUploadProgress li");
     $.each(liList,function(n,value) { 
     var n=$(value);
     var childId=n.children()[0].id;
     var arr=childId.split("|");
        $("#uf").append("<input type='text' name='attachment[name]' value='"+arr[1]+"' disabled='disabled'/><a href='AttachmentAction.do?method=download&id="+arr[0]+"'>&nbsp;下载&nbsp;<a href='AttachmentAction.do?method=delete&id="+arr[0]+"'>删除</a></br>");
     });
   }
    
});
}
    
    </script>

    