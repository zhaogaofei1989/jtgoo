<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>签证国家列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证国家管理</strong> / <small>签证国家列表</small></div>
    </div>
    
<div class="am-panel-hd">
</div>
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
          	<iamp-identify:IAMPIdentify authid="03_04_05_00">
            <button type="button" class="am-btn am-btn-default" onclick="createNew('VisaCountryAction.do?method=addUI');"><span class="am-icon-plus"></span> 新增</button>
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
                <th>名称</th>
                <th>描述</th>
                <th>路径</th>
 				<th class="table-set">操作</th>
              </tr>
                </thead>
                 <tbody>
                 
        <c:forEach items="${topList}" var="top">
           	<tr class="TableDetail1 template"><td>${top.name}&nbsp;</td>  <td>${country.description}&nbsp;</td>   <td>${top.icon}</td> <td>	<html:link action="background/VisaCountryAction?method=editUI&id=${top.id}">修改</html:link>
           	<html:link action="background/VisaCountryAction?method=delete&id=${top.id}" onclick="return delConfirm()">删除</html:link>
           	</td></tr>
           	 <c:forEach items="${pageBean.recordList}" var="country">
           	<c:if test="${top.id eq country.parent.id }">
           	<tr class="TableDetail1 template">
			   <td>&nbsp;┣${country.name}&nbsp;</td>
				<td>${country.description}&nbsp;</td>
				<td>${country.icon}</td>
				<td>
					<iamp-identify:IAMPIdentify authid="03_04_03_00">
					<html:link action="background/VisaCountryAction?method=editUI&id=${country.id}&pageNum=${pageBean.currentPage }">修改</html:link>
					</iamp-identify:IAMPIdentify>
					<iamp-identify:IAMPIdentify authid="03_04_04_00">
					<html:link action="background/VisaCountryAction?method=delete&id=${country.id}&pageNum=${pageBean.currentPage }" onclick="return delConfirm()">删除</html:link>
					</iamp-identify:IAMPIdentify>
				</td>
			</tr>
           	</c:if>
					</c:forEach>
		</c:forEach>	
			
    	    </tbody>
        </table>
				
					<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
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
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
<script src="${basePath}js/amazeui/app.js"></script>
</body>
</html>

