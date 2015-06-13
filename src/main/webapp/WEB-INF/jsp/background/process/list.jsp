<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
.ordersearchDivCss { 
	position: absolute; 
	z-index: 100; 
	display: block; 
	padding-left: 150px;
}

/* CSS Document */

text{height:3px}
a {
 color: #c75f3e;
}

#mytable {
 width: 100%;
 padding: 0;
 margin: 0;
}

caption {
 padding: 0 0 5px 0;
 font: italic 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 text-align: right;
}

th {
 font: bold 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 letter-spacing: 2px;
 text-transform: uppercase;
 text-align: center;
 padding: 6px 5px 6px;
}

th.nobg {
 border-top: 0;
 border-left: 0;
 border-right: 1px solid #C1DAD7;
 background: none;
}

#mytable td {
 border-left: 1px solid #C1DAD7;
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 font-size:12px;
 padding: 2px 3px 2px ;
}

.lanyuan_bb{
border-bottom: 1px solid #C1DAD7;
}

td.alt {
 background: #F5FAFA;
 color: #797268;
}

th.spec {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #fff ;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
}

th.specalt {
 border-left: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 background: #f5fafa ;
 font: bold 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #797268;
}
</style>

<script type="text/javascript">
	var dialog;
	var grid;
	$(function() {
		$("#seach").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			$("#delay").attr('value','');
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/process/list.html');
			f.submit();
		});
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/role/addUI.html',
				title : "增加角色",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		$("#saveTemp").click("click", function() {//绑定暂存按扭
			if(!saveData('${pageContext.request.contextPath}/background/process/save.html?returnStatus=0')){
				alert("数据暂存成功");	
			}
		});
		$("#delaybtn").click("click", function() {
			$('#pageNow').attr('value',1);
			$("#delay").attr('value',1);
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/process/list.html');
			f.submit();
		});
		$("#save").click("click", function() {//绑定查询按扭
			saveData('${pageContext.request.contextPath}/background/process/save.html?returnStatus=2');
			//alert(document.getElementsByName("returnNum").length);
			alert("数据已回");
			location.reload();
		});
		
		/***过滤查询**/
		$("#factory_text").ligerComboBox({
	        url: '/background/pinyin/factory.html',
	        valueField: 'id',
	        textField: 'name', 
	        selectBoxWidth: 220,
	        autocomplete: true,
	        width: 220,
	        height:20,
	        onSelected:function(e) {
	            $("#factoryId").val(e);
	             // alert($("#factoryId").val());
	        }
	   });
		
		$("#deleteView").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox=="") {
				parent.$.ligerDialog.alert("请选择删除项！！");
				return;
			}
			parent.$.ligerDialog.confirm('删除后不能恢复，确定删除吗？', function(confirm) {
				if (confirm) {
					$.ajax({
					    type: "post", //使用get方法访问后台
					    dataType: "json", //json格式的数据
					    async: false, //同步   不写的情况下 默认为true
					    url: rootPath + '/background/role/deleteById.html', //要访问的后台地址
					    data: {ids:cbox.join(",")}, //要发送的数据
					    success: function(data){
					    	if (data.flag == "true") {
					    		parent.$.ligerDialog.success('删除成功!', '提示', function() {
					    			loadGird();//重新加载表格数据
								});
							}else{
								parent.$.ligerDialog.warn("删除失败！！");
							}
						}
					});
				}
			});
		});
	});
	
	function saveData(url1){
		//alert(document.getElementsByName("returnNum").length);
		var cbox=getSelectedCheckbox();
		if(cbox==""){
			parent.$.ligerDialog.alert("请选择一条记录修改");
			return false;
		}
		for(var i=0;i<cbox.length;i++){
			var url=url1;
			var f = $('#'+cbox[i]+'_form');
			//alert(document.getElementsByName(cbox[i]+"returnNum").length);
			//var url='${pageContext.request.contextPath}/background/process/save.html?returnStatus=2';
			var returnNums=document.getElementsByName(cbox[i]+"returnNum");
			for(var j=0;j<returnNums.length;j++){
				url+="&returnNum="+returnNums[j].value;
			}
			
			var returnNumKgs=document.getElementsByName(cbox[i]+"returnNumKg");
			for(var j=0;j<returnNumKgs.length;j++){
				url+="&returnNumKg="+returnNumKgs[j].value;
			}
			
			var kongchas=document.getElementsByName(cbox[i]+"kongcha");
			for(var j=0;j<kongchas.length;j++){
				url+="&kongcha="+kongchas[j].value;
			}
			
			var jiaodais=document.getElementsByName(cbox[i]+"jiaodai");
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
			    url: url+"&id="+cbox[i], //要访问的后台地址
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
	}
	
	function loadGird(){
		grid.loadData();
	}
	
	/***增加一行**/
	var index=1;
	var newId=2;
	function addOneRow(itemId){
		//$('#'+itemId+'returnDate').before('<input type="text"  name="'+itemId+'returnDate" style="width:70px" value=""'+
		//		'onfocus="WdatePicker({isShowClear:true,readOnly:true})">');
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
		$('#'+itemId+'technologyName1').before('<input type="text" name="'+itemId+'technologyName" value="" style="width: 90px"><br>');
		$('#'+itemId+'mark1').before('<input type="text" name="'+itemId+'mark" value="" style="width: 60px"><br>');
		//document.getElementById(itemId+"returnCode1").innerHTML=document.getElementById(itemId+"returnCode1").innerHTML+'<input type="text"  name="'+itemId+'returnCode" value="" style="width: 70px"><br>';
		index++;
		newId++;
	}
	
	/**
	 * 获取选中的值
	 */
	function getSelectedCheckbox() {
		var arr = [];
		$('input[name="checkId"]:checked').each(function() {
			arr.push($(this).val());
		});
		return arr;
	};
	
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/process/list.html');
		f.submit();
	}
	/***点击**/
	var allsize=26;
	function onclickTr(id){
		//obj.style.backgroundColor ="#EEDC82";
		for(var i=0;i<=allsize;i++){
			document.getElementById(i+"_"+id).style.backgroundColor ="#EEDC82";
		}
		document.getElementById(id+"checkId").checked=true;
	}
	/***选择一个checkbox**/
	function clickCheckId(id){
		var checkFlag=document.getElementById(id+"checkId").checked;
		if(checkFlag){
			for(var i=0;i<=allsize;i++){
				document.getElementById(i+"_"+id).style.backgroundColor ="#EEDC82";
			}
		}else{
			for(var i=0;i<=allsize;i++){
				document.getElementById(i+"_"+id).style.backgroundColor ="";
			}
		}
	}
	/**全选checkbox**/
	function checkAllIds(obj){
		var falg=obj.checked;
		var checkIds=document.getElementsByName("checkId");
		for(var i=0;i<checkIds.length;i++){
			checkIds[i].checked=falg;
			clickCheckId(checkIds[i].value);
		}
	}
	/**去除颜色**/
	function clearColor(id){
		for(var i=0;i<=allsize;i++){
			document.getElementById(i+"_"+id).style.backgroundColor ="";
		}
		document.getElementById(id+"checkId").checked=false;
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
	var cobject=null;
	function selectCloth(obj){
		cobject=obj;
		dialog = parent.$.ligerDialog.open({
			width : 350,
			height : 410,
			url : rootPath + '/background/cloth/addlist.html',
			title : "增加角色",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function addCloth(id){
		//alert(id);
		cobject.value=id;
	}
</script>
</head>
<body>
	<div class="divBody" style="width:2000px;">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<input type="hidden" id="delay" name="delay" value="">
				<table class="dataintable">
					<tr>
						<td>工厂：</td>
						<td>
							<!--select  id="factoryId" name="factoryId">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factoryInfos }" var = "factoryInfo">
									<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
								</c:forEach>
							</select-->
							<input type="hidden" id="factoryId" name="factoryId" value="${ bean.factoryId }">
							<input type="text" id="factory_text" style="width: 200px;" value="${factoryInfo.name }" 
								onchange="changeTextValue('factoryId',this);"/> 
						</td><td>&nbsp;&nbsp;编号：</td>
						<td>
							<input type="text" id="code" name="code" value="${bean.code }">
						</td><td>
							&nbsp;&nbsp;<a class="btn btn-primary" href="javascript:void(0)" id="seach"> <span>查询</span></a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="saveTemp"> 
				暂存数据
			</a>
			<a class="btn btn-info" href="javascript:void(0)" id="save"> 
				已回
			</a>
			<a class="btn btn-info" href="javascript:void(0)" id="delaybtn"> 
				拖延${delayDates }单
			</a>
		</div>
		<div id="paging" class="pagclass" >
			<table border="1" id="mytable" class="dataintable">
				<tr>
					<th class="specalt" rowspan="2">
						<input type="checkbox" id="checkAll" name="checkAll" onclick="checkAllIds(this);">
					</th>
					<th rowspan="2">序号</th>
					<!--th rowspan="2">&nbsp;状态&nbsp;</th-->
					<th rowspan="2" style="width: 60px;">下单日期</th>
					<th style="min-width: 60px;" rowspan="2">工&nbsp;厂</th>
					<th colspan="11">下单</th>
					<th colspan="16">实到</th>
				</tr><tr>
					<th style="min-width:60px;">&nbsp;布&nbsp;种&nbsp;</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					<th>&nbsp;工&nbsp;艺&nbsp;</th>
					<th>我司编号</th>
					<th>我司颜色</th>
					<th>纸管</th>
					<th>空差</th>
					<th>胶袋</th>
					<th>条数</th>
					<th>数量(KG)</th>
					
					<th>布种</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					<th>工艺</th>
					<th>我司编号</th>
					<th>我司颜色</th>
					
					<th style="width: 50px;">纸管</th>
					<th style="width: 50px;">空差</th>
					<th style="width: 50px;">胶袋</th>
					<!--th >回货日期</th-->
					<th style="width: 68px;">条数</th>
					<th style="width: 68px;">数量(KG)</th>
					<th style="width: 68px;">备注</th>
					<th></th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
				<form id="${item.id }_form" action="${ctx}/background/sample/add.html" method="post" enctype="multipart/form-data">
				<tr id="${item.id }">
					<td style="text-align: center;" id="0_${item.id }">
						<input type="checkbox" id="${item.id }checkId" name="checkId" value="${item.id }" onclick="clickCheckId(${item.id });">
						<input type="hidden" id="summaryId" name="summaryId" value="${item.id }">
					</td>
					<td id="2_${item.id }">${item.id }</td>
					<!--td id="1_${item.id }">${item.returnStatusName }</td-->
					<td id="16_${item.id }" title="<fmt:formatDate value='${item.orderDate }' pattern='yyyy年MM月dd日'/>" onclick="clearColor(${item.id});">
						<fmt:formatDate value='${item.orderDate }' pattern='yyyy/MM/dd'/>
					</td>
					<td id="3_${item.id }" onclick="onclickTr(${item.id })">${item.factoryName }</td>
					<td id="5_${item.id }">${item.clothName }</td>
					<td id="6_${item.id }">${item.factoryCode }</td>
					<td id="7_${item.id }">${item.factoryColor }</td>
					
					<td id="8_${item.id }">${item.technologyName }</td>
					<td id="9_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyCode }</td>
					<td id="10_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyColor }</td>
					
					<td id="11_${item.id }">${item.zhiguan }</td>
					<td id="12_${item.id }">${item.kongcha }</td>
					<td id="13_${item.id }">${item.jiaodai }</td>
					<td id="14_${item.id }">${item.num }</td>
					<td id="15_${item.id }">${item.numKg }</td>
					
					<td id="26_${item.id }" style="width: 90px;" title="双击选择布种">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }clothName" value="${item.clothName }" 
								ondblclick="selectCloth(this);" style="width: 90px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }clothName" value="${item1.clothName }" ondblclick="selectCloth(this);" style="width: 90px;">
								<input type="hidden" name="${item.id }clothId" value="${item1.clothId }" style="width: 90px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}clothName1" ></span>
					
					</td>
					
					<td id="17_${item.id }" onclick="onclickTr(${item.id })" style="width: 90px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }returnCode" value="${item.factoryCode }" style="width: 90px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }returnCode" value="${item1.returnCode }" style="width: 90px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}returnCode1" ></span>
					</td>
					
					<td id="18_${item.id }" style="width: 90px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }factoryColor" value="${item.factoryColor }" style="width: 90px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }factoryColor" value="${item1.returnColor }" style="width: 90px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}factoryColor1" ></span>
					</td>
					<td id="19_${item.id }" style="width: 90px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }technologyName" value="${item.technologyName }" style="width: 90px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }technologyName" value="${item1.technologyName }" style="width: 90px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}technologyName1" ></span>
					</td>
					<td id="20_${item.id }" style="width: 90px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }myCompanyCode" value="${item.myCompanyCode }" style="width: 90px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }myCompanyCode" value="${item1.myCompanyCode }" style="width: 90px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}myCompanyCode1" ></span>
					</td>
					
					
					<!--td id="8_${item.id }" style="width:120px;" onclick="onclickTr(${item.id })">
					<c:if test="${fn:length(map[item.id]) ==0}">
						<input type="text" name="${item.id }returnDate" style="width:70px" value=""
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
					</c:if><c:if test="${map[item.id] != null }">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<input type="text" name="${item.id }returnDate" style="width:70px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:forEach>
					</c:if>
						<span id="${item.id }returnDate" onclick="addOneRow(${item.id });" style="cursor:pointer;vertical-align:bottom;">
							<img alt="点击新增编号" width="20px;" src="../../images/jiahao.jpg" />
						</span>
					</td-->
					<td id="21_${item.id }" style="width: 90px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }myCompanyColor" value="${item.myCompanyColor }" style="width: 90px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }myCompanyColor" value="${item1.myCompanyColor }" style="width: 90px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}myCompanyColor1" ></span>
					</td>
					
					<td id="22_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }zhiguan" value="${item.zhiguan }" style="width: 45px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }zhiguan" value="${item1.zhiguan }" style="width: 45px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}zhiguan1" ></span>
					</td><td id="23_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }kongcha" value="${item.kongcha }" style="width: 45px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }kongcha" value="${item1.kongcha }" style="width: 45px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}kongcha1" ></span>
					</td><td id="24_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text" name="${item.id }jiaodai" value="${item.jiaodai }" style="width: 45px;"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text" name="${item.id }jiaodai" value="${item1.jiaodai }" style="width: 45px;"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id}jiaodai1" ></span>
					</td>
					
					<td id="25_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text"  name="${item.id }returnNum" value="${item.num }" style="width: 60px"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text"  name="${item.id }returnNum" value="${item1.returnNum }" style="width: 60px"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id }returnNum1" ></span>
					</td><td id="4_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text"  name="${item.id }returnNumKg" value="${item.numKg }" style="width: 60px"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text"  name="${item.id }returnNumKg" value="${item1.returnNumKg }" style="width: 60px"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id }returnNumKg1" ></span>
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
						<c:if test="${fn:length(map[item.id]) ==0}">
							<input type="text"  name="${item.id }mark" value="${item.mark }" style="width: 60px"><br>
						</c:if><c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								<input type="text"  name="${item.id }mark" value="${item1.mark }" style="width: 60px"><br>
							</c:forEach>
						</c:if>
						<span id="${item.id }mark1" ></span>
					</td>
					<td>
					<span id="${item.id }returnDate" onclick="addOneRow(${item.id });" 
						style="cursor:pointer;vertical-align:bottom;font-size: 24px;font-weight: bold;">
					+
					</span></td>
				</tr>
				</form>
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="15" style="text-align: center;font-size: 14px;">
<div id="pagelist">
  <ul style="font-size: 14px;">
  	<c:if test="${pageView.pageNow==1}">
  		<li><a href="#">首页</a></li>
  		<li><a href="#">上一页</a></li>
  	</c:if><c:if test="${pageView.pageNow>1}">
  		<li><a href="javascript:page(1)">首页</a></li>
    	<li><a href="javascript:page(${pageView.pageNow-1>0?pageView.pageNow-1:1 })">上一页</a></li>
  	</c:if>
    
    <c:if test="${pageView.pageNow>3 }"><li style="width:15px;border: 0">...</li></c:if>
    <c:if test="${pageView.pageNow>2 }">
		<li><a href="javascript:page(${pageView.pageNow-2 })">${pageView.pageNow-2 }</a></li>
	</c:if><c:if test="${pageView.pageNow>1 }">					
		<li><a href="javascript:page(${pageView.pageNow-1 })">${pageView.pageNow-1 }</a></li>
	</c:if>	
		<li class="current">${pageView.pageNow }</li>
	<c:if test="${pageView.pageCount-1>=pageView.pageNow }">
		<li><a href="javascript:page(${pageView.pageNow+1 })">${pageView.pageNow+1 }</a></li>
	</c:if><c:if test="${pageView.pageCount-2>=pageView.pageNow }">
		<li><a href="javascript:page(${pageView.pageNow+2 })">${pageView.pageNow+2 }</a></li>
	</c:if><c:if test="${pageView.pageCount-3>=pageView.pageNow }">
		<li style="width:15px;border: 0">...</li>
	</c:if>
    
    <c:if test="${pageView.pageNow>=pageView.pageCount }">
		<li><a href="#">下一页</a></li>
		<li><a href="#">尾页</a></li>
	</c:if><c:if test="${pageView.pageNow<pageView.pageCount }">
		<li><a href="javascript:page(${pageView.pageNow+1 })">下一页</a></li>
		<li><a href="javascript:page(${pageView.pageCount })">尾页</a></li>
	</c:if>
	
    <li class="pageinfo">第${pageView.pageNow }页</li>
    <li class="pageinfo">共${pageView.pageCount }页</li>
    <li class="pageinfo">共${pageView.rowCount }条</li>
  </ul>
</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<iframe id="iframe" name="iframe" style="display: none"></iframe>
</body>
</html>