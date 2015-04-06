<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="${ctx}/themes/blue/style.css"
	type="text/css" id="" media="print, projection, screen" />
	
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
	var dialog;
	var grid;
	
	$(function() {
		
		$("#seach").click("click", function() {
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/code/list.html');
			f.submit();
		});
		
		
		$(".thumbnail").click("click", function() {
			var rid = $(this).attr("rid");
			if(rid == '' || rid == undefined) return;
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/code/picture.html?id='+rid,
				title : "缩微图",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		$(".detailColor").click("click", function() {
			var rid = $(this).attr("rid");
			if(rid == '' || rid == undefined) return;
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/code/detailColor.html?id='+rid,
				title : "工厂颜色",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		
	});
	
	function page(pageNO) {
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		f.attr('action','${pageContext.request.contextPath}/background/code/list.html');
		f.submit();
	}
	
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="1">
				编号：<input type="text" name="code" value="${param.code}" style="height: 20px" /> 
				<a class="btn btn-primary"
					href="javascript:void(0)" id="seach"> 查询
				</a>
			</form>
		</div>
		
		<div id="paging" class="pagclass">
		
			<table id="rowspan" cellspacing="0" class="tablesorter">
				<thead>
					<tr>
						<th>id</th>
						<th>我司编号</th>
						<th>工厂名称</th>
						<th>工厂编号</th>
						<th>缩微图</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ pageView.records }" var="flower">
						<tr>
							<td>${flower.id}</td>
							<td>${flower.myCompanyCode }</td>
							<td>${flower.factoryName}</td>
							<td><span rid="${flower.id}" class="detailColor">${flower.factoryCode}</span></td>
							<td><span pic="${flower.picture}" rid="${flower.id}" class="thumbnail">缩微图</span></td>
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