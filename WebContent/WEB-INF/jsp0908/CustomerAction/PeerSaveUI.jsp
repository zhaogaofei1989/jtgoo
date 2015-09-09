<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>用户信息</title>
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
     <script type="text/javascript" src="${basePath}js/artdia	log/artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="${basePath}js/artdialog/iframeTools.js"></script>
    <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
    <link href="${basePath}style/loadingbar/showLoading.css" rel="stylesheet" media="screen" />
     <script type="text/javascript" src="${basePath}js/jquery.showLoading.js"></script>
</head>
<body>
<!-- content start -->
<div class="admin-content">

  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户管理</strong> / <small>${param.id eq null ? '用户信息添加' : '用户信息修改'}</small></div>
  </div>

  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab2">详细描述</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade" id="tab2">
        <html:form styleClass="am-form" styleId="myform" action="background/CustomerAction">
     	<html:hidden property="method" value="${param.id eq null ? 'addPeer' : 'editPeer'}" styleId="myform"/>
    	<html:hidden property="id"/>
		<input type="hidden" id="occuHidenId" value="${occuId}"/>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             用户名
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="userName" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            公司名称
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="companyName" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           公司地址
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="companyAddr" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            公司电话
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="companyPhone" styleClass="am-input-sm"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          
          
           <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		             销售
		     	   </div>
				        	<div class="am-u-sm-8 am-u-md-4">
				<select style="font-size: 12px;" name="salerId" id="salerId">
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
		             同业用户组
		     	   </div>
				  <div class="am-u-sm-8 am-u-md-4">
					<select style="font-size: 12px;" name="peergroupId" id="peergroupId">
					<option value="">请选择</option>
				     <c:forEach var="peerGroup" items="${peerGroupList }">  
                        <option value="${peerGroup.id}" ${peerGroup.id==peergroupId?'selected':''}>${peerGroup.name}</option>
                   </c:forEach>
				</select>
								
				    </div>
		           <div class="am-hide-sm-only am-u-md-6"></div>
	          </div>
          
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            同业价格表(签证)保存后显示
            </div>
            <div class="am-u-sm-8 am-u-md-4">
             <c:if test="${param.id ne null}">
                        <html:button property="regTime" value="设置"  onclick="peer_price_visa(${param.id})"/> <br/><br/>
              </c:if>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            同业价格表(线路)保存后显示
            </div>
            <div class="am-u-sm-8 am-u-md-4">
          		<c:if test="${param.id ne null}">
                           <html:button property="regTime"  value="设置"/> <br/><br/>
                          </c:if>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>

          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             密码
            </div>
            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
            <html:text styleId="passwd" property="mobliePhone" styleClass="input"/> 
            </div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            确认密码
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="confirmPasswd" styleClass="am-input-sm"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          

          
		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		            注册日期
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		              <html:text property="regTime" styleClass="Wdate" style="width:100px;height: 39px;"readonly="true" value="${regTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6"></div>
		  </div>
		  <div class="am-g am-margin-top">
		            <div class="am-u-sm-4 am-u-md-2 am-text-right">
		            更新日期
		            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		              <html:text property="updateTime" styleClass="Wdate" style="width:100px;height: 39px;"readonly="true" value="${regTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/>
		            </div>
		            <div class="am-hide-sm-only am-u-md-6"></div>
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
				           <select style="font-size: 12px;" name="inputName" id="inputNameId">
				 		 	 <option value="">请选择</option>
				     		<c:forEach var="user" items="${salerList}">  
                       		 <option value="${user.name}" ${user.name==inputName?'selected':''}>${user.name}</option>
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
		 <!--          <div class="am-u-sm-4 am-u-md-2 am-text-right">
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
	          </div> -->  
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
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>公司名称</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='companyName' value='${object.companyName}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>公司地址</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='companyAddr' value='${object.companyAddr}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>公司电话</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='companyPhone' value='${object.companyPhone}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='zaizhi'><div class='am-u-sm-4 am-u-md-2 am-text-right'>职务</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='position' value='${object.position}' class='am-input-sm' /></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
     }
     else if(index==3)
     {
  $("div[name='zaizhi']").remove();
  $("div[name='description']").remove();
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>学生</div><div class='am-u-sm-8 am-u-md-4'> </div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>学校名称</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='schoolName' value='${object.schoolName}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>学校地址</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='schoolAddr' value='${object.schoolAddr}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
   $("#myform").append("<div class='am-g am-margin-top' name='xuesheng'><div class='am-u-sm-4 am-u-md-2 am-text-right'>专业</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='professional' value='${object.professional}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
     }
     else if(index==2||index==4||index==5)
     {
 	 $("div[name='description']").remove();
 	$("#myform").append("<div class='am-g am-margin-top' name='description'><div class='am-u-sm-4 am-u-md-2 am-text-right'>职业描述</div><div class='am-u-sm-8 am-u-md-4'> <input type='text' name='description' value='${object.description}' class='am-input-sm'/></div><div class='am-hide-sm-only am-u-md-6'></div></div>");
     $("div[name='zaizhi']").remove();
     $("div[name='xuesheng']").remove();
     }
     else
     {
     $("div[name='zaizhi']").remove();
     $("div[name='xuesheng']").remove();
     }
     
     }
     
   
    function peer_price_visa(id)
    {
    art.dialog.open('CustomerAction.do?method=peerPriceSetingVisaUI&peerId='+id,
{
    title: '同行价格表设置',
    width: 850,
    height: 640,
    left: '50%',
    top: '6%',
    lock:true,
    cancel: function()
    {
    this.close();
    }
});
    
    }
    
    
 function addCu(id,userType)
    {
art.dialog.open('CustomerServicersAction.do?method=list&peerId='+id+'&userType='+userType,
{
    title: '添加联系人',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    this.close();
    }
});
    }
    

    
function showName(id)
{
art.dialog.open('CustomerServicersAction.do?method=showNameUI&id='+id,
{
    title: '联系人信息',
    width: 800,
    height: 640,
    left: '50%',
    top: '10%',
    lock:true
});
}

function saveInfo()
{
$("#myform").submit();
}

//添加并继续
function savePeerAndGoOn()
{

$("#methodId").val("savePeerAndGoOn");
if(validate())
{

$("#myform").submit();
}

}

function validate()
{
var userName=$("#userName").val();
if(userName==null||userName.length==0)
{
$("#userNameLabel").text("该字段不能为空");
return false;
}
jQuery('#InputDetailBar').showLoading();
return true;
}
    </script>


    
    