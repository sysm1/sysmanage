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
</script>

</head>
<body>

	<div class="divBody">
		<div class="">
			
			<table width="100%">
				<tr>
					<td>
						<table width="100%">
							<tr><td colspan="2">地址：</td><td>NO:XD198484866</td></tr>
							<tr><td>电话：038-12345678</td><td>传真：0334-1235678</td><td>下单日期：${notify.createTimeStr}</td></tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">加工单位：${factory.name }</td>
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
				<textarea name="mark" style="margin: 0px; width: 328px; height: 72px;">
					${notify.mark}
				</textarea>
			</td></tr>
			</table>
		</div>

	</div>

</body>
</html>