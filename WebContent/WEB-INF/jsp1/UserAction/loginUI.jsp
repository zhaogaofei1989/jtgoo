<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>jtgoo</title>
    <%@ include file="../Public/commons.jspf" %>
	<LINK href="${basePath}/style/blue/login.css" type=text/css rel=stylesheet>
	<script type="text/javascript">
		if( window.parent != window ){ // 如果在frame中显示，就变成在顶级窗口中显示登录
			window.parent.location.href = window.location.href;
		}
	</script>
</head>

<body LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 CLASS=PageBody >


<!-- 显示表单 -->

<html:form action="/background/UserAction?method=login" focus="loginName">
    <div id="CenterAreaBg">
        <div id="CenterArea">
            <div id="LogoImg"><img border="0" src="${basePath}/style/blue/images/logo.png" /></div>
            <div id="LoginInfo">
                <table BORDER=0 CELLSPACING=0 CELLPADDING=0 width=100%>
                	<tr>
                		<td colspan="3"><!-- 显示错误 -->
							<font color="red"><html:errors/></font>
                		</td>
                	</tr>
                    <tr>
                        <td width=45 class="Subject"><img border="0" src="${basePath}/style/blue/images/login/userId.gif" /></td>
                        <td>
                        	<html:text property="loginName" size="20" tabindex="1" styleClass="TextField required" />
                        	<html:hidden property="type" value="1"/>
                        </td>
                        <td rowspan="2" style="padding-left:10px;">
                        	<html:image tabindex="3" src="${basePath}/style/blue/images/login/userLogin_button.gif" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Subject"><img border="0" src="${basePath}/style/blue/images/login/password.gif" /></td>
                        <td><html:password property="password" size="20" tabindex="2" redisplay="false" styleClass="TextField required" /></td>
                    </tr>
                </table>
            </div>
            <div id="CopyRight"><a href="javascript:void(0)">&copy; 2014 版权所有 jtgoo</a></div>
        </div>
    </div>
    </html:form>
</body>

</html>

