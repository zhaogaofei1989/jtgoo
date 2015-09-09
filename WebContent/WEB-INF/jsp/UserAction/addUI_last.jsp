<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
	<title>用户信息</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
</head>
<body>

<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${pageContext.request.contextPath}/style/images/title_arrow.gif"/> 用户信息
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div id=MainArea>
    <html:form action="background/UserAction">
    	<html:hidden property="method" value="add"/>
    	<html:hidden property="id"/>
    
        <div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title1">
        	<img border="0" width="4" height="7" src="${pageContext.request.contextPath}/style/blue/images/item_point.gif" /> 用户信息 </div> 
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr><td width="100">所属部门</td>
                        <td><html:select property="departmentId" styleClass="SelectStyle">
                                <html:option value="0">请选择部门</html:option>
                               	<c:forEach items="${departmentList}" var="department">
	                                <html:option value="${department.id}">${department.name}</html:option>
                               	</c:forEach>
                            </html:select> 
                        </td>
                    </tr>
                    <tr><td>登录名</td>
                        <td><html:text property="loginName" 
                        	  styleClass="InputStyle {required:true, remote:'${basePath}/background/UserAction.do?method=checkLoginName', messages:{remote:'登录名已存在，请更换！'}}"/> *
							（登录名要唯一）
						</td>
                    </tr>
                    <tr><td>姓名</td>
                        <td><html:text property="name" styleClass="InputStyle required"/> *</td>
                    </tr>
                    
                    
					<tr><td>性别</td>
                        <td><html:radio property="sex" value="男" styleId="male"/><label for="male">男</label>
							<html:radio property="sex" value="女" styleId="female"/><label for="female">女</label>
						</td>
                    </tr>
					<tr><td>联系电话</td>
                        <td><html:text property="phoneNumber" styleClass="InputStyle"/></td>
                    </tr>
                    <tr><td>E-mail</td>
                        <td><html:text property="email" styleClass="InputStyle"/></td>
                    </tr>
                    <tr><td>备注</td>
                        <td><html:textarea property="description" styleClass="TextareaStyle"/></td>
                    </tr>
                </table>
            </div>
        </div>
        
		<div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title1">
        	<img border="0" width="4" height="7" src="${pageContext.request.contextPath}/style/blue/images/item_point.gif" /> 岗位设置 </div> 
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr>
						<td width="100">岗位</td>
                        <td><html:select property="roleIds" multiple="true" size="10" styleClass="SelectStyle">
                        		<c:forEach items="${roleList}" var="role">
	                                <html:option value="${role.id}">${role.name}</html:option>
                        		</c:forEach>
                            </html:select>
                            按住Ctrl键可以多选或取消选择
                        </td>
                    </tr>
                </table>
            </div>
        </div>		
		
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${pageContext.request.contextPath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/style/images/goBack.png"/></a>
        </div>
    </html:form>
</div>

<div class="Description">
	说明：<br />
	1，用户的登录名要唯一，在填写时要同时检测是否可用。<br />
	2，新建用户后，密码被初始化为"1234"。<br />
	3，密码在数据库中存储的是MD5摘要（不是存储明文密码）。<br />
	4，用户登录系统后可以使用“个人设置→修改密码”功能修改密码。<br />
	5，新建用户后，会自动指定默认的头像。用户可以使用“个人设置→个人信息”功能修改自已的头像<br />
	6，修改用户信息时，登录名不可修改。
</div>

</body>
</html>
