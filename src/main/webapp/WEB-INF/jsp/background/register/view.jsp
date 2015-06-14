<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">
//单独验证某一个input  class="checkpass"
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
								parent.register.loadGird();
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
	function selectFactory(obj){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/ordersummary/queryFactoryCodeByFactoryId.html', //要访问的后台地址
		    data: {factoryId:obj.value}, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	var factoryCode = $("#factoryCode");
		    	factoryCode.empty();
		    	$("#factoryColor").empty();
		    	if(data!=null&&data!=''){
			    	for(var i=0;i<data.length;i++) {
			    	    var option = $("<option>").text(data[i]).val(data[i]);
			    	    factoryCode.append(option);
			    	    if(i==0){
			    	    	selectFactoryCode(data[i]);
			    	    }
			    	}
		    	}else{
		    		factoryCode.append($("<option>").text("-无数据-").val(""));
		    		$("#factoryColor").append($("<option>").text("-无数据-").val(""));
		    	}
			}
		});
	}
	function selectFactoryCode(code){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/ordersummary/queryFactoryColor.html', //要访问的后台地址
		    data: {factoryCode:code,factoryId:$("#factoryId").val()}, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	var factoryColor = $("#factoryColor");
			    factoryColor.empty();
			    factoryColor.append($("<option>").text("-请选择-").val(""));
		    	if(data!=null&&data!=''){
			    	for(var i=0;i<data.length;i++) {
			    	    var option = $("<option>").text(data[i]).val(data[i]);
			    	    factoryColor.append(option);
			    	}
		    	}else{
		    		//alert('没有相关联的我司编号');
		    	}
			}
		});
	}
	function selectFactoryColor(value){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/process/queryReturnTime.html', //要访问的后台地址
		    data: {factoryCode:$("#factoryCode").val(),factoryColor:value,factoryId:$("#factoryId").val()}, //要发送的数据
		    success: function(data){
		    	var date="";
		    	if(data!=null&&data!=''){
			    	var factoryColor = $("#factoryColor");
			    	//factoryColor.empty();
			    	factoryColor.append($("<option>").text("请选择").val(""));
			    	for(var i=0;i<data.length;i++) {
			    		date=","+date+data[i].substring(0,10);
			    	}
		    	}
		    	$('#returnDatespan')[0].innerHTML=date.substring(1);
		    	$('#returnDate').val(date.substring(1));
			}
		});
	}
</script>
</head>
<body >
<div class="divdialog" style="text-align: center;">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/examine/update.html" method="post">
		<input type="hidden" id="id" name="id" value="${unsub.id }">
		<table style="width: 98%; height: 100%;background-color: #9AFF9A;margin-left: 6px;" border="1" class="dataintable">
			<tbody>
				<tr>
					<td style="text-align: right;height: 30px;width: 15%;">退货日期：</td>
					<td class="l_left" style="text-align: left;">
					<div class="lanyuan_input">
						<fmt:formatDate value='${unsub.unsubdate }' pattern='yyyy-MM-dd'/>
					</div>
					</td>
					<td style="text-align: right;width: 15%;">布种：</td>
					<td style="width: 35%;text-align: left;">
					<div class="lanyuan_input">${unsub.clothName }
					</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;height: 30px;">我司编号：</td>
					<td style="text-align: left;">
					<div class="lanyuan_input">${unsub.myCompanyCode }
					</div>
					</td>
					<td style="text-align: right;">我司颜色：</td>
					<td style="text-align: left;">${unsub.myCompanyColor }
					</td>
				</tr><tr>
					<td style="text-align: right;height: 30px;">数量：</td>
					<td style="text-align: left;">
						${unsub.ysnum }条
					</td><td>工艺：</td>
					<td style="text-align: left;">${unsub.technologyName }</td>
				</tr><tr style="height: 30px;">
					<td colspan="4" style="background-color: #E0EEE0;text-align: center;">客户反映质量问题</td>
				</tr><tr>
					<td colspan="4" style="text-align: left;">
						${unsub.qualityProblem }
					</td>
				</tr><tr style="height: 30px;">
					<td style="text-align: right;">工厂：</td>
					<td style="text-align: left;">
						${unsub.factoryName}
					</td>
					<td style="text-align: right;">工厂编号：</td>
					<td style="text-align: left;">
						${unsub.factoryCode}
					</td>
				</tr><tr style="height: 30px;">
					<td style="text-align: right;">工厂颜色：</td>
					<td style="text-align: left;">
						${unsub.factoryColor}
					</td>
					<td style="text-align: right;">到货日期：</td>
					<td style="text-align: left;">
						<fmt:formatDate value="${unsub.returnDate }" pattern="yyyy-MM-dd"/>
					</td>
				</tr><tr style="height: 30px;">
					<td colspan="4" style="background-color: #D1EEEE;text-align: center;">我司验收报告</td>
				</tr><tr>
					<td colspan="4" style="text-align: left;">
						<c:if test="${unsub.myCompanyReport == null ||unsub.myCompanyReport == '' }">&nbsp;<br></c:if>
						<c:if test="${unsub.myCompanyReport != null }">${unsub.myCompanyReport }</c:if>
					</td>
				</tr><tr style="height: 30px;">
					<td colspan="4" style="background-color: #DEDEDE;text-align: center;">工厂交涉情况</td>
				</tr><tr>
					<td colspan="4" style="text-align: left;">
						${unsub.negotiate }
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<div class="l_btn_centent">
								<!-- saveWin_form   from是表单Ｉd-->
								<a class="btn btn-primary" href="javascript:void(0)"
									id="saveWin_form" onclick="closeWin();"><span>关闭</span> </a> 
							</div>
						</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>