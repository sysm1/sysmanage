<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">
//单独验证某一个input  class="checkpass"
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
								parent.unsubInput.loadGird();
								closeWin();
							});
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			}
		});
	});
	function saveWin() {
		$("#form").submit();
	}
	function selectCloth(obj){
		//alert(obj.value);
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/inputsummary/queryMyCompanyCodeByClothId.html', //要访问的后台地址
		    data: {clothId:obj.value}, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	if(data!=null&&data!=''){
			    	var myCompanyCode = $("#myCompanyCode");
			    	myCompanyCode.empty();
			    	myCompanyCode.append($("<option>").text("请选择").val(""));
			    	for(var i=0;i<data.length;i++) {
			    	    var option = $("<option>").text(data[i]).val(data[i]);
			    	    myCompanyCode.append(option);
			    	}
		    	}else{
		    		//alert('没有相关联的我司编号');
		    	}
			}
		});
	}
	
	function selectMyCompanyCode(obj){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/inputsummary/queryMyCompanyColorByMyCompanyCode.html', //要访问的后台地址
		    data: {myCompanyCode:obj.value}, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	if(data!=null&&data!=''){
			    	var myCompanyCode = $("#myCompanyColor");
			    	myCompanyCode.empty();
			    	myCompanyCode.append($("<option>").text("请选择").val(""));
			    	for(var i=0;i<data.length;i++) {
			    	    var option = $("<option>").text(data[i]).val(data[i]);
			    	    myCompanyCode.append(option);
			    	}
		    	}else{
		    		//alert('没有相关联的我司编号');
		    	}
			}
		});
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/unsubInput/add.html" method="post">
		<table style="width: 100%; height: 100%;" class="dataintable">
			<tbody>
				<tr>
					<td style="text-align: right;height: 35px;">退货日期：</td>
					<td style="text-align: left;">
					<div class="lanyuan_input">
					<input type="text" id="unsubdate" name="unsubdate" value="<fmt:formatDate value='${now }' pattern='yyyy-MM-dd'/>" 
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
					</div>
					</td>
					<td style="text-align: right;">布种：</td>
					<td style="text-align: left;">
					<div class="lanyuan_input">
						<select id="clothId" name="clothId" onchange="selectCloth(this)">
							<option>-请选择布种-</option>
							<c:forEach items="${clothInfos }" var="cloth">
							<option value="${cloth.id }">${cloth.clothName }</option>
							</c:forEach>
						</select>
					</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;height: 35px;">我司编号：</td>
					<td style="text-align: left;">
					<div class="lanyuan_input">
						<select id="myCompanyCode" name="myCompanyCode" onchange="selectMyCompanyCode(this)">
							<option value="">请选择</option>
							<c:forEach var="code" items="${myCompanyCodes }">
								<option value="${code }">${code }</option>
							</c:forEach>
						</select>
					</div>
					</td>
					<td style="text-align: right;">我司颜色：</td>
					<td style="text-align: left;">
						<select id="myCompanyColor" name="myCompanyColor" >
							<option value="">请选择</option>
						</select>
					</td>
				</tr><tr>
					<td style="text-align: right;height: 35px;">数量：</td>
					<td colspan="3" style="text-align: left;">
						<input type="text" id="num" name="num" value="">条
					</td>
				</tr><tr style="height: 30px;">
					<td colspan="4" style="background-color: #E0EEE0;">客户反映质量问题</td>
				</tr><tr>
					<td colspan="4" style="text-align: center;">
						<textarea rows="6" style="width: 98%;" id="qualityProblem" name="qualityProblem"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
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