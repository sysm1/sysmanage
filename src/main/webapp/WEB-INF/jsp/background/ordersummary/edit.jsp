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
		$("#form").submit();
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
	
	function addtoflower(code){
		alert("添加到花号基本资料");
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
		<table style=" height: 200px;" border="1">
			<tbody>
				<tr style="text-align: center;height: 30px;"><td colspan="6">下单录入汇总页面</td></tr>
				<tr style="height: 30px;text-align: center;">
					<td class="l_right">单号：</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<input type="text" id="orderCode" name="orderCode" value="${inputsummary.orderCode }" readonly="readonly">
						</div>
					</td>
					<td class="l_right">下单日期:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<fmt:formatDate value="${inputsummary.orderDate }" pattern="YYYY-MM-dd"/>
						</div>
					</td>
				</tr><tr>
					<td class="l_right">工厂:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id="factoryId" name="factoryId">
								<option value="">请选择</option>
								<c:forEach var="item" items="${factoryInfos }" varStatus="status">
								<option value="${item.id }" <c:if test="${item.id eq inputsummary.factoryId }">selected="selected"</c:if>>${item.name }</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td class="l_right">布种:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select>
							<c:forEach var="cloth" items="${clothInfos }">
								<option value="${cloth.id }" <c:if test="${cloth.id eq summary.clothId }">selected="selected"</c:if>>${cloth.clothName }</option>
							</c:forEach>
							</select>
						</div>
					</td>
				</tr><tr>
					<td class="l_right">我司编号:</td>
					<td class="l_left" colspan="2" <c:if test="${codeRed !=null }">title="点击添加到花号基本资料"</c:if> >
						<div class="lanyuan_input" 
							<c:if test="${codeRed !=null }">onclick="addtoflower('${inputsummary.myCompanyCode }');" style="color: ${codeRed};cursor:pointer;" </c:if> 
						>
							${inputsummary.myCompanyCode }
						</div>
					</td>
					<td class="l_right">工艺:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id='technologyId' name="technologyId">
								<option>请选择</option>
								<c:forEach var="item" items="${technologyInfos }">
								<option value="${item.id }" <c:if test="${item.id eq inputsummary.technologyId }">selected="selected" </c:if>>${item.name }</option>
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
									<option value="${code}" <c:if test="${code eq inputsummary.factoryCode}">selected="selected"</c:if>  >${code }</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td class="l_right">我司颜色:</td>
					<td class="l_left" colspan="2" <c:if test="${codeRed !=null }">title="点击添加到花号基本资料"</c:if>>
						<div class="lanyuan_input" 
							<c:if test="${codeRed !=null }">onclick="addtoflower('${inputsummary.myCompanyColor }');" style="color: ${codeRed};cursor:pointer;" </c:if>
						> 
							${inputsummary.myCompanyColor }
						</div>
					</td>
				</tr><tr>
					<td class="l_right">工厂坯布数量:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							${clothAllowance }
						</div>
					</td>
					<td class="l_right">工厂颜色:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id="factoryColor">
								<option value="">请选择</option>
								<c:forEach var="color" items="${factoryColors }">
									<option value="${color}"  <c:if test="${color eq inputsummary.factoryColor }">selected="selected"</c:if>  >${color }</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr><tr>
					<td class="l_right">数量:</td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<input id='num' name="num" class="checkdesc" type="text" value="${inputsummary.num }" style="width: 100px;" onchange="changeNum(this)">
							<span id="balancetext" style="display: none">差额<input type="text" id="balance" name="balance" value="" style="width: 50px;"></span>条
						</div>
					</td>
					<td class="l_right"><span id="ywy" style="display: none">业务员：</span></td>
					<td class="l_left" colspan="2">
						<div class="lanyuan_input">
							<select id="ywy2" style="display: none" id="balanceSalemanId" name="balanceSalemanId">
								<option>请选择</option>
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
						<input id='kuanfu' name="kuanfu" class="checkdesc" type="text" value="${inputsummary.kuanfu }" style="width: 80px;">&nbsp;CM&nbsp;
						<select id="kuanfufs" name="kuanfufs" style="width: 60px;">
							<option value="0" <c:if test="${inputsummary.kuanfufs eq 0 }">selected="selected"</c:if> >包边</option>
							<option value="1" <c:if test="${inputsummary.kuanfufs eq 1 }">selected="selected"</c:if>>实用</option>
						</select>
					</td><td  class="l_right">克重:</td>
					<td colspan="2">
						<input id='kezhong' name="kezhong" class="checkdesc" type="text" value="${inputsummary.kezhong }" style="width: 70px;">
						<select id="kezhongUnit" name="kezhongUnit" style="width: 60px;">
							<option value="0" <c:if test="${inputsummary.kezhongUnit eq 0 }">selected="selected"</c:if>>G/M2</option>
							<option value="1" <c:if test="${inputsummary.kezhongUnit eq 1 }">selected="selected"</c:if>>G/Y</option>
							<option value="2" <c:if test="${inputsummary.kezhongUnit eq 2 }">selected="selected"</c:if>>G/M</option>
						</select>
						<select id="kezhongfs" name="kezhongfs" style="width: 60px;">
							<option value="0" <c:if test="${inputsummary.kezhongfs eq 0 }">selected="selected"</c:if>>回后</option>
							<option value="1" <c:if test="${inputsummary.kezhongfs eq 1 }">selected="selected"</c:if>>出机</option>
						</select>
					</td>
				</tr><tr>
					<td  colspan="6" style="height: 30px;text-align: center;">
							包装方式
					</td>
				</tr><tr>
					<td style="width: 100px;text-align: right;">纸管：</td>
					<td style="width: 110px;"><input type="text" id="zhiguan" name="zhiguan" value="${inputsummary.zhiguan }" style="width: 110px;"></td>
					<td style="width: 100px;text-align: right;">空差：</td>
					<td ><input type="text" id="kongcha" name="kongcha" value="${inputsummary.kongcha }" style="width: 110px;"></td>
					<td style="width: 100px;text-align: right;">胶袋：</td>
					<td ><input type="text" id="jiaodai" name="jiaodai" value="${inputsummary.jiaodai }" style="width: 110px;"> </td>
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
							<input id='mark' name="mark" class="checkdesc" type="text" value="${inputsummary.mark }" style="width: 553px">
						</div>
					</td>
				</tr>
				
				<tr>
					<td colspan="6">
						<div class="l_btn_centent">
							<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();">
								<span>保存</span> 
							</a>
							<a class="btn btn-primary" href="javascript:void(0)" id="closeWin" onclick="javascript:history.go(-1);">
								<span>取消</span> 
							</a>
							<a class="btn btn-primary" href="javascript:void(0)" id="search" onclick="closeWin()">
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