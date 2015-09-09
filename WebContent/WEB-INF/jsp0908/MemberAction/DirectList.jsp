<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>客户列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
      <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">客户管理</strong> / <small>直接用户列表</small></div>
    </div>
    
<div class="am-panel-hd">
</div>
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
            <button type="button" class="am-btn am-btn-default" onclick="createNew('${basePath}background/MemberAction.do?method=directAddUI');"><span class="am-icon-plus"></span> 新增</button>
          </div>
        </div>
      </div>
    </div>
  
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/UserAction.do?method=list" method="post">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
              <th><input  type="checkbox" id="check_box" /></th>
             <th>用户编号</th><th>用户名</th><th>姓名</th><th>手机号</th><!--  <th>销售</th--><th>状态</th><th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
            <c:forEach items="${pageBean.recordList}" var="director">
            <tr class="TableDetail1 template">
                <td><input class="checkbox1"   name="ids" value="${customer.id}"  type="checkbox" ></td>
                		<td>${director.serialNumber}&nbsp;</td>
				<td>${director.userName}&nbsp;</td>
				<td>${director.name}&nbsp;</td>
				<td>${director.mobliePhone}&nbsp;</td>
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
</script>

