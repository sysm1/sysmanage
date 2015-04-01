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
</script>

</head>
<body>
<form name="fenye" id="fenye">
	<div class="divBody">
		<div class="">
			
			<table width="100%"><tr><td width="100%"><font style="font-size: 40">下单通知</font></td></tr></table>
			
			<table width="100%">
				<tr>
					<td>
						<table width="100%">
							<tr><td colspan="2">地址：</td><td>NO:XD198484866</td></tr>
							<tr><td>电话：038-12345678</td><td>传真：0334-1235678</td><td>下单日期：2015-01-09</td></tr>
						</table>
					</td>
					<td>
						<a class="btn btn-primary" href="javascript:void(0)" id="printsave"> 打印&保存 </a>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">加工单位：**</td>
				</tr>
			</table>
			
		</div>
		
		<div id="paging" class="pagclass">
			<table id="rowspan" cellspacing="0" class="tablesorter">
				<thead>
					<tr>
						<th>序号</th>
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
					<c:forEach items="${ list }" var="summary">
						<tr>
							<td><input name="ids" type="hidden" value="${summary.id}" />${summary.id}</td>
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
			<table width="100%">
			<tr><td width="100%">
				<textarea name="mark" style="margin: 0px; width: 928px; height: 72px;">备注信息</textarea>
			</td></tr>
			</table>
		</div>

	</div>
</form>
</body>
</html>