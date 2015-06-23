<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
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
		$("#unit").change(function(){
			if(this.value==1){
				document.getElementById("defaultKg").style.display="none";
			}else{
				document.getElementById("defaultKg").style.display="";
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
	<div class="l_err" style="width: 390px;"></div>
	<form name="form" id="form" action="${ctx}/background/cloth/add.html" method="post">
		<table style="width: 390px; height: 200px;" id="table1" class="dataintable">
			<tbody>
				<tr>
					<td style="text-align: right;">布种名称：</td>
					<td style="text-align: left;">
						<input id='clothName' name="clothName" type="text" value="">
					</td>
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
					<td style="text-align: left;">
						<select id="unit" name="unit" >
							<option value="">请选择</option>
							<option value="0">条</option>
							<option value="1">KG</option>
						</select>
					</td>
				</tr><tr id="defaultKg" name="defaultKg">
					<td style="text-align: right;">默认公斤数：</td>
					<td style="text-align: left;">
						<input type="text" id="tiaoKg" name="tiaoKg" value="">KG/条
					</td>
				</tr>
				<tr>
					<td class="l_right">状态：</td>
					<td style="text-align: left;">
						<input type="radio" id="status1" name="status" value="1" checked="checked">正常
						<input type="radio" id="status2" name="status" value="2">停用
					</td>
				</tr>		
				<tr>
					<td style="text-align: right;">备注：</td>
					<td style="text-align: left;">
					<div class="lanyuan_input">
					<input id='mark'
						name="mark" class="checkdesc" type="text" value="">
						</div>
						</td>
				</tr>
				<!--tr height="30px;" style="background: #EEE9E9;">
					<td colspan="2" style="color: FFF68F;background-color:#EEE9E9;font-weight: bold;text-align: center; ">
					布&nbsp;种&nbsp;颜&nbsp;色
					</td>
				</tr>
				<tr >
					<td  colspan="2" style="background-color: #FFF5EE;text-align: center;">
						<input id='color' name="color" class="checkdesc" type="text" value="">
					</td>
				</tr-->
			</tbody>
		</table>
		<div class="l_btn_centent">
			<!-- saveWin_form   from是表单Ｉd>
			<a class="btn btn-primary" id="addone" ><span>新增一行颜色</span> </a>&nbsp;&nbsp;&nbsp;-->
			<a class="btn btn-primary" id="saveWin_form" onclick="saveWin();"><span>保存</span></a> 
			
		</div>
	</form>
	</div>
</body>
</html>