<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <title>拒签原因</title>
    <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
    <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/>拒签原因
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
    <html:form action="background/CustomerAction">
    	<html:hidden property="method" value="refusedVisaResult"/>
    	<html:hidden property="id" value="${id}"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr>
                        <td>拒签原因: </td>
                        <td><textarea id="reason" name="reason" class="TextareaStyle" style="width: 450px;"  value="asdfasdf">${reason }</textarea>
                  
                        </td>
                    </tr>
                    <tr>
                        <td>问题分析: </td>
                        <td><textarea id="analysis" name="analysis"  style="width: 450px;" class="TextareaStyle"> ${ analysis}</textarea></td>
                    </tr>
                    <tr>
                        <td >处理结果: </td>
                        <td><textarea id="results" name="results"  style="width: 450px;" class="TextareaStyle"> ${results }</textarea></td>
                    </tr>
                </table>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
        </div>
    </html:form>
</div>
    

<div class="Description">
	说明：<br />

</div>

</body>
</html>

