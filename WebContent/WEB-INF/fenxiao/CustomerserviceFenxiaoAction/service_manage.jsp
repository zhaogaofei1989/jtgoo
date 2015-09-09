<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/user_style.css" />
<title>客服信息</title>
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
        <jsp:include page="/WEB-INF/fenxiao/Public/left.jsp"/>
        <!--  -----------------右边内容部分--------------  -->
        <div class="right">
            <span class="ser_user"><b>用户管理</b> &nbsp;>> &nbsp;客服管理列表</span>
                <table border="1" class="service_tab">
                    <tr>
                        <th height="25px">编号</th>
                        <th>客服姓名</th>
                        <th>客服电话</th>
                         <th>QQ/MSN</th>
                         <th>公司名称</th>
                         <th>公司地址</th>
                         <th>公司电话</th>
                         <th>添加时间</th>
                         <th>相关操作</th>
                    </tr>
                    <tr>
                        <td>KF00000001</td>
                        <td>张三</td>
                        <td>13434343434</td>
                        <td>33434344</td>
                        <td>AAAA</td>
                        <td>BBBB</td>
                        <td>021-33334444</td>
                        <td>2012/11/17</td>
                        <td>
                            <a href="service_modify.html">修改</a>
                            <a href="#">删除</a>
                        </td>
                    </tr>            
                    <c:forEach var="cvo" items="${pageBean.recordList}">
                    <tr>
                    <td>${cvo.serialNumber }</td>
                    <td>${cvo.name}</td>
                    <td>${cvo.mobliePhone }</td>
                    <td>${cvo.chatTools }</td>
                    <td>${cvo.companyAddr }</td>
                    <td>${cvo.companyName }</td>
                    <td>${cvo.companyPhone }</td>
                    <td>${cvo.regTime }</td>
                    <td> <a href="${basePath}fenxiao/CustomerServiceFenXiaoAction.do?method=editUI&id=${cvo.id }">修改</a>
                           <a href="${basePath}fenxiao/CustomerServiceFenXiaoAction.do?method=delete&id=${cvo.id }">删除</a></td>
                    </tr>                                                                 
                    </c:forEach>
                </table>
                <input id="add_button" type="button" value="增加..." onclick="location.href='${basePath}fenxiao/CustomerServiceFenXiaoAction.do?method=addUI'" />
        </div>
    </div>
<!--  -----------------页脚部分--------------  -->
    <div class="footer">
    	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>

