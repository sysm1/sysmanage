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
								parent.salesman.loadGird();
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
						url: rootPath + '/background/salesman/isExist.html',
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
	<div class="l_err" ></div>
	<form name="form" id="form" action="${ctx}/background/salesman/add.html" method="post">
		<table style="height: 200px;" border="1">
			<tbody>
				<tr>
					<td class="l_right">开版日期：</td>
					<td class="l_left">
						<input id='name' name="name" class="isNum" readonly="readonly" type="text" value="${nowDate }">
					</td><td rowspan="9" style="width: 450px">
						<img alt="" src="">图片预览区
					</td>
				</tr><tr>
					<td>工厂：</td>
					<td>
						<select>
							<option value="">请选择</option>
					    </select>
					</td>
				</tr><tr>
					<td>布种：</td>
					<td>
						<select>
							<option value="">请选择</option>
					    </select>
					</td>
				</tr><tr>
					<td>
						<select style="width:90px">
							<option value="">编号类型</option>
							<option value="">分色文件号</option>
							<option value="">工厂编号</option>
							<option value="">我司编号</option>
					    </select></td>
					<td>
						<input id='name' name="name" class="isNum" type="text" value="">
					</td>
				</tr><tr>
					<td>工艺：</td>
					<td>
						<select>
							<option value="">请选择</option>
					    </select>
					</td>
				</tr><tr>
					<td>图片：</td>
					<td>
						<input type="file" id="pic" style="width: 220px"/>
					</td>
				</tr><tr>
					<td>业务员：</td>
					<td>
						<select>
							<option value="">请选择</option>
					    </select>
					</td>
				</tr><tr>
					<td class="l_right">备注：</td>
					<td class="l_left">
						<textarea rows="4" cols="6" id='mark' name="mark" ></textarea>
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