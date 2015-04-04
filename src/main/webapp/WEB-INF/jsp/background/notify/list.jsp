<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link rel="stylesheet" href="${ctx}/themes/blue/style.css"
	type="text/css" id="" media="print, projection, screen" />
<script type="text/javascript" src="${ctx}/js/jquery.tablesorter.js"></script>

<script type="text/javascript">

	var dialog;
	var grid;
	$(function() {
		
		$("#cancelView").click("click", function() {//绑定查询按扭
			var cbox = getSelectedCheckbox();
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
					    			// loadGird();//重新加载表格数据
					    			// window.location.reload();
					    			window.location.href = "${pageContext.request.contextPath}/background/printsummary/list.html"
								});
							}else{
								parent.$.ligerDialog.warn("撤销失败！！");
							}
						}
					});
				}
			});
		});
		
		
		$("#seach").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/notify/list.html');
			f.submit();
		});
		
		$(".detail").click("click", function(){
			var rid = $(this).attr("rid");
			if(rid == '' || rid == undefined) return;
			dialog = parent.$.ligerDialog.open({
				width : 600,
				height : 410,
				url : rootPath + '/background/notify/detail.html?id=' + rid,
				title : "查看详情",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
	});
	
	/**
	 * 获取选中的值
	 */
	function getSelectedCheckbox() {
		var arr = [];
		$('input[name="checkId"]:checked').each(function() {
			arr.push($(this).val());
		});
		return arr;
	};
	

	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		f.attr('action','${pageContext.request.contextPath}/background/notify/list.html');
		f.submit();
	}
	
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="1">
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
		<div id="paging" class="pagclass">
			
			<table id="rowspan" cellspacing="0" class="tablesorter">
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th>序号</th>
						<th>单号</th>
						<th>工厂</th>
						<th>下单日期</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ pageView.records }" var="summary">
						<tr>
							<td><input type="checkbox" name="checkId" value="${summary.notifyId}" /></td>
							<td><span class="detail" rid="${summary.notifyId}">${summary.notifyId}</span></td>
							<td>${summary.no}</td>
							<td>${summary.factoryName}</td>
							<td>${summary.notifyTimeStr }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
		</div>
		
		
		<div
			style="vertical-align: middle; border: 2px solid #DDDDDD; margin-top: -3px;"
			class="span12 center">
			<table width="100%">
				<tr>
					<td style="text-align: left;">
						<div class="dataTables_paginate paging_bootstrap pagination">
							<ul>
								<li class="prev"><a href="javascript:void(0)">
										总&nbsp;${pageView.rowCount }&nbsp;条&nbsp;&nbsp;
										每页&nbsp;${pageView.pageSize }&nbsp;条&nbsp;&nbsp;
										共&nbsp;${pageView.pageCount }&nbsp;页</a>
								</li>
							</ul>
						</div>
					</td>
					<!-- disabled active -->
					<td style="text-align: right;">
						<div class="dataTables_paginate paging_bootstrap pagination">
							<ul>
								<c:if test="${pageView.pageCount > 1 }">
									<li><a href="javascript:page(1)">首页</a></li>
								</c:if>

								<c:choose>
									<c:when test="${pageView.pageNow > 1 }">
										<li class="prev"><a
											href="javascript:page(${pageView.pageNow - 1 });">← prev</a></li>
									</c:when>
									<c:otherwise>
										<li class="prev disabled"><a
											href="javascript:page(${pageView.pageNow - 1 });">← prev</a></li>
									</c:otherwise>
								</c:choose>

								<c:forEach items="${pageList}" var="pageno">
									<c:choose>
										<c:when test="${pageno == pageNow}">
											<li class="active">${pageno}</li>
										</c:when>
										<c:otherwise>
											<li><a href="javascript:page(${pageno});">${pageno}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<c:choose>
									<c:when test="${pageView.pageCount > pageView.pageNow }">
										<li class="next"><a
											href="javascript:page(${pageView.pageNow + 1 });">next →</a></li>
									</c:when>
									<c:otherwise>
										<li class="prev disabled"><a
											href="javascript:page(${pageView.pageNow - 1 });">next →</a></li>
									</c:otherwise>
								</c:choose>

								<c:if test="${pageView.pageCount > pageView.pageNow }">
									<li><a href="javascript:page(${pageView.pageCount})">尾页</a></li>
								</c:if>
							</ul>
						</div>
					</td>
				</tr>

			</table>
		</div>
		
		
	</div>
</body>
</html>