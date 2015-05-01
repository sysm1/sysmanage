<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
var dialog;
var grid;

$(function() {
	
	$("#exportAll").click("click", function() {
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/db/exportAll.html', //要访问的后台地址
		    data: {}, //要发送的数据
		    success: function(data){
		    	if (data.flag == "true") {
		    		parent.$.ligerDialog.success('备份成功!', '提示', function() {
		    			
					});
				}else{
					parent.$.ligerDialog.warn("删除失败！！");
				}
			}
		});
	});
	
	
	$("#importAll").click("click", function() {//绑定查询按扭
		
		parent.$.ligerDialog.confirm('还原将清除已有的数据，确定还原吗？', function(confirm) {
			// alert("confirm:" + confirm)
			if(confirm == true){
				$.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/db/importAll.html', //要访问的后台地址
				    data: {}, //要发送的数据
				    success: function(data){
				    	// alert("data:" + data);
				    	if (data.flag == "true") {
				    		parent.$.ligerDialog.success('还原成功!', '提示', function() {
				    			// loadGird();//重新加载表格数据
							});
						}else{
							parent.$.ligerDialog.warn("还原失败！！");
						}
					}
				});
			}
		});
	});
	
	
	
	$("#flower").click("click", function() {
		/**
		if($("#date4").attr("checked")){
			
		} else {
			$("#beginTime").attr("value", $("#beginTime4").attr("value"));
			$("#endTime").attr("value", $("#endTime4").attr("value"));
		}
		**/
		var f = $('#fenye');
		f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/flower/exportExcel.html');
		f.submit();
	});
	
	// 下单历史记录导出
	$("#summary").click("click", function() {
		/**
		if($("#date2").attr("checked")){
			
		} else {
			$("#beginTime").attr("value", $("#beginTime2").attr("value"));
			$("#endTime").attr("value", $("#endTime2").attr("value"));
		}
		**/
		var f = $('#fenye');
		f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/ordersummary/exportSummaryExcel.html');
		f.submit();
	});
	
});
</script>
</head>
<body>
	<div class="divBody">
		
		<form name="fenye" id="fenye">
			
			<input type="hidden" id="beginTime" name="beginTime"  />
			<input type="hidden" id="endTime" name="endTime"  />
		</form>

		<div id="paging" class="pagclass">

			<table id="table_head"
				class="pp-list table table-striped table-bordered"
				style="margin-bottom: -3px; width: 400px;">

			</table>
			<br/>
			<div
				style="overflow-y: auto; overflow-x: auto; height: 348px; border: 1px solid #DDDDDD;"
				class="t_table">
				<table id="mytable"
					class="pp-list table table-striped table-bordered"
					style="margin-bottom: -3px;width:400px">
					
					<tr><td>
						<a class="btn btn-large btn-success" href="javascript:void(0)" id="flower">花号基础资料导出</a></td>
						<td>
						<a class="btn btn-large btn-success" href="javascript:void(0)" id="2">花号基础资料导入</a></td></tr>
					<tr><td>
						<a class="btn btn-large btn-success" href="javascript:void(0)" id="summary">下单历史记录导出</a></td>
					<td><a class="btn btn-large btn-success" href="javascript:void(0)" id="4">下单历史记录导入</a></td></tr>
					
					<tr><td>
					<a class="btn btn-large btn-success" href="javascript:void(0)" id="exportAll">软件数据备份</a></td>
					<td><a class="btn btn-large btn-success" href="javascript:void(0)" id="importAll">软件数据还原</a></td></tr>
					
				</table>
			</div>


		</div>

	</div>
</body>
</html>