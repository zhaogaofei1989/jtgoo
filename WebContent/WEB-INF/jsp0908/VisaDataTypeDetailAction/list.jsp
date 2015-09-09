<%@ page language="java" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>版块列表</title>
 <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
<script type="text/javascript" src="${basePath}js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
</head>
<body>

<!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证所需资料</strong> / <small>   <c:choose>
            <c:when test="${type eq 1}">在职人员</c:when>
            <c:when test="${type eq 2}">退休人员</c:when>
            <c:when test="${type eq 3}">学生</c:when>
            <c:when test="${type eq 4}">儿童</c:when>
            <c:when test="${type eq 5}">其他</c:when>
          </c:choose></small> </div>
    </div>
    <div class="am-panel-hd">
	</div>

<div class="am-g">
      <div class="am-u-sm-12">
        <html:form action="background/VisaDataTypeDetailAction"  styleId="myform">
    	<html:hidden property="method" styleId="methodId"  value="saveSort"/>
    	<html:hidden styleId="pid" property="pid" value="${pid }"/>
    	<html:hidden styleId="type" property="type" value="${type }"/>
          <table class="am-table am-table-striped am-table-hover table-main" id="mytable">
             <thead>
              <tr>
                <th><input  type="checkbox" id="check_box"/></th>
            	<th>ID</th>
                <th>名称</th>
                <th>详细内容</th>
 				<th class="table-set">操作</th>
              </tr>
                </thead>
                 <tbody>
                 
                     <c:forEach items="${datatypeDetailList}" var="item" varStatus="sta">
                     		<tr name="parent">
                     		<td colspan="5" align="center" style="font-weight: bold;color: red;">${item.key.name}</td>
                     		</tr>
                     		
                     		        <c:forEach items="${item.value}" var="datatype" varStatus="status">
                     		        <tr>
				 <td width="35px;">
            	 <input class="checkbox1"  name="ids" value="${datatype.id}"  type="checkbox"/>
            	 <input type="hidden"  name="arrids" value="${datatype.id}"/>
            	 </td>
				<td width="30px;"><input type="text" name="sort" style="width: 30px;" value="${datatype.sort}"/></td>
				<td width="120px;"><c:if test="${datatype.sign eq 0 }"><font color="red">*</font>&nbsp;</c:if>${datatype.title}&nbsp;</td>
				<td width="50%" style="word-break:break-all;">${datatype.content}</td>
				<td  name="child">
					<html:link styleId="edithref_${status.index}"  action="background/VisaDataTypeDetailAction?method=editUI&id=${datatype.id}&pid=">修改</html:link>
					<html:link styleId="delhref_${status.index}" action="background/VisaDataTypeDetailAction?method=delete&id=${datatype.id}&pid=">删除</html:link>
				</td>
			</tr>
                     		        
                     		        </c:forEach>
                     </c:forEach>
             
    	    </tbody>
        </table>
				 <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
        	<input type="button" class="am-btn am-btn-primary am-btn-xs" onclick="saveSort()" value="保存排序"/>
        	<input type="button" id="addhref" class="am-btn am-btn-primary am-btn-xs" onclick="createNew('VisaDataTypeDetailAction.do?method=addUI&pid=${pid}&type=${type}');" value="新建"/>
        	 <input type="button" class="am-btn am-btn-primary am-btn-xs" onclick="copy(${pid },${type })" value="复制到其他职业"/>
        	 <input type="button" class="am-btn am-btn-primary am-btn-xs" onclick="copyVisaProduct(${pid },${type })" value="复制到其他签证产品"/>
       		 <input type="button" class="am-btn am-btn-primary am-btn-xs" onclick="deleteBatch();" value="批量删除"/> 
        </div>
    </div>
     </html:form>
          <hr />
          <p>注：.....</p>
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
<script type="text/javascript">
//全选、反选
$(document).ready(function() {

		$('#check_box').click(function(event) { //on click 
			if(this.checked) { // check select status
			$('.checkbox1').each(function() { //loop through each checkbox
			this.checked = true; //select all checkboxes with class "checkbox1" 
			});
			}
			else{
				$('.checkbox1').each(function() { //loop through each checkbox
				this.checked = false; //deselect all checkboxes with class "checkbox1" 
				}); 
			}
		
		});
});





var pid=$("#pid").val();
var type=$("#type").val();
var type=art.dialog.data('type');
var addurl=document.getElementById("addhref").href;
var type='&type='+type;
//var length=$("#mytable>tbody tr").length;
var length=$("td[name='child']").length;
for(var i=0;i<length;i++)
{
var edit=$("td[name='child']")[i].children[0];
var del=$("td[name='child']")[i].children[1];
edit.href=edit.href+pid+type;
del.href=del.href+pid+type;
}
$("#addhref").attr("href",addurl+type);

</script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>



</body>
</html>


<script type="text/javascript">

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
	alert("请选择一项资料!");
	}
}
function copyVisaProduct(pid,type)
{
/**暂时只支持一个复制**/
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
	if(idArr.split(",").length-1>0)
	{
	window.location.href="VisaDataTypeDetailAction.do?method=copyTargetVisaProductUI&ids="+idArr+"&pid="+pid+"&type="+type;
	}
	else
	{
	alert("请选择一项资料!");
	}
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
