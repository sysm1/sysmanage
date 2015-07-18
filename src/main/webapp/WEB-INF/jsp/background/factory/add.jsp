<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
//单独验证某一个input  class="checkpass"
jQuery.validator.addMethod("checkpass", function(value, element) {
	 return this.optional(element) || ((value.length <= 16) && (value.length>=6));
}, "编号由6至16位字符组合构成");

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
								parent.factory.loadGird();
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
				name : {
					required : true,
					remote:{ //异步验证是否存在
						type:"POST",
						url: rootPath + '/background/factory/isExist.html',
						data:{
							name:function(){return $("#name").val();}
						 }
						}
				}
			},
			messages : {
				name : {
					required : "请输入业务员名称",
				    remote:"该名称已经存在"
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
	<form name="form" id="form" action="${ctx}/background/factory/add.html" method="post">
		<table style="width: 285px; height: 100%;" >
			<tbody>
				<tr>
					<td class="l_right">名称：</td>
					<td class="l_left">
					<input id='name' name="name" type="text" value="">
					</td>
				</tr><tr>
					<td>分点：</td>
					<td>
						<select id="cityId" name="cityId">
							<option value="">请选择</option>
							<c:forEach items="${citys }" var="city">
							<option value="${city.id }">${city.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr><tr>
					<td>状态</td>
					<td>
						<input type="radio" id="status1" name="status" value="1">正常
						<input type="radio" id="status2" name="status" value="2">停用
					</td>
				</tr><tr>
					<td>状态</td>
					<td>
						<input type="radio" id="isdefault" name="isdefault" value="是">是
						<input type="radio" id="isdefault1" name="isdefault" value="否">否
					</td>
				</tr><tr>
					<td class="l_right">备注：</td>
					<td class="l_left">
						<textarea rows="10" cols="8" id='mark' name="mark" ></textarea>
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