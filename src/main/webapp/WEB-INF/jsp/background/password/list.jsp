<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
	var dialog;
	var grid;
	$(function() {
		
		// 修改密码
		$("#passwd_btn").click("click", function() {
			
			// 检查
			var p1 = $("#p_passwd1").attr("value");
			var len = getStrLength(p1);
			if(len < 6) {
				alert("密码太弱！");
				return;
			}
			
			$("#id").attr("value", 1);
			$("#num").attr("value", 0);
			$("#passwd").attr("value", p1);
			
			// alert($("#fenye").serialize());
			
			parent.$.ligerDialog.confirm('确定修改密码吗？', function(confirm) {
				if(confirm == true){
					$.ajax({
					    type: "post", //使用get方法访问后台
					    dataType: "json", //json格式的数据
					    async: false, //同步   不写的情况下 默认为true
					    url: rootPath + '/background/password/updatePasswd.html', //要访问的后台地址
					    data: $("#fenye").serialize(), //要发送的数据
					    success: function(data){
					    	// alert("data:" + data);
					    	if (data.flag == "true") {
					    		parent.$.ligerDialog.success('密码修改成功!', '提示', function() {
					    			// loadGird();//重新加载表格数据
								});
							}else{
								parent.$.ligerDialog.warn("密码修改失败！！");
							}
						}
					});
				}
			});
		});
		
		// 修改数字
		$("#num_btn").click("click", function() {
			// 检查
			var p1 = $("#p_num2").attr("value");
			if(!isPositiveNum(p1)){
				alert("请输入正整数");
				return;
			}
			
			$("#id").attr("value", 2);
			$("#num").attr("value", p1);
			$("#passwd").attr("value", "");
			
			alert($("#fenye").serialize());
			
			parent.$.ligerDialog.confirm('修改打印下单勾选条数？', function(confirm) {
				if(confirm == true){
					$.ajax({
					    type: "post", //使用get方法访问后台
					    dataType: "json", //json格式的数据
					    async: false, //同步   不写的情况下 默认为true
					    url: rootPath + '/background/password/updateNum.html', //要访问的后台地址
					    data: $("#fenye").serialize(), //要发送的数据
					    success: function(data){
					    	// alert("data:" + data);
					    	if (data.flag == "true") {
					    		parent.$.ligerDialog.success('修改打印下单勾选条数成功!', '提示', function() {
					    			// loadGird();//重新加载表格数据
								});
							}else{
								parent.$.ligerDialog.warn("修改打印下单勾选条数失败！！");
							}
						}
					});
				}
			});
		});
		
		
		
		
	});

	function getStrLength(str) {  
	    var cArr = str.match(/[^\x00-\xff]/ig);  
	    return str.length + (cArr == null ? 0 : cArr.length);  
	} 
	
	function isPositiveNum(s){//是否为正整数  
	    var re = /^[1-9]\d*$/ ;  
	    return re.test(s)  
	} 
	
	
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			
		</div>
		
		<div id="paging" class="pagclass">
		
		<form name="fenye" id="fenye">
			<input type="hidden" id="id" name="id"  />
			<input type="hidden" id="passwd" name="passwd"  />
			<input type="hidden" id="num" name="num"  />
		</form>
		
			<div
				style="overflow-y: auto; overflow-x: auto; height: 348px; border: 1px solid #DDDDDD;"
				class="t_table">
				<table id="mytable"
					class="pp-list table table-striped table-bordered"
					style="margin-bottom: -3px;">
					<thead>
						<tr style="line-height: 27px;">
							<td style="text-align: center;">序号</td>
							<td style="text-align: center; display:;">功能</td>
							<td style="text-align: center;">密码</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><span id="p_id1">1</span></td>
							<td>撤销打印、修改、删除5条记录密码</td>
							<td><input type="text" id="p_passwd1" name="p_passwd1" value="${passwd}"></input></td>
						</tr>
					</tbody>
				</table>
				<br/><br/>
				<table class="pp-list table table-striped table-bordered">
					<tr>
						<td style="text-align: center;">
						<a class="btn btn-large btn-success" href="javascript:void(0)" id="passwd_btn">确定</a>
						</td>
					</tr>
				</table>
				
				<br/><br/><br/><br/>
				
				<table class="pp-list table table-striped table-bordered">
					<tr>
						<td style="text-align: center;">修改打印下单勾选条数</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input type="text" id="p_num2" name="p_num2" value="${num}">
							<a class="btn btn-large btn-success" href="javascript:void(0)" id="num_btn">确定</a>
						</td>
					</tr>
				</table>


				
				
			</div>
		
		</div>
	</div>
</body>
</html>