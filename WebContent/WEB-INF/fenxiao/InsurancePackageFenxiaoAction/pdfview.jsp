<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="${basePath}/js/jquery-1.11.1.js"></script>
<title>pdfview</title>
<style>
	body {
		margin: 0px;	
	}
	.myframe {
		width: 100%;
	}
</style>
<script>
		$(function() {
			$('#myframe').height($(window).height());		
		});
</script>
</head>
<body>
	<input id="pdf" type="hidden" value="${baoXianAttachment }" />
	<iframe  id="myframe" class="myframe" src="../files/${baoXianAttachment }" frameborder="0" marginheight="0" marginwidth="0" scrolling="no">
	</iframe>
</body>
</html>


