<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
var dialog;
var grid;

$(function() {
	//grid = window.lanyuan.ui.lyGrid();
	$("#search").click("click", function() {//绑定查询按扭
		// alert("ds");
		$('#pageNow').attr('value',1);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/report/exportFactory.html');
		f.submit();
	});
	
	$("#exportExcel").click("click", function() {
		var f = $('#fenye');
		f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/report/exportFactoryExcel.html');
		f.submit();
	});

});

function loadGird(){
	//grid.loadData();
	$('#pageNow').attr('value',"${pageView.pageNow}");
	var f = $('#fenye');
	//f.attr('target','_blank');
	f.attr('action',window.location.href);
	f.submit();
}
function page(pageNO){
	$('#pageNow').attr('value',pageNO);
	var f = $('#fenye');
	//f.attr('target','_blank');
	f.attr('action','${pageContext.request.contextPath}/background/report/exportFactory.html');
	f.submit();
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
				<input type="hidden" id="pageNow" name="pageNow" value="${pageView.pageNow}" />
				<table>
					<tr>
						<td>
						下单日期:<input type="text" name="beginTime" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
						至<input type="text" name="endTime" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/></td>
						<td>工厂:
							<select id="factoryId" name="factoryId" style="width:110px;">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factorys }" var = "factory">
									<option value="${factory.id }">${factory.name}</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<a class="btn btn-primary" href="javascript:void(0)" id="search"> 查询</a>
							<a class="btn btn-large btn-success" href="javascript:void(0)" id="exportExcel">导出excel</a>
						</td>
					</tr>
				</table>
				
			</form>
		</div>
		
		<div class="topBtn">
			<!--  
			
			-->
		</div>
		
		<div id="paging" class="pagclass">
		
		<table id="table_head" class="pp-list table table-striped table-bordered" style="margin-bottom: -3px; width: 1008px;">
		
		</table>
		
		<div style="overflow-y: auto; overflow-x: auto; height: 348px; border: 1px solid #DDDDDD;" class="t_table">
			<table id="mytable" class="pp-list table table-striped table-bordered" style="margin-bottom: -3px;">
				<thead>
					<tr style="line-height:27px;">
						<td style="text-align:center;">工厂</td>
						<td style="text-align:center;display: ;">布种</td>
						<td style="text-align:center;">数量</td>
						<td style="text-align:center;">工厂余胚</td>
					</tr>
				</thead>
			
				<tbody>
				<c:forEach items="${ pageView.records }" var="summary">
				<tr style="line-height:27px;">
					<td style="text-align:center;">${summary.factoryName}</td>
					<td style="text-align:center;">${summary.clothName}</td>
					<td style="text-align:center;">${summary.numstr }</td>
					<td style="text-align:center;">${summary.clothNumStr }</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
		
		<div style="vertical-align: middle;border: 2px solid #DDDDDD;margin-top: -3px;" class="span12 center">
			<table width="100%">
			<tr>
				<td style="text-align: left;">
					<div class="dataTables_paginate paging_bootstrap pagination">
						<ul>
							<li class="prev">
								<a href="javascript:void(0);">
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
								<li class="prev"><a href="javascript:page(${pageView.pageNow - 1 });">← prev</a></li>
							</c:when>
							<c:otherwise>
								<li class="prev disabled"><a href="javascript:page(${pageView.pageNow - 1 });">← prev</a></li>
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
								<li class="next"><a href="javascript:page(${pageView.pageNow + 1 });">next →</a></li>
							</c:when>
							<c:otherwise>
								<li class="prev disabled"><a href="javascript:page(${pageView.pageNow - 1 });">next →</a></li>
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
		
	</div>
</body>
</html>