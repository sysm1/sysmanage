<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">

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
		
		$("#unit").change(function(){
			if(this.value==1){
				document.getElementById("defaultKg").style.display="none";
			}else{
				document.getElementById("defaultKg").style.display="";
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
	function closeWin() {
		 parent.$.ligerDialog.close(); //关闭弹出窗; //关闭弹出窗
		parent.$(".l-dialog,.l-window-mask").css("display","none"); 
	}
</script>
</head>
<body>
<div class="divdialog">
	<form name="form" id="form" action="${ctx}/background/cloth/update.html" method="post">
		<table style="width: 390px; height: 200px;" id="table1" class="dataintable">
			<tbody>
				<tr>
					<td class="l_right">名称：</td>
					<td class="l_left">
					<input id='id' name="id" type="hidden" value="${cloth.id}">
					<input id='clothName' name="clothName" type="text" value="${cloth.clothName}">
					</td>
				</tr>
				<!--tr>
					<td class="l_right">下单名称：</td>
					<td class="l_left">
					<input id='orderName' name="orderName" type="text" value="${cloth.orderName}">
					</td>
				</tr--><tr>
					<td class="l_right">布种单位：</td>
					<td class="l_left">
						<select id="unit" name="unit" onchange="selectUnit(this);">
							<option value="0" <c:if test="${cloth.unit eq 0 }">selected</c:if>>条</option>
							<option value="1" <c:if test="${cloth.unit eq 1 }">selected</c:if>>KG</option>
						</select>
					</td>
				</tr>
				
				<tr id="defaultKg" <c:if test="${cloth.tiaoKg ==null }">style="display: none;"</c:if>  >
					<td class="l_right">默认公斤数：</td>
					<td style="text-align: left;">
						<input type="text" id="tiaoKg" name="tiaoKg" style="width: 180px;" value="${cloth.tiaoKg }">KG/条
					</td>
				</tr>
				
				<tr>
					<td class="l_right">备注：</td>
					<td class="l_left">
					<div class="lanyuan_input">
					<input id='mark'
						name="mark" type="text" class="checkdesc" value="${cloth.mark}">
						</div>
						</td>
				</tr>
				<!--tr height="30px;" style="background: #EEE9E9;">
					<td colspan="2" align="center" style="color: FFF68F;background-color:#EEE9E9;font-weight: bold; ">
					布&nbsp;种&nbsp;颜&nbsp;色
					</td>
				</tr>
				<c:forEach items="${clothColors }" var="color">
				<tr >
					<td class="l_left" colspan="2" align="center" style="background-color: #FFF5EE;">
						<input id='color' name="color" class="checkdesc" type="text" value="${color.color }">
					</td>
				</tr>
				</c:forEach>-->
			</tbody>
		</table>
		<div class="l_btn_centent">
			<!-- saveWin_form   from是表单Ｉd>
			<a class="btn btn-primary" id="addone" ><span>新增一行</span> </a>-->
			&nbsp;&nbsp;&nbsp;  
			<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> 
			
		</div>
	</form>
	</div>
</body>
</html>