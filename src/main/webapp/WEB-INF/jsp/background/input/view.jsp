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
	
	var i=${ fn:length(addtionlist)}+1;
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
				'	&nbsp;&nbsp;<input type="button" value="删除" id="deleteTable" onclick="deleteRow('+i+')"/>'+
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
				document.getElementById('table1').deleteRow(i+1);
				return true;
			}
		}
	}
	function changeUnitName(name){
		var names=document.getElementsByName("unitName");
		for(var i=0;i<names.length;i++){
			names[i].innerHTML=name;
		}
	}
	function initUnit(id){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/cloth/getClothUnit.html', //要访问的后台地址
		    data: {id:id}, //要发送的数据
		    success: function(data){
		    	changeUnitName(data);
			},error : function() {    
		          // view("异常！");    
		          alert("异常！");    
		     } 
		});
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/input/update.html" method="post">
		<c:if test="${type==null }">
			<input type="hidden" id="id" name="id" value="${input.id }">
		</c:if>
		<table id="table1" border="1">
			<tbody>
				<tr style="height: 30px;">
					<td align="right" style="width: 100px;"><span style="color: red">*</span>布种：</td>
					<td class="l_left" style="width: 130px;">
						<c:forEach items="${ cloths }" var = "cloth">
							<c:if test="${cloth.id eq input.clothId }">${cloth.clothName}</c:if>
						</c:forEach>
					</td><td align="right" style="width: 100px;"><span style="color: red">*</span>我司编号：</td>
					<td style="width: 130px;">
						<select id="myCompanyCode" name="myCompanyCode" style="width: 100px;">
							<option>请选择</option>
							<option id="1">1</option>
						</select>
					</td>
					<td align="right" style="width: 100px;"><span style="color: red">*</span>业务员：</td>
					<td style="width: 350px;">
						<c:forEach items="${salesmanInfos }" var="saleman">
							<c:if test="${saleman.id==input.salesmanId }">${saleman.name }</c:if>
						</c:forEach>
					</td>
				</tr>
				<c:forEach var="addtion" items="${addtionlist }" varStatus="status">
				<tr id="${status.index }" name="trow" style="height: 30px;">
					<td align="right"><span style="color: red">*</span>我司颜色：</td>
					<td class="l_left">
						${addtion.myCompanyColor }
					</td>
					<td align="right"><span style="color: red">*</span>数量：</td>
					<td class="l_left" style="text-align: right;">
						${addtion.num }
						<span id="unitName" name="unitName"></span>	
					</td>
					<td align="right">备注：</td>
					<td class="l_left">
						${addtion.mark }
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<table width="850px">
			<tr>
				<td>
					<div class="l_btn_centent">
						<!-- saveWin_form   from是表单Ｉd-->
						<a class="btn btn-primary" href="javascript:void(0)" id="closeWin"
							onclick="closeWin()"><span>关闭</span> </a>
					</div>
				</td>
			</tr>
		</table>
	</form>
	<img alt="图片预览" src="http://img6.cache.netease.com/photo/0001/2015-03-13/AKJQVDIB19BR0001.jpg">
	</div>
<script type="text/javascript">
initUnit(${input.clothId});
</script>
</body>
</html>