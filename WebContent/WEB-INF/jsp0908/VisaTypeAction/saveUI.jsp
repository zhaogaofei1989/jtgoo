<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>签证类型设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
<!-- content start -->
<div class="admin-content">

  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证类型</strong> / <small>${param.id eq null ? '签证类型添加' : '签证类型修改'}</small></div>
  </div>

  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
        <html:form styleClass="am-form" action="background/VisaTypeAction" styleId="myform">
    	 	<html:hidden property="method"  value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id"/>
		<input type="hidden" id="occuHidenId" value="${occuId}"/>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            分类名称
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="name" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             分类描述
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:textarea rows="10" property="description" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
  
        </html:form>
      </div>

    </div>
  </div>
  <div class="am-margin">
    <button type="button" onclick="saveInfo()" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
  </div>
</div>
<!-- content end -->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${basePath}js/amazeui/jquery.min.js"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>
<script src="${basePath}js/amazeui/app.js"></script>
</body>
</html>
<script type="text/javascript">

function saveInfo()
{
$("#myform").submit();
}
</script>
