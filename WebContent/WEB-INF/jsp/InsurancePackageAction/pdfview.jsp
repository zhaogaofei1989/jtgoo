<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ss</title>
<style>
	body {
		margin: 0px;	
	}
	.myframe {
		/*overflow-x: hidden;
		overflow-y: hidden; */
		width: 100%;
		height: 640px;
	}
</style>
</head>
<body>
	<input id="pdf" type="hidden" value="${baoXianAttachment }" />
	<iframe  id="myframe" class="myframe" src="../files/${baoXianAttachment }" frameborder="0" marginheight="0" marginwidth="0" scrolling="no">
	</iframe>
</body>
</html>


