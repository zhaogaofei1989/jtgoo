<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}style/fenxiao/time_dynamic.css" />
<title>预约时间动态</title>
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
        <span class="content_title">
            <b>预约时间动态 (上海)</b>
            <small>预约时间即时有效，以实际预约时间为准!</small>
        </span>
        <table class="content_tab" border="1">
           	<tr>
                <th height="30px">洲际</th>
                <th>国家</th>
                <th>签证类型</th>
                <th>领区</th>
                <th>最早日期</th>
                <th>更新人员</th>
                <th>更新日期</th>
                <th>备注</th>
            </tr>
           <c:forEach items="${zhouJiList}" var="zhouji">
            <c:forEach items="${pageBean.recordList}" var="visaOrder"  varStatus="status">
                        <c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
                <tr class="odd">
                    <td>
                    ${ zhouji.name}
                    </td>
                    <td>
                    ${visaOrder.visaProduct.country.name}
                    </td>
                    <td>
                    ${visaOrder.visaProduct.type.name}
                    </td>
                    <td>
                        ${visaOrder.visaProduct.lingqu.name}
                    </td>
                    <td>
                    </td>
                    <td>		${visaOrder.remarksBackstage}
                    </td>
                    <td>		${visaOrder.remarksBackstage}
                    </td>
                    <td>
                    </td>
                
                <!-- 	<td>
                    <c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
                    ${ visaOrder.visaProduct.country.name}
                    </c:if>
                    </td>
                    <td>
                    <c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
                    ${ visaOrder.visaProduct.type.name}
                    </c:if>
                    </td>
                    <td>
                    <c:if test="${ visaOrder.visaProduct.country.parent ne null && visaOrder.visaProduct.country.parent.id ==zhouji.id }">
                    ${ visaOrder.visaProduct.lingqu.name}
                    </c:if>
                    </td>
                    <td>${ visaOrder.customer.saler.name}</td>
                    <td>${ visaOrder.operator}</td>
                    <td>${ visaOrder.sentToSignPeople}</td>
                    <td>${ visaOrder.remarksReception}</td> -->
                </tr>
                </c:if>
            </c:forEach>	
            </c:forEach>
    
            <tr>
                <th rowspan="6">欧洲申根国家</th>
                <td>德国</td>
                <td>旅游签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td>(管理员)</td>
                <td>2012/11/16</td>
                <td>以后都有时间</td>
            </tr>
            <tr>
                <td>德国</td>
                <td>商务签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>17、19有时间</td>
            </tr>
            <tr>
                <td>德国</td>
                <td>探亲访友签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>20、21没有时间其他都有</td>
            </tr>
            <tr>
                <td>法国</td>
                <td>旅游签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>以后都有时间</td>
            </tr>
            <tr>
                <td>法国</td>
                <td>商务签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>17、19有时间</td>
            </tr>
            <tr>
                <td>法国</td>
                <td>探亲访友签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>20、21没有时间其他都有</td>
            </tr>
            <tr>
                <th rowspan="3">欧洲申根国家</th>
                <td>英国</td>
                <td>旅游签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>以后都有时间</td>
            </tr>
            <tr>
                <td>英国</td>
                <td>旅游签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>17、19有时间</td>
            </tr>
            <tr>
                <td>俄罗斯</td>
                <td>旅游签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>20、21没有时间其他都有</td>
            </tr>
            <tr>
                <th rowspan="2">美洲国家</th>
                <td>美国</td>
                <td>旅游签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>以后都有时间</td>
            </tr>
            <tr>
                <td>美国</td>
                <td>旅游签证</td>
                <td>上海</td>
                <td>2012/11/17</td>
                <td></td>
                <td>2012/11/16</td>
                <td>17、19有时间</td>
            </tr>
        </table>
    </div>
    <div class="footer">
    	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>
