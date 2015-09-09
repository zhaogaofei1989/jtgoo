<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>jtgoo</title>
<%@ include file="../Public/commons.jspf" %>
<link rel="stylesheet" type="text/css" href="${basePath}/static/layout/style.css"/>
<script type="text/javascript">
window.onresize = window.onload = function(){
var w,h
if(!!(window.attachEvent && !window.opera))
{
h = document.documentElement.clientHeight;
w = document.documentElement.clientWidth;
}else{
h =	window.innerHeight;
w = window.innerWidth;
}
document.getElementById('msg').value  ='çªå£å¤§å°ï¼' + 'width:' + w + '; height:'+h;
var bgImg = document.getElementById('bg').getElementsByTagName('img')[0];
bgImg.width = (w - 5);
bgImg.height= (h-5) ;	

}	
</script>
</head>

<body>
<div class="login-ty">
    <div id="bg"><img src="${basePath}/static/images/bg.gif" width="1106" height="739" /></div>
    <input type="text" id="msg" name="msg" size="50" style="display:none"/>
    <div class="ty-SiteNav">
    	<div class="ty-SiteNavBd">
        	<ul>
        		<li class="ty-logo"><img src="${basePath}/static/layout/images/ty-logo.png" width="189" height="58" /></li>
                
                <li class="ty-icon"><img src="${basePath}/static/layout/images/ty-QQ.gif" width="94" height="24" /></li>
        	</ul>
        </div>	
      <div class="ty-SiteNavBg"></div>
    </div>
  <div class="ty-loginArea">
  <form action="/jtgooCMS/fenxiao/PeerUserAction.do" method="post">
  <input type="hidden" name="method" value="login" />
        <table width="268" border="1" class="ty-tab">
        		<tr>
                		<td colspan="2"><!-- 显示错误 -->
							<font color="red">${error}</font>
                		</td>
                	</tr>
            <tr>
                <td style="text-align:right">用户名</td>
                <td><input id="userName" name="userName" type="text" /></td>
            </tr>
            <tr>
                <td style="text-align:right">密码</td>
                <td><input id="passwd" name="passwd" type="password" /></td>
            </tr>
            <tr>
                <td style="text-align:right">验证码</td>
                <td><input type="text" name="randCode"  value="请输入验证码！"  onfocus="if (value =='请输入验证码！'){value =''}" onblur="if (value ==''){value='请输入验证码！'}"/> </td>
              </tr>
              <tr>
              	<td colspan="2" style="text-align:right; padding-right: 26px;"> <img title="点击更改验证码" style="cursor: pointer;"  width="100" height="21" align="absmiddle" onclick="changeCode(this)" src="../RandomCode" /></td>
              </tr>
        </table>
      
        </form>
        <div class="ty-btn"  onclick="login()">登录</div>
        <div class="loginArea-bottom"><a href="">同业登录</a><span>|</span><a href="http://127.0.0.1:8080/jtgooCMS/static/register.html">同业注册</a></div>
   </div>
</div>
</body>
</html>
<script type="text/javascript">
function login()
{
document.forms[0].submit();
}
</script>

