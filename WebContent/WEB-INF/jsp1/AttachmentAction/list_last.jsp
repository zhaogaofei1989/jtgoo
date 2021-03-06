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
<form action="${basePath}background/AttachmentAction.do?method=list" method="post">
<html:hidden property="pageNum" value="1"/>
<html:hidden property="pageSize" value="${pageBean.pageSize eq null ? 10 :pageBean.pageSize }"/>
</form>
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 附件列表
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle" id="mytable">
       
        <!-- 表头-->
        <thead>
            <tr align="CENTER" valign="MIDDLE" id="TableTitle">
              <th width="35px;"><input  type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            <!-- <td>ID</td> -->	
                <td>附件名称</td>
                <td>上传时间</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
        <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="attachment" varStatus="status">
			<tr class="TableDetail1 template">
			 <th width="35px;" style="vertical-align: middle;"><input class="inputcheckbox"   name="ids" value="${attachment.id}"  type="checkbox" ></th>
			<!--	<td>${attachment.id}&nbsp;</td>  -->
				<td>
		    	 <html:link target="_blank" action="/background/AttachmentAction.do?method=download&id=${attachment.id}">
                  	${attachment.name}&nbsp;
                  </html:link>
				</td>
				<td>${attachment.uploadTime}&nbsp;</td>
				<td>   
					<html:link action="/background/AttachmentAction.do?method=delete&id=${attachment.id}">删除</html:link>
                  	<html:link action="/background/AttachmentAction.do?method=editUI&id=${attachment.id}">修改</html:link>
                  </td>
				<!--  <td>
					<html:link styleId="edithref_${status.index}"  action="/VisaDataTypeDetailAction?method=editUI&id=${attachment.id}&pid=">修改</html:link>
					<html:link styleId="delhref_${status.index}" action="/VisaDataTypeDetailAction?method=delete&id=${attachment.id}">删除</html:link>
				</td>-->
			</tr>
		</c:forEach>	
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
        <input type="button" class="cmd" onclick="createNew();" value="新建"/> 
        <input type="button" class="cmd" onclick="deleteBatch();" value="批量删除"/> 
             <!--   <html:link action="/AttachmentAction?method=addUI"><img src="${basePath}/style/images/createNew.png" /></html:link>-->
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
<div class="Description">
<br />

</div>

</body>
</html>


<script type="text/javascript">

function createNew()
{
window.location.href="AttachmentAction.do?method=addUI";
}
/**var pid=art.dialog.data('pid');
var addurl=document.getElementById("addhref").href;
var length=$("#mytable>tbody tr").length;
for(var i=0;i<length-1;i++)
{
var editurl=document.getElementById("edithref_"+i).href;
var delurl=document.getElementById("delhref_"+i).href;
$("#edithref_"+i).attr("href",editurl+pid);
$("#delhref_"+i).attr("href",editurl+pid);
}
$("#addhref").attr("href",addurl+pid);
**/
function uploadInfo()
{

art.dialog.open('AttachmentAction.do?method=uploadUI',
 {  title: '上传文件',
    width: 800,
    height: 540,
    left: '50%',
    top: '3%',
    lock:true,
   ok:function()
   {
     }
     
  }  );




}
//全选、反选
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
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
window.location.href="AttachmentAction.do?method=deleteBatch&ids="+idArr;
}
}
else
{
alert("您还没有选中任何附件!");
}


}

</script>
