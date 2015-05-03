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
	
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/printsummary/list.html');
		f.submit();
	}
	
</script>

</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="1">
				<a class="btn btn-primary" href="javascript:void(0)" id="printSummary"> 打印 </a> 
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
						<th rowspan="2"></th>
						<th rowspan="2" style="font-size: 14px;">下单日期</th>
						<th rowspan="2" style="font-size: 14px;">工厂</th>
						<th rowspan="2" style="font-size: 14px;">布种</th>
						<th rowspan="2" style="font-size: 14px;">工艺</th>
						<th rowspan="2" style="font-size: 14px;">编号</th>
						<th rowspan="2" style="font-size: 14px;">颜色</th>
						<th rowspan="2" style="font-size: 14px;">数量</th>
						<th colspan="2" style="font-size: 14px;text-align: center;">规格</th>
						<th colspan="3" style="font-size: 14px;text-align: center;">包装方式</th>
						<th rowspan="2" style="font-size: 14px;">备注</th>
					</tr>
					<tr>
						<th style="font-size: 12px;">宽幅</th>
						<th style="font-size: 12px;">克重</th>
						<th style="font-size: 12px;">纸管</th>
						<th style="font-size: 12px;">空差</th>
						<th style="font-size: 12px;">胶袋</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ pageView.records }" var="summary">
						<tr>
							<td><input type="checkbox" name="checkId"
								value="${summary.factoryId}-${summary.id}" /></td>
							<td style="font-size: 12px;">${summary.createTimeStr}</td>
							<td style="font-size: 12px;">${summary.factoryName}</td>
							<td style="font-size: 12px;">${summary.clothName}</td>
							<td style="font-size: 12px;">${summary.technologyName}</td>
							<td style="font-size: 12px;">${summary.factoryCode}</td>
							<td style="font-size: 12px;">${summary.factoryColor}</td>
							<td style="font-size: 12px;">
								<c:if test="${summary.unit==4 }">${summary.num}KG</c:if>
								<c:if test="${summary.unit==0 }">
									<fmt:formatNumber var="c" value="${summary.num}" pattern="#"/>
									${c}条
								</c:if>
							</td>
							<td style="font-size: 12px;">
						 		${summary.kuanfu }CM
						 		<c:if test="${summary.kuanfufs==0 }">包边</c:if>
						 		<c:if test="${summary.kuanfufs==1 }">实用</c:if>
						 	</td>
						 	<td style="font-size: 12px;">
						 		${summary.kezhong }
						 		<c:if test="${summary.kezhongUnit==0 }">G/M2</c:if>
						 		<c:if test="${summary.kezhongUnit==1 }">G/Y</c:if>
						 		<c:if test="${summary.kezhongUnit==2 }">G/M</c:if>
						 		<c:if test="${summary.kezhongfs==0 }">回后</c:if>
						 		<c:if test="${summary.kezhongfs==1 }">出机</c:if>
						 	</td><td style="font-size: 12px;">
						 		${summary.zhiguan }
						 	</td><td style="font-size: 12px;">
						 		${summary.kongcha }
						 	</td><td style="font-size: 12px;">
						 		${summary.jiaodai }
						 	</td>
							<td style="font-size: 12px;">${summary.mark }</td>
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