

<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>同业用户价格设置</title>
    <%@ include file="/WEB-INF/jsp/Public/commons.jspf" %>
    <link rel="stylesheet" type="text/css" href="${basePath}style/blue/jquery.autocomplete.css"></link>
    <script type="text/javascript" src="${basePath}js/jquery.autocomplete.js"></script>
    <script type="text/javascript" src="${basePath}/js/Date/WdatePicker.js"></script>
    <script type="text/javascript" src="${basePath}/js/artdialog/artDialog.js?skin=blue"></script>
	<script type="text/javascript" src="${basePath}/js/artdialog/iframeTools.js"></script>
</head>
<body>

<br><br><!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${basePath}/style/images/title_arrow.gif"/>同业用户价格设置
        </div>
        <div id="Title_End"></div>
    </div>
</div>

<!--显示表单内容-->
<div id="MainArea">
    <br><br><html:form action="background/CustomerAction">
    	<html:hidden property="method" value="${param.id eq null ? 'addPeer' : 'editPeer'}"/>
    	<html:hidden property="id"/>
    
        <div class="ItemBlock_Title1"><!-- 信息说明<DIV CLASS="ItemBlock_Title1">
        	<IMG BORDER="0" WIDTH="4" HEIGHT="7" SRC="${basePath}/style/blue/images/item_point.gif" /> 版块信息 </DIV>  -->
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                       <tr>
                        <td>产品名称<br><br></td>
                        <td><html:text property="name" styleId="name" styleClass="InputStyle"/> *<br><br></td>
                    </tr>
                 
                    <tr>
                        <td>联系人号码<br><br></td>
                        <td><html:text property="mobliePhone" styleClass="InputStyle"/> <br><br></td>
                    </tr>
                    <tr>
                        <td>QQ号码<br><br></td>
                        <td><html:text property="chatTools" styleClass="InputStyle"/> <br><br></td>
                    </tr>
                </table>
               
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${basePath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${basePath}/style/images/goBack.png"/></a>
        </div>
    </html:form>
</div>

<div class="Description">
	说明：<br />
	1，新添加的版块默认显示在最下面（sortOrder值最大）。<br />
</div>

</body>
</html>
    <script type="text/javascript">
    
    
    $(document).ready(function(){
$.ajax({
url: "VisaAutoComplete.do", 
dataType:'json',
success: function(msg){
var info=msg.obj;
$('#name').AutoComplete({
      'data': info,
                'width':280,
                'listStyle': 'custom',
                'maxHeight': 480,
                'createItemHandler': function(index, data)
							                {
							                 return "<span style='color:green;'>--"+data.label+"--</span>";  // 文本显示为绿色，并在前后使用'--'包裹
							                },
									       'afterSelectedHandler': function(data)
										    {
										    alert(data.id)
								
									        }
                
   									  });
								}      
      })
       });
    
    
    
    
    
    
    
    
    
    
    
    </script>

    
    