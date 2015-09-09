<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js">
<head>
	<title>签证领区设置</title>
	
    <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
    <script type="text/javascript" src="${basePath}js/jquery.autocomplete.js"></script>

<link rel="stylesheet" type="text/css" href="${basePath}style/blue/jquery.autocomplete.css"></link>
<script type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
 
</head>
<body>
<!-- content start -->
<div class="admin-content">
        <html:form styleClass="am-form" action="background/VisaOrderAction" styleId="myform">

  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签证订单</strong> / <small>${param.id eq null ? '签证订单添加' : '签证订单修改'}</small></div>
  </div>
  <div class="am-tabs am-margin" data-am-tabs>
    <ul class="am-tabs-nav am-nav am-nav-tabs">
      <li><a class="am-active" href="#tab">详细描述</a></li>
		<c:if test="${0 le status }">
     	 <li><a class="am-active" href="#tab0">未审核</a></li>
		</c:if>
		<c:if test="${1 le status }">
	      <li><a class="am-active" href="#tab1">已预定</a></li>
		</c:if>
		<c:if test="${2 le status }">
	      <li><a class="am-active" href="#tab2">已收到材料</a></li>
		</c:if>
		<c:if test="${3 le status }">
	       <li><a class="am-active" href="#tab3">已审核</a></li>
		</c:if>
		<c:if test="${4 le status }">
	   <li><a class="am-active" href="#tab4">已预约</a></li>
		</c:if>
		<c:if test="${5 le status }">
	          <li><a class="am-active" href="#tab5">已面试/送签</a></li>
		</c:if>
		<c:if test="${6 le status }">
	      <li><a class="am-active" href="#tab6">已出签</a></li>
		</c:if>
		<c:if test="${7 le status }">
	   <li><a class="am-active" href="#tab7">已寄回</a></li>
		</c:if>
		<c:if test="${8 le status }">
	       <li><a class="am-active" href="#tab8">已完成</a></li>
		</c:if>
		<c:if test="${9 le status }">
	          <li><a class="am-active" href="#tab9">已付款</a></li>
		</c:if>

 
    
 
    
     
   

    </ul>
    <div class="am-tabs-bd">
      <div class="am-tab-panel am-fade am-form" id="tab">
		<html:hidden property="method" value="${param.id eq null ? 'add' : 'edit'}" styleId="methodId"/>
    	<html:hidden styleId="visaorderId" property="id"/>
    	
         <html:hidden styleId="status" property="status" value="${status}"/>
         <html:hidden property="serialnumber"/> 
         <!-- 避免保存数据  actionform中没有      -->
    	<html:hidden property="user1"/>
    	<html:hidden property="user2"/>
    	<html:hidden property="user3"/>
    	<html:hidden property="user4"/>
    	<html:hidden property="user5"/>
    	<html:hidden property="user6"/>
    	<html:hidden property="user7"/>
    	<html:hidden property="user8"/>
    	<html:hidden property="user9"/>
    	<html:hidden property="user10"/>
  	 	<!--客服ID  -->
    	<html:hidden styleId="customServiceId" property="customServiceId"/>
    	<!-- 客户ID -->
    	<html:hidden styleId="customerId" property="customerId"/>
    	<input type="hidden" id="hidden_user_name" name="hidden_user_name" value="${hidden_user_name }">
    	<html:hidden styleId="visaProductId" property="visaProductId" value="${visaProductId }"/>
    	<!-- 提交表单时，验证产品的名称和id  是否 一直 -->
    	<input  type="hidden" id="visaProductName" property="visaProductName" value="${ visaProductName}"/>
    	<input type="hidden" id="userType" value="${customer_userType }"/>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            签证产品
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           <style type="text/css">
				            .content_div{ margin-top:0px; font-size:16px; position:relative; }
				            #search_divvisa_id{ position:relative; top:0px; border:1px solid #dfdfdf; text-align:left; padding:1px; left:0px;*left:0px; width:263px;*width:260px; background-color:#FFF; display:none; font-size:12px; height:100px; overflow-y:scroll;}
				            #search_divvisa_id li{ line-height:24px;cursor:pointer}
				            #search_divvisa_id li a{  padding-left:6px;display:block}
				            #search_divvisa_id li a:hover, #search_divvisa_id li:hover{ background-color:#e2eaff}
			</style>
				             <div class="content_div">
				                        <html:text styleId="name"  property="name" onfocus="if(this.value == this.defaultValue) this.value = ''" onblur="if(this.value.replace(' ','') == '') this.value = this.defaultValue;"/>
				                              <ul id="search_divvisa_id"></ul>
				                              </div>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           用户类型
            </div>
            <div class="am-u-sm-8 am-u-md-4">
					                       同业用户
					                       <html:radio property="customer_userType" styleId="tradeUser" value="0" onclick="alter(this.value)"  style="width:60px;"/>
					                       直接用户<html:radio property="customer_userType" styleId="directUser"  value="1" onclick="alter(this.value)" style="width:60px;"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top" id="cus_1">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             用户名
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <style type="text/css">
												            .userNameDiv{ margin-top:0px; font-size:14px; position:relative; }
												            #search_div_username_id{ position:relative; top:0px; border:1px solid #dfdfdf; text-align:left; padding:1px; left:0px;*left:0px; width:263px;*width:260px; background-color:#FFF; display:none; font-size:12px; height:100px; overflow-y:scroll;}
												            #search_div_username_id li{ line-height:24px;cursor:pointer}
												            #search_div_username_id li a{  padding-left:6px;display:block}
												            #search_div_username_id li a:hover, #search_div_username_id li:hover{ background-color:#e2eaff}
												            </style>
												             <style type="text/css">
												            .customerServiceDiv{ margin-top:0px; font-size:14px; position:relative; }
												            #search_div_customService_id{ position:relative; top:0px; border:1px solid #dfdfdf; text-align:left; padding:1px; left:0px;*left:0px; width:263px;*width:260px; background-color:#FFF; display:none; font-size:12px; height:100px; overflow-y:scroll;}
												            #search_div_customService_id li{ line-height:24px;cursor:pointer}
												            #search_div_customService_id li a{  padding-left:6px;display:block}
												            #search_div_customService_id li a:hover, #search_div_customService_id li:hover{ background-color:#e2eaff}
												            </style>
											                       <div id="userNameDiv"> 
											                       <html:text property="tradeUserForm" onfocus="if(this.value == this.defaultValue) this.value = ''" onblur="if(this.value.replace(' ','') == '') this.value = this.defaultValue;" styleId="userName" styleClass="InputStyle"/> 
											                       <ul id="search_div_username_id"></ul>
											                       </div>
											                       <div id="customerServiceDiv">
											                       
											                       
											           联系人:
											            <select name="customerServicerId" id="customerServicerId">
				                      				    <option selected="selected" value="">请选择</option>
											            <c:forEach var="customVo" items="${customerServiceSet}">
				                      				   <option value="${customVo.id}" ${customVo.id==customerServiceId?'selected':''}>${customVo.name}</option>
				                      				   </c:forEach>
											            </select>
											                </div>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
          <div class="am-g am-margin-top" id="cus_2">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             用户姓名：
            </div>
            <div class="am-u-sm-8 am-u-md-4">
           <style>
									            .customernameDiv{ margin-top:0px; font-size:14px; position:relative; }
									            #search_div_customername_id{ position:relative; top:0px; border:1px solid #dfdfdf; text-align:left; padding:1px; left:0px;*left:0px; width:263px;*width:260px; background-color:#FFF; display:none; font-size:12px; height:100px; overflow-y:scroll;}
									            #search_div_customername_id li{ line-height:24px;cursor:pointer}
									            #search_div_customername_id li a{  padding-left:6px;display:block}
									            #search_div_customername_id li a:hover, #search_div_customername_id li:hover{ background-color:#e2eaff}
									            </style>
					                        <div id="customernameDiv">
					                        <html:text property="directUserForm" onfocus="if(this.value == this.defaultValue) this.value = ''" onblur="if(this.value.replace(' ','') == '') this.value = this.defaultValue;" styleId="customername" styleClass="InputStyle"/> 
					                        <ul id="search_div_customername_id"></ul>
											</div>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          </div>
  	  	</div>
              <div class="am-tab-panel am-fade" id="tab0">
              <fieldset>
              <legend>状态:未审核</legend>
              <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            预定时间
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <div class="am-input-group am-datepicker-date" data-am-datepicker="{format: 'yyyy-mm-dd', viewMode: 'years'}">
			      <html:text property="scheduledtime" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-btn am-datepicker-add-on">
			    <button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>
			  </span>
			</div>
            
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            接单人(销售):
            </div>
            <div class="am-u-sm-8 am-u-md-4">
              <select name="single" id="single" >
                        <option selected="selected" value="">请选择</option>
                         <c:forEach var="user" items="${userList }">  
                        <option value="${user.name}" ${user.name==single?'selected':''}>${user.name}</option>
                        </c:forEach>
               </select>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab1">
   			<fieldset>
              <legend>状态:已预订</legend>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            预定时间
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            
              <div class="am-input-group date form_datetime-3">
		 	 <html:text property="receivedDataTime1" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
			  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
				</div>
           
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	    <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user2" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab2">
              <fieldset>
              <legend>状态:已收到材料</legend>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
               收到材料时间
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            
              <div class="am-input-group am-datepicker-date" data-am-datepicker="{format: 'yyyy-mm-dd', viewMode: 'years'}">
			      <html:text property="receivedDataTime2" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-btn am-datepicker-add-on">
			    <button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>
			  </span>
			</div>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	 <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            材料特殊要求:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:textarea styleClass="TextareaStyle" property="supplementData"/>
                			      <br/><br/>
    				  <c:if test="${param.id ne null }"><input type="button" onclick="uploadInfo()" class="am-btn am-btn-default am-round" value="上传客户资料清单"/></c:if><br/> <br/> <div  id="cusArray" ><c:forEach items="${cusDatList}" var="cusDat"><label style="font-weight:bolder;" onclick='showCustomerName(${visaProductId},${cusDat.customerId})'>${cusDat.customerName}</label>&nbsp;</c:forEach>
    				  </div>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
          	   	    <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user3" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab3">
             <fieldset>
              <legend>状态:已审核</legend>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             出发日期:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <div class="am-input-group date form_datetime-3">
		  <html:text property="receivedDataTime3" styleClass="am-form-field" readonly="true"/>
		  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
		  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
			</div>

            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
            
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             操作员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <select name="operator" id="operator" class="SelectStyleSecond">
                        <option selected="selected" value="">请选择</option>
                         <c:forEach var="user" items="${userList }">  
                        <option value="${user.name}" ${user.name==operator?'selected':''}>${user.name}</option>
                        </c:forEach>
             </select>
                      
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
          	
       	 <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                        <input type="button" value="增加已补充资料" class="am-btn am-btn-default am-round" onclick="addData()" />
                        <input type="hidden" id="count" value="1"/>
            </div>
            <div class="am-u-sm-8 am-u-md-4">
              <div id="d1">已补充资料一: <html:text property="data1" styleClass="InputStyle"/>
                <br/>   
                   <div class="am-input-group date form_datetime-3">
		  <html:text property="datatime1" styleClass="am-form-field" readonly="true"/>
		  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
		  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
			</div>
              
</div>
                        <div id="d2">已补充资料二: <html:text property="data2" styleClass="InputStyle"/>
                        <br/>   
                   <div class="am-input-group date form_datetime-3">
			  <html:text property="datatime2" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
			  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
				</div>
                         </div>
                        <div id="d3">已补充资料三: <html:text property="data3" styleClass="InputStyle"/>    
                        <br/>   
                          <div class="am-input-group date form_datetime-3">
			  <html:text property="datatime3" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
			  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
				</div></div>
                        <div id="d4">已补充资料四: <html:text property="data4" styleClass="InputStyle"/> 
                        <br/>   
                         <div class="am-input-group date form_datetime-3">
			  <html:text property="datatime4" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
			  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
				</div></div>
                        <div id="d5">已补充资料五: <html:text property="data5" styleClass="InputStyle"/>  
                        <br/>
                           <div class="am-input-group date form_datetime-3">
			  <html:text property="datatime5" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
			  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
				</div></div>
           	 </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
       	 <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                 资料已全: 
            </div>
            <div class="am-u-sm-8 am-u-md-4">
                  否:<html:radio property="dataIsComplete"  value="0"/> 是:<html:radio property="dataIsComplete" value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
       	 <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                补充材料:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
                 <select name="sentToSignPeople" id="sentToSignPeople" class="SelectStyleSecond">
                        <option selected="selected" value="">请选择</option>
                         <c:forEach var="user" items="${userList }">  
                        <option value="${user.name}" ${user.name==sentToSignPeople?'selected':''}>${user.name}</option>
                        </c:forEach>
                        </select>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
       	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                出境方式:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
              单次:<html:radio property="oneToManySelect"  value="0"/> 多次:<html:radio property="oneToManySelect" value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
       	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                 是否代买保险:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
               是: <html:radio property="buyInsurance"  value="0"/> 否:<html:radio property="buyInsurance" value="1"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
       	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                 保险备注:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:textarea styleClass="TextareaStyle" property="insuranceRemarks"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
          	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user4" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab4">
             <fieldset>
              <legend>状态:已预约</legend>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           面试时间:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
             <div class="am-input-group date form_datetime-3">
			  <html:text property="interviewTime" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
			  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
				</div>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user5" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab5">
                <fieldset>
              <legend>状态:已面试/送签</legend>
       		
       		 <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                送签人员
            </div>
            <div class="am-u-sm-8 am-u-md-4">
                 <select name="sentToSignPeople" id="sentToSignPeople" class="SelectStyleSecond" style="width:85px;">
                        <option selected="selected" value="">请选择</option>
                         <c:forEach var="user" items="${userList }">  
                        <option value="${user.name}" ${user.name==sentToSignPeople?'selected':''}>${user.name}</option>
                        </c:forEach>
                        </select>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	 <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           送签备注
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:textarea styleClass="TextareaStyle" property="sendToRemark"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
       		
       		   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user6" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
       		
              </fieldset>
              
              
              </div>
              <div class="am-tab-panel am-fade" id="tab6">
         <fieldset>
              <legend>状态:已面试/送签</legend>
        <c:forEach items="${cusDatList}" var="cusDat">
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           <label style="font-weight:bolder;" onclick='showCustomerName(${visaProductId},${cusDat.customerId})'>${cusDat.customerName}</label>&nbsp;
            </div>
		            <div class="am-u-sm-8 am-u-md-4">
		             <select name="visaResult[${cusDat.id }]">
					<c:choose>
						<c:when test="${cusDat.status==1}">
						<option selected="selected" value="1">通过</option>
						<option value="0">拒绝</option>
						</c:when>
						<c:when test="${cusDat.status==0}">
						<option selected="selected" value="0">拒绝</option>
						<option value="1">通过</option>
						</c:when>
			  			 <c:otherwise>
						<option selected="selected"></option>
						<option value="0">拒绝</option>
						<option value="1">通过</option>
						</c:otherwise>
						</c:choose>
					</select>
							
		            </div>
           			 <div class="am-hide-sm-only am-u-md-6">
           				 <c:if test="${cusDat.status==0}">
							  <label onclick="refusedVisaResult(${cusDat.id})">拒签原因-修改</label>
							<br/> <br/>
							
					     <span id="reason_${cusDat.id}">  拒绝原因:${cusDat.reason }</span>
							  <br/> <br/>
						  <span id="analysis_${cusDat.id}">   问题分析:${cusDat.analysis }</span>
							<br/> <br/>
					      <span id="results_${cusDat.id}">    处理结果:${cusDat.results }</span>
							  </c:if>
           			 </div>
          	</div>
           		</c:forEach>
           		   	
          	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user7" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab7">
               <fieldset>
              <legend>状态:已寄回</legend>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            护照返还方式:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <select name="passportReturnMethod" id="passportReturnMethod" onchange="changeMethod(this.value)" class="SelectStyleSecond">
											                         <c:forEach var="passportMethod" items="${passportMethodList }">  
											                        <option value="${passportMethod.key}" ${passportMethod.key eq passportReturnMethod?'selected':''}>${passportMethod.value}</option>
											                        </c:forEach>
            </select>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top" id="receiver_tr">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
           领取人:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="receiver" property="receiver" />
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top" id="receiverPhone_tr">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             领取人电话:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="receiverPhone" property="receiverPhone" /> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top" id="receiverDate_tr">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             领取时间:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
                <div class="am-input-group date form_datetime-3">
			  <html:text property="passportGetTime" styleClass="am-form-field" readonly="true"/>
			  <span class="am-input-group-label add-on"><i class="icon-remove am-icon-close"></i></span>
			  <span class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
				</div>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top" id="expressMethod_tr">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             快递方式:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="expressMethod" property="expressMethod" styleClass="InputStyle"/> 
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            快递公司:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="express" property="express" styleClass="InputStyle"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             收件人:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="expressContact" property="expressContact" styleClass="InputStyle"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             联系方式:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="expressContactInformation" property="expressContactInformation" styleClass="InputStyle"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
             快递地址:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="expressAddress" property="expressAddress" styleClass="InputStyle"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	   	
          	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user8" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab8">
                  <fieldset>
              <legend>状态:已完成</legend>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            上传操作资料
            </div>
            <div class="am-u-sm-8 am-u-md-4">
          	  <input type="button" class="am-btn am-btn-default am-round" value="上传资料" onclick="upload(${param.id })"/>   
                    	
            </div>
            <div class="am-hide-sm-only am-u-md-6">
            <c:if test="${!empty attchment}">
                    	<div id="zipData">
	                   <html:link target="_blank" action="/background/VisaOrderAction.do?method=download&orderId=${orderId}">
	                  	${attchment.name}&nbsp;
	                  </html:link>
	                  </div>
                        </c:if>
            </div>
          	</div>
          	   	
          	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user9" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              </fieldset>
              </div>
              <div class="am-tab-panel am-fade" id="tab9">
                  <fieldset>
              <legend>状态:已付款</legend>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            付款金额
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text styleId="payForAmount" property="payForAmount"  />
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
             <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            付款时间
            </div>
            <div class="am-u-sm-8 am-u-md-4">
            <html:text property="payForTime" styleClass="Wdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
          	
          	   <div class="am-g am-margin-top">
            <div class="am-u-sm-4 am-u-md-2 am-text-right">
            输入人员:
            </div>
            <div class="am-u-sm-8 am-u-md-4">
		 	 <html:text property="user10" styleClass="am-form-field" readonly="true"/>
            </div>
            <div class="am-hide-sm-only am-u-md-6"></div>
          	</div>
              </fieldset>
              </div>
    
    </div>
  </div>
  <div class="am-margin" id="InputDetailBar">
            <input id="save" type="submit" class="am-btn am-btn-primary am-btn-xs"" value="保存" onclick="return validate()"/>
            <input type="button" class="am-btn am-btn-primary am-btn-xs" id="saveGoOn"  onclick="return saveAndGoOn();"  value="保存并继续" />
            <input type="button" class="am-btn am-btn-primary am-btn-xs" id="saveAndClose"  onclick="return editAndClose();"  value="保存并关闭" />
            <input type="button" class="am-btn am-btn-primary am-btn-xs" id="next"  onclick="nextOrBack(0)"  value="下一步" />
           <!-- <input type="button" class="am-btn am-btn-primary am-btn-xs" id="back" onclick="nextOrBack(1)"  value="上一步" /> --> 
  </div>
          </html:form>
</div>
<!-- content end -->
<!--[if (gte IE 9)|!(IE)]><!-->
<script language="javascript" src="${basePath}js/jquery-1.7.js"  charset="utf-8"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>

<script language="javascript" src="${basePath}/script/jquery_validate/jquery.validate.js"></script>
<script language="javascript" src="${basePath}/script/jquery_validate/jquery.metadata.js"></script>
<link href="${basePath}style/loadingbar/showLoading.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${basePath}js/jquery.showLoading.js"></script>
 <script src="${basePath}js/amazeui/amazeui.datetimepicker.js"></script>
 <link rel="stylesheet" type="text/css" href="${basePath}js/amazeui/css/amazeui.datetimepicker.css"></link>
<script type="text/javascript">
  $(function() {
    $('.form_datetime-3').datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        autoclose: true,
        todayBtn: true,
        startDate: '2015-02-14 14:45',
        minuteStep: 10
    });
  });
</script>
<script src="${basePath}js/amazeui/app.js"></script>
</body>
</html>
<script type="text/javascript">
  $(function(){
  			//界面验证
  			//禁止name属性缓存
  			    document.getElementById("name").autocomplete="off";
			    document.getElementById("userName").autocomplete="off";
			    document.getElementById("customername").autocomplete="off";
				validateUI();
			//隐藏数据
		
		});
		
		
//界面表单验证
function validateUI()

{
 $("#myform").validate({
 	onsubmit:true,// 是否在提交是验证 
	onfocusout:false,// 是否在获取焦点时验证 
	onkeyup :false,// 是否在敲击键盘时验证 
        rules: {
            name:{
            		 required: true
            		 },
       		 },
        	messages: 
			{
			 name: {
					required: "不能为空",
					  }
			},
			submitHandler: function(form) { 
			
			var vpId=$("#visaProductId").val();
			if(vpId==='')
			{
			alert("该签证产品不存在，请重新查询！");
			return false;
			}
			//检测  签证产品的真实性
			var vpName=$("#visaProductName").val().replace(/(^\s+)|(\s+$)/g, "");
			var name=$("#name").val().replace(/(^\s+)|(\s+$)/g, "");
			if(vpName!==name)
			{
			alert("该签证产品不存在，请重新查询！");
			return false;
			}
			//检测同业用户 直接用户的真实性
		    var customer_userType = $('input:radio[name="customer_userType"]:checked').val();
			
			//同业用户，用户名不能为空
			if(customer_userType==="0")
			{
			//userName
			  var userName=$("#userName").val();
			  if(userName==='')
			  {
				 alert("用户信息不能为空！");
				 return false;
			  }
			 var hidden_user_name=$("#hidden_user_name").val();
			if(hidden_user_name==='')
			{
		    alert("用户信息不能为空！");
			return false;
			}	
			  
			if(userName!=hidden_user_name)
			{
			alert("该用户不存在，请重新查询！");
			return false;
			}
			}
			//直接用户(包含会员)
			else if(customer_userType==="1")
			{
			 var customername=$("#customername").val().replace(/(^\s+)|(\s+$)/g, "");
			 if(customername==='')
			 {
		    alert("用户信息不能为空！");
			return false;
			 }
		  var hidden_user_name=$("#hidden_user_name").val().replace(/(^\s+)|(\s+$)/g, "");
			if(hidden_user_name==='')
			{
		    alert("用户信息不能为空！");
			return false;
			}	
				  
			if(customername!=hidden_user_name)
			{
			alert("该用户不存在，请重新查询！");
			return false;
			}	    
			
			
			
	}
	
	
	//ajax 请求,用户在保存的情况下可能会切换用户类型，导致用户信息不一致，因此需要在提交前检测一下类型，防止类型和用户信息不一致的情况
	
			$("#InputDetailBar").showLoading(); 
	
			//#######
			form.submit();
			},
			 invalidHandler: function(form, validator) {  //不通过回调 
			 return false; 
          } ,
			
    });

}

		
		
  //添加已补充资料
function addData()
{
var count=$("#count").val();
if(count==1)
{
$("#d2").show();
$("#count").val("2");
}
else if(count==2)
{
$("#d3").show();
$("#count").val("3");
}
else if(count==3)
{
$("#d4").show();
$("#count").val("4");
}
else if(count==4)
{
$("#d5").show();
$("#count").val("5");

}


}
  
//拒签原因

function refusedVisaResult(cusDatId)
{

art.dialog.open('CustomerAction.do?method=refusedVisaResultUI&id=${cusDat.id}'+cusDatId,
{
    title: '拒签原因',
    width: 800,
    height: 340,
    left: '50%',
    top: '10%',
    lock:true,
     ok: function()
    {
		  var d=this.iframe.contentDocument;
		  var reason=d.getElementById("reason").value;
	      var analysis=d.getElementById("analysis").value;
		  var results=d.getElementById("results").value;
		   $.ajax({
			 dataType: "json",
			 url: "CustomerAction.do?method=refusedVisaResult&id="+cusDatId+"&reason="+reason+"&analysis="+analysis+"&results="+results, 
			 success: function(msg){
			 $("#reason_"+msg.id).text(msg.reason);
			 $("#analysis_"+msg.id).text(msg.analysis);
			 $("#results_"+msg.id).text(msg.results);
			 }});
		   
    },
    cancel:function()
    {
    this.close();
    }
    });

}
function  editAndClose()
{
$("#methodId").val("saveAndClose");
if(validate())
{
$("#myform").submit();
}
}
//添加并继续
function saveAndGoOn()
{
$("#methodId").val("saveAndGoOn");
if(validate())
{
$("#myform").submit();
}
}




function showVisaResult(visaorderId)
{
art.dialog.open('CustomerAction.do?method=updateVisaResultUI&visaorderId='+visaorderId,
{
    title: '签证结果设置',
    width: 800,
    height: 340,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {

    }
  
}

);

}


function nextOrBack(value)
{
var status=$("#status").val();
if(value==0)
{
if(status==9)
{
alert("订单已完成!");
return false;
}
else
{
$("#methodId").val("savaNextUI");
}
}
else
{
$("#methodId").val("savaBackUI");
}
$("#myform").submit();

}
function changeMethod(value)
{
//快递 1  申请人2
if(value==1)
{
$("#receiver_tr").hide();
$("#receiverDate_tr").hide();
$("#receiverPhone_tr").hide();
$("#expressMethod_tr").show();
$("#receiver").val("");
$("#receiverDate").val("");
$("#receiverPhone").val("");


}
else if(value==2)
{
$("#receiver_tr").show();
$("#receiverDate_tr").show();
$("#receiverPhone_tr").show();
$("#expressMethod_tr").hide();
$("#expressMethod").val("");
}
}


//验证是否有空,由于 jquery.autocomplete.js 和jquery.validate.js 有冲突，因此去掉validate验证，改为自己编写进行验证

function validate()
{
var name=$("#name").val();
var tradeUser=$("#tradeUser").attr('checked');
var directUser=$("#directUser").attr('checked');
var userName=$("#userName").val();
var customername=$("#customername").val();
if(!name && typeof(name)!="undefined" && name!=0)
{
$("#name").parent().append("<font color='red'>该字段不能为空</font>");
return false;
}
if(tradeUser=='checked')
{
if(!userName && typeof(userName)!="undefined" && userName!=0)
						{
						$("#userNameDiv").append("<font color='red'>该字段不能为空</font>");
						return false;
						}
}
else if(directUser=='checked')
{if(!customername && typeof(customername)!="undefined" && customername!=0)
				
				{
				  $("#customernameDiv").append("<font color='red'>该字段不能为空</font>");
						return false;
				}
}
//jQuery('#table').showLoading();
return true;
}



//上传压缩文件的dialog
function upload(id)
{
art.dialog.open('../background/VisaOrderAction.do?method=uploadUI&id='+id,
{
    title: '上传压缩文件夹',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    	 var d=this.iframe.contentDocument;
    	 var orderId= d.getElementById("orderId").value;
    	 if(orderId!=="")
    	 {
    	   $.ajax({
			 dataType: "json",
			 url: "AttachmentAction.do?method=getJSONInfo&id="+orderId, 
			 success: function(msg){
			 $("#zipData").html("<a href='/jtgooCMS/background/VisaOrderAction.do?method=download&orderId="+orderId+"' target='_blank'>"+msg.name+"</a>");
			 }});
    	  
    	 }
    	 
    	
    }
  
}

);
}
//选择是同业用户还是普通用户
function alter(value)
{
if(value==0)
{
$("#cus_1").show();
$("#cus_2").hide();
$("#tradeUser").attr('checked',true );
$("#userType").val("0");
}
else 
{
$("#cus_1").hide();
$("#cus_2").show();
$("#directUser").attr('checked',true );
$("#userType").val("1");
}

}

//============================================
function showCustomerName(visaProductId,cuid)
{
art.dialog.open('CustomerAction.do?method=showCustomerNameDetailUI&visaProductId='+visaProductId+'&customerId='+cuid,
{
    title: '其他信息',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    lock:true,
    ok: function()
    {
    },
    cancel: function()
    {
    this.close();
    }
});
}


//============================================

function uploadInfo()
{
var visaProductId =$("#visaProductId").val();
var visaorderId = $("#visaorderId").val();
art.dialog.data('visaProductId', visaProductId);
art.dialog.data('visaorderId', visaorderId);
/**
*art.dialog.data('test', val);
*/
art.dialog.open('CustomerAction.do?method=customerUI&visaProductId='+visaProductId+'&visaorderId='+visaorderId,
{
    title: '添加资料清单',
    width: 800,
    height: 240,
    left: '50%',
    top: '10%',
    cancel:false,
    lock:true,
    
    ok: function()
    {
  var win = art.dialog.open.origin;
$.ajax({
 dataType: "json",
 url: "CustomerAction.do?method=getAllCustomerName&visaorderId="+visaorderId, 
 success: function(msg){
 var cusArr=msg.Items;
 // <label style="font-weight:bolder;" onclick='showCustomerId(${visaOrder.visaProduct.id },${customer.id})'>${customer.name}</label>&nbsp;
 if(msg.Items!=null&&msg.Items.length>0)
 {
 win.$("#cusArray").text("");
 for(var i=0;i<msg.Items.length;i++)
 {
 var obj=msg.Items[i];
 win.$("#cusArray").append("<label style='font-weight:bolder;' onclick='showCustomerName("+obj.visaProductId+","+obj.customerId+")'>"+obj.name+"</label>&nbsp;");
 }}
 }});


    this.close();
    }
});
}

//==============================================



//=============================================
//签证产品 属性设置
 function setvaluevisa_id(title,id)
                {
                    $("#name").val(title);
                    $("#visaProductName").val(title);
                    $("#visaProductId").val(id);
                    $('#search_divvisa_id').hide();
                }
//直接用户属性设置
 function search_username_id(title,id,customerServiceArr)
                {
                if(customerServiceArr!='')
                {
               $("#customerServicerId").empty();
                var cs_string=customerServiceArr.substring(0,customerServiceArr.length-1);
               	var csarray=cs_string.split("|");
               	$("#customerServicerId").append("<option value=''>请选择</option>");
               	for(var i=0;i<csarray.length;i++)
               	{
               	var option="<option value='"+csarray[i].split(",")[0]+"'>"+csarray[i].split(",")[1]+"</option>";
               	$("#customerServicerId").append(option);
               	}
                
                }
            
               $("#userName").val(title);
               $("#hidden_user_name").val(title);
               $("#customerId").val(id);
               $('#search_div_username_id').hide();
                }
  //同业用户属性设置                 
 function search_customername_id(title,id,customerId)
                {
                    $("#customername").val(title);
                    $("#hidden_user_name").val(title);
                   $("#customerId").val(id);
                    $('#search_div_customername_id').hide();
                }
                
    //客服(联系人属性设置)
 function search_customService_id(title,id)
                {
                    $("#customService").val(title);
                    $("#customServiceId").val(id);
                    $('#search_div_customService_id').hide();
                }
                   
      
function  visa_id_search_ajax(){
				var value =$("#name").val();
				if (value.length > 0){
								
								$.ajax({  
				               	    url: 'VisaAutoComplete.do',  
				               		type: 'POST',
				               		dataType : 'json',
				                    data : {
				                    q:value
											},
								success : function(data, textStatus, jqXHR) {
																					if (data != null) 
																					{
																						var str = '';
																							$.each(data.obj, function(i,n){
																								str += '<li onclick=\'setvaluevisa_id("'+n.label+'","'+n.id+'");\'>'+n.label+'</li>';
																							});
																						$('#search_divvisa_id').html(str);
																						$('#search_divvisa_id').show();
																					} else 
																						{
																							$('#search_divvisa_id').hide();
																						}
																						
											}											
																						
									});
									
				} 
				else {
					$('#search_divvisa_id').hide();
				} 
}
function  username_search_ajax(){

				var value =$("#userName").val();
				var userType =$("#userType").val();
				if (value.length > 0){


				
					$.ajax({  
				               	    url: 'UserNameAutoComplete.do',  
				               		type: 'POST',
				               		dataType : 'json',
				                    data : {
				                    q:value,
				                    userType:userType
				                    
											},
								success : function(data, textStatus, jqXHR) {
						if (data != null) {
							var str = '';
							$.each(data.obj.customers, function(i,n){
							
								var customerServiceArr='';
									$.each(n.customerservices, function(j,m){
									customerServiceArr+=m.id+","+m.value+'|';
								});
							
								str += '<li onclick=\'search_username_id("'+n.label+'","'+n.id+'","'+customerServiceArr+'");\'>'+n.label+'</li>';
							});
					
							$('#search_div_username_id').html(str);
							$('#search_div_username_id').show();
						} else {
							$('#search_div_username_id').hide();
						}
					}
					}
					);
				} else {
					$('#search_div_username_id').hide();
				} 
}
     
function  customService_search_ajax(){
				var value =$("#customService").val();
				if (value.length > 0){
					$.getJSON('CustomerServicersAutoComplete.do',{q:value},  function(data){
						if (data != null) {
							var str = '';
							$.each(data.obj, function(i,n){
								str += '<li onclick=\'search_customService_id("'+n.label+'","'+n.id+'");\'>'+n.label+'</li>';
							});
							$('#search_div_customService_id').html(str);
							$('#search_div_customService_id').show();
						} else {
							$('#search_div_customService_id').hide();
						}
					});
				} else {
					$('#search_div_customService_id').hide();
				} 
}
function  customername_search_ajax(){
				var value =$("#customername").val();
				var userType =$("#userType").val();
				if (value.length > 0){
				
					$.ajax({  
				               	    url: 'UserNameAutoComplete.do',  
				               		type: 'POST',
				               		dataType : 'json',
				                    data : {
				                    q:value,
				                    userType:userType
										},
								success : function(data, textStatus, jqXHR) {
				
						if (data != null) {
							var str = '';
							$.each(data.obj.customers, function(i,n){
								str += '<li onclick=\'search_customername_id("'+n.label+'","'+n.id+'","'+n.customer+'");\'>'+n.label+'</li>';
							});
							$('#search_div_customername_id').html(str);
							$('#search_div_customername_id').show();
						} else {
							$('#search_div_customername_id').hide();
						}
						}
					});
				} else {
					$('#search_div_customername_id').hide();
				} 
}
     

     
     
//==============================================



$(document).ready(function(){


//===========================================
$('#name').keyup(function(){
					 visa_id_search_ajax();
				});
				
$('#userName').keyup(function(){
					 username_search_ajax();
				});				
				
$('#customService').keyup(function(){
					 customService_search_ajax();
				});				
				
$('#customername').keyup(function(){
					 customername_search_ajax();
				});				
				
				
//============================================
   									  
  


      
      
      
      
      
      
      
      //=============================================
      //===========================================
var id=$("#visaorderId").val();
if(id==null||id=="")
{
$("#next").hide();
$("#back").hide();
$("#saveAndClose").hide();
}
else
{
$("#saveGoOn").hide();
}
//====================================================
var passportReturnMethod=$("#passportReturnMethod option:selected").val();
if(passportReturnMethod==null||passportReturnMethod=="")
{
$("#expressMethod_tr").hide();
$("#receiver_tr").hide();
$("#receiverDate_tr").hide();
$("#receiverPhone_tr").hide();
}
else if(passportReturnMethod==1)
{
$("#expressMethod_tr").show();
$("#receiver_tr").hide();
$("#receiverDate_tr").hide();
$("#receiverPhone_tr").hide();

}
else if(passportReturnMethod==2)
{
$("#expressMethod_tr").hide();
$("#receiver_tr").show();
$("#receiverDate_tr").show();
$("#receiverPhone_tr").show();
}
	//=============================================================
	var tradeUser=$("#tradeUser").attr("checked");
	var directUser=$("#directUser").attr("checked");
	
	if(tradeUser=="checked")
	{
	$("#cus_2").hide();
	}
	else if(directUser=="checked")
	{
	$("#cus_1").hide();
	}
	//=============================================================
	// 隐藏一
    var tr_length=$("[id^=tr_]").size();
    for(var i=0;i<tr_length;i++)
    {
    if(i>$("#status").val())
    {
     $("#tr_"+i).hide();
    }
     }
  });
  


</script>
