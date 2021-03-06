<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
<script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/>
            <c:choose>
            <c:when test="${type eq 1}">在职人员</c:when>
            <c:when test="${type eq 2}">退休人员</c:when>
            <c:when test="${type eq 3}">学生</c:when>
            <c:when test="${type eq 4}">儿童</c:when>
            <c:when test="${type eq 5}">其他</c:when>
            </c:choose>
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
  <html:form action="background/VisaDataTypeDetailAction"  styleId="myform">
    	<html:hidden property="method" styleId="methodId"  value="saveSort"/>
    	<html:hidden styleId="pid" property="pid" value="${pid }"/>
    	<html:hidden styleId="type" property="type" value="${type }"/>
    <table cellspacing="0" cellpadding="0" class="TableStyle" id="mytable">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
                 <th width="35px;"><input type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>ID</td>
                <td>名称</td>
                <td>详细内容</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        <c:forEach items="${datatypeDetailList}" var="datatype" varStatus="status">
			<tr class="TableDetail1 template">
            	 <th width="35px;">
            	 <input class="inputcheckbox"  name="ids" value="${datatype.id}"  type="checkbox"/>
            	 <input type="hidden"  name="arrids" value="${datatype.id}"/>
            	 </th>
				<td width="30px;"><input type="text" name="sort" style="width: 30px;" value="${datatype.sort}"/></td>
				<td width="120px;"><c:if test="${datatype.sign eq 0 }"><font color="red">*</font>&nbsp;</c:if>${datatype.title}&nbsp;</td>
				<td width="50%" style="word-break:break-all;">${datatype.content}</td>
				<td>
					<html:link styleId="edithref_${status.index}"  action="background/VisaDataTypeDetailAction?method=editUI&id=${datatype.id}&pid=">修改</html:link>
					<html:link styleId="delhref_${status.index}" action="background/VisaDataTypeDetailAction?method=delete&id=${datatype.id}&pid=">删除</html:link>
				</td>
			</tr>
		</c:forEach>	
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
        	<input type="button" class="cmd" onclick="saveSort()" value="保存排序"/>
        	<input type="button" id="addhref" class="cmd" onclick="createNew('VisaDataTypeDetailAction.do?method=addUI&pid=${pid}&type=${type}');" value="新建"/>
        	 <input type="button" class="cmd2" onclick="copy(${pid },${type })" value="复制到其他职业"/>
       		 <input type="button" class="cmd" onclick="deleteBatch();" value="批量删除"/> 
        </div>
    </div>
      </html:form>
</div>

<div class="Description">
<br />

</div>

</body>
</html>


<script type="text/javascript">
$(function(){
var pid=art.dialog.data('pid');
var type=art.dialog.data('type');
var addurl=document.getElementById("addhref").href;
var type='&type='+type;
var length=$("#mytable>tbody tr").length;
for(var i=0;i<length;i++)
{
var editurl=document.getElementById("edithref_"+i).href;
var delurl=document.getElementById("delhref_"+i).href;
$("#edithref_"+i).attr("href",editurl+pid+type);
$("#delhref_"+i).attr("href",delurl+pid+type);
}
$("#addhref").attr("href",addurl+type);
	});





function copy(pid,type)
{
/**暂时只支持一个复制**/


var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.split(",").length-1>0)
{
window.location.href="VisaDataTypeDetailAction.do?method=copyTargetUI&ids="+idArr+"&pid="+pid+"&type="+type;
}
else
{
alert("请选择一个产品!");
}


}
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
}
function saveSort()
{
var checkList=$('input[name="ids"]');
if(checkList.length===0)
{
return false;
}
$("#myform").submit();
}


function  deleteBatch()
{

var idArr='';
var pid=$("#pid").val();
var type=$("#type").val();
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){

 if(confirm("确定要删除所选数据吗？"))
 {
window.location.href="VisaDataTypeDetailAction.do?method=deleteBatch&ids="+idArr+"&pid="+pid+"&type="+type;
}
}
else
{
alert("您还没有选中任何附件!");
}

}

</script>
