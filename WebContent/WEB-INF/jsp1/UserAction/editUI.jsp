<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>用户信息</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
</head>
<body>
<!-- content start -->
<div class="admin-content">

  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户管理</strong> / <small>用户修改</small></div>
  </div>

  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
        <html:form styleClass="am-form" styleId="myform" action="background/UserAction">
        <html:hidden property="method" value="edit"/>
    	<html:hidden property="id"/>
	          <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		             所属部门
		     	   </div>
				        	<div class="am-u-sm-8 am-u-md-4">
				             <html:select property="departmentId">
				                                <html:option value="0">请选择部门</html:option>
				                               	<c:forEach items="${departmentList}" var="department">
					                                <html:option value="${department.id}">${department.name}</html:option>
				                               	</c:forEach>
				              </html:select> 
				           </div>
		           <div class="am-hide-sm-only am-u-md-6"></div>
	          </div>
        
          <div class="am-g am-margin-top">
            	<div class="am-u-sm-4 am-u-md-2 am-text-right">
             	性别
     	       </div>
	        	<div class="am-u-sm-8 am-u-md-10">
	        		<html:radio property="sex" value="男" styleId="male"/><label for="male">男</label>
					<html:radio property="sex" value="女" styleId="female"/><label for="female">女</label>
	         	</div>
          </div>
        
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              登录名
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="loginName" styleClass="am-input-sm" readonly="true"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6">登录名，不可修改</div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              名称
            </div>
            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
            <html:text property="name" styleClass="am-input-sm"/>
            </div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              电话
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="phoneNumber" styleClass="am-input-sm"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6">选填</div>
          </div>
		          <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		              Email
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		              <html:text property="email" styleClass="am-input-sm"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6">选填</div>
		          </div>
		          
		          
		             <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		              领区
		            </div>
		            <div class="am-u-sm-8 am-u-md-10">
		             <c:forEach items="${lingquList}" var="lingqu"> 
					 <html:multibox property="userIds" value="${lingqu.id}" styleId="cb_${lingqu.id}" />${lingqu.name }
					</c:forEach>
		            </div>
		          </div>
	          

          <div class="am-g am-margin-top-sm">
            <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
              备注
            </div>
            <div class="am-u-sm-12 am-u-md-10">
              <html:textarea rows="10" property="description"/>
            </div>
          </div>
          
            <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		             所属部门
		     	   </div>
				        	<div class="am-u-sm-8 am-u-md-4">
				          <html:select property="roleIds" multiple="true" size="10" styleClass="SelectStyle">
                        		<c:forEach items="${roleList}" var="role">
	                                <html:option value="${role.id}">${role.name}</html:option>
                        		</c:forEach>
                            </html:select>
                            按住Ctrl键可以多选或取消选择
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
