<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>复制到其他职业</title>
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
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">复制到其他职业</strong> </div>
    </div>
    <div class="am-panel-hd">
	</div>

<div class="am-g">
      <div class="am-u-sm-12">
        <html:form action="background/VisaDataTypeDetailAction"  styleId="myform">
    	<html:hidden property="method" styleId="methodId"  value="copyRefreshUI"/>
    	<html:hidden styleId="pid" property="pid" value="${pid }"/>
    	<html:hidden styleId="type" property="type" value="${type }"/>
    	<html:hidden styleId="ids" property="ids" value="${ids }"/>
          <table class="am-table am-table-striped am-table-hover table-main">
           
			<tr class="TableDetail1 template">
			 		<td>选择复制到其他职业:</td>
                        <td>
                     	<c:forEach var="occ" items="${occuMap}">
                        <c:if test="${occ.key ne type}">${occ.value }  <input type="radio" value="${occ.key }" name="occ" /></c:if>
                        </c:forEach>
                        </td>	
			</tr>
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
var name = $("input[@name='occ']:checked").val();
if(name==''||name==undefined)
{
alert("请选择一个职业类型!");
return false;
}
}
    </script>

