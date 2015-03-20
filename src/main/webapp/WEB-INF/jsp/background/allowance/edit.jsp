<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">

/**
jQuery.validator.addMethod("checkpass", function(value, element) {
	 return this.optional(element) || ((value.length <= 16) && (value.length>=6));
}, "编号由6至16位字符组合构成");
**/

jQuery.validator.addMethod("isNum", function(value, element) {
	 var num = /^([-0-9]+)$/;
	 return this.optional(element) || (num.test(value));
}, "只能输入数字");

jQuery.validator.addMethod("isDay", function(value, element) {
	 var num = /^(\d{4})-(\d{2})-(\d{2})$/;
	 return this.optional(element) || (num.test(value));
}, "只能输入日期(yyyy-MM-dd)");

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
							$.ligerDialog.warn("提交失败！！");
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
				},
				changeSumkg : {
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
				},
				changeSumkg : {
					required : "kg改变量不能为空",
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
	function closeWin() {
		 parent.$.ligerDialog.close(); //关闭弹出窗; //关闭弹出窗
		parent.$(".l-dialog,.l-window-mask").css("display","none"); 
	}
	
	
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/allowance/update.html" method="post">
		<input id='id' name="id" type="hidden" value="${allowance.id}">
		<table style="width: 285px; height: 200px;">
			<tbody>
			
			<tr>
				<td class="l_right">日期：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='inputDate' name="inputDate" class="isDay" type="text" value="${allowance.strInputDate}">
					</div>
				</td>
			</tr>
			
			<tr>
				<td class="l_right">布种：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='clothId' name="clothId" type="hidden" value="${allowance.clothId}">
						<input id='clothName' name="clothName" type="text" value="${allowance.clothName}" readonly="readonly">
					</div>
				</td>
			</tr>
			<!-- 0条 1 kg 2cm 3码 -->
			<tr>
				<td class="l_right">单位：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<c:choose>
							<c:when test="${ allowance.unit == '1' }">公斤</c:when>
							<c:when test="${ allowance.unit == '2' }">米</c:when>
							<c:when test="${ allowance.unit == '3' }">码</c:when>
							<c:when test="${ allowance.unit == '4' }">包</c:when>
							<c:otherwise>条</c:otherwise>
						</c:choose>
					</div>
				</td>
			</tr>
			
			<tr>
				<td class="l_right">工厂：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='factoryId' name="factoryId" type="hidden" value="${allowance.factoryId}">
						<input id='factoryName' name="factoryName" type="text" value="${allowance.factoryName}" readonly="readonly">
					</div>
				</td>
			</tr>
			
			<tr>
				<td class="l_right">新增量：</td>
				<td class="l_left">
					<div class="lanyuan_input">
					<input id='changeSum' name="changeSum" type="text" class="isNum" value="${allowance.changeSum}">
					</div>
				</td>
			</tr>
			
			<tr>
				<td class="l_right">新增量(公斤)：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='changeSumkg' name="changeSumkg" type="text" class="isNum" value="${allowance.changeSumkg}">
					</div>
				</td>
			</tr>
			
			<tr>
				<td class="l_right">备注：</td>
				<td class="l_left">
					<div class="lanyuan_input">
					<input id='mark' name="mark" type="text" value="${allowance.mark}">
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