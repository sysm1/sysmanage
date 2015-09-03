<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
</style>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">

var dialog;
var grid;
var delarr = [];
$(function() {
	$("#search").click("click", function() {//绑定查询按扭
		dialog = parent.$.ligerDialog.open({
			width : 750,
			height : 450,
			url : rootPath + '/background/ordersummary/list.html?flag=1&clothId=${inputsummary.clothId }&myCompanyCode=${inputsummary.myCompanyCode }&myCompanyColor=${inputsummary.myCompanyColor }',
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
	$("#closeWin").click("click",function(){
		closeWin();
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
							//parent.ordersummary.loadGird();
							//closeWin();
							window.location.href=rootPath + "/background/ordersummary/list.html";
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
		$("#form").submit();
	}
	function changeNum(obj){
		var beforNum=$("#orgNum").val();
		var nowNum=obj.value;
		if(nowNum==''){
			$("#num").attr("value",beforNum);
		}
		var chae=parseInt(nowNum)-parseInt(beforNum);
		if(chae>=0){
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
	
	function addtoflower(code){
		var factoryId=$('#factoryId').val();
		var clothId=$('#clothId').val();
		var myCompanyCode=$('#myCompanyCode').val();
		var myCompanyColor=$('#myCompanyColor').val();
		var technologyId=$('#technologyId').val();
		var factoryCode=$('#factoryCode').val();
		factoryCode = encodeURI(factoryCode) ;
		myCompanyColor=encodeURI(myCompanyColor) ;
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
</script>
</head>
<body style="text-align: center;">
<div class="divdialog" style="height: 100%;">
		<table style=" height: 100%;" border="1" class="dataintable">
			<tbody>
				<tr style="height: 40px;"><th colspan="6" style="text-align: center;"><b>下单录入汇总查看</b></th></tr>
				<tr style="height: 30px;text-align: center;">
					<th style="text-align: right;width: 18%;">单号：</th>
					<td style="text-align: left;width: 30%;" colspan="2">
						${inputsummary.orderCode }
					</td>
					<th style="text-align: right;width: 18%;">下单日期:</th>
					<td style="text-align: left;width: 30%" colspan="2" >
						<div class="lanyuan_input">
							<fmt:formatDate value="${inputsummary.orderDate }" pattern="YYYY-MM-dd"/>
						</div>
					</td>
				</tr><tr style="height: 30px;">
					<th style="text-align: right;">工厂:</th>
					<td style="text-align: left;" colspan="2">
						<c:forEach var="item" items="${factoryInfos }" varStatus="status">
							<c:if test="${item.id eq inputsummary.factoryId }">${item.name }</c:if>
						</c:forEach>
					</td>
					<th style="text-align: right;">布种:</th>
					<td style="text-align: left;" colspan="2">
						${clothInfo.clothName}
					</td>
				</tr><tr style="height: 30px;">
					<th style="text-align: right;">我司编号:</th>
					<td style="text-align: left;" colspan="2" >
						${inputsummary.myCompanyCode }
					</td>
					<th style="text-align: right;">工艺:</th>
					<td style="text-align: left;" colspan="2">
						${technologyInfo.name }
					</td>
				</tr><tr style="height: 30px;">
					<th style="text-align: right;">工厂编号:</th>
					<td style="text-align: left;" colspan="2">
						<c:forEach var="code" items="${factoryCodes }">
							<c:if test="${code eq inputsummary.factoryCode}">${code }</c:if>  
						</c:forEach>
					</td>
					<th style="text-align: right;">我司颜色:</th>
					<td style="text-align: left;" colspan="2" >
						${inputsummary.myCompanyColor }
					</td>
				</tr><tr style="height: 30px;">
					<th style="text-align: right;">工厂坯布数量:</th>
					<td style="text-align: left;" colspan="2">
						<div class="lanyuan_input">
							${clothAllowance }
						</div>
					</td>
					<th style="text-align: right;">工厂颜色:</th>
					<td style="text-align: left;" colspan="2">
						${inputsummary.factoryColor }
					</td>
				</tr><tr style="height: 30px;">
					<th style="text-align: right;">数量:</th>
					<td style="text-align: left;" colspan="2">
						<div class="lanyuan_input">
							${inputsummary.num }
							<c:if test="${inputsummary.balance != null}">
							<span id="balancetext" >差额 	${inputsummary.balance}</span>
							</c:if>条
						</div>
					</td>
					<th style="text-align: right;">
						<c:if test="${inputsummary.balance != null}">
						<span id="ywy" >业务员：</span>
						</c:if>
					</th>
					<td style="text-align: left;" colspan="2">
						<c:if test="${inputsummary.balance != null}">
						<c:forEach var="saleman" items="${salesmanInfos }">
						   <c:if test="${saleman.id==inputsummary.balanceSalemanId }">${saleman.name } </c:if>
						</c:forEach>
						</c:if>
					</td>
				</tr>
				<c:if test="${inputsummary.balancemark!=null && inputsummary.balancemark!=''}">
				<tr style="height: 30px;">
					<th>差额业务员备注：</th>
					<td colspan="6" style="text-align: left;">
						${inputsummary.balancemark }
					</td>
				</tr>
				</c:if>
				<tr style="height: 30px;text-align: center;">
					<th colspan="6">规格</th>
				</tr><tr style="height: 30px;">
					<th style="text-align: right;">幅宽:</th>
					<td style="text-align: left;" colspan="2">
						${inputsummary.kuanfu }&nbsp;CM&nbsp;
						<c:if test="${inputsummary.kuanfufs eq 0 }">包边</c:if>
						<c:if test="${inputsummary.kuanfufs eq 1 }">实用</c:if>
					</td><th  style="text-align: right;">克重:</th>
					<td style="text-align: left;" colspan="2">
						${inputsummary.kezhong }
						<c:if test="${inputsummary.kezhongUnit eq 0 }">G/M2</c:if>
						<c:if test="${inputsummary.kezhongUnit eq 1 }">G/Y</c:if>
						<c:if test="${inputsummary.kezhongUnit eq 2 }">G/M</c:if>
						<c:if test="${inputsummary.kezhongfs eq 0 }">回后</c:if>
						<c:if test="${inputsummary.kezhongfs eq 1 }">出机</c:if>
					</td>
				</tr><tr style="height: 30px;">
					<th  colspan="6" style="height: 30px;text-align: center;">
							包装方式
					</th>
				</tr><tr style="height: 30px;">
					<th style="text-align: right;">纸管：</th>
					<td style="width: 110px;text-align: left;">${inputsummary.zhiguan }</td>
					<th style="width: 100px;text-align: right;">空差：</th>
					<td style="text-align: left;">${inputsummary.kongcha }</td>
					<th style="text-align: right;width: ">胶袋：</th>
					<td style="text-align: left;width: 70px;">${inputsummary.jiaodai }</td>
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
				<tr style="height: 30px;">
					<th style="text-align: right;">备注：</th>
					<td style="text-align: left;" colspan="5">
						${inputsummary.mark }
					</td>
				</tr>
				
				<tr style="height: 30px;">
					<td colspan="6">
						<div class="l_btn_centent">
							<a class="btn btn-primary" href="javascript:void(0)" id="closeWin">
								<span>关闭</span> 
							</a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>