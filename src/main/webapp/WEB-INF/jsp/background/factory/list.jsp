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
					}, {
						colkey : "name",
						name : "名称",
						width:"300px"
					}, {
						colkey : "cityName",
						name : "分点",
						width:"300px"
					}, {
						colkey : "statusName",
						name : "状态",
						width:"300px"
					}
					/**, {
						colkey : "mark",
						name : "备注"
					}*/
					],
					jsonUrl : '${pageContext.request.contextPath}/background/factory/query.html',
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
			f.attr('action','${pageContext.request.contextPath}/background/factory/exportExcel.html');
			f.submit();
		});
		
		
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 410,
				url : rootPath + '/background/factory/addUI.html',
				title : "增加工厂信息",
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
				height : 410,
				url : rootPath + '/background/factory/editUI.html?id='+cbox,
				title : "修改工厂信息",
				isHidden : false
			});
		});
		
		$("#view").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/factory/viewUI.html?id='+cbox,
				title : "查看工厂信息",
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
					    url: rootPath + '/background/factory/deleteById.html', //要访问的后台地址
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
				名称：<input type="text" name="name" value="${param.name}"
					style="height: 20px" />
				分点：
				<select id="cityId" name="cityId">
					<option value="">请选择</option>
					<c:forEach items="${citys }" var="city">
					<option value="${city.id }">${city.name }</option>
					</c:forEach>
				</select>
				状态：
				<input type="radio" id="status0" name="status" value=""  >全部
				<input type="radio" id="status1" name="status" value="1" <c:if test="${factory.status eq 1 }">checked="checked" </c:if> >正常
				<input type="radio" id="status2" name="status" value="2" <c:if test="${factory.status eq 2 }">checked="checked" </c:if>>停用
				<a class="btn btn-primary" href="javascript:void(0)" id="seach"> <span>查询</span>
				</a>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <span>添加</span>
			</a> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView">  <span>修改</span>
			</a> 
			
			<a class="btn btn-primary" href="javascript:void(0)" id="view">  <span>查看</span>
			</a>
			<!-- 
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <span>删除</span>
			</a>
			 -->
		</div>
		<div id="paging" class="pagclass"></div>
	</div>
</body>
</html>