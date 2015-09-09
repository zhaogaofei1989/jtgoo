

<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>同业用户设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
    <script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
	<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
	<link href="${basePath}style/loadingbar/showLoading.css" rel="stylesheet" media="screen" />
     <script type="text/javascript" src="${basePath}js/jquery.showLoading.js"></script>
</head>
<body>

<br><br><!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/>同业用户设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div id="MainArea">
    <br><br><html:form action="background/CustomerAction"   styleId="myform">
    	<html:hidden property="method" value="${param.id eq null ? 'addPeer' : 'editPeer'}" styleId="methodId"/>
    	<html:hidden property="id"/>
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                       <tr>
                        <td>用户名<br><br></td>
                        <td><html:text styleId="userName" property="userName" styleClass="InputStyle"/> *<label id="userNameLabel" style="color:red;"></label><br><br></td>
                    </tr>
                   <!-- 
                      <tr>
                        <td>联系人姓名<br><br></td>
                        <td><html:text styleId="name" property="name" styleClass="InputStyle"/> *<label id="nameLabel" style="color:red;"></label><br><br></td>
                    </tr>
                    <tr>
                        <td>联系人号码<br><br></td>
                        <td><html:text property="mobliePhone" styleClass="InputStyle"/> *<br><br></td>
                    </tr>
                    <tr>
                        <td>QQ号码<br><br></td>
                        <td><html:text property="chatTools" styleClass="InputStyle"/> *<br><br></td>
                    </tr>
                        <tr>
                        <td>邮箱地址<br><br></td>
                        <td><html:text property="email" styleClass="InputStyle"/> *<br><br></td>
                    </tr>
                     -->
                    <tr>
                        <td>公司名称<br><br></td>
                        <td><html:text property="companyName" styleClass="InputStyle"/> *<br><br></td>
                    </tr>
                 <tr>
                        <td>公司地址<br><br></td>
                        <td><html:text property="companyAddr" styleClass="InputStyle"/> *<br><br></td>
             
                    </tr>    
                    <tr>
                        <td>公司电话<br><br></td>
                        <td><html:text property="companyPhone" styleClass="InputStyle"/> *<br><br></td>
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
                    
                       <tr>
          			<td>
          			同业用户组
          			<br><br></td>
          			<td>
				<select name="peergroupId" id="peergroupId">
				     <c:forEach var="peerGroup" items="${peerGroupList }">  
                        <option value="${peerGroup.id}" ${peerGroup.id==peergroupId?'selected':''}>${peerGroup.name}</option>
                   </c:forEach>
				</select>
          			<br><br></td>
          			</tr>
                    <tr>
                        <td>同业价格表(签证)保存后显示<br><br></td>
                        <td>        
                        <c:if test="${param.id ne null}">
                        <html:button property="regTime" value="设置"  onclick="peer_price_visa(${param.id})"/> <br/><br/>
                        </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td>
                      
                        同业价格表(线路)保存后显示<br><br>
                        </td>
                        <td>
                           <c:if test="${param.id ne null}">
                           <html:button property="regTime"  value="设置"/> <br/><br/>
                          </c:if>
                        </td>
                    </tr>
                 <tr><td>密码<br><br></td><td><html:text property="passwd" styleClass="InputStyle"/> * <br><br></td><td><br><br></td></tr>
                <tr><td>确认密码<br><br></td><td><html:text property="confirmPasswd" styleClass="InputStyle"/> * <br><br></td><td><br><br></td></tr>
                    <tr><td>输入人员<br><br></td><td>
                    
                 <select name="inputName" id="inputNameId">
				   <option value="">请选择</option>
				     <c:forEach var="user" items="${salerList}">  
                        <option value="${user.name}" ${user.name==inputName?'selected':''}>${user.name}</option>
                   </c:forEach>
				</select>
                    
                    
                     <br><br></td><td><br><br></td></tr>
                    <tr>
                        <td>注册日期<br><br></td>
                        <td><html:text property="regTime" styleClass="Wdate" readonly="true" value="${regTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/> <br><br></td>
                    </tr>
          		<tr><td>更新日期<br><br></td><td><html:text property="updateTime" styleClass="Wdate" readonly="true"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/> * <br><br></td><td><br><br></td></tr>
                   <tr><td>客户状态<br><br></td><td><html:radio property="status"  styleId="status_01" value="0"/>  锁定
                     <html:radio property="status" styleId="status_02" value="1"/>  解锁 <br><br></td><td></td></tr>
    			    <tr>
          			<td>
          			领区选择
          			</td>
          			<td>
					<c:forEach items="${lingquList}" var="lingqu"> 
					 <html:multibox property="customerIds" value="${lingqu.id}" styleId="cb_${lingqu.id}" />${lingqu.name }
					</c:forEach>
          			</td>
          			</tr>
          			<tr><td>联系人管理 保存后显示</td><td>
          			 <c:if test="${param.id ne null}">
          			<input type="button" value="联系人管理" onclick="addCu(${param.id},1)"/>
          			</c:if>
          			 <c:forEach items="${customerServicersList}" var="link">
          			   <c:if test="${link.userType eq '1'}">
				  <label style="font-weight:bolder;" onclick="showName(${link.id})">${link.name }</label>
				    </c:if>
				    </c:forEach></td></tr>
          			
                </table>
               
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="submit" class="cmd" value="保存并关闭" />
           <input type="button" id="saveGoOn" class="cmd"  onclick="return savePeerAndGoOn();"  value="保存并继续" />
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
    function peer_price_visa(id)
    {
    art.dialog.open('CustomerAction.do?method=peerPriceSetingVisaUI&peerId='+id,
{
    title: '同行价格表设置',
    width: 800,
    height: 440,
    left: '50%',
    top: '10%',
    lock:true,
    cancel: function()
    {
    this.close();
    }
});
    
    }
    
    
 function addCu(id,userType)
    {
art.dialog.open('CustomerServicersAction.do?method=list&peerId='+id+'&userType='+userType,
{
    title: '添加联系人',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    this.close();
    }
});
    }
    

    
function showName(id)
{
art.dialog.open('CustomerServicersAction.do?method=showNameUI&id='+id,
{
    title: '联系人信息',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    lock:true
});
}


//添加并继续
function savePeerAndGoOn()
{

$("#methodId").val("savePeerAndGoOn");
if(validate())
{

$("#myform").submit();
}

}

function validate()
{
var userName=$("#userName").val();
if(userName==null||userName.length==0)
{
$("#userNameLabel").text("该字段不能为空");
return false;
}
jQuery('#InputDetailBar').showLoading();
return true;
}
    </script>


    
    