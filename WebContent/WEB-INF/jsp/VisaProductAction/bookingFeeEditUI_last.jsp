<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>签证预约费设置</title>
	<meta   http-equiv= "Pragma"   content= "no-cache" />
	<meta   http-equiv= "Cache-Control"   content= "no-cache" />
	<meta   http-equiv= "Expires"   content= "0" /> 
	
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
<link href="${basePath}style/loadingbar/showLoading.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${basePath}js/jquery.showLoading.js"></script>
</head>
<body>
<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 签证预约费设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<!--显示表单内容-->
<div id="MainArea">
    <html:form action="/background/VisaProductAction" styleId="myform">
    	<html:hidden property="method" styleId="methodId" value="bookFeeEdit"/>
    	<html:hidden property="id" styleId="id" value="${id}"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder" id="table">
            <div class="ItemBlock">
                <table  cellpadding="0" cellspacing="0" class="mainForm">
             
                    <tr>
                        <td align="center">签证名称</td>
                        <td><html:text property="name" readonly="true" styleClass="InputStyle required"/> *</td>
                    </tr>

     
             	 <tr><td align="center">签证费</td><td><html:text property="visaFee" styleClass="InputStyle"/></td></tr>
           	    <tr><td align="center">签证费0-6岁 </td><td><html:text property="visaFee1" styleClass="InputStyle"/></td></tr>
           		 <tr><td align="center">签证费6-12岁 </td><td><html:text property="visaFee2" styleClass="InputStyle"/></td></tr>
            
            	 <tr><td align="center">预约费</td><td><html:text property="bookFee" styleClass="InputStyle"/></td></tr>
            	 <tr><td align="center">预约费0-6岁</td><td><html:text property="bookFee1" styleClass="InputStyle"/></td></tr>
            	 <tr><td align="center">预约费6-12岁</td><td><html:text property="bookFee2" styleClass="InputStyle"/></td></tr>
                </table>
           
<br />
<br />
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
  
    //添加并继续
function saveAndGoOn()
{

$("#methodId").val("bookFeeEditContinue");
$("#myform").submit();
//jQuery('#InputDetailBar').showLoading();
}

    </script>
    