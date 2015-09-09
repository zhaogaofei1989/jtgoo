<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/user_style.css" />
<title>我的资料</title>
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
        <!-- -----------------左边菜单版块---------------- -->
		<jsp:include page="/WEB-INF/fenxiao/Public/left.jsp"/>
    <!--  -----------------右边内容部分--------------  -->
        <div class="right">
            <span class="user_mana"><b>用户管理</b> &nbsp;>> &nbsp;我的资料 &nbsp;>> &nbsp;修改</span>
            <div class="user_modify">
                <form id="myform" name ="CustomerActionForm" action="/jtgooCMS/fenxiao/PeerUserAction.do?method=account_manage_update" method="post">
                <table class="modify_tab" style="font-size: 14px;">
                    <tr>
                        <th>用户编号：</th>
                        <td>
                            <input type="text" name="data_modify1" readonly value="${customer.serialNumber }" />
                        </td>
                    </tr>
                    <tr>
                        <th>姓名：</th>
                        <td>
                            <input type="text" name="data_modify2"  readonly="readonly" value="${customer.userName }" />
                        </td>
                    </tr>
                    <tr>
                        <th>手机：</th>
                        <td>
                            <input type="text" name="mobliePhone" value="${customer.mobliePhone }" />
                        </td>
                    </tr>
                    <tr>
                        <th>Email：</th>
                        <td>
                            <input type="text" name="email" value="${customer.email }" />
                        </td>
                    </tr>
                    <tr>
                        <th>QQ号码：</th>
                        <td>
                            <input type="text" name="chatTools" value="${customer.chatTools }" />
                        </td>
                    </tr>
                    <tr>
                        <th>公司名称：</th>
                        <td>
                            <input type="text" name="companyName" value="${customer.companyName }" />
                        </td>
                    </tr>
                    <tr>
                        <th>职务：</th>
                        <td>
                            <input type="text" name="position" value="${customer.position }" />
                        </td>
                    </tr>
                    <tr>
                        <th>公司地址：</th>
                        <td>
                            <input type="text" name="companyAddr" value="${customer.companyAddr }" />
                        </td>
                    </tr>
                    <tr>
                        <th>公司座机：</th>
                        <td>
                            <input type="text" name="companyPhone" value="${customer.companyPhone }" />
                        </td>
                    </tr>
                    <tr>
                        <th>公司主要经营范围：</th>
                        <td>
                            <textarea class="textareastyle" name="business_content">${customer.business_content }</textarea>
                        </td>
                    </tr>                                                                               
                </table>
                <span>
                    <input type="submit" name="user_modify" value="保存"/>
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

