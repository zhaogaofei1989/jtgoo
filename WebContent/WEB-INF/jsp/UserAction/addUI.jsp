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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户管理</strong> / <small>用户添加</small></div>
  </div>

  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
          <html:form styleClass="am-form" styleId="myform" action="background/UserAction">
        <html:hidden property="method" value="add"/>
    	<html:hidden property="id"/>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             所属部门
     	       </div>
        	<div class="am-u-sm-8 am-u-md-10">
        	<select name="departmentId" id="departmentId" data-am-selected="{btnSize: 'sm'}">
                                <option value="0">请选择部门</option>
                               	<c:forEach items="${departmentList}" var="department">
	                                <option value="${department.id}">${department.name}</option>
                               	</c:forEach>
             </select> 
          </div>
          </div>
        
          <div class="am-g am-margin-top">
            	<div class="am-u-sm-4 am-u-md-2 am-text-right">
             	性别
     	       </div>
	        	<div class="am-u-sm-8 am-u-md-10">
	        		<input type="radio" name="sex" value="男" id="male"/><label for="male">男</label>
					<input type="radio" name="sex" value="女" id="female"/><label for="female">女</label>
	         	</div>
          </div>
        
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              登录名
            </div>
            <div class="am-u-sm-8 am-u-md-4">
              <input type="text" id="loginName" name="loginName" class="am-input-sm">
            </div>
            <div class="am-hide-sm-only am-u-md-6">*必填，不可重复</div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              用户姓名
            </div>
            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
              <input type="text" id="name" name="name" class="am-input-sm">
            </div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              电话
            </div>
            <div class="am-u-sm-8 am-u-md-4">
              <input type="text" id="phoneNumber" name="phoneNumber" class="am-input-sm">
            </div>
            <div class="am-hide-sm-only am-u-md-6">选填</div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              Email
            </div>
            <div class="am-u-sm-8 am-u-md-4">
              <input type="text" id="email" name="email" class="am-input-sm">
            </div>
            <div class="am-hide-sm-only am-u-md-6">选填</div>
          </div>

          <div class="am-g am-margin-top-sm">
            <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
              备注
            </div>
            <div class="am-u-sm-12 am-u-md-10">
              <textarea rows="10" placeholder="请填写相关备注"></textarea>
            </div>
          </div>
           <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		             所属岗位
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
