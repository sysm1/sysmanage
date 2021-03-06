<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
jQuery.validator.addMethod("checkpass", function(value, element) {
	 return this.optional(element) || ((value.length <= 16) && (value.length>=6));
}, "密码由6至16位字符组合构成");
	$(function() {
		
		$("form").validate({
			submitHandler : function(form) {//必须写在验证前面，否则无法ajax提交
				$(form).ajaxSubmit({//验证新增是否成功
					type : "post",
					dataType:"json",
					success : function(data) {
						if (data.flag == "true") {
							$.ligerDialog.success('提交成功!', '提示', function() {
								//这个是调用同一个页面趾两个iframe里的js方法
								//account是iframe的id
								location.href=rootPath + '/background/process/list.html';
								//parent.role.loadGird();
								//closeWin();
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			},
			rules : {
				enable : {
					required : true
				}
			},
			messages : {
				enable : {
					required : "选择状态"
				}
			},
			errorPlacement : function(error, element) {//自定义提示错误位置
				$(".l_err").css('display','block');
				//element.css('border','3px solid #FFCCCC');
				$(".l_err").html(error.html());
			},
			success: function(label) {//验证通过后
				$(".l_err").css('display','none');
			}
		});
		
		$("#saveTemp").click("click", function() {//绑定暂存按扭
			if(!check()){
				return false;
			}
			if(!saveData('${pageContext.request.contextPath}/background/process/save.html?returnStatus=1')){
				alert("数据暂存成功");
				location.href=rootPath + '/background/process/list.html';
			}
		});
		$("#save").click("click", function() {//绑定查询按扭
			if(!check()){
				return false;
			}
			var returnCode=document.getElementsByName('${item.id }returnCode');
		    if(!checkYh(returnCode)){
		    	alert("工厂编号不能为空");
		    	return false;
		    }
		    var factoryColor=document.getElementsByName('${item.id }factoryColor');
		    if(!checkYh(factoryColor)){
		    	alert("工厂颜色不能为空");
		    	return false;
		    }
		    var myCompanyCode=document.getElementsByName('${item.id }myCompanyCode');
		    if(!checkYh(myCompanyCode)){
		    	alert("我司编号不能为空");
		    	return false;
		    }
		    var myCompanyColor=document.getElementsByName('${item.id }myCompanyColor');
		    if(!checkYh(myCompanyColor)){
		    	alert("我司颜色不能为空");
		    	return false;
		    }
		    var zhiguan=document.getElementsByName('${item.id }zhiguan');
		    if(!checkYh(zhiguan)){
		    	alert("纸管不能为空");
		    	return false;
		    }
		    var kongcha=document.getElementsByName('${item.id }kongcha');
		    if(!checkYh(kongcha)){
		    	alert("空差不能为空");
		    	return false;
		    }
		    var jiaodai=document.getElementsByName('${item.id }jiaodai');
		    if(!checkYh(jiaodai)){
		    	alert("胶袋不能为空");
		    	return false;
		    }var returnNum=document.getElementsByName('${item.id }returnNum');
		    if(!checkYh(returnNum)){
		    	alert("条数不能为空");
		    	return false;
		    }
		    var returnNumKg=document.getElementsByName('${item.id }returnNumKg');
		    if(!checkYh(returnNumKg)){
		    	alert("数量不能为空");
		    	return false;
		    }
			saveData('${pageContext.request.contextPath}/background/process/save.html?returnStatus=2');
			//alert(document.getElementsByName("returnNum").length);
			alert("数据已回");
			location.href=rootPath + '/background/process/list.html';
			//location.reload();
		});
	});
	
	function checkYh(obja){
		var length=obja.length;
		for(var i=0;i<length;i++){
			if(obja[i].value==''||null==obja[i].value){
				return false;
			}
		}
		return true;
	}
	function saveData(url1){
		//alert(document.getElementsByName("returnNum").length);
		var cbox=getSelectedCheckbox();
		var url=url1;
		var f = $('#form');
		//alert(document.getElementsByName(cbox[i]+"returnNum").length);
		//var url='${pageContext.request.contextPath}/background/process/save.html?returnStatus=2';
		var returnNums=document.getElementsByName("${item.id }returnNum");
		for(var j=0;j<returnNums.length;j++){
			url+="&returnNum="+returnNums[j].value;
		}
		
		var returnNumKgs=document.getElementsByName("${item.id }returnNumKg");
		for(var j=0;j<returnNumKgs.length;j++){
			url+="&returnNumKg="+returnNumKgs[j].value;
		}
		
		var kongchas=document.getElementsByName("${item.id }kongcha");
		for(var j=0;j<kongchas.length;j++){
			url+="&kongcha="+kongchas[j].value;
		}
		
		var jiaodais=document.getElementsByName("${item.id }jiaodai");
		for(var j=0;j<jiaodais.length;j++){
			url+="&jiaodai="+jiaodais[j].value;
		}
		//alert(url);
		//alert(f.serialize());
		f.attr('target','');
		//f.attr('action','${pageContext.request.contextPath}/background/process/save.html?status=1');
		//f.submit();
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: url+"&id=${item.id }", //要访问的后台地址
		    data: f.serialize(), //要发送的数据
		    success: function(data){
		    	//alert(data);
			},error : function(XMLHttpRequest, textStatus, errorThrown,data) {    
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(data);  
		     }
		});
	}
	$(function() {
		$("input:radio[value='${role.enable}']").attr('checked','true');
	});
	function saveWin() {
		$("#form").submit();
	}
	function closeWin() {
		 parent.$.ligerDialog.close(); //关闭弹出窗; //关闭弹出窗
		parent.$(".l-dialog,.l-window-mask").css("display","none"); 
	}
	/***增加一行**/
	var index=1;
	var newId=2;
	function addOneRow(itemId){
		var newtr=$("#table1 tr:last").clone();
  		newtr.insertAfter($("#table1 tr:last"));
  		for(var i=2;i<13;i++){
  			newtr.find("input").eq(i).attr("value",'');
  		}
  		newtr.find("input").eq(1).attr("value",'${item.clothName }');
  		newtr.find("input").eq(2).attr("value",'${item.technologyName }');
  		newtr.find("input").eq(3).attr("value",'${item.factoryCode }');
  		newtr.find("input").eq(4).attr("value",'${item.factoryColor }');
  		newtr.find("input").eq(5).attr("value",'${item.myCompanyCode }');
  		newtr.find("input").eq(6).attr("value",'${item.myCompanyColor }');
		/**
　  		$('#'+itemId+'returnDate').before('<input type="text"  name="'+itemId+'returnDate" style="width:70px" value="${nowTime}"'+
				'onfocus="WdatePicker({isShowClear:true,readOnly:true})">');
		$('#'+itemId+'returnNum1').after('<input type="text"  name="'+itemId+'returnNum" value="" style="width: 60px"><br>');
		$('#'+itemId+'returnNumKg1').before('<input type="text"  name="'+itemId+'returnNumKg" value="" style="width: 60px"><br>');
		$('#'+itemId+'returnColor1').before('<input type="text"  name="'+itemId+'returnColor" value="" style="width: 60px"><br>');
		//$('#'+itemId+'mark').before('<input type="text"  name="'+itemId+'mark" value="" ><br>');
		$('#'+itemId+'zhiguan1').before('<input type="text"  name="'+itemId+'zhiguan" value="" style="width: 45px"><br>');
		$('#'+itemId+'kongcha1').before('<input type="text"  name="'+itemId+'kongcha" value="" style="width: 45px"><br>');
		$('#'+itemId+'jiaodai1').before('<input type="text"  name="'+itemId+'jiaodai" value="" style="width: 45px"><br>');
		$('#'+itemId+'returnCode1').before('<input type="text"  name="'+itemId+'returnCode" value="" style="width: 90px"><br>');
		$('#'+itemId+'clothName1').before('<input type="text" ondblclick="selectCloth(this);" name="'+itemId+'clothName" value="" style="width: 90px"><br>');
		$('#'+itemId+'factoryColor1').before('<input type="text" name="'+itemId+'factoryColor" value="" style="width: 90px"><br>');
		$('#'+itemId+'myCompanyCode1').before('<input type="text" name="'+itemId+'myCompanyCode" value="" style="width: 90px"><br>');
		$('#'+itemId+'myCompanyColor1').before('<input type="text" name="'+itemId+'myCompanyColor" value="" style="width: 90px"><br>');
		$('#'+itemId+'technologyName1').before('<input type="text" name="'+itemId+'technologyName" value="" style="width: 90px" ondblclick="selectTechnologyName(this);"><br>');
		$('#'+itemId+'mark1').before('<input type="text" name="'+itemId+'mark" value="" style="width: 60px"><br>');
		//$('#'+itemId+'factoryName1').before('<input type="text" ondblclick="selectFactory(this);" name="'+itemId+'factoryName" value="" style="width: 90px"><br>');
		$('#'+itemId+'factoryName1').before('<input type="text" ondblclick="selectFactory(this);" name="shdw" value="" style="width: 90px"><br>');
		//document.getElementById(itemId+"returnCode1").innerHTML=document.getElementById(itemId+"returnCode1").innerHTML+'<input type="text"  name="'+itemId+'returnCode" value="" style="width: 70px"><br>';
		**/
		index++;
		newId++;
	}
	
	function copyOne(itemId){
		
		var newtr=$("#table1 tr:last").clone();
  		newtr.insertAfter($("#table1 tr:last"));
		/**
		//alert(1);
		//$('#'+itemId+'returnDate').before('<input type="text"  name="'+itemId+'returnDate" style="width:70px" value="${nowTime}"'+
		//'onfocus="WdatePicker({isShowClear:true,readOnly:true})">');
		var returnDate=$('#'+itemId+'returnDate').clone();
		alert(returnDate);
		//returnDate.insertAfter($("#table1 tr:last td:last"))
		$('#'+itemId+'returnDate').before(returnDate);
		$('#'+itemId+'returnNum1').after('<input type="text"  name="'+itemId+'returnNum" value="" style="width: 60px"><br>');
		$('#'+itemId+'returnNumKg1').before('<input type="text"  name="'+itemId+'returnNumKg" value="" style="width: 60px"><br>');
		$('#'+itemId+'returnColor1').before('<input type="text"  name="'+itemId+'returnColor" value="" style="width: 60px"><br>');
		//$('#'+itemId+'mark').before('<input type="text"  name="'+itemId+'mark" value="" ><br>');
		$('#'+itemId+'zhiguan1').before('<input type="text"  name="'+itemId+'zhiguan" value="" style="width: 45px"><br>');
		$('#'+itemId+'kongcha1').before('<input type="text"  name="'+itemId+'kongcha" value="" style="width: 45px"><br>');
		$('#'+itemId+'jiaodai1').before('<input type="text"  name="'+itemId+'jiaodai" value="" style="width: 45px"><br>');
		$('#'+itemId+'returnCode1').before('<input type="text"  name="'+itemId+'returnCode" value="" style="width: 90px"><br>');
		$('#'+itemId+'clothName1').before('<input type="text" ondblclick="selectCloth(this);" name="'+itemId+'clothName" value="" style="width: 90px"><br>');
		$('#'+itemId+'factoryColor1').before('<input type="text" name="'+itemId+'factoryColor" value="" style="width: 90px"><br>');
		$('#'+itemId+'myCompanyCode1').before('<input type="text" name="'+itemId+'myCompanyCode" value="" style="width: 90px"><br>');
		$('#'+itemId+'myCompanyColor1').before('<input type="text" name="'+itemId+'myCompanyColor" value="" style="width: 90px"><br>');
		$('#'+itemId+'technologyName1').before('<input type="text" name="'+itemId+'technologyName" value="" style="width: 90px" ondblclick="selectTechnologyName(this);"><br>');
		$('#'+itemId+'mark1').before('<input type="text" name="'+itemId+'mark" value="" style="width: 60px"><br>');
		//$('#'+itemId+'factoryName1').before('<input type="text" ondblclick="selectFactory(this);" name="'+itemId+'factoryName" value="" style="width: 90px"><br>');
		$('#'+itemId+'factoryName1').before('<input type="text" ondblclick="selectFactory(this);" name="shdw" value="" style="width: 90px"><br>');
		//document.getElementById(itemId+"returnCode1").innerHTML=document.getElementById(itemId+"returnCode1").innerHTML+'<input type="text"  name="'+itemId+'returnCode" value="" style="width: 70px"><br>';
		**/
		index++;
		newId++;
	}
	
	var cobject=null;
	function selectCloth(obj){
		cobject=obj;
		dialog = parent.$.ligerDialog.open({
			width : 350,
			height : 410,
			url : rootPath + '/background/cloth/addlist.html',
			title : "添加布种",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function addCloth(id){
		//alert(id);
		cobject.value=id;
	}
	
	function selectFactory(obj){
		cobject=obj;
		dialog = parent.$.ligerDialog.open({
			width : 400,
			height : 500,
			url : rootPath + '/background/factory/addlist.html',
			title : "添加工厂",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function selectTechnologyName(obj){
		//alert(obj);
		cobject=obj;
		dialog = parent.$.ligerDialog.open({
			width : 400,
			height : 500,
			url : rootPath + '/background/technology/addlist.html',
			title : "添加工艺",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function addFactory(name,id){
		//alert(cobject.id);
		cobject.value=name;
	}
	function fh(){
		location.href=rootPath + '/background/process/list.html';
	}
	/****1 工厂编号 ***/
	var arr=new Array();
	var arrindex=0;
	function checkValueInFlower(obj,type){
		arr[arrindex]=obj;
		//alert(obj.value);
		var url='/background/flower/checkValue.html?type='+type+"&value="+obj.value;
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: url, //要访问的后台地址
		    //data: f.serialize(), //要发送的数据
		    success: function(data){
		    	if(data=='0'){
		    		alert("所填数据在花号基本资料中不存在，请重新填写");
		    		//document.getElementById("saveTemp").style.display="none";
		    		//document.getElementById("save").style.display="none";
		    		obj.value=obj.value;
		    		//obj.focus();
		    		return false;
		    	}if(data=='1'){
		    		for(i=0;i<arr.length;i++){
		    			if(arr[i]==obj){
		    				arr[i]="";
		    			}
		    		}
		    		//document.getElementById("saveTemp").style.display="";
		    		//document.getElementById("save").style.display="";
		    	}
			},error : function(XMLHttpRequest, textStatus, errorThrown,data) {    
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(data);  
		     }
		});
		arrindex=arrindex+1;
	}
	function check(){
		for(i=0;i<arr.length;i++){
			if(arr[i]!=''){
				alert("数据添加不正确");
				arr[i].focus();
				return false;
			}
		}
		return true;
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 100%;"></div>
	<form id="form" action="${ctx}/background/sample/add.html" method="post" enctype="multipart/form-data">
		<input type="hidden" id="summaryId" name="summaryId" value="${item.id }">
		<table style="width: 100%; " class="dataintable" id="table1" name="table1">
			<tbody>
				<tr>
					<th style="text-align: right;">&nbsp;状态&nbsp;</th>
					<td id="1_${item.id }" colspan="2" style="text-align: left;">${item.returnStatusName }</td>
					<th style="text-align: right;">下单日期</th>
					<td style="text-align: left;">
						<fmt:formatDate value='${item.orderDate }' pattern='yyyy-MM-dd'/>
					</td>
					<th style="min-width: 60px;" style="text-align: right;">工&nbsp;厂</th>
					<td id="3_${item.id }" colspan="2" style="text-align: left;">${item.factoryName }</td>
					<th title="双击选择收货单位">收货单位</th>
					<td colspan="2">
						<c:if test="${item1.shdw ==null||item1.shdw ==''}">
							<input type="text" name="shdw" value="${facname }" 
								ondblclick="selectFactory(this);" style="width: 93%;"><br>
						</c:if><c:if test="${item1.shdw  != null&&item1.shdw!='' }">
							<input type="text" name="shdw" value="${item1.shdw }" ondblclick="selectFactory(this);" style="width: 93%;">
						</c:if>
					</td>
				</tr>
				<tr>
					<th colspan="11">下单</th>
				</tr><tr>
					<th style="min-width:60px;">&nbsp;布&nbsp;种&nbsp;</th>
					<th>&nbsp;工&nbsp;艺&nbsp;</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					
					<th>我司编号</th>
					<th>我司颜色</th>
					<th>纸管</th>
					<th>空差</th>
					<th>胶袋</th>
					<th colspan="2">条数</th>
					<!--th>数量(KG)</th-->
				</tr><tr>
					<td id="5_${item.id }">${item.clothName }</td>
					<td id="8_${item.id }">${item.technologyName }</td>
					<td id="6_${item.id }">${item.factoryCode }</td>
					<td id="7_${item.id }">${item.factoryColor }</td>
					
					<td id="9_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyCode }</td>
					<td id="10_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyColor }</td>
					
					<td id="11_${item.id }">${item.zhiguan }</td>
					<td id="12_${item.id }">${item.kongcha }</td>
					<td id="13_${item.id }">${item.jiaodai }</td>
					<td id="14_${item.id }" colspan="2">
						<c:if test="${item.num!=null }">${item.num }条</c:if>
						<c:if test="${item.numKg!=null }">${item.numKg }KG</c:if>
					</td>
					<!--td id="15_${item.id }">${item.numKg }</td-->
				</tr>
				<tr>
					<th colspan="13">实到</th>
				</tr><tr>
					<!--th>收货单位</th-->
					<th>布种</th>
					<th>工艺</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					
					<th>我司编号</th>
					<th>我司颜色</th>
					
					<th style="width: 50px;">纸管</th>
					<th style="width: 50px;">空差</th>
					<th style="width: 50px;">胶袋</th>
					<!--th >回货日期</th-->
					<th style="width: 68px;">条数</th>
					<th style="width: 68px;">数量(KG)</th>
					<th style="width: 68px;">备注</th>
					<th style="width: 68px;">回货日期</th>
				</tr>
				<c:if test="${fn:length(map[item.id]) ==0}">
				<tr>
					<!--td id="27_${item.id }" style="width: 90px;" title="双击选择收货单位">
						<c:if test="${item1.shdw ==null||item1.shdw ==''}">
							<input type="text" name="shdw" value="${facname }" 
								ondblclick="selectFactory(this);" style="width: 90px;"><br>
						</c:if><c:if test="${item1.shdw  != null&&item1.shdw!='' }">
							<input type="text" name="shdw" value="${item1.shdw }" ondblclick="selectFactory(this);" style="width: 90px;">
						</c:if>
					</td--><td id="26_${item.id }" style="width: 90px;" title="双击选择布种">
						<input type="text" name="${item.id }clothName" value="${item.clothName }" 
							ondblclick="selectCloth(this);" style="width: 90px;"><br>
					</td><td id="19_${item.id }" style="width: 90px;" title="双击选择工艺">
						<c:if test="${item1.technologyName ==null||item1.technologyName ==''}">
							<input type="text" name="${item.id }technologyName" value="${item.technologyName }" 
								ondblclick="selectTechnologyName(this);" style="width: 90px;"><br>
						</c:if><c:if test="${item1.technologyName  != null&&item1.technologyName!='' }">
							<input type="text" name="${item.id }technologyName" value="${item1.technologyName }" ondblclick="selectTechnologyName(this);" style="width: 90px;">
						</c:if>
					</td>
					
					<td id="17_${item.id }" onclick="onclickTr(${item.id })" style="width: 90px;">
					<c:if test="${item1.returnCode eq null }">
						<input type="text" name="${item.id }returnCode" value="${item.factoryCode }" style="width: 90px;">
					</c:if><c:if test="${item1.returnCode != null }">
						<input type="text" name="${item.id }returnCode" value="${item1.returnCode }" style="width: 90px;">
					</c:if>
					</td>
					
					<td id="18_${item.id }" style="width: 90px;">
					<c:if test="${item1.returnCode eq null }">
						<input type="text" name="${item.id }factoryColor" value="${item.factoryColor }" style="width: 90px;"><br>
					</c:if><c:if test="${item1.returnCode != null }">
						<input type="text" name="${item.id }factoryColor" value="${item1.returnColor }" style="width: 90px;"><br>
					</c:if>
					</td>
					
					<td id="20_${item.id }" style="width: 90px;">
					<c:if test="${item1.myCompanyCode eq null }">
						<input type="text" name="${item.id }myCompanyCode" value="${item.myCompanyCode }" style="width: 90px;">
					</c:if><c:if test="${item1.myCompanyCode != null }">
						<input type="text" name="${item.id }myCompanyCode" value="${item1.myCompanyCode }" style="width: 90px;">
					</c:if>
					</td>
					
					<td id="21_${item.id }" style="width: 90px;">
					<c:if test="${item1.myCompanyColor eq null }">
						<input type="text" name="${item.id }myCompanyColor" value="${item.myCompanyColor }" style="width: 90px;">
					</c:if><c:if test="${item1.myCompanyColor != null }">
						<input type="text" name="${item.id }myCompanyColor" value="${item1.myCompanyColor }" style="width: 90px;">
					</c:if>
					</td>
					
					<td id="22_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<input type="text" name="${item.id }zhiguan" value="${item1.zhiguan }" style="width: 45px;">
					</td><td id="23_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<input type="text" name="${item.id }kongcha" value="${item1.kongcha }" style="width: 45px;">
					</td><td id="24_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<input type="text" name="${item.id }jiaodai" value="${item1.jiaodai }" style="width: 45px;">
					</td>
					
					<td id="25_${item.id }" onclick="onclickTr(${item.id })">
						<input type="text"  name="${item.id }returnNum" value="${item1.returnNum }" style="width: 60px">
					</td><td id="4_${item.id }" onclick="onclickTr(${item.id })">
						<input type="text"  name="${item.id }returnNumKg" value="${item1.returnNumKg }" style="width: 60px">
					</td>
					<!--td id="14_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyColor }</td-->
					<!--td onclick="onclickTr(${item.id })">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }returnColor" value="${item1.returnColor }" style="width: 60px"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }returnColor" value="${item1.returnColor }" style="width: 60px"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id }returnColor" ></span>
					</td-->
					<!--td id="15_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }mark" value="" ><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }mark" value="${item1.mark }" ><br>
							</c:forEach>
						</c:if>
						<span id="${item.id }mark" ></span>
					</td-->
					<td>
						<input type="text"  name="${item.id }mark" value="${item1.mark }" style="width: 60px">
					</td><td id="8_${item.id }" style="width:120px;" onclick="onclickTr(${item.id })">
						<c:if test="${item1.returnDate ==null||item1.returnDate ==''}">
							<input type="text" name="${item.id }returnDate" style="width:70px" value="${nowTime }"
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:if><c:if test="${item1.returnDate  != null&&item1.returnDate!='' }">
							<input type="text"  name="${item.id }returnDate" style="width:70px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:if>
					</td>
				</tr>
				</c:if>
				<c:if test="${map[item.id] != null }">
				<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
				<tr>
					<!--td id="27_${item.id }" style="width: 90px;" title="双击选择收货单位">
						<c:if test="${item1.shdw ==null||item1.shdw ==''}">
							<input type="text" name="shdw" value="${facname }" 
								ondblclick="selectFactory(this);" style="width: 90px;"><br>
						</c:if><c:if test="${item1.shdw  != null&&item1.shdw!='' }">
							<input type="text" name="shdw" value="${item1.shdw }" ondblclick="selectFactory(this);" style="width: 90px;">
						</c:if>
					</td--><td id="26_${item.id }" style="width: 90px;" title="双击选择布种">
						<c:if test="${item1.clothName ==null||item1.clothName ==''}">
							<input type="text" name="${item.id }clothName" value="${item.clothName }" 
								ondblclick="selectCloth(this);" style="width: 90px;"><br>
						</c:if><c:if test="${item1.clothName  != null&&item1.clothName!='' }">
							<input type="text" name="${item.id }clothName" value="${item1.clothName }" ondblclick="selectCloth(this);" style="width: 90px;">
							<input type="hidden" name="${item.id }clothId" value="${item1.clothId }" style="width: 90px;"><br>
						</c:if>
						<span id="${item.id}clothName1" ></span>
					</td><td id="19_${item.id }" style="width: 90px;" title="双击选择工艺">
						<c:if test="${item1.technologyName ==null||item1.technologyName ==''}">
							<input type="text" name="${item.id }technologyName" value="${item.technologyName }" 
								ondblclick="selectCloth(this);" style="width: 90px;"><br>
						</c:if><c:if test="${item1.technologyName  != null&&item1.technologyName!='' }">
							<input type="text" name="${item.id }technologyName" value="${item1.technologyName }" ondblclick="selectTechnologyName(this);" style="width: 90px;">
						</c:if>
					</td>
					
					<td id="17_${item.id }" onclick="onclickTr(${item.id })" style="width: 90px;">
						<input type="text" name="${item.id }returnCode" onblur="checkValueInFlower(this,1);" value="${item1.returnCode }" style="width: 90px;">
					</td>
					
					<td id="18_${item.id }" style="width: 90px;">
						<input type="text" name="${item.id }factoryColor" onblur="checkValueInFlower(this,4);" value="${item1.returnColor }" style="width: 90px;"><br>
					</td>
					
					<td id="20_${item.id }" style="width: 90px;">
						<input type="text" name="${item.id }myCompanyCode" onblur="checkValueInFlower(this,2);" value="${item1.myCompanyCode }" style="width: 90px;">
					</td>
					
					<td id="21_${item.id }" style="width: 90px;">
						<input type="text" name="${item.id }myCompanyColor" onblur="checkValueInFlower(this,3);" value="${item1.myCompanyColor }" style="width: 90px;">
					</td>
					
					<td id="22_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<input type="text" name="${item.id }zhiguan" value="${item1.zhiguan }" style="width: 45px;">
					</td><td id="23_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<input type="text" name="${item.id }kongcha" value="${item1.kongcha }" style="width: 45px;">
					</td><td id="24_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<input type="text" name="${item.id }jiaodai" value="${item1.jiaodai }" style="width: 45px;">
					</td>
					
					<td id="25_${item.id }" onclick="onclickTr(${item.id })">
						<input type="text"  name="${item.id }returnNum" value="${item1.returnNum }" style="width: 60px">
					</td><td id="4_${item.id }" onclick="onclickTr(${item.id })">
						<input type="text"  name="${item.id }returnNumKg" value="${item1.returnNumKg }" style="width: 60px">
					</td>
					<!--td id="14_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyColor }</td-->
					<!--td onclick="onclickTr(${item.id })">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }returnColor" value="${item1.returnColor }" style="width: 60px"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }returnColor" value="${item1.returnColor }" style="width: 60px"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id }returnColor" ></span>
					</td-->
					<!--td id="15_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }mark" value="" ><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }mark" value="${item1.mark }" ><br>
							</c:forEach>
						</c:if>
						<span id="${item.id }mark" ></span>
					</td-->
					<td>
						<input type="text"  name="${item.id }mark" value="${item1.mark }" style="width: 60px">
					</td><td id="8_${item.id }" style="width:120px;" onclick="onclickTr(${item.id })">
						<c:if test="${item1.returnDate ==null||item1.returnDate ==''}">
							<input type="text" name="${item.id }returnDate" style="width:70px" value="${nowTime }"
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:if><c:if test="${item1.returnDate  != null&&item1.returnDate!='' }">
							<input type="text"  name="${item.id }returnDate" style="width:70px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:if>
					</td>
				</tr>
				</c:forEach>
				</c:if>
			</tbody>
		</table>
		<table style="width: 100%;">
			<tr>
				<td colspan="14">
					<div class="l_btn_centent">
						<a class="btn btn-primary" href="javascript:void(0)" onclick="copyOne(${item.id });">复制一行</a>
						<a class="btn btn-primary" href="javascript:void(0)" id="closeWin"
							onclick="addOneRow(${item.id });" ><span>新增回货</span> </a>
						<a class="btn btn-primary" href="javascript:void(0)" id="saveTemp"> 
							暂存数据
						</a>
						<a class="btn btn-info" href="javascript:void(0)" id="save"> 
							已回
						</a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="btn btn-primary" href="javascript:void(0)" id="closeWin"
							onclick="fh()"><span>返回</span> </a>
					</div>
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>