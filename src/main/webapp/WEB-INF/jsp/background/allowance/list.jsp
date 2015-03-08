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
		grid = window.lanyuan.ui.lyGrid({
					id : 'paging',
					l_column : [ {
						colkey : "id",
						name : "id",
						width : "50px"
					},{
						colkey : "strInputDate",
						name : "日期",
						width : "100px"
					},{
						colkey : "clothName",
						name : "布种名称",
						width : "200px"
					},{
						colkey : "factoryName",
						name : "工厂",
						width : "200px"
					}, {
						colkey : "allowance",
						name : "现余量",
						width : "50px"
					}, {
						colkey : "oldSum",
						name : "前余量",
						width : "50px"
					}, {
						colkey : "changeSum",
						name : "新增量",
						width : "50px"
					},{
						colkey : "mark",
						name : "备注"
					}],
					jsonUrl : '${pageContext.request.contextPath}/background/allowance/queryByFind.html',
					checkbox : true
				});
		
		$("#seach").click("click", function() {//绑定查询按扭
			var searchParams = $("#fenye").serialize();
			grid.setOptions({
				data : searchParams
			}); 
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/allowance/exportExcel.html');
			f.submit();
		});
		
		
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 400,
				height : 410,
				url : rootPath + '/background/allowance/addUI.html',
				title : "增加坯布余量",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		$("#editView").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/allowance/editUI.html?id='+cbox,
				title : "修改坯布余量",
				isHidden : false
			});
		});
		
		$("#deleteView").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox=="") {
				parent.$.ligerDialog.alert("请选择删除项！！");
				return;
			}
			parent.$.ligerDialog.confirm('删除后不能恢复，确定删除吗？', function(confirm) {
				if (confirm) {
					$.ajax({
					    type: "post", //使用get方法访问后台
					    dataType: "json", //json格式的数据
					    async: false, //同步   不写的情况下 默认为true
					    url: rootPath + '/background/allowance/deleteById.html', //要访问的后台地址
					    data: {ids:cbox.join(",")}, //要发送的数据
					    success: function(data){
					    	if (data.flag == "true") {
					    		parent.$.ligerDialog.success('删除成功!', '提示', function() {
					    			loadGird();//重新加载表格数据
								});
							}else{
								parent.$.ligerDialog.warn("删除失败！！");
							}
						}
					});
				}
			});
		});
	});
	function loadGird(){
		grid.loadData();
	}
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				布种：
				<select id="clothId" name="clothId">
					<option value="">请选择布种</option>
					<c:forEach items="${ cloths }" var = "cloth">
						<option value="${cloth.id }">${cloth.clothName}</option>
					</c:forEach>
				</select> 
				工厂:
				<select id="factoryId" name="factoryId">
					<option value="">请选择工厂</option>
					<c:forEach items="${ factorys }" var = "factory">
						<option value="${factory.id }">${factory.name}</option>
					</c:forEach>
				</select>
				备注:<input type="text" name="mark" value="${param.mark}" style="height: 20px" /><br/>
				开始日期:<input type="text" name="beginTime" value="${param.beginTime}" style="height: 20px;width:100px" />
				结束日期:<input type="text" name="endTime" value="${param.endTime}" style="height: 20px;width:100px" />
				新增量:
				<select id="change" name="change">
					<option value="all">全部</option>
					<option value="positive">正数</option>
					<option value="negative">负数</option>
					<option value="zero">0</option>
				</select>
				<a class="btn btn-primary"
					href="javascript:void(0)" id="seach"> 查询
				</a>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>add</span>
			</a> 
			
			<!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> Edit
			</a> 
			
			<a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <i
				class="icon-trash icon-white"></i> Delete
			</a>
			
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="exportExcel">
				导出excel
			</a>
		</div>
		<div id="paging" class="pagclass"></div>
	</div>
</body>
</html>