<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>上传界面</title>
 <%@ include file="/WEB-INF/jsp/Public/commons-no-validate.jspf" %>
<script language="javascript" src="${basePath}/script/jquery_treeview/jquery.treeview.js"></script>
<link type="text/css" rel="stylesheet" href="${basePath}/style/blue/file.css" />
<link type="text/css" rel="stylesheet" href="${basePath}/script/jquery_treeview/jquery.treeview.css" />
<script type="text/javascript">
 		// 选择所有
function selectAll(checkedValue){
    		$("[name=resourceIds]").attr("checked", checkedValue);
}
    	
    	$(function(){
    	var arr=$("input:checkbox:checked");
	     for(var i=0;i<arr.length;i++)
	     {
	  $(arr[i]).parents("li").children("[name=resourceIds]").attr("checked", true);
	     }
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
<!-- 标题显示 -->
<div ID="Title_bar">
    <div ID="Title_bar_Head">
        <div ID="Title_Head"></div>
        <div ID="Title"><!--页面标题-->
            <IMG BORDER="0" WIDTH="13" HEIGHT="13" SRC="${pageContext.request.contextPath}/style/images/title_arrow.gif"/> 关联产品关系
        </div>
        <div ID="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div ID="MainArea">

	<!-- 显示顶级 -->
  <html:form action="background/AttachmentAction">
  <br/>
 附件名称:<html:text property="name" styleId="name" styleClass="InputStyle"/>
   <br/>
 <hr></hr>
  <html:hidden property="method" value="add"/>
    <html:hidden property="ids" styleId="attacmentId" value="${param.id}"/>
						<!--  	<ul id="tree">
							<c:forEach items="${topLevel}" var="top">
								<li>
									<label for="cb_${top.id}">${top.name}</label>
									<c:forEach items="${visaProductList}" var="product">
										<html:multibox property="resourceIds" value="${product.id}" styleId="cb_${product.id}"/>
										<label for="cb_${product.id}">${product.name}</label><br>
									</c:forEach>
								</li></c:forEach>
							</ul>-->
	
	
	        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
					<!--表头-->
					<thead>
						<tr align="LEFT" valign="MIDDLE" id="TableTitle">
							<td width="300px" style="padding-left: 7px;">
								<!-- 如果把全选元素的id指定为selectAll，并且有函数selectAll()，就会有错。因为有一种用法：可以直接用id引用元素 -->
								<input type="checkbox" id="cbSelectAll" onclick="selectAll(this.checked)"/>
								<label for="cbSelectAll">全选</label>
							</td>
						</tr>
					</thead>
                   
			   		<!--显示数据列表-->
					<tbody id="TableData">
						<tr class="TableDetail1">
							<!-- 显示权限树 -->
							<td>
							<!-- 显示顶级 -->
							<ul id="tree"><c:forEach items="${topLevel}" var="top">
								<li>
								 <html:multibox property="resourceIds" value="${top.id}" styleId="cb_${top.id}"/>
									<label for="cb_${top.id}">${top.name}</label>
										<ul>
											<c:forEach items="${top.coutryChild}" var="children">	
											<li>
											   <html:multibox property="resourceIds" value="${children.id}" styleId="cb_${children.id}"/>
														<label for="cb_${children.id}">${children.name}</label><br>	
														
															 <ul><%-- 显示第二级 --%>
															<c:forEach items="${visaProductList}" var="visaProduct">	
															<li>
															<c:if test="${children.id eq visaProduct.country.id}">
																		      <html:multibox property="resourceIds" value="${visaProduct.id}" styleId="cb_${visaProduct.id}"/>
																				<label for="cb_${visaProduct.id}">${visaProduct.name}</label><br>			
															</c:if>
															
															</li>
															
															</c:forEach>
															</ul>	
														
																
											</li>
											</c:forEach>
										</ul>
														
									
								</li></c:forEach>
							</ul>
							
							</td>
						</tr>
					</tbody>
                </table>
            </div>
        </div>
        
             <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
        </div>
		</html:form>
	
	
	
	
</div>
								
</body>
</html>
<script type="text/javascript">


</script>
