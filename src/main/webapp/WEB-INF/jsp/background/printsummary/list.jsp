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
<script type="text/javascript" src="${ctx}/js/printSummary.js"></script>
<script type="text/javascript">
	var dialog;
	var grid;

	$(function() {
		$("table").tablesorter({
			debug : true
		});
	});

	function myrefresh() {
		window.location.reload();
	}

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
</script>

</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<a class="btn btn-primary" href="javascript:void(0)"
					id="printSummary"> 打印 </a> 
				<a class="btn btn-primary"
					href="javascript:myrefresh();" id="refresh"> 刷新 </a>
			</form>
		</div>
		<!-- 
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>打印</span>
			</a> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> 刷新
			</a> 
			
		</div>
		 -->
		<div id="paging" class="pagclass">

			<table id="rowspan" cellspacing="0" class="tablesorter">
				<thead>
					<tr>
						<td>序号</td>
						<th>下单日期</th>
						<th>工厂</th>
						<th>布种</th>
						<th>工艺</th>
						<th>编号</th>
						<th>颜色</th>
						<th>数量</th>
						<th>规格</th>
						<th>包装方式</th>
						<th>备注</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ pageView.records }" var="summary">
						<tr>
							<td><input type="checkbox" name="checkId"
								value="${summary.factoryId}-${summary.id}" /></td>
							<td>${summary.createTimeStr}</td>
							<td>${summary.factoryName}</td>
							<td>${summary.clothName}</td>
							<td>${summary.technologyName}</td>
							<td>${summary.factoryCode}</td>
							<td>${summary.factoryColor}</td>
							<td>${summary.num}</td>
							<td>${summary.standard}</td>
							<td>${summary.packingStyle}</td>
							<td>${summary.mark }</td>
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
								<li class="prev"><a href="javascript:void(0);">
										总&nbsp;${pageView.rowCount }&nbsp;条&nbsp;&nbsp;
										每页&nbsp;${pageView.pageSize }&nbsp;条&nbsp;&nbsp;
										共&nbsp;${pageView.pageCount }&nbsp;页</a></li>
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