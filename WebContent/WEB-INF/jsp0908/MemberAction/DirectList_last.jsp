<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 直接用户
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<form action="${basePath}background/MemberAction.do?method=directList" method="post">
<div class="top">
<!--  
注册时间:<input type="text" name="regTime" id="regTime"  class="Wdate"  style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>
<select name="status">
<option selected="selected" value="">状态</option>
<option value="0">锁定</option>
<option value="1">正常</option>
</select>-->
<!--  <select name="review">
<option selected="selected" value="">审核</option>
<option value="0">已审核</option>
<option value="1">为审核</option>
</select>-->
<!-- 
<select name="groupMember">
<option selected="selected" value="">会员组</option>
<option value="上海同业">上海同业</option>
<option value="北京同业">北京同业</option>
<option value="个人合作同业">个人合作同业</option>
</select>
<select name="type">
<option selected="selected" value="1">手机号码</option>
<option value="2">QQ号码</option>
<option value="3">邮箱</option>
<option value="4">用户名</option>
<option value="5">姓名</option>
<option value="6">销售人员</option>
</select>
<input type="text"  name="obj" style="width:150px;"/>
<input type="submit" value="搜索"/> -->
<html:hidden property="pageNum" value="1"/>
<html:hidden property="pageSize" value="10"/>
</div>
</form>
<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
           <th width="35px;"><input type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>用户编号</td>
                <td>用户名</td>
                <td>姓名</td>
                <td>手机号码</td>
                <td>销售人员</td>
                <td>状态</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        <c:forEach items="${pageBean.recordList}" var="director">
			<tr class="TableDetail1 template">
				 <th width="35px;"><input class="inputcheckbox"  name="ids" value="${customer.id}"  type="checkbox" ></th>
				<td>${director.serialNumber}&nbsp;</td>
				<td>${director.userName}&nbsp;</td>
				<td>${director.name}&nbsp;</td>
				<td>${director.mobliePhone}&nbsp;</td>
				<td>${director.saler.name}&nbsp;</td>
				<td>
				<c:choose>
				<c:when test="${director.status eq 0}">
				  解锁
				</c:when>
				<c:when test="${director.status eq 1}">
				 锁定
				</c:when>
				</c:choose>
			</td>
			
		
			
				<td>
					<html:link action="background/MemberAction?method=directEditUI&id=${director.id}">修改</html:link>
				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
           <input type="button" class="cmd" onclick="createNew('MemberAction.do?method=directAddUI');" value="新建"/>
      <!--      <input type="button" class="cmd" onclick="return exportConfirm();" value="导出excel"/>
          <input type="button" class="cmd" onclick="deleteBatch();" value="批量删除"/>  -->
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
<div class="Description">
	说明：<br />

</div>

</body>
</html>

<script type="text/javascript">
//全选、反选
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
}
//导出pdf
function exportConfirm(showId)
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){
//openUrl("CustomerAction.do?method=exportExcel&id="+idArr);
//window.open("VisaProductAction.do?method=exportPDF&id="+idArr+"&showId="+showId);
window.location.href="CustomerAction.do?method=exportExcel&id="+idArr+"&type=1";
}
else
{
alert("您还没有选中任何订单!")
}
}



function  deleteBatch()
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){

 if(confirm("确定要删除所选数据吗？"))
 {
window.location.href="CustomerAction.do?method=deleteBatch&ids="+idArr+"&ctype=1";
}
}
else
{
alert("您还没有选中任何用户!");
}

}

</script>