<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
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
							parent.orderAudit.loadGird();
							closeWin();
							//window.location.href=rootPath + "/background/orderAudit/list.html";
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
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/orderAudit/audit.html" method="post">
		<input type="hidden" id="id" name="id" value="${id }">
		<table style=" height: 200px;" border="1" class="dataintable">
			<tbody>
				<tr style="height: 35px;text-align: center;">
					<td class="l_right">布种：</td>
					<td style="text-align: left;" colspan="2">
						<div class="lanyuan_input">
							${bean.clothName }
						</div>
					</td>
					<td class="l_right">我司编号：</td>
					<td style="text-align: left;" colspan="2">
						<div class="lanyuan_input">
							${bean.myCompanyCode }
						</div>
					</td>
				</tr><tr style="height: 35px;">
					<td class="l_right">我司颜色：</td>
					<td style="text-align: left;" colspan="2">
						<div class="lanyuan_input">
							${bean. myCompanyColor}
						</div>
					</td>
					<td class="l_right">数量：</td>
					<td class="l_left" colspan="2" style="text-align: left;">
						<div class="lanyuan_input">
							${bean.num }
						</div>
					</td>
				</tr><tr style="height: 35px;">
					<td class="l_right">备注：</td>
					<td style="text-align: left;" colspan="5"  >
							${bean.mark }
					</td>
				</tr><tr style="height: 35px;">
					<td class="l_right">业务员：</td>
					<td class="l_left" colspan="2" style="text-align: left;">
						${bean.saleManName }
					</td>
					<td class="l_right">审核是否通过：</td>
					<td colspan="2" style="text-align: left;">
						<input type="radio" name="status" value="1" <c:if test="${audit.status eq 1 }">checked="checked"</c:if> >通过
						<input type="radio" name="status" value="2" <c:if test="${audit.status eq 2 }">checked="checked"</c:if> >不通过
					</td>
				</tr><tr id="reasonTr" style="display: ;">
					<td>审核意见：</td>
					<td colspan="5" style="text-align: left;">
						<textarea id="reason" name="reason" style="width: 97%;height: 70px;">${audit.reason }</textarea>
					</td>
				</tr><tr>
					<td colspan="6">
						<div class="l_btn_centent">
							<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();">
								<span>保存</span> 
							</a>
							<!--a class="btn btn-primary" href="javascript:void(0)" id="search" onclick="closeWin()">
								<span>查询</span> 
							</a-->
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>