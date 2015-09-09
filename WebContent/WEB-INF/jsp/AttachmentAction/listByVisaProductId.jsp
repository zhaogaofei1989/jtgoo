<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>版块列表</title>
  <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">附件管理</strong> / <small>附件管理列表</small></div>
    </div>
    
<div class="am-panel-hd">
</div>
    
    
     <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/AttachmentAction.do?method=list" method="post">
        <html:hidden property="pageNum" value="1"/>
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th><input  type="checkbox" id="check_box"/></th>
             <th>附件名称</th>
             <th>上传时间</th>
              </tr>
          </thead>
          <tbody>
                <c:forEach items="${attachmentList}" var="attachment" varStatus="status">
           		 <tr class="TableDetail1 template">
             	 <td><input class="checkbox1"   name="ids" value="${attachment.id}"  type="checkbox" ></td>
             	 <td> <html:link target="_blank" action="/background/AttachmentAction.do?method=download&id=${attachment.id}">
                  	${attachment.name}&nbsp;
                  </html:link></td>
				<td>${attachment.uploadTime}&nbsp;</td>
				
            </tr>
    	    </c:forEach>
          </tbody>
        </table>
          <hr />
          <p>注：.....</p>
        </form>
      </div>
    </div>
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


</script>
