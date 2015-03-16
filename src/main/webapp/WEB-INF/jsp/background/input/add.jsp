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
								parent.input.loadGird();
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
	
	var i=1;
	$(document).ready(function(){
	    $("#addTable").click(function(){
	    	var tr='<tr id="'+i+'" name="trow">'+
				'<td align="right"><span style="color: red">*</span>我司颜色：</td>'+
				'<td class="l_left">'+
				'	<input type="text" name="myCompanyColor">'+
				'</td>'+
				'<td align="right"><span style="color: red">*</span>数量：</td>'+
				'<td class="l_left">'+
				'	<input type="text" name="num" style="width: 68%">'+
				' <select style="width: 25%" id="unit" name="unit">'+
				'			<option value="0">条</option>'+
				'			<option value="1">KG</option>'+
				'			<option value="2">米</option>'+
				'			<option value="3">码</option>'+
				'		</select>'+
				'</td>'+
				'<td align="right">备注：</td>'+
				'<td class="l_left">'+
				'	<input type="text" name="mark">'+
				'</td><td>'+
				'	&nbsp;<input type="button" value="删除" id="deleteTable" onclick="deleteRow('+i+')"/>'+
				'</td>'+
			'</tr>';
			i++;
	　  $("#table1").append(tr);
	    });
	});
	
	/***删除一行**/
	function deleteRow(index){
		var trow=document.getElementsByName("trow");
		for(var i=0;i<=trow.length;i++){
			if(index==trow[i].id){
				document.getElementById('table1').deleteRow(i+2);
				return true;
			}
		}
	}
	
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/input/add.html" method="post">
		<table id="table1">
			<tbody>
				<tr>
					<td align="right"><span style="color: red">*</span>布种：</td>
					<td class="l_left">
						<select id="clothId" name="clothId">
							<option>请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</td><td align="right"><span style="color: red">*</span>我司编号：</td>
					<td>
						<select id="myCompanyCode" name="myCompanyCode" style="width: 99%">
							<option>请选择</option>
							<option id="1">1</option>
						</select>
					</td>
					<td align="right"><span style="color: red">*</span>业务员：</td>
					<td>
						<select id="salesmanId" name="salesmanId">
							<option>请选择</option>
							<c:forEach items="${salesmanInfos }" var="saleman">
								<option value="${saleman.id }">${saleman.name }</option>
							</c:forEach>
						</select>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				
				<tr>
					<td align="right"><span style="color: red">*</span>我司颜色：</td>
					<td class="l_left">
						<input type="text" name="myCompanyColor" >
					</td>
					<td align="right"><span style="color: red">*</span>数量：</td>
					<td class="l_left">
						<input type="text" name="num" style="width: 68%">
						<select style="width: 25%" id="unit" name="unit">
							<option value="0">条</option>
							<option value="1">KG</option>
							<option value="2">米</option>
							<option value="3">码</option>
						</select>
					</td>
					<td align="right">备注：</td>
					<td class="l_left">
						<input type="text" name="mark">
					</td><td>
						&nbsp;<input type="button" value="增加" id="addTable"/>
					</td>
				</tr>
			</tbody>
		</table>
		<table width="850px">
			<tr>
				<td>
					<div class="l_btn_centent">
						<!-- saveWin_form   from是表单Ｉd-->
						<a class="btn btn-primary" href="javascript:void(0)"
							id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> <a
							class="btn btn-primary" href="javascript:void(0)" id="closeWin"
							onclick="closeWin()"><span>关闭</span> </a>
					</div>
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>