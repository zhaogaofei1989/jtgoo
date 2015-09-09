

<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>签证设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
    <script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
</head>
<body>

<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 直接用户设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div id="MainArea">
    <br><html:form action="background/MemberAction" onsubmit="return validate();">
    	<html:hidden property="method" value="${param.id eq null ? 'directAdd' : 'directEdit'}"/>
    	<html:hidden property="id"/>
    	<input type="hidden" id="occuHidenId" value="${occuId}"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm" id="mainTable">
                    <tr>
                        <td>用户名<br></td>
                        <td><html:text property="userName" styleClass="InputStyle required"/> *<br></td>
                    </tr>
                       <tr>
                        <td>姓名<br></td>
                        <td><html:text property="name" styleClass="InputStyle required"/> *<br></td>
                    </tr>
                    <tr>
                        <td>手机号码<br></td>
                        <td><html:text property="mobliePhone" styleClass="InputStyle required"/> *<br></td>
                    </tr>
                    <tr>
                        <td>QQ号码<br></td>
                        <td><html:text property="chatTools" styleClass="InputStyle"/> <br></td>
                    </tr>
                    <tr>
                        <td>Email<br></td>
                        <td><html:text property="email" styleClass="InputStyle"/> *<br></td>
                    </tr>
                    <tr>
                        <td>家庭地址<br></td>
                        <td><html:text property="address" styleClass="InputStyle"/> *<br></td>
                    </tr>
                    <tr>
                        <td>家庭电话<br></td>
                        <td><html:text property="phone" styleClass="InputStyle"/><br></td>
                    </tr>
                     <tr>
          			<td>
          			销售
          			<br><br></td>
          			<td>
				<select name="salerId" id="salerId">
				   <option value="">请选择</option>
				     <c:forEach var="saler" items="${salerList}">  
                        <option value="${saler.id}" ${saler.id==salerId?'selected':''}>${saler.name}</option>
                   </c:forEach>
				</select>
          			<br><br></td>
          			</tr>
                        <tr><td>输入人员<br><br></td><td>
                    
                 <select name="inputName" id="inputNameId">
				   <option value="">请选择</option>
				     <c:forEach var="user" items="${salerList}">  
                        <option value="${user.name}" ${user.name==inputName?'selected':''}>${user.name}</option>
                   </c:forEach>
				</select>
                     <br><br></td><td><br><br></td></tr>
                    <tr>
                    <tr>
                        <td>密码设置<br></td>
                        <td><html:text styleId="passwd" property="passwd" styleClass="InputStyle required"/> *<br></td>
                    </tr>
                    <tr>
                        <td>密码确认<br></td>
                        <td><html:text styleId="confirmPasswd" property="confirmPasswd" styleClass="InputStyle required"/> *<br></td>
                    </tr>
                      <tr>
                        <td>注册时间<br></td>
                        <td><html:text property="regTime" styleClass="Wdate" readonly="true"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/><br></td>
                    </tr>
                      <tr>
                        <td>更新时间<br></td>
                        <td><html:text property="updateTime" styleClass="Wdate" readonly="true"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'}"/><br></td>
                    </tr>
                 <tr>
                        <td>职业<br></td>
                        <td>
                        <select id="occupationChoice" name="occupationChoice" onchange="changeType(this.value)">
                        <option value="" >请选择</option>
                        <c:forEach items="${occuMap}" var="occu">
                        <option value="${occu.key}"   ${occu.key==occuId?'selected':''}>${occu.value} </option>
                        </c:forEach>
                        </select>
                        <br></td>
                        
                    </tr>
                    
                    <tr><td><div id="noOccu"></div></td></tr>
                  
                </table>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
        </div>
    </html:form>
</div>

<div class="Description">
	说明：<br />
	1，新添加的版块默认显示在最下面（sortOrder值最大）。<br />
</div>

</body>
</html>
    
<script type="text/javascript">
$(document).ready(function(){
var occuId=$("#occuHidenId").val();
changeType(occuId);
 }
);
    
        /**验证密码的一致性**/
    function validate()
    {
    var passwd=$("#passwd").val();
    var confirmPasswd=$("#confirmPasswd").val();
    if(passwd==confirmPasswd)
    {
    return true;
    }
    alert("密码不一致!");
    return false;
    
    }

     function changeType(index)
     {
     if(index==1)
     {
      $("#noOccu").html("");
    $("tr[name='xuesheng']").remove();
    $("tr[name='description']").remove();
   $("#mainTable").append("<tr name='zaizhi'><td>在职人员</td></tr>");
   $("#mainTable").append("<tr name='zaizhi'><td>公司名称</td><td><input type='text' class='InputStyle'  name='companyName' value='${companyName}'/></td></tr>");
   $("#mainTable").append("<tr name='zaizhi'><td>公司地址</td><td><input type='text' class='InputStyle' name='companyAddr' value='${companyAddr}'/></td></tr>");
   $("#mainTable").append("<tr name='zaizhi'><td>公司电话</td><td><input type='text' class='InputStyle' name='companyPhone' value='${companyPhone}'/></td></tr>");
   $("#mainTable").append("<tr name='zaizhi'><td>职务</td>      <td><input type='text' class='InputStyle' name='position' value='${position}'/></td></tr>");
     }
     else if(index==3)
     {
	$("#noOccu").html("");
    $("tr[name='zaizhi']").remove();
    $("tr[name='description']").remove();
   $("#mainTable").append("<tr name='xuesheng'><td>学生</td></tr>");
   $("#mainTable").append("<tr name='xuesheng'><td>学校名称</td><td><input type='text' class='InputStyle' name='schoolName' value='${schoolName}'/></td></tr>");
   $("#mainTable").append("<tr name='xuesheng'><td>学校地址</td><td><input type='text' class='InputStyle' name='schoolAddr' value='${schoolAddr}'/></td></tr>");
   $("#mainTable").append("<tr name='xuesheng'><td>专业</td><td><input type='text' class='InputStyle' name='professional' value='${professional}'/></td></tr>");
 //  $("#mainTable").append("<tr name='xuesheng'><td>密码</td><td><input type='text'  name='passwd' value='${passwd}'/></td></tr>");
 //  $("#mainTable").append("<tr name='xuesheng'><td>确认密码</td><td><input type='text'  name='confirmPasswd' value='${confirmPasswd}'/></td></tr>");
     }
     else if(index==2||index==4||index==5)
     {
     $("#mainTable").append("<tr name='description'><td>职业描述</td><td><input type='text' class='InputStyle' name='description' value='${description}'/></td></tr>");
     $("#noOccu").html("无职业");
     $("tr[name='zaizhi']").remove();
     $("tr[name='xuesheng']").remove();
     }
     else
     {
     $("#noOccu").html("");
     $("tr[name='zaizhi']").remove();
     $("tr[name='xuesheng']").remove();
     }

     }
     </script>