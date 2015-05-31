<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>

<link rel="stylesheet" href="${ctx}/themes/blue/style.css"
	type="text/css" id="" media="print, projection, screen" />
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript" src="${ctx}/js/jquery.tablesorter.js"></script>
<script type="text/javascript" src="${ctx}/js/printSummary.js"></script>
<script type="text/javascript">
	var dialog;
	var grid;
	$(function() {
		$("form").validate({
			submitHandler : function(form) {//必须写在验证前面，否则无法ajax提交
				$(form).ajaxSubmit({//验证新增是否成功
					type : "post",
					dataType:"json",
					success : function(data) {
						if (data.flag == "true") {
							$.ligerDialog.success('提交成功!', '提示', function() {
								//这个是调用同一个页面趾两个iframe里的js方法
								//account是iframe的id
								parent.orderAudit.loadGird();
								closeWin();
								//window.location.href=rootPath + "/background/orderAudit/list.html";
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			}		
		});
	});
	
	function saveWin() {
		$("#form").submit();
	}
</script>

</head>
<body>
<form name="form" id="form" action="${ctx}/background/orderAudit/audit.html" method="post">
	<input name="id" id="id" type="hidden" value="${id}" />
	<div class="divBody">
		<div class="pagclass">
			<table width="100%" class="dataintable">
				<tr>
					<td>地址：</td>
					<td></td>
					<td>NO:</td><td>XD198484866</td>
					<td>下单日期：</td><td>${orderNotifyInfo.createTimeStr}</td>
				</tr><tr>
					<td>电话：</td><td>038-12345678</td><td>传真：</td><td>0334-1235678</td>
					<td>加工单位：</td><td>${orderNotifyInfo.factoryName }</td>
				</tr>
			</table>
		</div>
		
		<div id="paging" class="pagclass">
			<table id="rowspan" cellspacing="0" class="dataintable" style="width: 945px;">
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
		</div>
		<div id="paging" class="pagclass">
			<table class="dataintable" style="width: 945px;">
				<tr>
					<td colspan="2" style="text-align: center;font-size: 15px;font-weight: bold;">备&nbsp;&nbsp;注</td>
				</tr>
				<tr>
				<td width="100%" colspan="2" style="text-align: left;min-height: 40px;" >
					${orderNotifyInfo.mark }
				</td></tr>
				<tr>
					<td style="width: 145px;">审核是否通过：</td>
					<td style="text-align: left;">
						<input type="radio" name="status" value="1" <c:if test="${audit.status eq 1 }">checked="checked"</c:if> >通过&nbsp;
						<input type="radio" name="status" value="2" <c:if test="${audit.status eq 2 }">checked="checked"</c:if> >不通过
					</td>
				</tr><tr>
					<td>审核意见：</td>
					<td>
						<textarea id="reason" name="reason" style="width: 800px;height: 70px;">${audit.reason }</textarea>
					</td>
				</tr><tr>
					<td colspan="2" style="text-align: center;">
						<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();">
							<span>保存</span> 
						</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
</body>
</html>