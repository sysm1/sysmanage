<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<style type="text/css">
.l_right{
	text-align: right;
	width: 150px;
	height: 30px;
}
</style>
<script type="text/javascript">
//单独验证某一个input  class="checkpass"
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
								parent.clothManage.loadGird();
								closeWin();
							});
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			},
			rules : {
				accountName : {
				required : true,
				remote:{ //异步验证是否存在
					type:"POST",
					url: rootPath + '/background/account/isExist.html',
					data:{
						name:function(){return $("#accountName").val();}
					 }
					}
				},
				state : {
					required : true
				}
			},
			messages : {
				accountName : {
					required : "请输入账号",
				    remote:"该账号已经存在"
				},
				state : {
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
		/**$('#clothId').change(function(){
			$.ajax({
				type: "post",
				dataType: "json", //json格式的数据
			    async: false,     //同步   不写的情况下 默认为true
			    url: rootPath + '/background/cloth/getClothColor.html',  //要访问的后台地址
			    data: {clothId:$(this).val()}, //要发送的数据
			    success: function(data){
			    	if(data!=null&&data!=''){
				    	var color = $("#color");
				    	color.empty();
				    	color.append($("<option>").text("请选择").val(""));
				    	for(var i=0;i<data.length;i++) {
				    	    var option = $("<option>").text(data[i].color).val(data[i].color);
				    	    color.append(option);
				    	}
			    	}else{
			    		//alert('没有相关联的我司编号');
			    	}
				}
			});
			ajaxQuery();
		});**/
		/**
		$('#color').change(function(){
			ajaxQuery();
		});*/
		$('#factoryId').change(function(){
			ajaxQuery();
		});
	});
	
	function ajaxQuery(){
		var clothId=$('#clothId').val();
		//var color=$('#color').val();
		var factoryId=$('#factoryId').val();
		if(clothId!=''&&factoryId!=''){
			$.ajax({
				type: "post",
				dataType: "json", //json格式的数据
			    async: false,     //同步   不写的情况下 默认为true
			    url: rootPath + '/background/allowance/queryAllowance.html',  //要访问的后台地址
			    data: {clothId:clothId,color:color,factoryId:factoryId}, //要发送的数据
			    success: function(data){
			    	$('#itemNum')[0].innerHTML=data[0];
			    	$("#paperNum").attr("value",data[0]);
			    	$('#kgNum')[0].innerHTML=data[1];
			    	$("#paperNumKg").attr("value",data[1]);
				}
			});
		}
	}
	
	function saveWin() {
		$("#form").submit();
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/clothManage/add.html" method="post">
		<table style="width: 100%; height: 200px;border-color: #DECEED;" border="2">
			<tbody>
				<tr>
					<td class="l_right">布种：</td>
					<td class="l_left">
						<select id="clothId" name="clothId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option runit="${cloth.unit}" value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<!--tr>
					<td class="l_right">布种颜色：</td>
					<td class="l_left">
						<select id="color" name="color">
							<option value="">请选择布种</option>
						</select>
					</td>
				</tr-->
				<tr>
					<td class="l_right">工厂：</td>
					<td class="l_left">
						<select id="factoryId" name="factoryId">
							<option value="">请选择工厂</option>
							<c:forEach items="${factorys }" var="factory">
							<option value="${factory.id }">${factory.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr><tr>
					<td class="l_right">账目条数：</td>
					<td><div id="itemNum">&nbsp;账目条数&nbsp;</div>
						<input type="hidden" id="paperNum" name="paperNum" value="">
					</td>
				</tr><tr>
					<td class="l_right">账目公斤数：</td>
					<td><div id="kgNum">&nbsp;账目公斤数&nbsp;</div>
						<input type="hidden" id="paperNumKg" name="paperNumKg" value="">
					</td>
				</tr><tr>
					<td class="l_right">实际条数：</td>
					<td>
						<input type="text" id="factNum" name="factNum" value="" style="border-color: #030A86;">
					</td>
				</tr><tr>
					<td class="l_right">实际公斤数：</td>
					<td><input type="text" id="factNumKg" name="factNumKg" value="" style="border-color: #030A86;"></td>
				</tr><tr>
					<td class="l_right">调整原因：</td>
					<td class="l_left">
						<textarea rows="2" cols="30" id="mark" name="mark" style="border-color: #030A86;"></textarea>
					</td>
				</tr><tr>
					<td colspan="2" style="text-align: center;">
						<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> 
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>