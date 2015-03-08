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


jQuery.validator.addMethod("isDay", function(value, element) {
	 var num = /^(\d{4})-(\d{2})-(\d{2})$/;
	 return this.optional(element) || (num.test(value));
}, "只能输入日期(yyyy-MM-dd)");


jQuery.validator.addMethod("chrnum", function(value, element) {
	var chrnum = /^([a-zA-Z0-9]+)$/;
	return this.optional(element) || (chrnum.test(value));
}, "只能输入数字和字母(字符A-Z, a-z, 0-9)");

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
								parent.allowance.loadGird();
								closeWin();
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！" + data.msg);
						}
					}
				});
			},
			rules : {
				inputDate : {
					required : true
				},
				clothId : {
					required : true
				},
				factoryId : {
					required : true
				},
				changeSum : {
					required : true
				}
			},
			messages : {
				inputDate : {
					required : "日期不能为空",
				},
				clothId : {
					required : "布种不能为空",
				},
				factoryId : {
					required : "工厂不能为空",
				},
				changeSum : {
					required : "改变量不能为空",
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
	<div class="l_err" style="width: 370px;"></div>
	<form name="form" id="form" action="${ctx}/background/allowance/add.html" method="post">
		<table style="width: 385px; height: 300px;">
			<tbody>
			
			<tr>
				<td class="l_right">日期：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='inputDate' name="inputDate" class="isDay" type="text" value="">
					</div>
				</td>
			</tr>
			
			<tr>
				<td class="l_right">布种：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<select id="clothId" name="clothId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			
			<tr>
				<td class="l_right">工厂：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<select id="factoryId" name="factoryId">
							<option value="">请选择工厂</option>
							<c:forEach items="${ factorys }" var = "factory">
								<option value="${factory.id }">${factory.name}</option>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			
			
			<tr>
				<td class="l_right">新增量：</td>
				<td class="l_left">
					<div class="lanyuan_input">
					<input id='changeSum' name="changeSum" type="text" class="isNum" value="">
					<select id="unit" name="unit">
						<option value="item">条</option>
						<option value="kg">公斤</option>
						<option value="cm">米</option>
						<option value="yard">码</option>
					</select>
					</div>
				</td>
			</tr>
			
			
			<tr>
				<td class="l_right">备注：</td>
				<td class="l_left">
					<div class="lanyuan_input">
					<input id='mark' name="mark" type="text" value="">
					</div>
				</td>
			</tr>
				
				<tr>
					<td colspan="2">
						<div class="l_btn_centent">
								<!-- saveWin_form   from是表单Ｉd-->
								<a class="btn btn-primary" href="javascript:void(0)"
									id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> <a
									class="btn btn-primary" href="javascript:void(0)" id="closeWin"
									onclick="closeWin()"><span>关闭</span> </a>
							</div>
						</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>