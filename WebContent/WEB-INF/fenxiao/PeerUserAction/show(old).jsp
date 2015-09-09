<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/style_visa1.css" />
<title>签证中心</title>
</head>
<body>

<!-- -----------头部---------------- -->
	<div class="banner">
    	<span>钧通同业分销系统</span>
        <div class="banner1">
        	<img height="24px" src="${basePath}/style/images/banner1.gif" />
        	<span>4000-987-088</span>
        </div>
        <p><a href="http://wpa.qq.com/msgrd?v=3&uin=&site=qq&menu=yes" target="_blank"><img height="24px" src="${basePath}/style/images/qq.gif" /></a></p>
    </div>
    <div class="header">
    	<div class="header11">
        	<a href="http://toplife.gotoip55.com/"><img height="64px" src="${basePath}/style/images/head_logo.gif" /></a>
        </div>
        <div class="status">
        	<ul class="loginStatus">
                <li>
                	<span class="login_li">${customer.userName }！！欢迎登录同业分销系统</span>
                    <span>你的身份是<b>同业用户</b></span>
                    <span>
                        <a href="http://127.0.0.1:8080/jtgooCMS/static/login-ty.html">退出登录</a>
                        <a href="http://toplife.gotoip55.com/index.php?m=member&c=index">同业系统首页</a>
                        <a href="http://127.0.0.1:8080/jtgooCMS/static/index.html">网站主页</a>
                	</span>
                </li>
                <li>
                           最新签证订单：未审核
                    <strong>
                    <a href="${basePath}/fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=0">${nocheck }</a>
                    </strong>
                    个，已确认
                    <strong>
                    <a href="${basePath}/fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=8">${finished }</a>
                    </strong>
                    个，正在处理中
                    <strong>
                    <a href="${basePath}/fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList&status=1|2|3|4|5|6|7">${process }</a>
                    </strong>
                    个; 
                </li>
        	</ul>
        </div>
        
        <div class="notification">
        	<dl id="broadCast">
            	<dt>
                	<span>
						<a href="javascript:announce('46','持有美国签证可免签入境国')">持有美国签证可免签入境国</a>
					</span>
                    <font>
                    	<a href="http://toplife.gotoip55.com/index.php?m=member&c=index&a=announcelist">[更多公告...]</a>
                    </font>
                </dt>
            </dl>
        </div>
        <div class="notification1">
        	<a href="http://toplife.gotoip55.com/index.php?m=message&amp;c=index&amp;a=send">[更多通知...]</a>
        </div> 
    </div>

<div class="content">    
<jsp:include page="/WEB-INF/fenxiao/Public/left.jsp"/>
<!--  -----------------右边内容部分--------------  -->
<div class="right">

 <table id="RuningInfo">
 <tbody>
 <tr>
 <th>
 <ul class="Dynamic">
 <h1>
 <span>签证产品更新动态</span>
 </h1>
 <li>1</li>
 <li>1</li>
 <li>1</li>
 <li>11</li>
 </ul>
 </th>
 
 <td>
 
 <ul class="ProductDynamic">
                                	<h1>
                                    	<span>旅游产品更新动态</span>
                                        
                                    </h1>	
						 						 	                                	<li><a href="trip-13-30-1.html" target="_blank">澳大利亚卧龙岗大学11日动感游学项目</a><span>13/01/07</span></li>
							                                	<li><a href="trip-13-32-1.html" target="_blank">2013第24届越南国际纺织面料及服装辅料展览会</a><span>13/01/06</span></li>
							                                                         </ul>
 </td>
 </tr>
 </tbody>
 </table>
</div>



<!--  -----------------页脚部分--------------  -->
<div class="footer">
	    <p>
			<a target="_blank" href="http://toplife.gotoip55.com/about.html">关于我们</a>
			<a target="_blank" href="http://toplife.gotoip55.com/login_ty.html">同业系统</a>
			<a target="_blank" href="http://toplife.gotoip55.com/visalists-8-1.html">签证服务</a>
			<span><a target="_blank" href="http://toplife.gotoip55.com/show-7-61-1.html">付款方式</a></span>
    	</p>
    	<p>专业旅游签证公司，钧通商旅帮你忙</p>
</div>

</div>
</body>
</html>

