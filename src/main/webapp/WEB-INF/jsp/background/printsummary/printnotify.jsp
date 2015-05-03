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
	<input name="factoryId" type="hidden" value="${factory.id}" />
	<div class="divBody">
		<div class="">
			
			<table width="100%"><tr><td width="100%"><font style="font-size: 40">下单通知</font></td></tr></table>
			
			<table width="100%">
				<tr>
					<td>
						<table width="100%">
							<tr><td colspan="2">地址：</td><td>NO:XD198484866</td></tr>
							<tr><td>电话：038-12345678</td><td>传真：0334-1235678</td><td>下单日期：${printDate}</td></tr>
						</table>
					</td>
					<td>
						<a class="btn btn-primary" href="javascript:void(0)" id="printsave"> 打印&保存 </a>
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
						<th rowspan="2" style="font-size: 14px;text-align: center;">序号</th>
						<th rowspan="2" style="font-size: 14px;text-align: center;">布种</th>
						<th rowspan="2" style="font-size: 14px;text-align: center;">工艺</th>
						<th rowspan="2" style="font-size: 14px;text-align: center;">编号</th>
						<th rowspan="2" style="font-size: 14px;text-align: center;">颜色</th>
						<th rowspan="2" style="font-size: 14px;text-align: center;">数量</th>
						<th colspan="2" style="font-size: 14px;text-align: center;">规格</th>
						<th colspan="3" style="font-size: 14px;text-align: center;">包装方式</th>
						<th rowspan="2" style="font-size: 14px;text-align: center;">备注</th>
					</tr><tr>
						<th style="font-size: 12px;width: 75px;">宽幅</th>
						<th style="font-size: 12px;width: 85px;">克重</th>
						<th style="font-size: 12px;">纸管</th>
						<th style="font-size: 12px;">空差</th>
						<th style="font-size: 12px;">胶袋</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ list }" var="summary">
						<tr>
							<td style="font-size: 12px;"><input name="ids" type="hidden" value="${summary.id}" />${summary.id}</td>
							<td style="font-size: 12px;">${summary.clothName}</td>
							<td style="font-size: 12px;">${summary.technologyName}</td>
							<td style="font-size: 12px;">${summary.factoryCode}</td>
							<td style="font-size: 12px;">${summary.factoryColor}</td>
							<td style="font-size: 12px;">${summary.num}</td>
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