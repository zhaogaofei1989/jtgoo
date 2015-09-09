<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>签证类别列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证类别管理</strong> / <small>签证类别列表</small></div>
    </div>
    
<div class="am-panel-hd">
</div>
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
	          <iamp-identify:IAMPIdentify authid="03_01_05_00">
	            <button type="button" class="am-btn am-btn-default" onclick="createNew('VisaDataTypeAction.do?method=addUI');"><span class="am-icon-plus"></span> 新增</button>
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
            	<th>ID</th>
                <th>分类名称</th>
                <th>分类描述</th>
 				<th class="table-set">操作</th>
              </tr>
                </thead>
                 <tbody>
               <c:forEach items="${datatypeList}" var="datatype">
           	 <tr class="TableDetail1 template">
             	<td>${datatype.id}&nbsp;</td>
				<td>${datatype.name}&nbsp;</td>
				<td>${datatype.description}&nbsp;</td>
				<td>
					<iamp-identify:IAMPIdentify authid="03_01_03_00">
						<html:link action="background/VisaDataTypeAction?method=editUI&id=${datatype.id}">修改</html:link>
					</iamp-identify:IAMPIdentify>
					<iamp-identify:IAMPIdentify authid="03_01_04_00">
						<html:link action="background/VisaDataTypeAction?method=delete&id=${datatype.id}">删除</html:link>
					</iamp-identify:IAMPIdentify>
				</td>
            </tr>
    	    </c:forEach>
    	    </tbody>
        </table>
					 <div class="am-cf">
					
					</div>
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

