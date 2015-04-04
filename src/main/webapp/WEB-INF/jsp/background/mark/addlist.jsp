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
		$("#seach").click("click", function() {//绑定查询按扭
			var searchParams = $("#fenye").serialize();
			grid.setOptions({
				data : searchParams
			}); 
		});
		$("#ok").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			window.returnValue=cbox;
			window.close();
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/account/exportExcel.html');
			f.submit();
		});
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/mark/addUI.html',
				title : "增加备注",
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
				url : rootPath + '/background/mark/editUI.html?id='+cbox,
				title : "修改备注",
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
				$.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/mark/deleteById.html', //要访问的后台地址
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
	function getSelectedCheckbox() {
		var arr = [];
		$('input[name="checkId"]:checked').each(function() {
			arr.push($(this).val());
		});
		return arr;
	};
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				名称：<input type="text" name="accountName" value="${param.name}"
					style="height: 20px" /> 
					<a class="btn btn-primary" href="javascript:void(0)" id="seach"> 查询
					<a class="btn btn-primary" href="javascript:void(0)" id="ok"> 确定
				</a>
			</form>
		</div>
		<div id="paging" class="pagclass">
			<table id="mytable" cellspacing="0" border="1" summary="The technical specifications of the Apple PowerMac G5 series">
				<tr>
					<th></th>
					<th>备注内容</th>
				</tr>
				<c:forEach var="bean" items="${pageView.records }" varStatus="status">
				<tr>
					<td>
						<input type="checkbox" name="checkId" value="${bean.content }">						
					</td><td>
						${bean.content }
					</td>
				</tr>
				</c:forEach>
				
				
			</table>
		
		</div>
	</div>
</body>
</html>