<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<!-- 开办录入查询 -->
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
					}, {
						colkey : "sampleDate",
						name : "开版日期",
						width : "100px"
					}, {
						colkey : "factoryName",
						name : "工厂",
						width:"120px"
					}, {
						colkey : "clothName",
						name : "布种",
						width : "150px"
					}, {
						colkey : "codeValue",
						name : "编号"
					}, {
						colkey : "technologyName",
						name : "工艺"
					}, {
						colkey : "mark",
						name : "备注"
					}, {
						colkey : "createTime",
						name : "图片",
						render:function(rowdata, rowindex, value){
							alert(22);
						}
					} ],
					

					jsonUrl : '${pageContext.request.contextPath}/background/sample/query.html',
					
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
			f.attr('action','${pageContext.request.contextPath}/background/account/exportExcel.html');
			f.submit();
		});
		$("#add").click("click", function() {//绑定新增按扭
			dialog = parent.$.ligerDialog.open({
				width : 950,
				height : 500,
				url : rootPath + '/background/sample/addUI.html',
				title : "开版录入",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		$("#editView").click("click", function() {//绑定编辑按扭
			var cbox=grid.getSelectedCheckbox();
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			if (cbox.length > 1) {
				parent.$.ligerDialog.alert("一次只能修改一条记录");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 950,
				height : 500,
				url : rootPath + '/background/sample/editUI.html?id='+cbox,
				title : "修改开版录入",
				isHidden : false
			});
		});
		$("#perrole").click("click", function() {//绑定查询按扭
			var cbox=grid.selectRow();
			if (cbox.id == undefined || cbox.id=="") {
				parent.$.ligerDialog.alert("请选择一条数据!");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 500,
				height : 410,
				url : rootPath + '/background/account/accRole.html?id='+cbox.id+'&accountName='+encodeURI(encodeURI(cbox.accountName))+'&roleName='+encodeURI(encodeURI(cbox.roleName)),
				title : "分配角色",
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
					    url: rootPath + '/background/account/deleteById.html', //要访问的后台地址
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
				开版日期：
				<input type="text" id="startDay" name="startDay" value="" style="width:97px;">
				<input type="text" id="endDay" name="endDay" value="" style="width:98px;">
				备注：<input type="text" id="market" name="market" value="">
				编号：<input type="text" id="code" name="code" value="">
				<br>
				工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;厂：&nbsp;<select>
						<option value="">请选择</option>
					  </select>
			          布种：<select>
						<option value="">请选择</option>
					  </select>
			          工艺：<select>
						<option value="">请选择</option>
					  </select>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> 
				<i class="icon-zoom-add icon-white"></i> <span>新增</span>
			</a> <a class="btn btn-info" href="javascript:void(0)" id="editView"> 
				<i class="icon-edit icon-white"></i> 修改
			</a> <a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> 
				<i class="icon-zoom-add icon-white"></i> 复制新增
			</a> <a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> 
				<i class="icon-trash icon-white"></i> 删除
			</a>
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="perrole">
				查询
			</a>
		</div>
		<div id="paging" class="pagclass"></div>
	</div>
</body>
</html>