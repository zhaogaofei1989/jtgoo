<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setAttribute("basePath",  basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>钧通商旅</title>
<link rel="stylesheet" type="text/css" href="${basePath}style/blue/base.css"/>
<link rel="stylesheet" type="text/css" href="${basePath}style/blue/ExportTablePage.css"/>
<script type="text/javascript" src="${basePath}/js/jquery-1.7.js"></script>
</head>
<body style="margin-left: auto; margin-right: auto; width: 1000px;">
<div id="printDiv">  
		
	<div id="top">
    	<img src="${basePath}style/images/ExportTableHeader.jpg" />
    </div>
    
     <div id="MainTable">
    	<h1>签证材料</h1>
    	

    	
        
        <div id="VisaInfoDetail">
        	<ul class="left">
            	<li>产品编号：${product.serialNumber}</li>
                <li>领区：${product.name}</li>
            </ul>
            
            <ul class="middle">
            	<li>洲际：
            		<c:if test="${product.country.parent ne null}">
            		${product.country.parent.name}
            		</c:if>
            	</li>
                <li>签证类型： ${product.type.name}</li>
            </ul>
            
            <ul class="right">
            	<li>国家：${product.country.name}</li>
             
            </ul>
        </div>
    
        <dl id="InformationList">
            <c:if test="${product.bookingInformationNeeds ne ''}">
        	        	
        	<dt>预约面试：</dt>
            <dd>
   		  ${ product.bookingInformationNeeds }   </dd>
   		  </c:if>
   		  



  		  
  
   		     <c:if test="${product.lingquDivide ne ''}">
   		  
	  		<dt>领区划分：</dt>
            <dd>
            ${product.lingquDivide}  </dd>
      </c:if>
      
      
          <c:if test="${product.webSiteLink ne ''}">
         <dt>网址连接：</dt>
            <dd>
            	${product.webSiteLink }  </dd>
       </c:if>
      
         <c:if test="${product.bookingInformationNeeds ne ''}">
         <dt>预约需要的信息：</dt>
            <dd>
            	${product.bookingInformationNeeds }  </dd>
       </c:if>
      
          <c:if test="${product.consularAndVisaCenterAddress ne ''}">
         <dt>使领馆和签证中心地址：</dt>
            <dd>
            	${product.consularAndVisaCenterAddress }  </dd>
       </c:if>
          <c:if test="${product.howToQueryVisaInfo ne ''}">
         <dt>如何进行签证查询 ：</dt>
            <dd>
            	${product.howToQueryVisaInfo }  </dd>
       </c:if>
      
       <c:if test="${product.getVisaInfo ne ''}">
             <dt>签证的领取：</dt>
            <dd>
            ${product.getVisaInfo}
          </dd>
              </c:if>
      
      
      <c:if test="${product.visaMaterials ne ''}">
         <dt>签证材料准备：</dt>
            <dd>
            	${product.visaMaterials }  </dd>
       </c:if>                  
                 <c:if test="${product.submitApplicationAndInterview ne ''}">	
                 <dt>递交申请及面试:</dt>
            <dd>
            ${product.submitApplicationAndInterview }
            </dd>
                 </c:if>       
                 




                         <dt>签证材料</dt>
        </dl>
        
    
           <c:forEach items="${dataTypeMaps}" var="map">

        <div id="c_${map.key}">   
        <c:forEach items="${map.value}" var="dataType" varStatus="status">
              <table cellspacing="0" class="PersonInfo">
        	<caption>${status.index+1}.${dataType.name}</caption>
        	  <thead>
            	<tr>
                	<td width="200px;" style="text-align:center;">名称</td>
                	<td style="text-align:center;">备注</td>
                </tr>
            </thead>
            <tbody>
              <c:forEach items="${dataType.dataTypeDetailSet}" var="dataTypeDetail"  varStatus="status">
                 <tr>
                 <c:if test="${dataTypeDetail.type eq '1'}">
                	<td style="text-align:center;word-break:break-all;"  width="50%"><c:if test="${dataTypeDetail.sign eq 0 }"><font color="red">*</font>&nbsp;</c:if>${dataTypeDetail.title}</td>
                	<td style="text-align:center;word-break:break-all;"  width="50%">${dataTypeDetail.content }</td>
                 </c:if>
                </tr>
                </c:forEach>
            </tbody>
        	</table>
        
        
        </c:forEach>
        </div>
        </c:forEach>
        
        
         <br/>
                <table cellspacing="0" class="PersonInfo">
               <thead>
                <tr><td  style="text-align:center;word-break:break-all;"  width="8%">免责条款</td><td   style="text-align:left;word-break:break-all;">${product.disclaimer}</td></tr>
                <tr><td  style="text-align:center;word-break:break-all;"  width="8%">备注</td><td   style="text-align:left;word-break:break-all;">${product.visaRemarks }</td></tr>
               </thead>
             </table>
      
         <table cellspacing="0" class="PersonInfo" >
        	<caption>
        	客服信息
        	</caption>
            <thead>
            	<tr>
                	
                	<td width="10%">客服：</td>
                	<td width="30%" style="text-align: left; padding-left: 5px;">周松伟</td>
                	<td width="10%">邮件：</td>
                	<td width="30%" style="text-align: left; padding-left: 5px;">jtgoo_07@msn.cn</td>
                
                </tr>
                
                <tr>
                	
                	<td>传真：</td>
                	<td style="text-align: left; padding-left: 5px;">021-56371293</td>
                	<td>电话：</td>
                	<td style="text-align: left; padding-left: 5px;">021-56053327</td>
                
                </tr>
                
                <tr>
                	
                	<td colspan="4" align="left" style="text-align: left; padding-left: 5px;">1、单订机票、酒店、欧洲火车票、境外租车服务、境外景点门票、表演项目门票等服务。
<BR>2、出境散拼、自由行、整团接待服务。
<BR>3、特色项目服务：夏冬令营、高尔夫、邮轮、自驾游等。
<BR>4、公商务邀请、会展、出国培训服务。
<BR>5、出境“量身定制”服务。</td>
                	
                
                </tr>
            </thead>
           
        </table>
    </div>
  
   
	
	
    <div id="PageFooter" >
        	<span>服务热线：4000-987-0008</span>
            <b>网址：www.jtgoo.com</b>
        </div>
       
		
		</div>
		
		   <p style=" float:right; margin-right:120px;" class="noprint" ><input type="button" value="打印" onclick="printPdf()"/>  </p>
   <div style="float: right; margin-top:2px;margin-right:10px;" class="noprint">
   选择职业：<c:forEach items="${occuMap}" var="occu">${occu.value } <input type="checkbox" onclick="check(this.value)"  name="checkbox" id="${occu.key }"  value="${occu.key }"/> </c:forEach>

		</div>
</body>
</html>

<script type="text/javascript">

	$(function(){
   	//默认为1
    check('1');
   	});
function printPdf()
{
var printData = document.getElementById("printDiv").innerHTML; 
window.document.body.innerHTML = printData;
window.print();
}



 function check(value)
 {
var ches=document.getElementsByName("checkbox");
for (var i=0;i<ches.length;i++)
{
if(!ches[i].checked)
{
$("#c_"+ches[i].value).hide();
}
else
{
$("#c_"+ches[i].value).show();
}
}
}
</script>

    