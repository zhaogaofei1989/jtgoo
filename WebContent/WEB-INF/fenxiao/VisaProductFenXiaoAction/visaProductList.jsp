<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/index_style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/style/fenxiao/style_visa_center1.css" />
<script src="${basePath}/js/jquery-1.11.1.js"></script>
<title>签证中心</title>
</head>
<body id="body">
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
    <form  id="form1" action="${basePath}fenxiao/VisaProductFenXiaoAction.do?method=visaProductList" method="post">
        <b class="visa_word">签证中心</b>
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
                                            <option value="${child.id }" ${child.id==countryId?'selected':''}>&nbsp;&nbsp;&nbsp;&nbsp;${child.name }</option>
    
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
                        <option value="${lingqu.id }" ${lingqu.id==lingquId?'selected':''}>&nbsp;&nbsp;&nbsp;&nbsp;${lingqu.name }</option>
                        
                        </c:forEach>
                    </select>
                </li>
                
                <li>
                    <span>签证类型：</span>
                    <select id="visatype_select" style="width:100px; height:20px;
                        border:1px solid #C9D4E0;" name="visatype_select">
                         <option value="">请选择</option>
                        <c:forEach var="visaType" items="${visaTypeList}">
                        <option value="${visaType.id }" ${visaType.id==visaTypeId?'selected':''}>&nbsp;&nbsp;&nbsp;&nbsp;${visaType.name }</option>
                        
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
        <div class="cont-wrap">
                <div class="visa-contL" id="visaproduct_info">
                    <div class="visa2-state-wrap">
                         <c:forEach var="pageBean" items="${pageBean.recordList}">
                            <div class="visa2-state-wrap">
                                <div class="visa2-state-pht">
                                    <li></li>
                                    <a href="#"><img src="${basePath}static/images/visa-pht-big.png" width="230" height="181" /></a>
                                    <span class="tag"><img src="${basePath}static/layout/images/tag.png" width="97" height="43" /></span>
                                    <span class="tag-word">${pageBean.type.name }</span>  
                                </div>
                                <div class="visa2-state-word">
                                    <ul>
                                        <li><b>${pageBean.name }</b></li>
                                        <li class="visa2-link"><a href="">下载签证材料<br />预订</a></li>
                                        <li class="price">价格：<span>￥ ${pageBean.price}</span></li>
                                        <li class="visa-2-btn"><a href="fenxiao/VisaProductFenXiaoAction.do?method=productView&productId=${pageBean.id }">查看详情</a></li>
                                    </ul>
                                </div>
                            </div> 
                         </c:forEach>
                    </div>
                </div>
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
	function getCountryList(topId) {
		if(topId!=null&&topId.length>0) {
			$.getJSON('rest/visacountrys/getCountry/'+topId, function(data) {
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
		$("#form1").submit();
	}
</script>
