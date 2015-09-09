<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>用户信息</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
          <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
</head>
<body>
<!-- content start -->
<div class="admin-content">

  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">客户管理</strong> / <small>${param.id eq null ? '客户信息添加' : '客户信息修改'}</small></div>
  </div>

  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
        <html:form styleClass="am-form" styleId="myform" action="background/CustomerAction">
    	<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}"/>
    	<html:hidden property="id"/>
		<input type="hidden" id="occuHidenId" value="${occuId}"/>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              姓名
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="name" styleId="name" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6">*</div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
              手机号
            </div>
            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
            <html:text styleId="mobliePhone" property="mobliePhone" styleClass="input"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6">*</div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             QQ
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="chatTools" styleClass="am-input-sm"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6">选填</div>
          </div>
		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		            邮箱地址
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		              <html:text property="email" styleClass="am-input-sm"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6">选填</div>
		  </div>
		          
		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		            家庭地址
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		              <html:text property="address" styleClass="am-input-sm"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6">选填</div>
		  </div>
		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		            家庭电话
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		              <html:text property="phone" styleClass="am-input-sm"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6">选填</div>
		  </div>
		          
	 		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		             输入人员
		     	   </div>
				        	<div class="am-u-sm-8 am-u-md-4">
				        	  <html:text property="inputName" value="${user.name}" readonly="true" styleId="inputNameId"/>
				           </div>
		           <div class="am-hide-sm-only am-u-md-6"></div>
	          </div>
	 		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		             销售
		     	   </div>
				        	<div class="am-u-sm-8 am-u-md-4">
				<select name="salerId" id="salerId">
				   <option value="">请选择</option>
				     <c:forEach var="saler" items="${salerList}">  
                        <option value="${saler.id}" ${saler.id==salerId?'selected':''}>${saler.name}</option>
                   </c:forEach>
				</select>
								
				           </div>
		           <div class="am-hide-sm-only am-u-md-6"></div>
	          </div>
		          
     	  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		            注册时间
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		            <html:text property="regTime" styleClass="Wdate" style="width:100px;height: 39px;" readonly="true"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6"></div>
		  </div>
		  
		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		            更新时间
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		            <html:text property="updateTime" styleClass="Wdate" style="width:100px;height: 39px;" readonly="true"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6"></div>
		  </div>
          
          
          	<div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		             职业
		     	   </div>
				        	<div class="am-u-sm-8 am-u-md-4">
							     <select id="occupationChoice" name="occupationChoice" onchange="changeType(this.value)">
		                        <option value="" >请选择</option>
		                        <c:forEach items="${occuMap}" var="occu">
		                        <option value="${occu.key}"   ${occu.key==occuId?'selected':''}>${occu.value} </option>
		                        </c:forEach>
		                        </select>
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
$(document).ready(function(){
var occuId=$("#occuHidenId").val();
changeType(occuId);
 }
);
function changeType(index)
     {
     if(index==1)
     {
   $("div[name='xuesheng']").remove();
   $("div[name='description']").remove();
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>在职人员</div><div class='am-u-sm-8 am-u-md-4'></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>公司名称</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='companyName' value='${companyName}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>公司地址</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='companyAddr' value='${companyAddr}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>公司电话</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='companyPhone' value='${companyPhone}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>职务</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='position' value='${position}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
     }
     else if(index==3)
     {
  $("div[name='zaizhi']").remove();
  $("div[name='description']").remove();
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>学生</div><div class='am-u-sm-8 am-u-md-4'> </div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>学校名称</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='schoolName' value='${schoolName}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>学校地址</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='schoolAddr' value='${schoolAddr}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>专业</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='professional' value='${professional}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
     }
     else if(index==2||index==4||index==5)
     {
 	 $("div[name='description']").remove();
 	$("#myform").append("<div class='am-g am-margin-top' name='description'><div class='am-u-sm-4 am-u-md-2 am-text-right'>职业描述</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='description' value='${description}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
     $("div[name='zaizhi']").remove();
     $("div[name='xuesheng']").remove();
     }
     else
     {
     $("div[name='zaizhi']").remove();
     $("div[name='xuesheng']").remove();
     }
     
     }
     
     
     function check()
     {
var name=$("#name").val();
var mobliePhone=$("#mobliePhone").val();
if(name==''||mobliePhone=='')
{
	$("#check").text("请输入名称和手机号");
}
else
{

     	
     　$.ajax({
　　　　　　url: '${basePath}/background/CustomerAction.do?method=checkLoginName',
　　　　　　type: 'POST',
　　　　　　data: { name:name, mobliePhone:mobliePhone},
　　　　　　success: function (data) { 
					if(data=='true')
					{
					$("#check").text("该名称已存在");
					}
					else
					{
					$("#check").text("");
					}
				
					}
     });
     
     }
     }
     

function saveInfo() {
	if($('#name').val() == '') {
		alert("请输入客户姓名！");
		$('#name').focus();
		return;
	} else if($('#mobliePhone').val() == '') {
		alert("请输入联系电话！");
		$('#mobliePhone').focus();
		return;
	}
	$("#myform").submit();
}
</script>
