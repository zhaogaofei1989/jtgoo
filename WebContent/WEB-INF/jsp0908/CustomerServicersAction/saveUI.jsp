<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>信息管理</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    
</head>
<body>
<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/>
       人员信息管理     
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<!--显示表单内容-->
<div id="MainArea">	
    <html:form action="background/CustomerServicersAction">
    	<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}" styleId="methodId"/>
    	<html:hidden property="id"/>
    	<html:hidden property="peerId" value="${peerId}"/>
    	<html:hidden property="userType" value="${userType}"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr>
                        <td>姓名</td>
                        <td><html:text property="name" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>手机</td>
                        <td><html:text property="mobliePhone" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>公司座机</td>
                        <td><html:text property="companyPhone" styleClass="InputStyle"/> *</td>
                    </tr>
                    <tr>
                        <td>QQ</td>
                        <td><html:text property="chatTools" styleClass="InputStyle"/> </td>
                    </tr>
                    <tr>
                        <td>email</td>
                        <td><html:text property="email" styleClass="InputStyle"/></td>
                    </tr>
              <c:if test="${userType eq 1}">
                 <td>联系人职务</td>
                <td><html:text property="position" styleClass="InputStyle"/></td>
             </c:if>
             
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


    