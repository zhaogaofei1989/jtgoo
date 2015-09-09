<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>签证产品</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
    <script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
	<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证产品管理</strong> / <small>签证产品列表</small></div>
    </div>
    
<div class="am-panel-hd">
<form action="${basePath}/background/VisaProductAction.do?method=list" method="post">
  <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav" style="margin-bottom: 10px">
      <li>国家分类:&nbsp;<select name="countrySelect" id="countrySelect">
		<option value="">请选择</option>
		<c:forEach items="${countryList}" var="country">
		<option value="${country.id }">${country.name }</option>
		<c:forEach items="${country.coutryChild}" var="child">
		<option value="${child.id }"> ┣${child.name }</option>
		</c:forEach>
		</c:forEach>
</select>
	</li>
      <li style="margin-left: 15px">类型:
<select name="visaTypeSelect" id="visaTypeSelect">
<option value="">请选择</option>
<c:forEach items="${visaTypeList}" var="visaType">
<option value="${visaType.id }">${visaType.name }</option>
</c:forEach>
</select></li>
      <li style="margin-left: 15px">领区:
<select name="lingquSelect">
<option value="">请选择</option>
<c:forEach items="${lingquList}" var="lingqu">
<option value="${lingqu.id }">${lingqu.name }</option>
</c:forEach>
</select></li>
      <li style="margin-left: 15px">名称/标题: <input type="text" name="visaProductName" id="visaProductName"/>&nbsp;</li>
      <li><input type="submit" value="搜索"/></li>
    </ul>
   </div>
      <html:hidden property="pageNum" value="1"/>
	<html:hidden property="pageSize" value="10"/>
  </form>
</div>
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
	          	<iamp-identify:IAMPIdentify authid="03_05_01_05">
	            	<button type="button" class="am-btn am-btn-default" onclick="createNew();"><span class="am-icon-plus"></span> 新增</button>
	            </iamp-identify:IAMPIdentify>
	            <iamp-identify:IAMPIdentify authid="03_05_01_06">
	            	<button type="button" class="am-btn am-btn-default" onclick="return exportConfirm(3);"><span></span>导出有logo材料</button>
	            </iamp-identify:IAMPIdentify>
	            <iamp-identify:IAMPIdentify authid="03_05_01_07">
	            	<button type="button" class="am-btn am-btn-default" onclick="return exportConfirm(4);"><span></span>导出无logo材料</button>
	            </iamp-identify:IAMPIdentify>
	            <iamp-identify:IAMPIdentify authid="03_05_01_08">
	            	<button type="button" class="am-btn am-btn-default" onclick="return copy();"><span></span>复制</button>
	          	</iamp-identify:IAMPIdentify>
          </div>
        </div>
      </div>
    </div>
  
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th><input  type="checkbox" id="check_box"/></th>
             <th>ID</th>
             <th>名称</th>
             <th>洲际/国家</th>
             <th>领区</th>
             <th>类型</th>
             <th>价格</th>
             <th>签证费|0-6岁|6-12岁</th>
             <th>预约费|0-6岁|6-12岁</th>
               <c:if test="${hasAdmin==true}">
             	<th>下载</th>
             	</c:if>
             <th>状态</th>
             <th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
           <c:forEach items="${pageBean.recordList}" var="visaProduct">
            <tr class="TableDetail1 template">
                <td><input class="checkbox1"   name="ids" value="${visaProduct.id}"  type="checkbox" ></td>
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
                     <span onclick="showAttachmentList(${visaProduct.id })"><img src="${basePath}/style/images/tol_download.png" /></span>
                     </td>
            </c:if>
				<td>正常显示&nbsp;</td>
				<td>
					<iamp-identify:IAMPIdentify authid="03_05_01_03">
						<html:link action="background/VisaProductAction?method=editUI&id=${visaProduct.id}">修改</html:link>
					</iamp-identify:IAMPIdentify>
					<iamp-identify:IAMPIdentify authid="03_05_01_04">
						<html:link action="background/VisaProductAction?method=delete&id=${visaProduct.id}">删除</html:link>
					</iamp-identify:IAMPIdentify>
				</td>
            </tr>
    	    </c:forEach>
          </tbody>
        </table>
			<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
          <hr/>
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
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
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
			} else {
				$('.checkbox1').each(function() { //loop through each checkbox
					this.checked = false; //deselect all checkboxes with class "checkbox1" 
				}); 
			}
		});
$('.checkbox1').click(function(event) { 
var allbox =$('input[name="ids"]:checkbox:checked');
if(allbox.length>0)
{
document.getElementById("check_box").checked=true;
}
else
{
document.getElementById("check_box").checked=false;
}
});
});


	function showAttachmentList(visaProductId) {
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
	
	function copy() {
		var idArr='';
		$('input[name="ids"]:checkbox:checked').each(function() {
			idArr+=$(this).val()+','; 
		});
		if(idArr.split(",").length-1==1) {
			window.location.href="${basePath}/background/VisaProductAction.do?method=copyRefreshUI&id="+idArr.split(",")[0];
		} else if (idArr.split(",").length-1>1) {
			alert("只能选择一个!");
		} else {
			alert("请选择一个产品!");
		}
	}						

	function createNew() {
		window.location.href="${basePath}/background/VisaProductAction.do?method=addUI";
	}
	
	//全选、反选
	function selectAll(checkedValue) {
		$("[name=ids]").attr("checked", checkedValue);
	}

	//show product
	function showProductByname(id,showId) {
		window.open("${basePath}/background/VisaProductAction.do?method=exportPDF&id="+id+"&showId="+showId);
	}

	function showInfo(id,showId) {
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
	function exportConfirm(showId) {
		var idArr='';
		$('input[name="ids"]:checkbox:checked').each(function() {
			idArr+=$(this).val()+','; 
		});
		if(idArr.length>0) {
			//openUrl("VisaOrderAction.do?method=exportExcel&id="+idArr);
			window.open("${basePath}/background/VisaProductAction.do?method=exportPDF&id="+idArr+"&showId="+showId);
		} else {
			alert("您还没有选中任何产品!")
		}
	}
</script>

