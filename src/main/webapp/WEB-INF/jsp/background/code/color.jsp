<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="${ctx}/themes/blue/style.css"
	type="text/css" id="" media="print, projection, screen" />
	
	<%@ include file="/common/header.jsp"%>
	
</head>
<body>
	<div class="divBody">
		<table id="rowspan" cellspacing="0" class="tablesorter">
			<thead>
				<tr>
					<th>工厂颜色</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="addtion">
				<tr>
					<td>${addtion.factoryColor }</td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
	</div>
</body>
</html>