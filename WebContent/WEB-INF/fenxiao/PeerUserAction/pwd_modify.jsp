<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/user_style.css" />
<title>修改密码</title>
<!--<script type="text/javascript">
		function close_self() {
			window.open("about:blank","_self").close();
		}
</script>-->
</head>
<body>
<!-- -----------头部---------------- -->
	<div class="header1">
		<jsp:include page="/WEB-INF/fenxiao/Public/header1.jsp" />
    </div>
    <div class="header2">
    	<jsp:include page="/WEB-INF/fenxiao/Public/header2.jsp" />
    </div>
    <div class="content">
    <!--  -----------------右边内容部分--------------  -->
        <jsp:include page="/WEB-INF/fenxiao/Public/left.jsp"/>
        <div class="right">
            <span><b>用户管理</b> &nbsp;>> &nbsp;修改密码</span>
            <div class="pwd_modify">
                <form id="myform" name ="CustomerActionForm" action="/jtgooCMS/fenxiao/PeerUserAction.do?method=account_manage_password_update" method="post">
                    <table border="0" class="pwd_tab" style="font-size: 14px;">
                        <tr>
                            <th>原始密码：</th>
                            <td>
                                <input type="password" name="oldpasswd"  value="" /> <font color="red"><html:errors/></font>
                            </td>
                        </tr>
                        <tr>
                            <th>新密码：</th>
                            <td>
                                <input type="password" name="passwd" />
                            </td>
                        </tr>
                        <tr>
                            <th>再次输入新密码：</th>
                            <td>
                                <input type="password" name="confirmPasswd" />
                            </td>
                        </tr>
                    </table>
                    <span>
                        <input type="submit" name="user_modify1" value="确认"/>
                        <!-- <input type="button" name="user_modify2" value="取消" onclick="close_self()" /> -->
                    </span>
                </form>
            </div>
        </div>
    </div>

<!--  -----------------页脚部分--------------  -->
    <div class="footer">
    	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>
