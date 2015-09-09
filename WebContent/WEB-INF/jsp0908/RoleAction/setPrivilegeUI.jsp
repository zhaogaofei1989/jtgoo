<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title>配置权限</title>
 <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
 <link type="text/css" rel="stylesheet" href="${basePath}js/amazeui/css/amazeui.css" />
<link type="text/css" rel="stylesheet" href="${basePath}js/amazeui/css/admin.css" />
	<script language="javascript" src="${basePath}/script/jquery_treeview/jquery.treeview.js"></script>
	<link type="text/css" rel="stylesheet" href="${basePath}/style/blue/file.css" />
	<link type="text/css" rel="stylesheet" href="${basePath}/script/jquery_treeview/jquery.treeview.css" />
	<script type="text/javascript">
    
 		// 选择所有
    	function selectAll(checkedValue){
    		$("[name=resourceIds]").attr("checked", checkedValue);
    	}
    	$(function(){
    		// 绑定click事件
    		$("[name=resourceIds]").click(function(){
    		
    			// 当前的选中状态
    			var checkedValue = this.checked;
    			
    			// 1，选中一个权限时：
    			if(checkedValue){
				     // a，应该选中他的所有直系上级
				     $(this).parents("li").children("[name=resourceIds]").attr("checked", checkedValue);
				     
				     // b，应该选中他的所有直系下级
				     $(this).siblings("ul").find("[name=resourceIds]").attr("checked", checkedValue);
				}
				// 2，取消选择一个权限时：
				else{
				     // a，应该取消选择 他的所有直系下级
				     $(this).siblings("ul").find("[name=resourceIds]").attr("checked", checkedValue);
				     
				     // b，如果同级的权限都是未选择状态，就应该取消选中他的直接上级，并递归向上做这个操作
				     if( $(this).parent("li").siblings("li").children("[name=resourceIds]:checked").size() == 0 ){
				     	$(this).parent("li").parent("ul").siblings("[name=resourceIds]").attr("checked", checkedValue);
				     	
				     	// 上级的上级也要进行同样的操作（仅当前为第三级时才可以）
				     	if( $(this).parent("li").parent("ul").parent("li").siblings("li").children("[name=resourceIds]:checked").size() == 0 ){
				     		$(this).parent("li").parent("ul").parent("li").parent("ul").siblings("[name=resourceIds]").attr("checked", checkedValue);
				     	}
				     }
				}
    		});
    	
    	
    		$("#tree").treeview({collapsed: true});
    	});
    </script>
</head>
<body>


<br/><br/><!-- 标题显示 -->
<!-- start  admin-content div-->
<div>
	  <div class="am-cf am-padding">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">权限设置</strong> / <small>权限修改</small></div>
	  </div>
  
<!--显示表单内容-->
<!--form div -->
  <div>
        <html:form  action="background/RoleAction" styleId="myform">
		<html:hidden property="method" value="setPrivilege"/>
    	<html:hidden property="id"/>
			<fieldset>
				<legend>正在配置权限 </legend>
			<!-- 显示顶级 -->
							<ul id="tree"><c:forEach items="${topResourceList}" var="top">
								<li>
									<html:multibox property="resourceIds" value="${top.id}" styleId="cb_${top.id}"/>
									<label for="cb_${top.id}">${top.name}</label>
									<ul><%-- 显示第二级 --%>
									<c:forEach items="${top.children}" var="level2">
										<li>
											<html:multibox property="resourceIds" value="${level2.id}" styleId="cb_${level2.id}"/>
											<label for="cb_${level2.id}">${level2.name}</label><br>
											<ul><%-- 显示第三级 --%>
												<c:forEach items="${level2.children}" var="level3">
													<li>
														<html:multibox property="resourceIds" value="${level3.id}" styleId="cb_${level3.id}"/>
														<label for="cb_${level3.id}">${level3.name}</label><br>
														
															<ul><%-- 显示第四级 --%>
															<c:forEach items="${level3.children}" var="level4">
															<li>
														<html:multibox property="resourceIds" value="${level4.id}" styleId="cb_${level4.id}"/>
														<label for="cb_${level4.id}">${level4.name}</label><br>
																			<ul><%-- 显示第五级 --%>
																				<c:forEach items="${level4.children}" var="level5">
																						
																							<li>
																							<html:multibox property="resourceIds" value="${level5.id}" styleId="cb_${level5.id}" />
																							<label for="cb_${level5.id}">${level5.name}</label><br>
																							</li>
																				</c:forEach>
																			</ul>
															</li>
															</c:forEach>
															</ul>
														
														
													</li>
												</c:forEach>
											</ul>
										</li>
									</c:forEach>
									</ul>
								</li></c:forEach>
							</ul>
			</fieldset>
			
	<hr/>

		</html:form>
		</div>
</div>

  <div class="am-margin" style="padding-left: 10">
            <input id="save" type="submit" class="am-btn am-btn-primary am-btn-xs" value="保存" onclick="save()"/>
  </div>

<div class="Description">
	说明：<br />
	1，选中一个权限时：<br />
	&nbsp;&nbsp;&nbsp;&nbsp; a，应该选中 他的所有直系上级。<br />
	&nbsp;&nbsp;&nbsp;&nbsp; b，应该选中他的所有直系下级。<br />
	2，取消选择一个权限时：<br />
	&nbsp;&nbsp;&nbsp;&nbsp; a，应该取消选择 他的所有直系下级。<br />
	&nbsp;&nbsp;&nbsp;&nbsp; b，如果同级的权限都是未选择状态，就应该取消选中他的直接上级，并递归向上做这个操作。<br />

	3，全选/取消全选。<br />
	4，默认选中当前岗位已有的权限。<br />
</div>

</body>
</html>
 <script type="text/javascript">	
 function save()
 {
 $("#myform").submit();
 }
 </script>