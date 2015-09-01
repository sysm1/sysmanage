<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>下单预录入</title>
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<!--script type="text/javascript" src="${ctx}/js/input/add.js"></script-->
<style type="text/css">
   .tdw80 {width: 80px;}
   .tdw100 {width: 100px;}
   .tdw150 {width: 150px;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	var object=null;
	$("#addTable").click(function(){
		var tr=$("#table1 tr:eq(1) ");
　  		$("#table1 tr:last").clone().insertAfter($("#table1 tr:last"));
　  		var tr=$("#table1 tr:last");
　  		var codeValue='<input id="codeValue" name="codeValue" class="isNum" type="text" value="" style="width: 100px;">';
　  		var mark='<input type="text" id="mark" name="mark" style="width:200px;" value="双击选择备注信息" onblur="blurValue(this);" onclick="clearText(this);" ondblclick="pop(this)">';
　  		tr.children('td').eq(1).html('<input type="hidden" name="clothId" value=""><input type="text" title="双击选择布种" name="clothName" value="" style="width: 110px;" ondblclick="popCloth(this)" readonly="readonly">');
　  		tr.children('td').eq(3).html('<input type="text" title="双击选择我司编号" name="myCompanyCode" value="" style="width: 110px;" ondblclick="popMyCompanyCode(this)" readonly="readonly">');
　  		tr.children('td').eq(4).html('<input type="text" title="双击选择我司颜色" name="myCompanyColor" value="" style="width: 110px;" ondblclick="popMyCompanyColor(this)" readonly="readonly">');
　  		tr.children('td').eq(5).html('<input type="text"  name="num" value="" style="width: 80px">');
　  		tr.children('td').eq(7).html('<input type="text" name="mark" value="">');
　  		$("input[name='checkId']").attr("checked",false);
	});
	$('#copyone').click(function(){
		var i=0;
    	var row='';
    	var clothId="";
    	var factoryId="";
    	var newRow="";
    	var codeType='';
    	var teln='';
    	var salman='';
    	$('input:checkbox[name=checkId]:checked').each(function(){
    		 i++;
    		 row=$(this).parent().parent();
    		 newRow=row.clone();
    		 factoryId=row.find("select").eq(0).val();
    		 clothId=row.find("select").eq(1).val();
    		 codeType=row.find("select").eq(2).val();
    		 teln=row.find("select").eq(3).val();
    		 salman=row.find("select").eq(4).val();
    		 
    		 newRow.insertAfter($("#table1 tr:last"));
    		 newRow.find("select").eq(0).attr("value",factoryId);
    		 newRow.find("select").eq(1).attr("value",clothId);
    		 newRow.find("select").eq(2).attr("value",codeType);
    		 newRow.find("select").eq(3).attr("value",teln);
    		 newRow.find("select").eq(4).attr("value",salman);
    		 $("input[name='checkId']").attr("checked",false);
    	});
    	if(i==0){
    		alert("请选择一条数据复制");
    	}
    });
	$("#deleteTable").click(function(){
    	var checkId=document.getElementsByName("checkId");
    	for(var i=checkId.length-1;i>=0;i--){
    		if(checkId[i].checked){
    			checkId[i].parentNode.parentNode.parentNode.removeChild(checkId[i].parentNode.parentNode);
    		}
    	}
    });
	$("#saveWin_form").click(function(){
		if(!clothIdCheck()){
			return false;
		}
		if(!salesmanIdCheck()){
			return false;
		}
		$.ajax({
			cache: true,
			type: "POST",
			url:rootPath + '/background/input/add.html',
			data:$('#form').serialize(),// 你的formid
			async: false,
		    error: function(request) {
		        alert("Connection error");
		    },
		    success: function(data) {
			    alert("保存成功");
			    location.href=rootPath+"/background/input/list.html";
		    }
		});
	});
	$("#fh").click(function(){
		location.href=rootPath+"/background/input/list.html";
	});
});

function popCloth(obj){
	object=obj;
	dialog = parent.$.ligerDialog.open({
		width : 550,
		height : 500,
		url : rootPath + '/background/cloth/addlist.html',
		title : "布种选择",
		isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
	});
}
function popMyCompanyCode(obj){
	var clothId=obj.parentNode.parentNode.children[1].firstChild.value;
	var technologyId=obj.parentNode.parentNode.children[2].firstChild.value;
	object=obj;
	dialog = parent.$.ligerDialog.open({
		width : 550,
		height : 500,
		url : rootPath + '/background/flower/addMyCompanyCode.html?clothId='+clothId+'&technologyId='+technologyId,
		title : "我司编号选择",
		isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
	});
}
function popMyCompanyColor(obj){
	var clothId=obj.parentNode.parentNode.children[1].firstChild.value;
	var technologyId=obj.parentNode.parentNode.children[2].firstChild.value;
	var companyCode=obj.parentNode.parentNode.children[3].firstChild.value;
	object=obj;
	dialog = parent.$.ligerDialog.open({
		width : 550,
		height : 500,
		url : rootPath + '/background/flower/addMyCompanyColor.html?clothId='+clothId+'&technologyId='+technologyId+'&companyCode='+companyCode,
		title : "我司编号选择",
		isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
	});
}
/**设置备注信息**/
function addCloth(name,id){
	object.value=name;
	object.parentNode.parentNode.children[1].firstChild.value=id;
	
	$.ajax({
	    type: "post", //使用get方法访问后台
	    dataType: "json", //json格式的数据
	    async: false, //同步   不写的情况下 默认为true
	    url: rootPath + '/background/cloth/getClothUnit.html', //要访问的后台地址
	    data: {id:id}, //要发送的数据
	    success: function(data){
	    	//alert(data);
	    	object.parentNode.parentNode.children[6].innerHTML=data;
		},error : function() {    
	          alert("异常！");
	     } 
	});
}
/**设置备注信息**/
function addData(data){
	object.value=data;
}

/**设置备注信息**/
function addColorData(data){
	object.value=data;
	var clothId=object.parentNode.parentNode.children[1].firstChild.value;
	var technologyId=object.parentNode.parentNode.children[2].firstChild.value;
	var companyCode=object.parentNode.parentNode.children[3].firstChild.value;
	var myCompanyColor=data;
	if(checkNull(clothId)&&checkNull(companyCode)&&checkNull(myCompanyColor)){
		var param = {
					clothId:clothId,
					myCompanyCode:companyCode,
					technologyId:technologyId,
					myCompanyColor:myCompanyColor
					};
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/ordersummary/queryNoReturnNum.html', //要访问的后台地址
		    data: param, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	if(null==data){
		    		data='未下单';
		    	}
		    	object.parentNode.parentNode.children[9].innerHTML=data;
			},error : function() {
		          alert("异常！");
		    }
		});
	}
}
function clothIdCheck(){
	var b = true;
	$("#table1 input[name=clothId]").each(function(){
		var v = $(this).val();
		if(v==""){
			alert("请选择布种");
			b = false;
			return false;
		}
	});
	return b;
}

function salesmanIdCheck(){
	var b = true;
	$("#table1 select[name=salesmanId]").each(function(){
		var v = $(this).val();
		if(v==""){
			alert("请选择业务员");
			b = false;
			return false;
		}
	});
	return b;
}
function queryNoReturnNum($this){
	var $tr = $($this).parents("tr[name=initfirst]");
	var clothId=$($tr).find("select[name=clothId]").val();
	var myCompanyCode=$($tr).find("input[name=myCompanyCode]").val();
	var myCompanyColor=$($tr).find("input[name=myCompanyColor]").val();
	if(checkNull(clothId)&&checkNull(myCompanyCode)&&checkNull(myCompanyColor)){
	var param = {
				clothId:clothId,
				myCompanyCode:myCompanyCode,
				myCompanyColor:myCompanyColor
				};
		
	$.ajax({
	    type: "post", //使用get方法访问后台
	    dataType: "json", //json格式的数据
	    async: false, //同步   不写的情况下 默认为true
	    url: rootPath + '/background/ordersummary/queryNoReturnNum.html', //要访问的后台地址
	    data: param, //要发送的数据
	    success: function(data){
	    	if(null==data){
	    		data='未下单';
	    	}
	    	$($tr).find("td[name=sum]").html(data);
		},error : function() {    
	          alert("异常！");    
	     } 
	    });
	}
}
function checkNull(value){
	if(null==value||value==""){
		return false;
	}
	return true;
}
</script>
</head>
<body>
<div class="divdialog">
	<div style="width: 1150px;">
		<table width="450px">
			<tr>
				<td class="tdw80">
					<a class="btn btn-primary" href="javascript:void(0)" id="copyone"><span>复制新增</span> </a>
				</td>
				<td  class="tdw80">
					<a class="btn btn-primary" href="javascript:void(0)" id="addTable"><span>新增一行</span> </a>
				</td>
				<td class="tdw80">
					<a class="btn btn-primary" href="javascript:void(0)" style=width:60px;"
						id="saveWin_form" ><span>保存</span> </a>
				</td>
				<td>
					<a class="btn btn-primary" href="javascript:void(0)" id="fh"><span>返回</span> </a>
				</td>
				<td style="text-align: right;">
					<a class="btn btn-primary" href="javascript:void(0)" id="deleteTable" style="background-color: red;"><span>删除</span></a>
				</td>
				
			</tr>
		</table>
	</div>
	
	<form name="form" id="form" action="${ctx}/background/input/add.html" method="post">
		<table>
			<tr>
				<td valign="top">
					<table id="table1" border="1" name="table1" class="dataintable">
						<tbody>
							<tr>
								<th style="height: 30px;width: 35px;text-align: center;">
									<input type="checkbox" id="checkAll" name="checkAll">
								</th>
								
								<th align="right" style="width: 110px;">布种</th>
								<th align="right">工艺</th>
								<th align="right" style="width: 110px;">我司编号</th>
								<th style="width: 110px;">我司颜色</th>
								<th >数量</th>
								
								<th >单位</th>
								<th>备注</th>
								<th align="right">业务员</th>
								<th>未回数量</th>
							</tr>
	
							<tr name="initfirst">
								<td style="text-align: center;">
									<input type="checkbox"  name="checkId" value="1">
								</td>
								<td class="l_left tdw100" title="双击选择布种">
									<input type="hidden" name="clothId" value="">
									<input type="text"  name="clothName" value="" style="width: 110px;" ondblclick="popCloth(this)" readonly="readonly">
									<!-- select  name="clothId"  style="width:110px;">
										<option value="">请选择</option>
										<c:forEach items="${ cloths }" var = "cloth">
											<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
										</c:forEach>
									</select-->
								</td>
								<td >
									<select  name="technologyId" style="width:100px;">
										<c:forEach items="${ technologys }" var = "technology">
											<option <c:if test="${technology.id eq bean.technologyId }">selected="selected"</c:if> value="${technology.id }">${technology.name}</option>
										</c:forEach>
									</select>
								</td>
								<td name="companyCode" title="双击选择我司编号">
									<input type="text" name="myCompanyCode" style="width:110px;" ondblclick="popMyCompanyCode(this)" readonly="readonly"/>
								</td>
								<td title="双击选择我司颜色">
									<input type="text" name="myCompanyColor" style="width:110px;" value="" ondblclick="popMyCompanyColor(this);" readonly="readonly">
								</td>
								<td>
									<input type="text"  name="num" value="" style="width: 80px">
								</td>
								
								<td name="danwei" style="font-weight: bold;text-align: center;">条</td>
								<td><input type="text" name="mark" value=""></td>
								<td>
									<select  name="salesmanId" style="width:100px;">
										<option value="">请选择</option>
										<c:forEach items="${salesmanInfos }" var="saleman">
											<option value="${saleman.id }">${saleman.name }</option>
										</c:forEach>
									</select>
								</td>
								<td name="sum">0</td>
							</tr>
						</tbody>
					</table>
			
				</td>
				<!--td>
					图片预览<img alt="" src="http://d.hiphotos.baidu.com/baike/w%3D268/sign=9855e88c3912b31bc76cca2fbe1a3674/a8ec8a13632762d01cdbd074a0ec08fa503dc610.jpg">
				</td-->
			</tr>
		</table>
	</form>
	</div>
	
</body>
<script type="text/javascript">
	//var tr=$("#table1 tr[name=initfirst]").clone(true);
</script>
</html>