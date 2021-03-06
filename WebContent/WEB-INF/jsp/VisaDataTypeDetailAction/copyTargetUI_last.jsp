<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>复制到其他职业</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
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
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 复制到其他职业
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<!--显示表单内容-->
<div id="MainArea">
    <html:form action="/background/VisaDataTypeDetailAction"  styleId="myform">
    	<html:hidden property="method" styleId="methodId"  value="copyRefreshUI"/>
    	<html:hidden styleId="pid" property="pid" value="${pid }"/>
    	<html:hidden styleId="type" property="type" value="${type }"/>
    	<html:hidden styleId="ids" property="ids" value="${ids }"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                        <td>选择复制到其他职业:</td>
                        <td>
                        <c:forEach var="occ" items="${occuMap}">
                        <c:if test="${occ.key ne type}">${occ.value }  <input type="radio" value="${occ.key }" name="occ" /></c:if>
                        </c:forEach>
                        </td>
                       </tr>
                </table>
            </div>
        </div>
        <!-- 表单操作 -->
        <div id="InputDetailBar">
             <input type="submit" class="cmd" value="保存" onclick="return validate();"/>
        </div>
    </html:form>
</div>
</body>
</html>
   <script type="text/javascript">
function validate()
{
var name = $("input[@name='occ']:checked").val();
if(name==''||name==undefined)
{
alert("请选择一个职业类型!");
return false;
}
}
    </script>

