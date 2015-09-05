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
	$(function() {
		
		$("#seach").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			$('#pageNow').attr('value',1);
			f.attr('action','${pageContext.request.contextPath}/background/flower/addMyCompanyCode.html');
			f.submit();
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/cloth/exportExcel.html');
			f.submit();
		});
				
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 450,
				height : 520,
				url : rootPath + '/background/cloth/addUI.html',
				title : "增加布种信息",
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
				width : 400,
				height : 520,
				url : rootPath + '/background/cloth/editUI.html?id='+cbox,
				title : "修改布种信息",
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
					    url: rootPath + '/background/cloth/deleteById.html', //要访问的后台地址
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
	function selectCloth(id){
		//alert(id);
		if(parent.process!=undefined){
			parent.process.addCloth(id);
		}
		if(parent.input!=undefined){
			parent.input.addColorData(id);
		}
		closeWin();
	}
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/flower/addMyCompanyColor.html');
		f.submit();
	}
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye" ation="${pageContext.request.contextPath}/background/flower/addMyCompanyColor.html">
				<input type="hidden" id="clothId" name="clothId" value="${clothId}">
				<input type="hidden" id="technologyId" name="technologyId" value="${technologyId }">
				<input type="hidden" id="pageNow" name="pageNow" value="${pageView.pageNow}" />
				<table><tr>
					<td>
					我司编号：<input type="text" name="code" value="${param.code}" style="height: 17px;width: 150px;" /> 
					</td><td>
					<a class="btn btn-primary" href="javascript:void(0)" id="seach"> 查询</a>
					</td>
				</tr></table>
			</form>
		</div>
		<div id="paging" class="pagclass">
			<table id="mytable" cellspacing="0" border="1" class="dataintable" style="width: 100%;">
				<tr>
					<th>我司编号</th>
				</tr>
				<c:forEach var="bean" items="${pageView.records}" varStatus="status">
				<tr>
					<td style="text-align: center;">
						<a href="#" onclick="selectCloth('${bean }');">${bean }</a>
					</td>
				</tr>
				</c:forEach>
				
				<tr style="width:100px;">
					<td  style="text-align: center;width: 200px;">
					<a href="javascript:page(${pageView.pageNow-1>0?pageView.pageNow-1:1 })">上一页</a>
					${pageView.pageNow }
					<c:if test="${pageView.pageCount< pageView.pageNow+1 }">下一页</c:if>
					<c:if test="${pageView.pageCount>= pageView.pageNow+1 }">
						<a href="javascript:page(${pageView.pageNow+1 })">下一页</a>
					</c:if>
					共${pageView.pageCount }页
					</td>
				</tr>
				
			</table>
		
		</div>
	</div>
</body>
</html>