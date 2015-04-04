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
						name : "序号",
						width : "50px"
					},{
						colkey : "no",
						name : "单号"
					},{
						colkey : "factoryName",
						name : "工厂"
					},{
						colkey : "createTimeStr",
						name : "下单日期"
					}],
					jsonUrl : '${pageContext.request.contextPath}/background/notify/queryFind.html',
					checkbox : true
				});
		
		
		
		$("#cancelView").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox=="") {
				parent.$.ligerDialog.alert("请选择撤销打印项！！");
				return;
			}
			parent.$.ligerDialog.confirm('确定择撤销打印吗？', function(confirm) {
				if (confirm) {
					$.ajax({
					    type: "post", //使用get方法访问后台
					    dataType: "json", //json格式的数据
					    async: false, //同步   不写的情况下 默认为true
					    url: rootPath + '/background/notify/cancel.html', //要访问的后台地址
					    data: {ids:cbox.join(",")}, //要发送的数据
					    success: function(data){
					    	if (data.flag == "true") {
					    		parent.$.ligerDialog.success('撤销成功!', '提示', function() {
					    			loadGird();//重新加载表格数据
								});
							}else{
								parent.$.ligerDialog.warn("撤销失败！！");
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
				下单日期:<input type="text" name="beginTime" value="${param.beginTime}" style="width:100px;" />至
				<input type="text" name="endTime" value="${param.endTime}" style="width:100px;" />
				工厂:
				<select id="factoryId" name="factoryId" style="width:100px;">
					<option value="">请选择工厂</option>
					<c:forEach items="${ factorys }" var = "factory">
						<option value="${factory.id }">${factory.name}</option>
					</c:forEach>
				</select>
				工艺:
				<select id="factoryId" name="factoryId" style="width:100px;">
					<option value="">请选择工艺</option>
					<c:forEach items="${ technologys }" var = "technology">
						<option value="${technology.id }">${technology.name}</option>
					</c:forEach>
				</select><br/>
				布种:
				<select id="clothId" name="clothId" style="width:100px;">
					<option value="">请选择布种</option>
					<c:forEach items="${ cloths }" var = "cloth">
						<option value="${cloth.id }">${cloth.clothName}</option>
					</c:forEach>
				</select>
				工厂编号:
					<input type="text" name="factoryCode" value="${param.factoryCode}" style="width:100px;" />
				工厂颜色:
					<input type="text" name="factoryColor" value="${param.factoryColor}" style="width:100px;" />
				<a class="btn btn-primary"
					href="javascript:void(0)" id="seach"> 查询
				</a>
			</form>
		</div>
		<div class="topBtn">

			<a class="btn btn-danger" href="javascript:void(0)" id="cancelView"> <i
				class="icon-trash icon-white"></i> 撤销打印
			</a>
			
		</div>
		<div id="paging" class="pagclass"></div>
	</div>
</body>
</html>