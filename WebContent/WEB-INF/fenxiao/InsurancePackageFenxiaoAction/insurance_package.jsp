<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/insurance_style.css" />
<title>保险套餐</title>
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
            <span><b>保险报价查询</b></span>
            <form  id="form1" action="${basePath}fenxiao/InsurancePackageFenXiaoAction.do?method=list" method="post">
                <div class="sear_banner">
                    <ul>
                        <li>
                            <span>保险公司：</span>
                            <select id="insurance_type" style="width:100px; height:20px;
                                border:1px solid #C9D4E0;" name="insurance_type" onchange="getInsurancePageList(this.value)">
                                <option value="">请选择</option>
                                <c:forEach var="insuranceType" items="${insuranceTypeList}">
                                <option value="${insuranceType.id }">${insuranceType.name }</option>
                                </c:forEach>
                            </select>
                        </li>
                        
                        <li>
                            <span>保险产品：</span>
                                <select id="insurance_package" style="width:90px; height:20px;
                                border:1px solid #C9D4E0;" name="insurance_package">
                            </select>
                        </li>
                        
                     <!--     <li>
                            <span>保险天数：</span>
                            <select id="country_select" style="width:80px; height:20px;
                                border:1px solid #C9D4E0;" name="choose">
                                <option value=""></option>
                            </select>
                        </li>-->
                        
                         <li class="search_btn" onclick="searchInfo()">搜索</li>   
                    </ul>
                 </div>
            </form>
            <div class="insurance">
                <table border="1" class="table_insurance">
                    <tr>
                        <th height="25px">保险公司</th>
                        <th>保险产品</th>
                        <th>附件名称2</th>
                        <th>备注</th>
                    </tr>
                     <c:forEach var="insurancePackage" items="${pageBean.recordList}">
                        <tr>
                        <td>${insurancePackage.insuranceType.name }</td>
                        <td>${insurancePackage.name }</td>
                        <td><a href="${basePath}fenxiao/InsurancePackageFenXiaoAction.do?method=getBaoxianInfo&baoxian_att_id=${ insurancePackage.baoxian_att_id}" target="_blank">${insurancePackage.path}&nbsp;</a></td>
                        <td>${insurancePackage.description }</td>
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


function getInsurancePageList(insuranceTypeId)
{
if(insuranceTypeId!=null&&insuranceTypeId.length>0)
{
					$.getJSON('fenxiao/InsurancePackageFenXiaoAction.do?method=getInfoByInsuranceTypeId&insuranceTypeId='+insuranceTypeId, function(data){
						if (data != null) {
							$("#insurance_package").empty();
						   $("#insurance_package").append("<option value=''>请选择</option>");
										$.each(data.Items, function(i,n)
									{
									$("#insurance_package").append("<option value="+n.id+">"+n.name+"</option>")
									}
									);
									}
										});
						
}
}
</script>
