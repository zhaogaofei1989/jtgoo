<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="${basePath}static/js/jquery-1.7.2.js"></script>
<script src="${basePath}static/js/jtgooutils.js"></script>
<link rel="stylesheet" type="text/css" href="${basePath}static/layout/style.css"/>
<script type="text/javascript" src="${basePath}static/js/layer/layer.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${basePath}static/layout/style.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}style/fenxiao/style_view.css" />
    <title>签证产品查看</title>
</head>

<body>
	<div class="top">
    	<img src="${basePath}style/images/logo_header.gif">
    	<p class="top_title">
        	<b>签证中心</b>
        	<span>&nbsp>>&nbsp${visaProduct.country.parent.name }</span>
        	<span>&nbsp>>&nbsp${visaProduct.name}</span>
        </p>
        <div class="visa_tab">
        	<table class="table_txt">
            	<tr>
                	<td width="400px">签证名称：<span>${visaProduct.name}</span></td>
                    <td>签证国家：<span>${visaProduct.country.name}</span></td>
                    <td class="tab_align">签证类型：<span>${visaProduct.type.name}</span></td>
                </tr>
                <tr>
                	<td width="300px">领区：<span>${visaProduct.lingqu.name}</span></td>
                    <td>是否需要预约：<span> 
                    <c:choose>
                    <c:when test="${visaProduct.isNeedToAppointment eq 0}">是</c:when>
                    <c:when test="${visaProduct.isNeedToAppointment eq 1}">否</c:when>
                    </c:choose>
                    
                    </span></td>
                    <td class="tab_align">是否需要面试：<span>
                    <c:choose>
                    <c:when test="${visaProduct.isInterview eq 0}">是</c:when>
                    <c:when test="${visaProduct.isInterview eq 1}">否</c:when>
                    </c:choose>
                    </span></td>
                </tr>
                <tr>
                	<td>签证申请周期：<span>
                	${visaProduct.visaApplyCycle}
                	</span></td>
                    <td>一般签证有效期：
                    <span>
                  ${visaProduct.visaValid}
                    </span></td>
                    <td class="tab_align">一般签证停留期：<span>
                   ${visaProduct.periodOfStay}
                    </span></td>
                </tr>
                <tr>
                	<td width="300px">入境次数：<span>
                	<c:choose>
                    <c:when test="${visaProduct.oneToManySelect eq 0}">单次</c:when>
                    <c:when test="${visaProduct.oneToManySelect eq 1}">多次</c:when>
                    </c:choose>
                	
                	</span></td>
                    <td>受理情况：<span></span></td>
                    <td class="tab_align">是否可以代领签证：
                    <span>

 				  <c:choose>
                    <c:when test="${visaProduct.acceptType eq 0}">是</c:when>
                    <c:when test="${visaProduct.acceptType eq 1}">否</c:when>
                    </c:choose>

					</span></td>
                </tr>
                <tr>
                	<td colspan="3">报价是否含签证费：
                	<span>
                	  <c:choose>
                    <c:when test="${visaProduct.quotationHasVisaPrice eq 0}">是</c:when>
                    <c:when test="${visaProduct.quotationHasVisaPrice eq 1}">否</c:when>
                    </c:choose>
                	</span></td>
                </tr>
            </table>
        </div>
    </div>
 <!-- -----------------正文部分--------------- -->   
    <div class="content">
    	<div class="content_tab">
            <b>签证价格</b>
            <table  border="2">
                <tr>
                    <th>价格分类</th>
                    <th>价格（元/人）</th>
                    <th>6-12岁价格（元/人）</th>
                    <th>0-6岁价格（元/人）</th>
                    <th>报价说明</th>
                </tr>
                <tr>
                    <th>同业价格</th>
                    <td>${visaProduct.price eq null?0.0:visaProduct.price}</td>
                    <td>${visaProduct.price eq null?0.0:visaProduct.price}</td>
                    <td>${visaProduct.price eq null?0.0:visaProduct.price}</td>
                    <td>报价不含使领馆签证费、预约费和保险费</td>
                </tr>
                <tr>
                    <th>签证费用</th>
                    <td>${visaProduct.visaFee}</td>
                    <td>${visaProduct.visaFee1}</td>
                    <td>${visaProduct.visaFee2}</td>
                    <td></td>
                </tr>
                <tr>
                    <th>预约费用</th>
                    <td>${visaProduct.bookFee}</td>
                    <td>${visaProduct.bookFee1}</td>
                    <td>${visaProduct.bookFee2}</td>
                    <td></td>
                </tr>
                <tr>
                    <th>附件下载</th>
                    <td colspan="4">
                        <a href="#"><span>德国签证申请表草表</span></a>
                        <a href="#"><span>在职证明样本</span></a>
                        <a href="#"><span>在读证明样本</span></a>
                	</td>
                </tr> 
            </table>
        </div>
    	
        <div class="content_area">
        	<p>
                <b>领区划分</b>
                <span>
                   ${visaProduct.lingquDivide}
                </span>
              
            </p>
            
            <p>
                <b>预约信息</b>
                <span>
                 ${visaProduct.bookingInformationNeeds}
               </span>
            </p>
            
            <p>
                <b>使领馆地址</b>
              <span>   ${visaProduct.consularAndVisaCenterAddress}</span>
            </p>
            
            <p>
                <b>备注</b>
                <span>
                ${visaProduct.visaRemarks}
                </span>
            </p>
        </div>
        
        
        
   <script type="text/javascript">
	  window.onload=function()
	  {
		  people_change("people","tab_content");
		  }
        	function people_change(id1,id2)
			{
				var oUl=document.getElementById(id1);
				var oLi=oUl.getElementsByTagName("li");
				var oContent=document.getElementById(id2);
				var oC_li=oContent.getElementsByTagName("li");
				for(i=0;i<oLi.length;i++)
				{
					oLi[i].index=i;
					oLi[i].onclick=function()
					{
						for(i=0;i<oLi.length;i++)
						{
							oC_li[i].className="";
							}
						oC_li[this.index].className="current";
						}
					}
				}
        </script>
	  	<div class="visa-3-cont2-top">
      		<ul id="people">
      			<li class="visa-3-cont2-current"><a href="javascript:;">在职人员</a></li>
                <li><a href="javascript:;">退休人员</a></li>
                <li><a href="javascript:;">学生及未成年</a></li>
                <li><a href="javascript:;">自由职业</a></li>
                <li><a href="javascript:;">不分职业</a></li>
             <!--   <li><a href="javascript:;">费用说明</a></li>
                <a href="visa-table.html" class="download">下载签证材料(保存为PDF)</a>       -->                    
      		</ul>
      	</div>
        <div class="visa-3-cont2-cont">
      		<div class="visa-3-cont2-del">
            	<ul id="tab_content">
            	       <c:forEach items="${dataTypeMaps}" var="map" >
            	       <c:choose>
            	       <c:when test="${map.key eq 1}">
            	       <li class="current" id="tab1">
            	               <c:forEach items="${map.value}" var="dataType" varStatus="status">
            	                 <h4>${dataType.name }</h4>
            	           		<c:forEach items="${dataTypeDetailList}" var="dataTypeDetail">
            	                         <c:if test="${dataTypeDetail.dataType.id eq dataType.id}">
						            	
						            	   <b>${dataTypeDetail.title} <c:if test="${dataTypeDetail.sign eq 0 }"><font color="red">*</font>&nbsp;</c:if> </b>
						       			  <p> ${dataTypeDetail.content }</p>
						                 </c:if>
						                 </c:forEach>
            	               </c:forEach>
            	       </li>
            	       </c:when>
            	       <c:otherwise>
            	       <li class="current" id="tab${map.key}">
   								          <c:forEach items="${map.value}" var="dataType" varStatus="status">
            	                 <h4>${dataType.name }</h4>
            	           		<c:forEach items="${dataTypeDetailList}" var="dataTypeDetail">
            	                         <c:if test="${dataTypeDetail.dataType.id eq dataType.id}">
						            	
						            	   <b>${dataTypeDetail.title} <c:if test="${dataTypeDetail.sign eq 0 }"><font color="red">*</font>&nbsp;</c:if> </b>
						       			  <p> ${dataTypeDetail.content }</p>
						                 </c:if>
						                 </c:forEach>
            	               </c:forEach>
            	               
							</li>
            	       </c:otherwise>
            	       
            	       </c:choose>
            		   </c:forEach>
            	</ul>  
            </div>
            <div class="visa3-cont2">
            	<ul>
            		<li class="top-bg">备注</li>
                    <li class="visa3-cont2-bottom">
                    	<p  style="text-align:left;word-break:break-all;">${visaProduct.visaRemarks }</p>
                    </li>
            	</ul>
            </div>
            <div class="visa3-cont2">
			            	<ul>
			            		<li class="top-bg">免责声明</li>
			                    <li class="visa3-cont2-bottom">
			                    	<p  style="text-align:left;word-break:break-all;">${visaProduct.disclaimer}
									</p>
			                    </li>
			            	</ul>
            </div>
            
             
            
      	</div>
        
        <div class="content-area2">
            <div class="content-area21">
                <a href="VisaOrderFenXiaoAction.do?method=productOrderUI&productId=${visaProduct.id }">预订</a>
            </div>
        </div>
 
 
 <!-- -----------------页脚部分--------------- -->         
        <div class="footer">
                <p>
                    <a target="_blank" href="http://toplife.gotoip55.com/about.html">关于我们</a>
                    <a target="_blank" href="http://toplife.gotoip55.com/login_ty.html">同业系统</a>
                    <a target="_blank" href="http://toplife.gotoip55.com/visalists-8-1.html">签证服务</a>
                    <span><a target="_blank" href="http://toplife.gotoip55.com/show-7-61-1.html">付款方式</a></span>
                </p>
                <p>专业旅游签证公司，钧通商旅帮你忙</p>
        </div>
        
    </div>
</body>
</html>
