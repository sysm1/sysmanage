<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">

//单独验证某一个input  class="checkpass"
jQuery.validator.addMethod("isNum", function(value, element) {
	 var num = /^([0-9]+)$/;
	 return this.optional(element) || (num.test(value));
}, "只能输入数字");

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
								parent.price.loadGird();
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
				clothId : {
					required : true
				},
				price : {
					required : true
				},
				standard : {
					required : true
				}
			},
			messages : {
				clothId : {
					required : "请选择布种",
				},
				price : {
					required : "请填写价格",
				},
				standard : {
					required : "请输入规格",
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
	});
	function saveWin() {
		$("#form").submit();
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/price/add.html" method="post">
		<table style="width: 285px; height: 200px;">
			<tbody>
			
				<tr>
				<td class="l_right">布种：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<select id="clothId" name="clothId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option runit="${cloth.unit}" value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</div>
				</td>
			 </tr>
			 
			<tr>
				<td class="l_right">布种价格</td>
				<td class="l_left">
					<input id='price' name="price" type="text" class="isNum" value="">
				</td>
			</tr>
			
			<tr>
				<td class="l_right">规格：</td>
				<td class="l_left">
				<div class="lanyuan_input">
					<input id='standard' name="standard" type="text" value="">
				</div>
				</td>
			</tr>
				
			<tr>
				<td colspan="2">
					<div class="l_btn_centent">
					<!-- saveWin_form   from是表单Ｉd-->
					<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();"><span>保存</span> </a>
					<a class="btn btn-primary" href="javascript:void(0)" id="closeWin" onclick="closeWin()"><span>关闭</span> </a>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>