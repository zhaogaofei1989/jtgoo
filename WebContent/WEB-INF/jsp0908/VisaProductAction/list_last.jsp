<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>版块列表</title>
  <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %> 
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
</head>
<body>

<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/> 签证产品管理
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<div id="QueryArea">
<div style="height: 30px">
<form action="${basePath}/background/VisaProductAction.do?method=list" method="post">
国家分类:<select name="countrySelect" id="countrySelect">
<option value="">请选择</option>
<c:forEach items="${countryList}" var="country">
<option value="${country.id }">${country.name }</option>
<c:forEach items="${country.coutryChild}" var="child">
<option value="${child.id }"> ┣${child.name }</option>
</c:forEach>
</c:forEach>
</select>
类型:
<select name="visaTypeSelect" id="visaTypeSelect">
<option value="">请选择</option>
<c:forEach items="${visaTypeList}" var="visaType">
<option value="${visaType.id }">${visaType.name }</option>
</c:forEach>
</select>
领区:
<select name="lingquSelect">
<option value="">请选择</option>
<c:forEach items="${lingquList}" var="lingqu">
<option value="${lingqu.id }">${lingqu.name }</option>
</c:forEach>
</select>
名称/标题: <input type="text" name="visaProductName" id="visaProductName"/>
<input type="submit" value="查询"/>
<html:hidden property="pageNum" value="1"/>
<html:hidden property="pageSize" value="10"/>
</form>
</div>
</div>
<div id="MainArea">
     
    <table cellspacing="0" cellpadding="0" class="TableStyle">
        <!-- 表头-->
        <thead>
              <tr align="center" valign="middle" id="TableTitle">
                <th width="35px;"><input type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th>
            	<td>ID</td>
                <td width="180px;">名称</td>
                <td>洲际/国家</td>
                <td>领区</td>
                <td>类型</td>
                <td>价格</td>
                <td>签证费|0-6岁|6-12岁</td>
                <td>预约费|0-6岁|6-12岁</td>
            <c:if test="${hasAdmin==true}">
                     <td>下载</td>
            </c:if>
                <td>状态</td>
                <td>相关操作</td>
            </tr>
        </thead>

		<!--显示数据列表-->
               <tbody id="TableData" class="dataContainer">
        
        <c:forEach items="${pageBean.recordList}" var="visaProduct">
			<tr class="odd">
			 <th width="35px;"><input class="inputcheckbox"  name="ids" value="${visaProduct.id}"  type="checkbox" ></th>
				<td>${visaProduct.serialNumber}&nbsp;</td>
				<td width="180px;"><label style="font-weight: bold;" onclick="showInfo(${visaProduct.id },1);">${visaProduct.name}</label></td>
				<td>${visaProduct.country.name}&nbsp;</td>
				<td>${visaProduct.lingqu.name}&nbsp;</td>
				<td>${visaProduct.type.name}&nbsp;</td>
				<td>${visaProduct.serviceFee1}&nbsp;</td>
				<td>${visaProduct.visaFee}|${visaProduct.visaFee1 eq null ?0.0:visaProduct.visaFee1}|${visaProduct.visaFee2  eq null ?0.0:visaProduct.visaFee2}</td>
				<td>${visaProduct.bookFee eq null ?0.0:visaProduct.bookFee}|${visaProduct.bookFee1 eq null ?0.0:visaProduct.bookFee1}|${visaProduct.bookFee2 eq null ?0.0:visaProduct.bookFee2}</td>
				   <c:if test="${hasAdmin==true}">
                     <td>
                     下载
                     <label onclick="showAttachmentList(${visaProduct.id })"><img src="${basePath}/style/images/tol_download.png" /></label>
                     </td>
            </c:if>
				<td>正常显示&nbsp;</td>
				<td>
				
				
				
					<html:link action="background/VisaProductAction?method=editUI&id=${visaProduct.id}">修改</html:link>
					<html:link action="background/VisaProductAction?method=delete&id=${visaProduct.id}">删除</html:link>
				</td>
			</tr>
		</c:forEach>	
		
        </tbody>
    </table>
    
    <!-- 其他功能超链接 -->
    <div id="TableTail">
        <div id="TableTail_inside">
          <input type="button" class="cmd" onclick="createNew();" value="新建"/>
          <!--  <html:link action="/VisaProductAction?method=addUI"><img src="${basePath}/style/images/createNew.png" /></html:link>  -->
                <!--<html:button property="exportVisaData" styleClass="cmd" onclick="return exportConfirm(1);" value="导出资料"/>
                <html:button property="searchVisaData" styleClass="cmd" onclick="return exportConfirm(2);" value="仅查看资料"/>-->
                <html:button property="exportLogoData" styleClass="cmd2" onclick="return exportConfirm(3);" value="导出有logo材料"/>
                <html:button property="exportNoLogoData" styleClass="cmd2" onclick="return exportConfirm(4);" value="导出无logo材料"/>
                <html:button property="copy" styleClass="cmd" onclick="return copy();" value="复制"/>
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
function showAttachmentList(visaProductId)
{
art.dialog.open('${basePath}/background/AttachmentAction.do?method=listByVisaProductId&visaProductId='+visaProductId,
{
    title: '附件列表信息',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    lock:true
});
}
function copy()
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.split(",").length-1==1)
{
window.location.href="${basePath}/background/VisaProductAction.do?method=copyRefreshUI&id="+idArr.split(",")[0];
}
else if(idArr.split(",").length-1>1)
{

alert("只能选择一个!");
}
else
{
alert("请选择一个产品!");
}

}

function createNew()
{
window.location.href="${basePath}/background/VisaProductAction.do?method=addUI";
}
//全选、反选
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
}

//show product
function showProductByname(id,showId)
{

window.open("${basePath}/background/VisaProductAction.do?method=exportPDF&id="+id+"&showId="+showId);

}

function showInfo(id,showId)
{
art.dialog.open("${basePath}/background/VisaProductAction.do?method=exportPDF&id="+id+"&showId="+showId,
{
    title: '产品详细信息',
    width: '100%',
    height: 420,
    left: '50%',
    top: '10%',
    lock:true
});
}

//导出pdf
function exportConfirm(showId)
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
if(idArr.length>0){
//openUrl("VisaOrderAction.do?method=exportExcel&id="+idArr);

window.open("${basePath}/background/VisaProductAction.do?method=exportPDF&id="+idArr+"&showId="+showId);
}
else
{
alert("您还没有选中任何产品!")
}
}






</script>
