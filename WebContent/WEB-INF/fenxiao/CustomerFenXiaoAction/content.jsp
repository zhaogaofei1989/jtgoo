<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/user_style.css" />
<link rel="stylesheet" href="${basePath}js/amazeui/css/amazeui.css"/>

<title>新增客服</title>

</head>
<body>
<!-- -----------头部---------------- -->
	
   
    <div class="content">
   
    <!--  -----------------右边内容部分--------------  -->
        <div class="right">

			<form id="myform" name="CustomerFenXiaoActionForm" action="/jtgooCMS/fenxiao/CustomerFenXiaoAction.do?method=contentUI" method="post">
              <html:hidden property="pageNum" value="1"/>
				<html:hidden property="pageSize" value="10"/>
             <div>
               
               </div>
                <table class="table_order" style="font-size: 14px;" border="1">
                    <tr>
                        <th>检索姓名：</th>
                        <td>
                            <div class="am-input-group am-input-group-sm">
					          <input type="text" class="am-form-field" id="searchvalue" name="searchvalue"/>
					          <span class="am-input-group-btn">
					            <button class="am-btn am-btn-default" onclick="searchCustomer()" type="button">搜索</button>
					          </span>
					        </div>
                        </td>
                    </tr>
                </table>
                
               <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th class="table-check"><input  type="checkbox" id="check_box" onclick="selectAll(this.checked);"></th><th class="table-title">序号</th><th class="table-type">名称</th><th class="table-author am-hide-sm-only">手机</th><th class="table-date am-hide-sm-only">QQ</th><th class="table-set">邮箱</th>
              </tr>
          </thead>
          <tbody>
          
               <c:forEach items="${pageBean.recordList}" var="customer"  varStatus="status">
                    <tr>
                        <th><input class="inputcheckbox" name="ids" value="${customer.id}|${customer.name}"  type="checkbox" /></th>
                        <td>
                        ${customer.serialNumber }
                        </td>
                        <td>
                        ${customer.name }
                        </td>
                        <td>
                        ${customer.mobliePhone }
                        </td>
                        <td>
                        ${customer.chatTools }
                        </td>
                        <td>
                        ${customer.email }
                        </td>
                    </tr>
                </c:forEach>
            
          </tbody>
        </table>
                
                </form>
                
 <div class="am-cf">
  共 ${pageBean.recordCount }条记录
  <div class="am-fr">
    <ul class="am-pagination">
    	<li class="am-disabled"><a href="#">«</a></li>
    	  <c:forEach begin="${pageBean.beginPageIndex}" end="${pageBean.endPageIndex}" var="num" >
			<c:if test="${pageBean.currentPage eq num}">
			    <li class="am-active"><a href="${basePath}fenxiao/CustomerFenXiaoAction.do?method=contentUI&pageNum=${num }">${num }</a></li>
			</c:if>
			<c:if test="${pageBean.currentPage ne num}">
			 <li><a  href="${basePath}fenxiao/CustomerFenXiaoAction.do?method=contentUI&pageNum=${num }">${num }</a></li>
			</c:if>
		</c:forEach>
		<li><a href="#">>></a></li>
    </ul>
  </div>
</div>
        </div>
    </div>
<!--  -----------------页脚部分--------------  -->
    <div class="footer">
    	<jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>

<script type="text/javascript">
//全选、反选
function selectAll(checkedValue){
$("[name=ids]").attr("checked", checkedValue);
}
function searchCustomer()
{
document.forms[0].submit();
}
</script>
