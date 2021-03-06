<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">
	var dialog;
	var grid;
	var delarr = [];
	$(function() {
		
		$("#seach").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/technology/list.html');
			f.submit();
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/technology/exportExcel.html');
			f.submit();
		});
		
		
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/technology/addUI.html',
				title : "增加工艺信息",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		$("#editView").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/technology/editUI.html?id='+cbox,
				title : "修改工艺信息",
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
					    url: rootPath + '/background/technology/deleteById.html', //要访问的后台地址
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
		window.location.reload();
	}
	/**
	 * 获取选中的值
	 */
	function getSelectedCheckbox() {
		var arr = [];
		$('input[name="checkId"]:checked').each(function() {
			arr.push($(this).val());
			delarr.push($(this).val());
		});
		return arr;
	};
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				名称：<input type="text" name="name" value="${param.name}"
					style="height: 20px" /> <a class="btn btn-primary"
					href="javascript:void(0)" id="seach"> 查询
				</a>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>新增</span>
			</a> 
			
			<!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> 修改
			</a> 
			
			<!-- a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <i
				class="icon-trash icon-white"></i> Delete
			</a-->
			
			<!--a class="btn btn-large btn-success" href="javascript:void(0)" id="exportExcel">
				导出excel
			</a-->
		</div>
		<div id="paging" class="pagclass">
		<table class="dataintable" style="width: 100%;">
				<tr>
					<th class="specalt" style="width:35px;">选择</th>
					<th>名称</th>
					<th>状态</th>
					<th>备注</th>
					<!--th>工厂颜色</th>
					<th style="width:80px;">到货日期</th>
					<th>我司验货报告</th>
					<th>工厂交涉情况</th-->
				</tr>
				
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr  id="${status.index }" >
						<td style="width:10%;text-align: center;">
					 		<input type="checkbox"  id="checkId" name="checkId" value="${item.id }" >
					 	</td><td style="width: 15%;">
					 		${item.name }
					 	</td><td style="width: 10%;text-align: center;">
					 		<c:if test="${item.status ==1 }">
					 			正常
					 		</c:if><c:if test="${item.status ==2 }">
					 			停用
					 		</c:if>
					 	</td><td>
					 		${item.mark }
					 	</td>
					<tr>
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="10" style="text-align: center;font-size: 14px;">
						<%@ include file="../page.jsp"%>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>