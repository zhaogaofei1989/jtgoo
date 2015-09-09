<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
    <title>同业用户组列表</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body>


 <!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">同业用户组管理</strong> / <small>同业用户组列表</small></div>
    </div>
    
<div class="am-panel-hd">
</div>
    
    <div class="am-g">
      <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs">
          	<iamp-identify:IAMPIdentify authid="02_03_05_00">
            <button type="button" class="am-btn am-btn-default" onclick="createNew('PeerGroupAction.do?method=addUI&parentId=${parent.id}');"><span class="am-icon-plus"></span> 新增</button>
          	</iamp-identify:IAMPIdentify>
          </div>
        </div>
      </div>
    </div>
  
  
  
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="${basePath}background/PeerGroupAction.do?method=list" method="post">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th>同业用户组名称</th><th>领区查看</th><th>会员数</th><th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
               <c:forEach items="${peerGroupList}" var="peerGroup">
           	 <tr class="TableDetail1 template">
             	 <td>${peerGroup.name}&nbsp;</td>
				<td>${peerGroup.description}&nbsp;</td>
				<td>${peerGroup.customerSet eq null ? 0 : fn:length(peerGroup.customerSet) }&nbsp;</td>
				<td>
				     	<iamp-identify:IAMPIdentify authid="02_03_03_00">
					<html:link action="background/PeerGroupAction?method=editUI&id=${peerGroup.id}">修改</html:link>
				</iamp-identify:IAMPIdentify>
				     	<iamp-identify:IAMPIdentify authid="02_03_04_00">
					<html:link action="background/PeerGroupAction?method=delete&id=${peerGroup.id}">删除</html:link>
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

