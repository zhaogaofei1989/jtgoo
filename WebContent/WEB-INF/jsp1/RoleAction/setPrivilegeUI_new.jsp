<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>配置权限</title>
	<%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
	<script language="javascript" src="${basePath}/script/jquery_treeview/jquery.treeview.js"></script>
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
	 		
	 		$("#tree").treeview();
	 	});
	 </script>
</head>
<body>
	<div class="admin-content">
		<div class="am-cf am-padding">
		    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">岗位管理</strong> / <small>配置权限</small>
		    </div>
		</div>
		
		<div class="am-tabs am-margin" data-am-tabs>
			<ul class="am-tabs-nav am-nav am-nav-tabs">
				<li><a class="am-active" href="#tab2">正在为【部门经理】配置权限</a></li>
			</ul>
			<div class="am-tabs-bd">
				<div class="am-tab-panel am-fade" id="tab2">
				   <html:form styleClass="am-form" styleId="myform" action="background/RoleAction">
		   				<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}" />
						<html:hidden property="id" />
						
						<div class="am-g">
							<div class="am-u-sm-12">
								<table class="am-table am-table-striped am-table-hover table-main">
									<thead>
										<tr align="LEFT" valign="MIDDLE" id="TableTitle">
											<td width="300px" style="padding-left: 7px;">
												<!-- 如果把全选元素的id指定为selectAll，并且有函数selectAll()，就会有错。因为有一种用法：可以直接用id引用元素 -->
												<input type="checkbox" id="cbSelectAll" onClick="selectAll(this.checked)"/>
												<label for="cbSelectAll">全选</label>
											</td>
										</tr>
									</thead>
									<tbody>
										<tr class="TableDetail1">
											<!-- 显示权限树 -->
											<td>
												<!-- 显示顶级 -->
												<ul id="tree">
													<c:forEach items="${topResourceList}" var="top">
														<li>
															<html:multibox property="resourceIds" value="${top.id}"
																	styleId="cb_${top.id}" />
															<label for="cb_${top.id}">
																	${top.name}
															</label>
															<ul>
																<%-- 显示第二级 --%>
																<c:forEach items="${top.children}" var="level2">
																	<li>
																		<html:multibox property="resourceIds"
																				value="${level2.id}" styleId="cb_${level2.id}" />
																			<label for="cb_${level2.id}">
																				${level2.name}
																			</label>
																			<br>
																			<ul>
																				<%-- 显示第三级 --%>
																				<c:forEach items="${level2.children}" var="level3">
																					<li>
																						<html:multibox property="resourceIds"
																							value="${level3.id}" styleId="cb_${level3.id}" />
																						<label for="cb_${level3.id}">
																							${level3.name}
																						</label>
																						<br>

																						<ul>
																							<%-- 显示第四级 --%>
																							<c:forEach items="${level3.children}"
																								var="level4">
																								<li>
																									<html:multibox property="resourceIds"
																										value="${level4.id}" styleId="cb_${level4.id}" />
																									<label for="cb_${level4.id}">
																										${level4.name}
																									</label>
																									<br>
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
												</td>
											</tr>
										</tbody>
								</table>
							</div>
						</div>
				  </html:form>	
				</div>
			</div>
		</div>
		
		<div class="am-margin">
    		<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="saveInfo()">保&nbsp;&nbsp;&nbsp;&nbsp;存</button>
    		<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="javascript:history.go(-1);"
    		>返&nbsp;&nbsp;&nbsp;&nbsp;回</button>
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
function saveInfo() {
	$("#myform").submit();
}
</script>


