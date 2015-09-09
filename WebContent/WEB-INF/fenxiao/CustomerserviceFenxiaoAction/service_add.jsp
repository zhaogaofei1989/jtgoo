<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/user_style.css" />
<title>新增客服</title>
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
            <span class="add_ser"><b>添加客服用户：</b></span>
            <form id="myform" name ="CustomerServicersActionForm" action="/jtgooCMS/fenxiao/CustomerServiceFenXiaoAction.do?method=add" method="post">
                <table class="add_tab" style="font-size: 14px;">
                    <tr>
                        <th>客服姓名：</th>
                        <td>
                            <input type="text" name="name" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>客服电话：</th>
                        <td>
                            <input type="text" name="mobliePhone" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>QQ/MSN：</th>
                        <td>
                            <input type="text" name="chatTools" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>公司名称：</th>
                        <td>
                            <input type="text" name="companyName" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>公司地址：</th>
                        <td>
                            <input type="text" name="companyAddr" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>公司电话：</th>
                        <td>
                            <input type="text" name="companyPhone" size="25"/>
                        </td>
                    </tr>                                                                      
                </table>
                <span>
                    <input type="submit" id="add_save" name="add_save" value="保存" onclick="" />
                    <input type="button" id="add_back" name="add_back" value="返回" onclick="javascript:history.go(-1)" />
                </span>
                </form>
        </div>
    </div>
<!--  -----------------页脚部分--------------  -->
    <div class="footer">
    	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>

