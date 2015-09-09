<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/style_visa_center.css" />
<script src="${basePath}/js/jquery-1.11.1.js"></script>
<title>签证中心</title>
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
       	<jsp:include page="/WEB-INF/fenxiao/Public/left.jsp" />
    <!--  -----------------右边内容部分--------------  -->
    <div class="right">
    	<form  id="form1" action="${basePath}fenxiao/VisaProductFenXiaoAction.do?method=visaProductList" method="post">
            <b>签证中心</b>
            <div class="sear_banner">
                <ul>
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
                        <span>邻区：</span>
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
                    
                    <li class="search_btn" onclick="searchInfo()">
                    搜索
                    </li>
                </ul>
            </div>
        </form>
        <div class="country_visa">
            <c:forEach var="top" items="${topCountryList}">
                    <c:if test="${top.coutryChild ne null}">
                        <b>${ top.name}</b>
                        <ul>
                        <c:forEach var="country" items="${top.coutryChild}">
                        <li>
                          <a href="fenxiao/VisaProductFenXiaoAction.do?method=visaProductList&country_select=${country.id }" target="_blank"><img src="${basePath}/style/images/head_logo.gif" />${country.name}</a>
                        </li>
                        </c:forEach>
                        </ul>
                    </c:if>
            </c:forEach>
        </div>
    </div>

<!--  -----------------页脚部分--------------  -->
    <div class="footer">
        <jsp:include page="/WEB-INF/fenxiao/Public/footer.jsp" />
    </div>
</body>
</html>

<script type="text/javascript">
	function getCountryList(topId) {
		if(topId!=null&&topId.length>0) {
			$.getJSON('rest/visacountrys/getCountry/'+topId, function(data){
				if (data != null) {
					$("#country_select").empty();
					$("#country_select").append("<option value=''>请选择</option>");
					$.each(data.country, function(i,n) {
						$("#country_select").append("<option value="+n.id+">"+n.name+"</option>")
					});
										
				}
			});
							
		}
	}
	
	function searchInfo() {
	//只有都不为空的时候才能提交
		$("#form1").submit();
	}
</script>

