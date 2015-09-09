<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>用户列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
            <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>



 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户管理</strong> / <small>用户列表</small></div>
    </div>
    
<div class="am-panel-hd">
<input type="text" name="startTime" class="Wdate" style="width:100px;height: 30px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/>
asdasd	<input type="text" style="width:100px;height: 30px;"/>
asdasd	<input type="text" style="width:100px;height: 30px;"/>
asdasd	<input type="text" style="width:100px;height: 30px;"/>
</div>
    
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
            <button type="button" class="am-btn am-btn-default" onclick="createNew('UserAction.do?method=addUI');"><span class="am-icon-plus"></span> 新增</button>
          </div>
        </div>
      </div>
    </div>
  
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/UserAction.do?method=list" method="post">
          <html:hidden property="pageNum" value="1"/>
		<html:hidden property="pageSize" value="10"/>
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th>登录名</th><th>姓名</th><th>所属部门</th><th>岗位</th><th>备注</th><th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
           <c:forEach items="${pageBean.recordList}" var="user">
            <tr class="TableDetail1 template">
                <td>${user.loginName}&nbsp;</td>
                <td>${user.name}&nbsp;</td>
                <td>${user.department.name}&nbsp;</td>
                <td><c:forEach items="${user.roles}" var="role">${role.name}&nbsp;</c:forEach></td>
                <td>${user.description}&nbsp;</td>
                <td><html:link action="background/UserAction?method=delete&id=${user.id}" onclick="return delConfirm()">删除</html:link>
                    <html:link action="background/UserAction?method=editUI&id=${user.id}">修改</html:link>
					<html:link action="background/UserAction?method=initPassword&id=${user.id}" onclick="return window.confirm('您确定要初始化密码吗？')">初始化密码</html:link>
                </td>
            </tr>
    	    </c:forEach>
          </tbody>
        </table>
					 <div class="am-cf">
					  共 ${pageBean.recordCount }条记录
					  <div class="am-fr">
					    <ul class="am-pagination">
					    	<li class="am-disabled"><a href="#">«</a></li>
					    	  <c:forEach begin="${pageBean.beginPageIndex}" end="${pageBean.endPageIndex}" var="num" >
								<c:if test="${pageBean.currentPage eq num}">
								    <li class="am-active"><a href="${basePath}fenxiao/CustomerFenXiaoAction.do?method=contentUI&pageNum=${num }">${num }</a></li>
								</c:if>
								<c:if test="${pageBean.currentPage ne num}">
								 <li><a  href="${basePath}fenxiao/CustomerFenXiaoAction.do?method=contentUI&pageNum=${num }">${num }</a></li>
								</c:if>
							</c:forEach>
							<li><a href="#">»</a></li>
					    </ul>
					  </div>
					</div>
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

