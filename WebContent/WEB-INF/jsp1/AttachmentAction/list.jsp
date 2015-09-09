<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>附件管理</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
          <iamp-identify:IAMPIdentify authid="03_05_02_05">
            <button type="button" class="am-btn am-btn-default" onclick="createNew();"><span class="am-icon-plus"></span> 新增</button>
        </iamp-identify:IAMPIdentify>
        <iamp-identify:IAMPIdentify authid="03_05_02_06">
            <button type="button" class="am-btn am-btn-default" onclick="deleteBatch();"><span></span> 批量删除</button>
         </iamp-identify:IAMPIdentify>
          </div>
        </div>
      </div>
    </div>
  
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/AttachmentAction.do?method=list" method="post">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th><input  type="checkbox" id="check_box"/></th>
             <th>附件名称</th>
             <th>上传时间</th>
             <th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
                  <c:forEach items="${pageBean.recordList}" var="attachment" varStatus="status">
           		 <tr class="TableDetail1 template">
             	 <td><input class="checkbox1"   name="ids" value="${attachment.id}"  type="checkbox" ></td>
             	 <td> <html:link target="_blank" action="/background/AttachmentAction.do?method=download&id=${attachment.id}">
                  	${attachment.name}&nbsp;
                  </html:link></td>
				<td>${attachment.uploadTime}&nbsp;</td>
				<td>   
				<iamp-identify:IAMPIdentify authid="03_05_02_03">
					<html:link action="/background/AttachmentAction.do?method=delete&id=${attachment.id}">删除</html:link>
        		</iamp-identify:IAMPIdentify>
                  <iamp-identify:IAMPIdentify authid="03_05_02_04">
                  	<html:link action="/background/AttachmentAction.do?method=editUI&id=${attachment.id}">修改</html:link>
                 </iamp-identify:IAMPIdentify>
                  </td>
            </tr>
    	    </c:forEach>
          </tbody>
        </table>
			<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
          <hr />
          <p>注：.....</p>
        </form>
      </div>
    </div>
  </div>
  
  <!-- content end -->


<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${basePath}js/amazeui/jquery.min.js"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
<script src="${basePath}js/amazeui/app.js"></script>
</body>
</html>

<script type="text/javascript">

//全选、反选
$(document).ready(function() {
$('#check_box').click(function(event) { //on click 
if(this.checked) { // check select status
$('.checkbox1').each(function() { //loop through each checkbox
this.checked = true; //select all checkboxes with class "checkbox1" 
});
}else{
$('.checkbox1').each(function() { //loop through each checkbox
this.checked = false; //deselect all checkboxes with class "checkbox1" 
}); 
}
});

});

function createNew()
{
window.location.href="AttachmentAction.do?method=addUI";
}
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