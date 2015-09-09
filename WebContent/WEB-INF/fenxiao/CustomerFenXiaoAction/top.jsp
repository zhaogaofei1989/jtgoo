<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/fenxiao/Public/commons.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="${basePath}js/amazeui/amazeui.js" type="text/javascript"></script>
<link rel="stylesheet" href="${basePath}js/amazeui/css/amazeui.css"/>
<title>新增客服</title>
<style type="text/css">
 Copy
  .am-tabs-nav li {
    position: relative;
    z-index: 1;
  }
  .am-tabs-nav .am-icon-close {
    position: absolute;
    top: 0;
    right: 10px;
    color: #888;
    cursor: pointer;
    z-index: 100;
  }

  .am-tabs-nav .am-icon-close:hover {
    color: #333;
  }

  .am-tabs-nav .am-icon-close ~ a {
    padding-right: 25px!important;
  }
  </style>
</head>
<body>



<div class="am-tabs" data-am-tabs="{noSwipe: 1}" id="doc-tab-demo-1">
  <ul class="am-tabs-nav am-nav am-nav-tabs" id="ul_tab">
  </ul>

  <div class="am-tabs-bd">

  </div>
</div>
<br />
<button type="button" class="am-btn am-btn-primary js-append-tab">添加</button>
</body>
</html>

<script type="text/javascript">
function save()
{
var idArr='';
$('input[name="ids"]:checkbox:checked').each(function(){
idArr+=$(this).val()+','; 
});
alert(idArr);
}
function checkLiId(id)
	{

 	var liIds=document.getElementsByName("tab_li");
	for(var j=0;j<liIds.length;j++)
	{
		if(liIds[j].id===id)
		{
			continue;	
		}
	}
}
$(function() {
    var tabCounter = 0;
    var $tab = $('#doc-tab-demo-1');
    var $nav = $tab.find('.am-tabs-nav');
    var $bd = $tab.find('.am-tabs-bd');

    function addTab(id,name) {
     var nav = '<li name="tab_li" id='+id+' name='+name+'><span class="am-icon-close"></span>' +
        '<a href="javascript: void(0)">' + name + '</a></li>';
      var content = '<div class="am-tab-panel"> 编号ID 为 ' + id + '</div>';
      $nav.append(nav);
      $bd.append(content);
      tabCounter++;
      $tab.tabs('refresh');
    }

    $('.js-append-tab').on('click', function() {
  //  var cc= $(window.parent.frames["tta"].document.getElementsByName("ids"));
	    var cc= $(window.parent.frames["tta"].document).find('input[name="ids"]:checkbox:checked');
     	var li_tab=$("#ul_tab li");
     	var idArray=""
     	if(li_tab.length===0)
     	{
     	
     		for(var k=0;k<cc.length;k++)
     		{
     		  var obj=cc[k].value.split("|");
     		  addTab(obj[0],obj[1]);
     		}
     		
     	}
     	else
     	{
     		for(var j=0;j<li_tab.length;j++)
     		{
     		  	idArray+=li_tab[j].id+","
     		}
		    for(var i=0;i<cc.length;i++)
		     {
		       var obj=cc[i].value.split("|");
		     	if(idArray.indexOf(obj[0])===-1)
		     	{
		     		addTab(obj[0],obj[1]);
		     	}
		     }
	     }
	    });


    $nav.on('click', '.am-icon-close', function() {
      var $item = $(this).closest('li');
      var index = $nav.children('li').index($item);

      $item.remove();
      $bd.find('.am-tab-panel').eq(index).remove();

      $tab.tabs('open', index > 0 ? index - 1 : index + 1);
      $tab.tabs('refresh');
    });
  });
</script>

