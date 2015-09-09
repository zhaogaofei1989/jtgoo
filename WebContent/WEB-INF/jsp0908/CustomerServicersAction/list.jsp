<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
<style type="text/css">
tr:hover{background-color: #CEA}
</style>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 
     		人员列表
            <html:hidden property="peerId" styleId="peerId" value="${peerId}"/>
            <html:hidden property="userType" styleId="userType" value="${userType}"/>
            <html:hidden property="pageNum" value="1"/>
			<html:hidden property="pageSize" value="1"/>
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle" id="mytable">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
            	<td>ID</td>
                <td>姓名</td>
                <td>电话</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${customerServicersList}" var="customerServicers" varStatus="status">
			<tr class="TableDetail1 template">
				<td>${customerServicers.id}&nbsp;</td>
				<td>
		    	 <html:link action="background/AttachmentAction.do?method=download&id=${customerServicers.id}">
                  	${customerServicers.name}&nbsp;
                  </html:link>
				
				</td>
				<td>${customerServicers.mobliePhone }</td>
				  <td>
					<html:link styleId="edithref_${status.index}"  action="background/CustomerServicersAction?method=editUI&id=${customerServicers.id}&peerId=">修改</html:link>
					<html:link styleId="delhref_${status.index}" 	 action="background/CustomerServicersAction?method=delete&id=${customerServicers.id}&peerId=">删除</html:link>
				</td>
			</tr>
		</c:forEach>	
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
         <html:link action="background/CustomerServicersAction?method=addUI&peerId=${peerId }&userType=${userType }"><img src="${basePath}/style/images/createNew.png" /></html:link>
        </div>
    </div>
</div>

<div class="Description">
<br />

</div>

</body>
</html>


<script type="text/javascript">
var peerId=$("#peerId").val();
var userType=$("#userType").val();
var length=$("#mytable>tbody tr").length;
for(var i=0;i<length;i++)
{
var editurl=document.getElementById("edithref_"+i).href;
var delurl=document.getElementById("delhref_"+i).href;
$("#edithref_"+i).attr("href",editurl+peerId+"&userType="+userType);
$("#delhref_"+i).attr("href",delurl+peerId+"&userType="+userType);
}
</script>
