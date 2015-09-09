<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>添加在职人员所需签证资料</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
    <script type="text/javascript">
function uploadInfo()
{
var pid=$("#id").val();
art.dialog.open('AttachmentAction.do?method=uploadUI&pid=pid',
 {title: '上传文件',
    width: 500,
    height: 240,
    left: '50%',
    top: '3%',
    lock:true,
    id:'tt',
    cancel: function()
    {
    this.close();
    }
});
}
    
    </script>
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
    	<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id"/>
    	<html:hidden property="pid" value="${pid}"/>
		<div id="tt" name="tt">${pid}sssssssssssssss</div>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr>
                        <td>资料分类</td>
                        <td><html:text property="title" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>多文件上传</td>
                        <td><input type="button" id="uploadId" onclick="uploadInfo()" value="上传附件"/> *</td>
                    </tr>
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


    