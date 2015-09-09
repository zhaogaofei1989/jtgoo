<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>客服信息管理</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>

</head>
<body>
<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
		        <div id="Title"><!--页面标题-->
		            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 联系人管理
		        </div>
        			<div id="Title_End"></div>
 		   </div>
</div>






<!--显示表单内容-->
<div id="MainArea">	

        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        <!-- 表单内容显示 -->
    
						                <table cellspacing="0" cellpadding="0"  width="400px;">
						                   <tbody id="TableData" class="dataContainer">
						                    <tr class="TableDetail1 template">
						                        <td width="40%">姓名</td>
						                        <td style="text-align: left">${customerServicersVo.name}</td>
						                    </tr>
						                    <tr class="TableDetail1 template">
						                        <td  width="40%">手机</td>
						                          <td style="text-align: left">${customerServicersVo.mobliePhone}</td>
						                    </tr>
						                     <tr>
						                        <td width="40%">公司座机</td>
						                          <td style="text-align: left">${customerServicersVo.companyPhone}</td>
						                    </tr>
						                    <tr>
						                        <td width="40%">QQ</td>
						                          <td style="text-align: left">${customerServicersVo.chatTools}</td>
						                    </tr>
						                    <tr>
						                        <td width="40%">email</td>
						                         <td style="text-align: left">${customerServicersVo.email}</td>
						                    </tr>
						                      <tr>
						                        <td width="40%">联系人职务</td>
						                          <td style="text-align: left">${customerServicersVo.position}</td>
						                    </tr>
						             </tbody>
    						</table>
   
</div>

</body>
</html>
    