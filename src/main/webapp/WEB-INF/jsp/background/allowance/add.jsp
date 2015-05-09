<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<style type="text/css">
	.l_right{
		text-align: right;
	}
</style>
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
				},
				changeSumkg: {
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
	
	// clothId  0条 1 kg 2cm 3码 4包
	$(function() {
		$('#clothId').change(function(){
			//alert($("#unit").val());
			var unit = ($(this).find("option:selected").attr("runit"));
			if(unit == '' || unit == null || unit == undefined) return;
			if(unit == '0') {
				$("#clothUnit").html("条");
				$("#clothUnit2").html("条");
				$("#unit").attr("value",0);
			} else if(unit == '1') {
				$("#clothUnit").html("公斤");
				$("#clothUnit2").html("公斤");
				$("#unit").attr("value",1);
			} else if(unit == '2') {
				$("#clothUnit").html("米");
				$("#clothUnit2").html("米");
				$("#unit").attr("value",2);
			} else if(unit == '3') {
				$("#clothUnit").html("码");
				$("#clothUnit2").html("码");
				$("#unit").attr("value",3);
			} else if(unit == '4') {
				$("#unit").attr("value",4);
				$("#clothUnit").html("包");
				$("#clothUnit2").html("包");
				
			}
			//alert($("#unit").val());
			//alert($(this).val());
			$.ajax({
			    type: "post", //使用get方法访问后台
			    dataType: "json", //json格式的数据
			    async: false, //同步   不写的情况下 默认为true
			    url: rootPath + '/background/cloth/getClothColor.html', //要访问的后台地址
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
		});
	});
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 370px;"></div>
	<form name="form" id="form" action="${ctx}/background/allowance/add.html" method="post">
		<input type="hidden" id="unit" name="unit" value="">
		<table style="width: 385px; height: 300px;">
			<tbody>
			
			<tr>
				<td class="l_right">日期：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input type="text" id="inputDate" name="inputDate" value="${today}" 
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
					</div>
				</td>
			</tr>
			<tr>
				<td class="l_right">坯布供应商：</td>
				<td>
					<select id="supplierId" name="supplierId">
						<option value="">请选择供应商</option>
						<c:forEach items="${suppliers }" var="supplier">
						<option value="${supplier.id }">${supplier.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
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
						<span class="lanyuan_input" id="clothUnit2" style="font-weight: bold;"></span>
					</div>
				</td>
			 </tr>
			 <tr>
				<td class="l_right">颜色：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						
						<select id="color" name="color">
							<option value="">请选择颜色</option>
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
							<c:forEach items = "${ factorys }" var="factory">
								<option value="${factory.id }">${factory.name}</option>
							</c:forEach>
						</select>
						
					</div>
				</td>
			</tr>
			<tr>
				<td class="l_right">坯布条数：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='changeSum' name="changeSum" type="text" class="isNum" value="" >
						<span class="lanyuan_input" id="clothUnit"></span>
					</div>
				</td>
			</tr><tr>
				<td class="l_right">坯布公斤数：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='changeSumkg' name="changeSumkg" type="text" class="isNum" value="" >
						<span class="lanyuan_input" id="clothUnit">公斤</span>
					</div>
				</td>
			</tr><tr>
				<td class="l_right">备注：</td>
				<td class="l_left">
					<div class="lanyuan_input">
					<input id='mark' name="mark" type="text" value="">
					</div>
				</td>
			</tr><tr>
				<td colspan="2">
					<div class="l_btn_centent">
						<!-- saveWin_form   from是表单Ｉd-->
						<a class="btn btn-primary" href="javascript:void(0)"
							id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> 
					</div>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>