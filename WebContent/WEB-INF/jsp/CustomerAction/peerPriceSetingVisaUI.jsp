<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>同行价格设置列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
    <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>

 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">同业价格</strong> / <small>同业价格设置</small></div>
    </div>

<div class="am-panel-hd">
<form action="${basePath}/background/CustomerAction.do?method=peerlistV2" method="post">
  <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav">
      <li>
	价格样表设置:
1000 &nbsp;<input type="radio" name="r1" checked="checked" value="1000"/>
2000 &nbsp;<input type="radio" name="r1" value="2000"/>
3000 &nbsp;<input type="radio" name="r1" value="3000"/>
<input class="am-btn am-btn-default" type="button" value="设置" onclick="selectObj()"/>
	 </li>
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
          </div>
        </div>
      </div>
    </div>
  
  
  <div class="am-g">
      <div class="am-u-sm-12">
        <form action="${basePath}background/CustomerAction.do?method=peerlistV2" method="post">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th><input  type="checkbox" id="check_box"/></th>
         	    <th>签证产品编号</th>
                <th>洲际</th>
                <th>签证产品名称</th>
                <th>同业价格</th>
                <th>受理类型</th>
                <th>报价是否含签证费</th>
              </tr>
          </thead>
          <tbody>
             <c:forEach items="${pageBean.recordList}" var="visaProduct">
			<tr class="TableDetail1 template">
			    <td><input class="inputcheckbox"   name="ids" value="${visaProduct.id}"  type="checkbox" ></td>
				<td>${visaProduct.id}&nbsp;</td>
				<td>${visaProduct.country.name}&nbsp;</td>
				<td>${visaProduct.name}&nbsp;</td>
				<td>
				  <input type="text" id="input_${visaProduct.id}" name="visaProductArraysPrice[${visaProduct.id }]" value="${ visaProduct.price}"/>
				</td>
				<td>
				<c:choose>
				<c:when test="${visaProduct.acceptType==0}">
				代送
				</c:when>
				<c:when test="${visaProduct.acceptType==1}">
				 包签
				</c:when>
				</c:choose>
				</td>
				<td>
				<c:choose>
				<c:when test="${visaProduct.acceptType==0}">
				是
				</c:when>
				<c:when test="${visaProduct.acceptType==1}">
				 否
				</c:when>
				</c:choose>
				</td>
			</tr>
		</c:forEach>	
           
          </tbody>
        </table>
	
          <hr />
          		<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
          <p>注：.....</p>
        </form>
        
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
function selectObj()
{

//   $("input[name=batch]").each(function() {  })
var arr=$("input:checkbox:checked");
var radioValue= $("input:radio:checked").val();
for(var i=0;i<arr.length;i++)
{

var obj=arr[i];
if(obj.name!='')
{
$("#input_"+obj.value).val(radioValue);
}
}
}
</script>
