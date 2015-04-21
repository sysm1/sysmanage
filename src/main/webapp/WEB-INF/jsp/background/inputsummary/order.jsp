<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/selectUI/css/163css.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="css/selectUI/js/163css.js"></script>

<%@ include file="/common/header.jsp"%>
<style type="text/css">
	.l_right{
		text-align: right;width:110px;
	}
	.l_left{
		text-align: left;width:221px;
	}
	.selectClss{
		height:30px;
	}
	.shortselect{
		background:#fafdfe;
		height:28px;
		line-height:28px;
		border:1px solid #9bc0dd;
		-moz-border-radius:2px;
		-webkit-border-radius:2px;
		border-radius:2px;
	}
</style>
<script type="text/javascript">

var dialog;
var grid;
var delarr = [];
$(function() {
	$("#search").click("click", function() {//绑定查询按扭
		dialog = parent.$.ligerDialog.open({
			width : 750,
			height : 450,
			url : rootPath + '/background/ordersummary/list.html?flag=1&clothId=${inputsummary.clothId }&myCompanyCode=${inputsummary.myCompanyCode }'+
						'&myCompanyColor=${inputsummary.myCompanyColor }',
			title : "修改下单预录入",
			isHidden : true
		});
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
	$("#refresh").click("click", function() {
		window.location.reload();
	});
	$("#order").click("click", function() {//下单录入页面
		var cbox=getSelectedCheckbox();
		//window.location.href=rootPath + "/background/inputsummary/order.html?id="+cbox.join(",");
		
		dialog = parent.$.ligerDialog.open({
			width : 700,
			height : 500,
			url : rootPath + "/background/inputsummary/order.html?id="+cbox.join(","),
			title : "开始下单",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
		
	});
	$("#editView").click("click", function() {//绑定编辑按扭
		var cbox=getSelectedCheckbox();
		if (cbox.length > 1||cbox=="") {
			parent.$.ligerDialog.alert("只能选中一个");
			return;
		}
		dialog = parent.$.ligerDialog.open({
			width : 950,
			height : 550,
			url : rootPath + '/background/input/editUI.html?addId='+cbox[0].split("_")[0],
			title : "修改下单预录入",
			isHidden : false
		});
	});
	$("#delete").click("click", function() {//绑定删除按扭
		var cbox=getSelectedCheckbox();
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
				    url: rootPath + '/background/inputsummary/deleteById.html', //要访问的后台地址
				    data: {ids:cbox.join(",")}, //要发送的数据
				    success: function(data){
				    	if (data.flag == "true") {
				    		parent.$.ligerDialog.success('删除成功!', '提示', function() {
				    			for(var i=0;i<delarr.length;i++){
				    				//alert(document.getElementById(delarr[i]).parentNode.parentNode.style.display);
				    				document.getElementById(delarr[i]).parentNode.parentNode.style.display="none";
				    			}
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
							parent.sample.loadGird();
							closeWin();
						});
						//parent.window.document.getElementById("username").focus();
					} else {
						$.ligerDialog.warn("提交失败！！");
					}
				}
			});
		}		
	});
});



	function saveWin() {
		var factoryId=$("#factoryId").val();
		if(factoryId==""){
			alert("工厂不能为空");
			$("#factoryId").focus();
			return false;
		}
		var technologyId=$("#technologyId").val();
		if(technologyId==""){
			alert("工艺不能为空");
			$("#technologyId").focus();
			return false;
		}
		var factoryCode=$("#factoryCode").val();
		if(factoryCode==""){
			alert("工厂编号不能为空");
			$("#factoryCode").focus();
			return false;
		}
		var factoryColor=$("#factoryColor").val();
		if(factoryColor==""){
			alert("工厂颜色不能为空");
			$("#factoryColor").focus();
			return false;
		}
		//$("#form").submit();
		
		$("#form").ajaxSubmit({//验证新增是否成功
			type : "post",
			dataType:"json",
			success : function(data) {
				if (data.flag == "true") {
					$.ligerDialog.success('提交成功!', '提示', function() {
						//这个是调用同一个页面趾两个iframe里的js方法
						//account是iframe的id
						window.location.href=rootPath + "/background/inputsummary/list.html";
						//parent.input.loadGird();
						//closeWin();
					});
					//parent.window.document.getElementById("username").focus();
				} else {
					$.ligerDialog.warn("提交失败！！");
				}
			}
		});
		
		
	}
	function changeNum(obj){
		var beforNum=$("#num1").val();
		var nowNum=obj.value;
		if(nowNum==''){
			$("#num").attr("value",beforNum);
		}
		var chae=parseInt(nowNum)-parseInt(beforNum);
		if(chae>0){
			$("#balancetext").show();
			$("#balance").attr("value",chae);
			$("#ywy").show();
			$("#ywy2").show();
		}else if(chae<0){
			alert("修改后的数量不能小于当前数量！");
			$("#num").attr("value",beforNum);
			$("#balancetext").hide();
			$("#ywy").hide();
			$("#ywy2").hide();
		}
	}
	
	/***添加到花号基本资料*/
	function addtoflower(code){
		var factoryId=$('#factoryId').val();
		var clothId=$('#clothId').val();
		var myCompanyCode=$('#myCompanyCode').val();
		var myCompanyColor=$('#myCompanyColor').val();
		var technologyId=$('#technologyId').val();
		var factoryCode=$('#factoryCode').val();
		dialog = parent.$.ligerDialog.open({
			width : 750,
			height : 500,
			url : rootPath + '/background/inputsummary/addtoFlowerUI.html?factoryId='+factoryId+
					"&myCompanyCode="+myCompanyCode+"&clothId="+clothId+"&myCompanyColor="+myCompanyColor+
					'&technologyId='+technologyId+"&factoryCode="+factoryCode,
			title : "花号修改",
			isHidden : false
		});
	}
	
	function changeFactory(obj){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/allowance/queryByClothAndFactory.html?factoryId='+obj.value+'&clothId=${inputsummary.clothId }', //要访问的后台地址
		    data: {}, //要发送的数据
		    success: function(data){
		    	$('#clothAllowance')[0].innerHTML=data;
			},error : function(XMLHttpRequest, textStatus, errorThrown,data) {    
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(data);  
		     }
		});
	}
	
	function overrideText(data){
		var technology=data[4].innerHTML;
		var factory=data[7].innerHTML;//工厂名称
		var factoryCode=data[8].innerHTML;//工厂编号
		var factoryColor=data[9].innerHTML;//工厂颜色
		var fac=document.getElementById("factoryId");
		var tec=document.getElementById("technologyId");//工艺
		var facCode=document.getElementById("factoryCode");//工厂编号 
		var facColor=document.getElementById("factoryColor");
		for(var i=0;i<fac.options.length;i++){
			if(fac.options[i].text.trim()==factory.trim()){
				fac.options[i].selected='selected';
			}
		}
		//设定工艺
		for(var i=0;i<tec.options.length;i++){
			if(tec.options[i].text.trim()==technology.trim()){
				tec.options[i].selected='selected';
			}
		}
		//设定工厂编号
		for(var i=0;i<facCode.options.length;i++){
			if(facCode.options[i].text.trim()==factoryCode.trim()){
				facCode.options[i].selected='selected';
			}
		}
		//设定工厂颜色
		for(var i=0;i<facColor.options.length;i++){
			if(facColor.options[i].text.trim()==factoryColor.trim()){
				facColor.options[i].selected='selected';
			}
		}
	}
	
	function changeColor(){
		document.getElementById("myCompanyCodediv").style.color="";
		document.getElementById("myCompanyColor").style.color="";
		location.reload();
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/ordersummary/add.html" method="post">
		<input type="hidden" id="clothId" name="clothId" value="${inputsummary.clothId }">
		<input type="hidden" id="myCompanyCode" name="myCompanyCode" value="${inputsummary.myCompanyCode }">
		<input type="hidden" id="myCompanyColor" name="myCompanyColor" value="${inputsummary.myCompanyColor }">
		<input type="hidden" id="num1" name="num1" value="${num }">
		<input type="hidden" id="status" name="status" value="1">
		<input type="hidden" id="orderCode" name="orderCode" value="${orderNo }">
		<input type="hidden" id="orderDate" name="orderDate" value="${nowDate }">
		<input type="hidden" id="inputIds" name="inputIds" value="${inputIds }">
		<input type="hidden" id="summId" name="summId" value="${summId }">
		<input type="hidden" id="salesmans" name="salesmans" value="${salmanIds }">
		<table style=" height: 200px;" border="1">
			<tbody>
				<tr style="text-align: center;height: 30px;"><td colspan="6">下单录入汇总页面</td></tr>
				<tr style="height: 30px;text-align: center;">
					<td class="l_right">单号：</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							${orderNo }
						</div>
					</td>
					<td class="l_right">下单日期:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							${nowDate }
						</div>
					</td>
				</tr><tr>
					<td class="l_right">工厂:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id="factoryId" name="factoryId" onchange="changeFactory(this);">
								<option value="">请选择</option>
								<c:forEach var="item" items="${factoryInfos }" varStatus="status">
								<option value="${item.id }">${item.name }</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td class="l_right">布种:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							${inputsummary.clothName }
						</div>
					</td>
				</tr><tr>
					<td class="l_right">我司编号:</td>
					<td class="l_left" colspan="2" <c:if test="${codeRed !=null }">title="点击添加到花号基本资料"</c:if> >
						<div class="lanyuan_input" id="myCompanyCodediv"
							<c:if test="${codeRed !=null }">onclick="addtoflower('${inputsummary.myCompanyCode }');" style="color: ${codeRed};cursor:pointer;" </c:if> 
						>
							${inputsummary.myCompanyCode }
						</div>
					</td>
					<td class="l_right">工艺:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id='technologyId' name="technologyId">
								<option value="">请选择</option>
								<c:forEach var="item" items="${technologyInfos }">
								<option value="${item.id }" >${item.name }</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr><tr>
					<td class="l_right">工厂编号:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id="factoryCode" name="factoryCode">
								<option value="">请选择</option>
								<c:forEach var="code" items="${factoryCodes }">
									<option value="${code }">${code }</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td class="l_right">我司颜色:</td>
					<td class="l_left" colspan="2" <c:if test="${codeRed !=null }">title="点击添加到花号基本资料"</c:if>>
						<div class="lanyuan_input" id="myCompanyColor"
							<c:if test="${codeRed !=null }">onclick="addtoflower('${inputsummary.myCompanyColor }');" style="color: ${codeRed};cursor:pointer;" </c:if>
						> 
							${inputsummary.myCompanyColor }
						</div>
					</td>
				</tr><tr>
					<td class="l_right">工厂坯布数量:</td>
					<td >
						<div class="lanyuan_input" id="clothAllowance"></div>
					</td><td style="width: 100px;">
						<span style="color: red;"><b>未回</b>：${noRetrun }</span>
					</td>
					<td class="l_right">工厂颜色:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id="factoryColor" name="factoryColor">
								<option value="">请选择</option>
								<c:forEach var="color" items="${factoryColors }">
									<option value="${color}">${color }</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr><tr>
					<td class="l_right">数量:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<input id='num' name="num" class="checkdesc" type="text" value="${num }" style="width: 100px;" onchange="changeNum(this)">
							<span id="balancetext" style="display: none">差额<input type="text" id="balance" name="balance" value="" style="width: 50px;"></span>条
						</div>
					</td>
					<td class="l_right"><span id="ywy" style="display: none">差额业务员：</span></td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id="ywy2" style="display: none" id="balanceSalemanId" name="balanceSalemanId">
								<option value="0">请选择</option>
								<c:forEach var="saleman" items="${salesmanInfos }">
								<option value="${saleman.id }">${saleman.name }</option>
								</c:forEach>
							</select>
						</div></td>
				</tr><tr style="height: 30px;text-align: center;">
					<td colspan="6">规格</td>
				</tr><tr>
					<td class="l_right">幅宽:</td>
					<td colspan="2">
						<input id='kuanfu' name="kuanfu" class="checkdesc" type="text" value="" style="width: 80px;">&nbsp;CM&nbsp;
						<select id="kuanfufs" name="kuanfufs" class="shortselect" style="width: 65px;">
							<option value="0">包边</option>
							<option value="1">实用</option>
						</select>
					</td><td  class="l_right">克重:</td>
					<td colspan="2">
						<input id='kezhong' name="kezhong" class="checkdesc" type="text" value="" style="width: 70px;">
						<select id="kezhongUnit" name="kezhongUnit" style="width: 67px;">
							<option value="0">G/M2</option>
							<option value="3">M/KG</option>
							<option value="1">G/Y</option>
							<option value="2">G/M</option>
						</select>
						<select id="kezhongfs" name="kezhongfs" style="width: 62px;">
							<option value="0">回后</option>
							<option value="1">出机</option>
						</select>
					</td>
				</tr><tr>
					<td  colspan="6" style="height: 30px;text-align: center;">
							包装方式
					</td>
				</tr><tr>
					<td style="width: 100px;text-align: right;">纸管：</td>
					<td style="width: 110px;"><input type="text" id="zhiguan" name="zhiguan" value="" style="width: 110px;"></td>
					<td style="width: 100px;text-align: right;">空差：</td>
					<td ><input type="text" id="kongcha" name="kongcha" value="" style="width: 110px;"></td>
					<td style="width: 100px;text-align: right;">胶袋：</td>
					<td ><input type="text" id="jiaodai" name="jiaodai" value="" style="width: 110px;"> </td>
				</tr>
				
				<c:forEach	var="order" items="${orderInputList }">
				<tr style="height: 30px;text-align: center;">
					<td class="l_right" >业务员:</td>
					<td class="l_left" colspan="2">
						${order.saleManName }
					</td>
					<td class="l_right">业务员备注:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							${order.mark }
						</div>
					</td>
				</tr>
				</c:forEach>
				<tr>
					<td class="l_right">备注:</td>
					<td class="l_left" colspan="5">
						<div class="lanyuan_input">
							<input id='mark' name="mark" class="checkdesc" type="text" value="" style="width: 553px">
						</div>
					</td>
				</tr>
				
				<tr>
					<td colspan="6">
						<div class="l_btn_centent">
							<a class="btn btn-primary" href="javascript:void(0)"
									id="saveWin_form" onclick="saveWin();"><span>保存</span> </a>
							<a class="btn btn-primary" href="javascript:void(0)" id="closeWin"
									onclick="javascript:history.go(-1);"><span>取消</span> </a>
							<a class="btn btn-primary" href="javascript:void(0)" id="search">
								<span>查询</span>
							</a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>