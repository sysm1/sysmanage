<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>回货进度查询</title>
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

body {
 font: normal 13px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
}

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
		
		$("#search").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			$("#delay").attr('value','');
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/processList/list.html');
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
		$("#edit").click("click", function() {//绑定修改按扭
			var cbox=getSelectedCheckbox();
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			//alert(cbox);
			//var f = $('#fenye');
			//f.attr('target','_blank');
			//f.attr('action','${pageContext.request.contextPath}/background/process/updateStatus.html?rStatus=1&oids='+cbox);
			//f.submit();
			window.location.href='${pageContext.request.contextPath}/background/process/updateStatus.html?rStatus=1&oids='+cbox;
			//alert("数据暂存成功");
		});
		$("#delaybtn").click("click", function() {
			$('#pageNow').attr('value',1);
			$("#delay").attr('value',1);
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/process/list.html');
			f.submit();
		});
		
		/***过滤查询**/
		$("#cloth_text").ligerComboBox({
	        url: '/background/pinyin/cloth.html',
	        valueField: 'id',
	        textField: 'clothName', 
	        selectBoxWidth: 215,
	        selectBoxHeight: 215,
	        autocomplete: true,
	        width: 215,
	        height:20,
	        onSelected:function(e) {
	            $("#clothId").val(e);
	            //alert($("#clothId").val());
	            var clothId=$("#clothId").val();
	            $.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/sample/queryMycompanyCodeByCloth.html', //要访问的后台地址
				    data: {clothId:clothId}, //要发送的数据
				    success: function(data){
				    	if(data!=null&&data!=''){
					    	var myCompanyCode = $("#myCompanyCode");
					    	myCompanyCode.empty();
					    	myCompanyCode.append($("<option>").text("请选择").val(""));
					    	for(var i=0;i<data.length;i++) {
					    	    var option = $("<option>").text(data[i]).val(data[i]);
					    	    myCompanyCode.append(option);
					    	}
				    	}else{
				    		//alert('没有相关联的我司编号');
				    	}
					}
				});
	        }
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
		
		
		$("#save").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			for(var i=0;i<cbox.length;i++){
				var f = $('#'+cbox[i]+'_form');
				f.attr('target','');
				f.attr('action','${pageContext.request.contextPath}/background/process/save.html?status=1');
				f.submit();
			}
			alert("数据已回");
			//location.reload();
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
	function loadGird(){
		grid.loadData();
	}
	
	/***增加一行**/
	var index=1;
	var newId=2;
	function addOneRow(itemId){
		$('#'+itemId+'returnDate').before('<input type="text"  name="returnDate" style="width:70px" value=""'+
				'onfocus="WdatePicker({isShowClear:true,readOnly:true})">');
		$('#'+itemId+'returnNum').before('<input type="text"  name="returnNum" value="" style="width: 60px"><br>');
		$('#'+itemId+'returnColor').before('<input type="text"  name="returnColor" value="" style="width: 60px"><br>');
		$('#'+itemId+'mark').before('<input type="text"  name="mark" value="" ><br>');
		$('#'+itemId+'zhiguan').before('<input type="text"  name="zhiguan" value="" style="width: 45px"><br>');
		$('#'+itemId+'kongcha').before('<input type="text"  name="kongcha" value="" style="width: 45px"><br>');
		$('#'+itemId+'jiaodai').before('<input type="text"  name="jiaodai" value="" style="width: 45px"><br>');
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
		f.attr('action','${pageContext.request.contextPath}/background/processList/list.html');
		f.submit();
	}
	/***点击**/
	function onclickTr(id){
		//obj.style.backgroundColor ="#EEDC82";
		for(var i=0;i<=16;i++){
			document.getElementById(i+""+id).style.backgroundColor ="#EEDC82";
		}
		document.getElementById(id+"checkId").checked=true;
	}
	/***选择一个checkbox**/
	function clickCheckId(id){
		var checkFlag=document.getElementById(id+"checkId").checked;
		if(checkFlag){
			for(var i=0;i<=16;i++){
				document.getElementById(i+""+id).style.backgroundColor ="#EEDC82";
			}
		}else{
			for(var i=0;i<=16;i++){
				document.getElementById(i+""+id).style.backgroundColor ="";
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
		for(var i=0;i<=16;i++){
			document.getElementById(i+""+id).style.backgroundColor ="";
		}
		document.getElementById(id+"checkId").checked=false;
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
	function showdetail(id){
		//alert(id);
		dialog = parent.$.ligerDialog.open({
			width : 1150,
			height : 350,
			url : rootPath + '/background/processList/view.html?id='+id,
			title : "回货进度信息查看",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
</script>
</head>
<body>
	<div class="divBody" style="width:1500px;">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<input type="hidden" id="delay" name="delay" value="">
				<table class="dataintable">
					<tr>
						<td>下单日期：</td>
						<td>
							<input type="text" name="returnDate" style="width:90px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">至
							<input type="text" name="returnDate" style="width:92px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</td>
						<td>工厂：</td>
						<td>
							<!-- select  id="factoryId" name="factoryId">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factoryInfos }" var = "factoryInfo">
									<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
								</c:forEach>
							</select-->
							<input type="hidden" id="factoryId" name="factoryId" value="${ bean.factoryId }">
							<input type="text" id="factory_text" style="width: 200px;" value="${factoryInfo.name }" 
								onchange="changeTextValue('factoryId',this);"/> 
						</td><td>
							布种：
						</td><td>
							<!--select id="clothId" name="clothId">
								<option value="">请选择布种</option>
								<c:forEach items="${ cloths }" var = "cloth">
									<option value="${cloth.id }" <c:if test="${bean.clothId eq cloth.id }" >selected='selected'</c:if> >${cloth.clothName}</option>
								</c:forEach>
							</select-->
							<input type="hidden" id="clothId" name="clothId" value="${ bean.clothId }">
						  	<input type="text" id="cloth_text" style="width: 200px;" value="${cloth.clothName }" 
						  		onchange="changeTextValue('clothId',this);"/>
						</td>
					</tr><tr>
						<td>&nbsp;&nbsp;编号：</td>
						<td>
							<input type="text" id="code" name="code" value="${bean.code }">
						</td><td>颜色:</td>
						<td>
							<select>
								<option>请选择</option>
							</select>
						</td><td>工艺:</td>
						<td>
							<select id="technologyId" name="technologyId">
								<option value="">请选择</option>
								<c:forEach items="${ technologys }" var = "technology">
									<option value="${technology.id }" <c:if test="${bean.technologyId eq technology.id }" >selected='selected'</c:if> >${technology.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr><tr>
						<td>回货日期：</td>
						<td>
							<input type="text" name="returnDate" style="width:90px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">至
							<input type="text" name="returnDate" style="width:92px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</td><td>状态:</td>
						<td>
							<select id="returnStatus" name="returnStatus">
								<option value="">请选择</option>
								<option value="0">未回</option>
								<option value="1">未回完</option>
								<option value="2">已回</option>
							</select>
						</td><td>备注:</td>
						<td>
							<input type="text" id="returnMark" name="returnMark" value="${bean.returnMark }">
						</td>		
					</tr><tr>	
						<td colspan="6" style="text-align: center;">
							<a class="btn btn-primary" href="javascript:void(0)" id="edit"> 修改</a>
							&nbsp;&nbsp;<a class="btn btn-primary" href="javascript:void(0)" id="search"> 查询</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="paging" class="pagclass" >
			<table border="1" id="mytable" class="dataintable">
				<tr>
					<th class="specalt" rowspan="2">
						<input type="checkbox" id="checkAll" name="checkAll" onclick="checkAllIds(this);">
					</th>
					<!--th rowspan="2">序号</th-->
					<th rowspan="2">&nbsp;状态&nbsp;</th>
					<th rowspan="2" style="width: 60px;">下单日期</th>
					<th style="min-width: 60px;" rowspan="2">工&nbsp;厂</th>
					<!--th colspan="11">下单</th-->
					<th colspan="16">实到</th>
				</tr><tr>
					<!--th style="min-width:60px;">&nbsp;布&nbsp;种&nbsp;</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					<th>&nbsp;工&nbsp;艺&nbsp;</th>
					<th>我司编号</th>
					<th>我司颜色</th>
					<th>纸管</th>
					<th>空差</th>
					<th>胶袋</th>
					<th>条数</th>
					<th>数量(KG)</th-->
					
					<th>收货单位</th>
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
					
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
				<form id="${item.id }_form" action="${ctx}/background/sample/add.html" method="post" enctype="multipart/form-data">
				<tr id="${item.id }" ondblclick="showdetail(${item.id });">
					<td style="text-align: center;" id="11_${item.id }">
						<input type="checkbox" id="${item.id }checkId" name="checkId" value="${item.id }" onclick="clickCheckId(${item.id });">
						<input type="hidden" id="summaryId" name="summaryId" value="${item.id }">
					</td>
					<!--td id="2_${item.id }">${item.id }</td-->
					<td id="13_${item.id }" name="${item.id }" title="双击查看详情">
						<c:if test="${item.returnStatus!=0 and item.status !='已回完' and  item.status !='未回完' and item.status !='未回'  and item.status !='已回'}">
						${item.status }
						</c:if>
					</td>
					<td id="14_${item.id }" name="${item.id }" title="<fmt:formatDate value='${item.orderDate }' pattern='yyyy年MM月dd日'/>" onclick="clearColor(${item.id});">
						<fmt:formatDate value='${item.orderDate }' pattern='MM-dd'/>
					</td>
					<td id="15_${item.id }" name="${item.id }" onclick="onclickTr(${item.id })">${item.factoryName }</td>
					
					<!--td id="5_${item.id }">${item.clothName }</td>
					<td id="6_${item.id }">${item.factoryCode }</td>
					<td id="7_${item.id }">${item.factoryColor }</td>
					
					<td id="8_${item.id }">${item.technologyName }</td>
					<td id="9_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyCode }</td>
					<td id="10_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyColor }</td>
					
					<td id="11_${item.id }">${item.zhiguan }</td>
					<td id="12_${item.id }">${item.kongcha }</td>
					<td id="13_${item.id }">${item.jiaodai }</td>
					<td id="14_${item.id }">${item.num }</td>
					<td id="15_${item.id }">${item.numKg }</td-->
					
					<td title="双击查看回货进度详情" name="${item.id }" id="12_${item.id }" >
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							${item1.factoryName }<br>
						</c:forEach>
					</td>
					<td id="16_${item.id }" name="${item.id }" style="width: 90px;" >
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.clothName }<br>
							</c:forEach>
						</c:if>
					</td>
					<td id="17_${item.id }" name="${item.id }" onclick="onclickTr(${item.id })" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnCode }<br>
							</c:forEach>
						</c:if>
					</td>
					
					<td id="18_${item.id }" name="${item.id }" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnColor }<br>
							</c:forEach>
						</c:if>
					</td>
					<td id="19_${item.id }" name="${item.id }" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.technologyName }<br>
							</c:forEach>
						</c:if>
					</td>
					<td id="20_${item.id }" name="${item.id }" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.myCompanyCode }<br>
							</c:forEach>
						</c:if>
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
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.myCompanyColor }<br>
							</c:forEach>
						</c:if>
					</td>
					
					<td id="22_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.zhiguan }<br>
							</c:forEach>
						</c:if>
					</td><td id="23_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.kongcha }<br>
							</c:forEach>
						</c:if>
					</td><td id="24_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.jiaodai }<br>
							</c:forEach>
						</c:if>
					</td>
					
					<td id="25_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnNum }<br>
							</c:forEach>
						</c:if>
					</td><td id="26_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnNumKg }<br>
							</c:forEach>
						</c:if>
					</td><td id="27_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.mark }<br>
							</c:forEach>
						</c:if>
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
				</tr>
				<script type="text/javascript">
					//alert(${item.returnStatus});
					if('${item.status }'=='未回完'||'${item.returnStatus}'==1){
						for(var i=11;i<=27;i++){
							document.getElementById(i+'_${item.id }').style.background="#7FFFD4";
						}
					}else if('${item.status }'=='已回完'||'${item.returnStatus}'==2){
						for(var i=11;i<=27;i++){
							document.getElementById(i+'_${item.id }').style.background="#FFFFE0";
						}

					}
				</script>
				</form>
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="19" style="text-align: center;font-size: 14px;">
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