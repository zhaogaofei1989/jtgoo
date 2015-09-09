<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}style/fenxiao/paid_order.css" />
 <script language="javascript" type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
<title>已付款订单</title>
</head>
<body>
<!-- -----------头部---------------- -->
	<div class="header1">
		<jsp:include page="/WEB-INF/fenxiao/Public/header1.jsp" />
    </div>
    <div class="header2">
    	<jsp:include page="/WEB-INF/fenxiao/Public/header2.jsp" />
    </div>	

    <div class="content">    
        <!-- -----------------左边菜单版块---------------- -->
        <jsp:include page="/WEB-INF/fenxiao/Public/left.jsp"/>
    
    <!--  -----------------右边内容部分--------------  -->
        <div class="right">
            <form  id="form1" action="${basePath}fenxiao/VisaOrderFenXiaoAction.do?method=customerOrderList" method="post">
                    <div class="sear_banner">
                        <ul>
                            <li>
                                <span>订单编号：</span>
                                <input id="serialnumber" name ="serialnumber" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" value=""/>
                          
                            </li>
                            
                            <li>
                                <span>客户姓名：</span>
                                   <input id="customer_name" name ="customer_name" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" value=""/>
                            </li>
                            
                            <li>
                                <span>面试时间：</span>
                              <input type="text" name="startTime"  class="Wdate" style="width:100px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'2100'})"/> -- <input name="endTime" type="text" class="Wdate" style="width:100px;" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d'})"/>
                            </li>
                            
                           <!--  <li>
                                <span>洲际：</span>
                                <select id="country_select" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" name="choose">
                                    <option value="">请选择</option>
                                </select>
                            </li>
                            --> 
                            <li>
                                <span>国家：</span>
                                <select id="country_select" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" name="country_select">
                                      <option value="">请选择</option>
                                    <c:forEach var="topCo" items="${topCountryList}">
                                    <option value="${topCo.id }" disabled="disabled">${topCo.name }</option>
                                                    <c:forEach var="child" items="${topCo.coutryChild}">
                                                        <option value="${child.id }">&nbsp;&nbsp;&nbsp;&nbsp;${child.name }</option>
                                                    </c:forEach>
                                    </c:forEach>
                                </select>
                            </li>
                            
                            <li>
                                <span>领区：</span>
                                <select id="lingqu_select" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" name="lingqu_select">
                                         <option value="">请选择</option>
                                    <c:forEach var="lingqu" items="${lingquList}">
                                    <option value="${lingqu.id }">${lingqu.name }</option>
                                    </c:forEach>
                                </select>
                            </li>                                    
                            
                            <li>
                                <span>签证类型：</span>
                                <select id="visatype_select" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" name="visatype_select">
                                     <option value="">请选择</option>
                                    <c:forEach var="visaType" items="${visaTypeList}">
                                    <option value="${visaType.id }">${visaType.name }</option>
                                    </c:forEach>
                                </select>
                            </li>
                            <li>
                                <span>订单状态：</span>
                                <select id="order_status"  name="order_status" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" >
                                    <option value="">请选择</option>
                                    <c:forEach var="statu" items="${statusList}">
                                    <option value="${statu.key }">${statu.value }</option>
                                    </c:forEach>
                                </select>
                            </li>
                            
                            <li>
                                <span>客服姓名：</span>
                                <input id="customerServicers" style="width:100px; height:20px;
                                    border:1px solid #C9D4E0;" name="customerServicers"  value=""/>
                            </li>
                            <li class="search_btn" onclick="searchInfo()">搜索</li>                      
                        </ul>
                     </div>
                 </form>
                 <div class="display_tab">
                    <table border="1">
                        <tr>
                            <th width="80px" height="30px">订单编号</th>
                            <th width="65px">订单状态</th>
                            <th>签证产品名称</th>
                            <th>出发日期</th>
                            <th>客户姓名</th>
                            <th>客服</th>
                            <th>面试时间</th>
                            <th>送签员</th>
                        </tr>
                        <c:forEach var="vo" items="${pageBean.recordList}">
                        <tr>
                        <td>${vo.serialnumber}</td>
                        <td>
                        <c:choose>
                            <c:when test="${vo.status==0||vo.status==null}">
                              未审核
                            </c:when>
                            <c:when test="${vo.status==1}">
                            已预订
                            </c:when>
                            <c:when test="${vo.status==2}">
                            已收到材料
                            </c:when>
                            <c:when test="${vo.status==3}">
                            已审核材料
                            </c:when>
                            <c:when test="${vo.status==4}">
                            已预约
                            </c:when>
                            <c:when test="${vo.status==5}">
                            已面试/送签
                            </c:when>
                            <c:when test="${vo.status==6}">
                            已出签
                            </c:when>
                            <c:when test="${vo.status==7}">
                            已寄回
                            </c:when>
                            <c:when test="${vo.status==8}">
                            已完成
                            </c:when>
                            <c:when test="${vo.status==9}">
                            已付款
                            </c:when>
                            </c:choose>
                        </td>
                        <td>${vo.visaProduct.name}</td>
                        <td>${vo.receivedDataTime3 }</td>
                        <td>
                                    <c:forEach items="${vo.customerSet}" var="customer">
                                     <label style="font-weight:bolder;" onclick='showCustomerName(${visaOrder.visaProduct.id },${customer.id})'>
                                          ${customer.name}
                                     </label>
                                        <br/>
                    </c:forEach>
                        </td>
                        <td>${vo.customService}</td>
                        <td>${vo.interviewTime }</td>
                        <td>${vo.sentToSignPeople }</td>
                        </tr>
                        </c:forEach>
                    </table>	
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
function searchInfo()
{
//只有都不为空的时候才能提交
$("#form1").submit();
}
</script>


