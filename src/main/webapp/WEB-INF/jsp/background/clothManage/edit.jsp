<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<style type="text/css">
.l_right{
	text-align: right;
	width: 150px;
	height: 30px;
}
</style>
<script type="text/javascript">
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
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			},
			rules : {
				state : {
					required : true
				}
			},
			messages : {
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
	});
	$(function() {
		$("input:radio[value='${account.state}']").attr('checked','true');
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
	<form name="form" id="form" action="${ctx}/background/clothManage/update.html" method="post">
		<input type="hidden" id="id" name="id" value="${clothManage.id }">
		<table style="width: 100%; height: 200px;border-color: #DECEED;" border="2">
			<tbody>
				<tr>
					<td class="l_right">布种：</td>
					<td class="l_left">
						${clothManage.clothName }
					</td>
				</tr>
				<tr>
					<td class="l_right">布种颜色：</td>
					<td class="l_left">
						${clothManage.color }
					</td>
				</tr>
				<tr>
					<td class="l_right">工厂：</td>
					<td class="l_left">
						${clothManage.factoryName }
					</td>
				</tr><tr>
					<td class="l_right">账目条数：</td>
					<td><div id="itemNum">&nbsp;${clothManage.paperNum }</div>
						<input type="hidden" id="paperNum" name="paperNum" value="${clothManage.paperNum }">
					</td>
				</tr><tr>
					<td class="l_right">账目公斤数：</td>
					<td><div id="kgNum">&nbsp;${clothManage.paperNumKg }&nbsp;</div>
						<input type="hidden" id="paperNumKg" name="paperNumKg" value="${clothManage.paperNumKg }">
					</td>
				</tr><tr>
					<td class="l_right">实际条数：</td>
					<td>
						<input type="text" id="factNum" name="factNum" value="${clothManage.factNum }" style="border-color: #030A86;">
					</td>
				</tr><tr>
					<td class="l_right">实际公斤数：</td>
					<td><input type="text" id="factNumKg" name="factNumKg" value="${clothManage.factNumKg }" style="border-color: #030A86;"></td>
				</tr><tr>
					<td class="l_right">调整原因：</td>
					<td class="l_left">
						<textarea rows="2" cols="30" id="mark" name="mark" style="border-color: #030A86;">${clothManage.mark }</textarea>
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