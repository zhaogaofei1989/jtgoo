<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>添加在职人员所需签证资料</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
   <link href="${basePath}js/linkage/style/admin.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${basePath}js/linkage/js/mln.colselect.js">    </script>
 
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
    <html:form action="/VisaDataTypeDetailAction">
    <html:hidden property="method" value="${param.parentId eq null ? 'add' : 'edit'}"/>
    <html:hidden property="id"/>
    <html:hidden styleId="visadataTypeName" property="visadataTypeName" value="${visadataTypeName}"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr>
                        <td>资料分类</td>
                        <td>  <div id="colsel_visadatatype"></div>
<script type="text/javascript">
 $.ajax({
 url: "GetVisaDataTypeInfo", 
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
                    
                    <c:if test="${param.parentId ne null}">
                    <tr>
                    <td>签证所需资料</td>
                    <td>  
                    <fieldset>
                    <legend>文件列表</legend>
                  <div id="uf" name="uf">
                  	<c:forEach items="${attachmentList}" var="attachment" >
             			 <input type="text" name="attachment[name]" value="${attachment.name}" disabled="disabled"/>
                   <html:link action="AttachmentAction?method=download&id=${attachment.id}">
                  下载
                  </html:link>
                   <html:link action="AttachmentAction?method=delete&id=${attachment.id}">
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
                    </tr></c:if>
                      <tr>
                        <td>标题</td>
                        <td><html:text property="title" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>内容</td>
                        <td><html:textarea property="content" styleClass="TextareaStyle"/> *</td>
                    </tr>
                 
             
                </table>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
        </div>
    </html:form>
</div>

<div class="Description">
	<br />

</div>

</body>
</html>
   <script type="text/javascript">
function uploadInfo()
{
var pid=${param.parentId};
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

    