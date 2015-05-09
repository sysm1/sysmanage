<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">

//单独验证某一个input  class="checkpass"
/**
jQuery.validator.addMethod("checkpass", function(value, element) {
	 return this.optional(element) || ((value.length <= 16) && (value.length>=6));
}, "编号由6至16位字符组合构成");
**/

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
								parent.cloth.loadGird();
								closeWin();
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			},
			rules : {
				clothName : {
					required : true
				},
				orderName : {
					required : true
				},
				unit : {
					required : true
				}
			},
			messages : {
				clothName : {
					required : "请输入布种名称"
				},
				orderName : {
					required : "请输入下单名称"
				},
				unit : {
					required : "请选择布种单位"
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
		
		$("#addone").click("click", function() {
			var newtr=$("#table1 tr:last").clone();
			newtr.insertAfter($("#table1 tr:last"));
			newtr.find("input").eq(0).attr("value",'');
		});
	});
	function saveWin() {
		$("#form").submit();
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 485px;"></div>
	<form name="form" id="form" action="${ctx}/background/cloth/add.html" method="post">
		<table style="width: 485px; height: 200px;" id="table1">
			<tbody>
			
				<tr>
					<td style="text-align: right;">布种名称：</td>
					<td class="l_left">
					<div class="lanyuan_input">
					<input id='clothName' name="clothName" type="text" value="">
						</div></td>
				</tr>
				
				<!--tr>
					<td class="l_right">下单名称：</td>
					<td class="l_left">
					<div class="lanyuan_input">
					<input id='orderName' name="orderName" type="text" value="">
						</div></td>
				</tr-->
				<tr>
					<td style="text-align: right;">布种单位：</td>
					<td class="l_left">
						<select id="unit" name="unit">
							<option value="0">条</option>
						</select>
					</td>
				</tr><tr>
					<td style="text-align: right;">默认公斤数：</td>
					<td>
						<input type="text" id="tiaoKg" name="tiaoKg" value="">KG/条
					</td>
				</tr>		
				<tr>
					<td style="text-align: right;">备注：</td>
					<td class="l_left">
					<div class="lanyuan_input">
					<input id='mark'
						name="mark" class="checkdesc" type="text" value="">
						</div>
						</td>
				</tr>
				<tr style="background-color:#DEDEDE ">
					<td style="text-align: right;">颜色：</td>
					<td class="l_left">
						<input id='color' name="color" class="checkdesc" type="text" value="">
					</td>
				</tr>
			</tbody>
		</table>
		<div class="l_btn_centent">
			<!-- saveWin_form   from是表单Ｉd-->
			<a class="btn btn-primary" id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> 
			<a class="btn btn-primary" id="addone" ><span>新增一行颜色</span> </a>
		</div>
	</form>
	</div>
</body>
</html>