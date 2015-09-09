<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>添加在职人员所需签证资料2</title>
    <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
  <script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
    
    <script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
   <link href="${basePath}js/linkage/style/admin.css" rel="stylesheet" type="text/css">
  <script type="text/javascript" src="${basePath}js/linkage/js/mln.colselect.js">    </script>
   <script type="text/javascript" src="${basePath}js/cke/basic/ckeditor.js"></script>
	<link rel="stylesheet" href="${basePath}js/cke/basic/sample.css">
<style type="text/css">
	td{
	padding-left: 15px;
	}
	</style>
</head>
<body>
<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 在职人员所需签证资料
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<!--显示表单内容-->
<div id="MainArea">
    <html:form action="background/VisaDataTypeDetailAction"  styleId="myform">
    	<html:hidden property="method" styleId="methodId"  value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id"/>
    	<html:hidden styleId="pid" property="pid" value="${pid }"/>
    	<html:hidden styleId="type" property="type" value="${type }"/>
       <html:hidden styleId="visadataTypeName" property="visadataTypeName" value="${visadataTypeName}"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                        <td>是否标记</td>
                        <td>&nbsp;
                       是 <html:radio property="sign"  styleId="sign0" value="0" onclick="alter(this.value)" />
                       否 <html:radio property="sign"  styleId="sign1" value="1" onclick="alter(this.value)" />
                        </td>
                       </tr>
                    <tr>
                        <td>资料分类</td>
                        <td>  <div id="colsel_visadatatype"></div>
<script type="text/javascript">
 $.ajax({
 url: "GetVisaDataTypeInfo.do", 
 dataType:'json',
 success: function(msg){
var visadataTypeId=${visadataTypeId};
if(visadataTypeId==-1)
{
	$("#colsel_visadatatype").mlnColsel(msg,{
				title:"签证资料分类",
				value:"-1",
				width:100
			});
}
else
{
 var name=$("#visadataTypeName").val();
	$("#colsel_visadatatype").mlnColsel(msg,{
				title:name,
				value:visadataTypeId,
				width:100
			});
}
 }});
      </script></td>
                    </tr> 
                    <!-- 
                    <c:if test="${param.id ne null}">
                    <tr>
                    <td>签证所需资料</td>
                    <td>  
                    <fieldset>
                    <legend>文件列表</legend>
                  <div id="uf" name="uf">
                  <c:forEach items="${attachmentList}" var="attachment" >
             			 <input type="text" name="attachment[name]" value="${attachment.name}" disabled="disabled"/>
                   <html:link action="AttachmentAction.do?method=download&id=${attachment.id}">
                  下载
                  </html:link>
                   <html:link action="AttachmentAction.do?method=delete&id=${attachment.id}">
                   删除
                  </html:link>
                  </br>
                  
                  </c:forEach>
                  </div>
                    </fieldset>
                    </td>
                    </tr>
                    <tr>
                        <td>多文件上传</td>
                        <td><input type="button" id="uploadId" onclick="uploadInfo()" value="上传附件"/> *</td>
                    </tr></c:if>-->
                      <tr> 
                        <td>标题</td>
                        <td><html:text property="title" styleId="title" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>内容</td>
                        <td><html:textarea property="content"  styleClass="ckeditor" style="height:200px;"/></td>
                    </tr>
             
                </table>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
             <input type="submit" class="cmd" value="保存"/>
             <input type="button" class="cmd" value="保存并新增" onclick="saveAndAdd();"/>
        </div>
    </html:form>
</div>

<div class="Description">
<br />
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
			var x=document.getElementsByName("info[colsel_visadatatype]")[0].value;
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
    
   
   
   
    
    </script>

    