<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>会员列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
      <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">会员管理</strong> / <small>会员列表</small></div>
    </div>
    
<div class="am-panel-hd">
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
        <form class="am-form" action="${basePath}background/UserAction.do?method=list" method="post">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th>会员用户名</th>
                <th>姓名</th>
                <th>手机号码</th>
                <th>邮箱</th>
                <th>注册时间</th>
                <th>最后登录时间</th>
              <!--  <td>订单数量</td> --> 
                <th>操作</th>
              </tr>
          </thead>
          <tbody>
            <c:forEach items="${pageBean.recordList}" var="pageBean">
            <tr class="TableDetail1 template">
       			<td>${pageBean.userName }</td>
				<td>${pageBean.name }</td>
				<td>${pageBean.mobliePhone}</td>
				<td>${pageBean.email}</td>
				<td>${pageBean.regTime }</td>
				<td>${pageBean.regTime}</td>
				<!--  <td>${pageBean}</td>-->
				<td>
					<!--<html:link action="background/MemberAction?method=editUI&id=${pageBean.id}">修改</html:link>-->
					<iamp-identify:IAMPIdentify authid="02_05_02_00">
						<html:link action="background/MemberAction?method=delete&id=${pageBean.id}">删除</html:link>
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
</script>

