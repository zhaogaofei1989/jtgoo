<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>复制到其他签证产品</title>
 <%@ include file="/WEB-INF/jsp/Public/commons_new.jspf" %>
<style type="text/css">
	td{
	padding-left: 15px;
	}
	</style>
</head>
<body>

<!-- content start -->
  <div class="admin-content">
  
   <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">复制到其他签证产品</strong> </div>
    </div>
    <div class="am-panel-hd">
	</div>

<div class="am-g">
      <div class="am-u-sm-12">
        <html:form action="background/VisaDataTypeDetailAction"  styleId="myform">
    	<html:hidden property="method" styleId="methodId"  value="copyTargetVisaProductUI"/>
    	<html:hidden styleId="pid" property="pid" value="${pid }"/>
    	<html:hidden styleId="type" property="type" value="${type }"/>
    	<html:hidden styleId="ids" property="ids" value="${ids }"/>
   		 <html:hidden property="pageNum" value="1"/>
		<html:hidden property="pageSize" value="10"/>
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
             <th><input  type="checkbox" id="check_box"/></th>
                    <th>名称</th>
             </tr>
           	<c:forEach var="visaProduct" items="${pageBean.recordList}">
          	<tr class="TableDetail1 template">
			 	      <td><input class="checkbox1"   name="productsIds" value="${visaProduct.id}"  type="checkbox" ></td>
          		 	<td>${visaProduct.name}&nbsp;</td>
			</tr>
          
           </c:forEach>
        </table>
         <div id="TableTail">
        <div id="TableTail_inside">
        	<input type="submit" class="am-btn am-btn-primary am-btn-xs" onclick="return validate();" value="保存"/>
        </div>
    </div>
        </html:form>
				
					<%@ include file="/WEB-INF/jsp/Public/pageView.jspf" %>
          <hr />
          <p>注：.....</p>
      </div>
    </div>
</div>  
    	
    	<!--[if (gte IE 9)|!(IE)]><!-->
<script language="javascript" src="${basePath}js/jquery-1.7.js"  charset="utf-8"></script>
<!--<![endif]-->
<script src="${basePath}js/amazeui/amazeui.js"></script>



</body>
</html>
   <script type="text/javascript">
function validate()
{
var name = $("input[@name='productsIds']:checked").val();
if(name==''||name==undefined)
{
alert("请选择一个产品!");
return false;
}
//修改提交方法
$("#methodId").val("copyTargetVisaProduct");

}
	$(document).ready(function() {
		$('#check_box').click(function(event) { //on click 
			if(this.checked) { // check select status
				$('.checkbox1').each(function() { //loop through each checkbox
					this.checked = true; //select all checkboxes with class "checkbox1" 
				});
			} else {
				$('.checkbox1').each(function() { //loop through each checkbox
					this.checked = false; //deselect all checkboxes with class "checkbox1" 
				}); 
			}
		});
	});
    </script>

