<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">

//单独验证某一个input  class="checkpass"
	
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 370px;"></div>
	<table class="pp-list table table-striped table-bordered" style="margin-bottom: -3px;">
		<thead>
			<tr style="line-height:27px;">
				<td style="text-align:center;">序号</td>
				<td style="text-align:center;display: ;">我司编号</td>
				<td style="text-align:center;">工厂编号</td>
				<td style="text-align:center;">我司颜色</td>
				<td style="text-align:center;">工厂颜色</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ list }" var="fad">
			<tr style="line-height:27px;" id="${fad.id}">
				<td style="text-align:center;">${fad.id}</td>
				<td style="text-align:center;display: ;">${fad.myCompanyCode}</td>
				<td style="text-align:center;">${fad.factoryCode}</td>
				<td style="text-align:center;">${fad.myCompanyColor}</td>
				<td style="text-align:center;">${fad.factoryColor}</td>
			</tr>
			</c:forEach>
			
			
			<tr>
					<td colspan="5">
						<div class="l_btn_centent">
								<!-- saveWin_form   from是表单Ｉd-->
								 <a
									class="btn btn-primary" href="javascript:void(0)" id="closeWin"
									onclick="closeWin()"><span>关闭</span> </a>
							</div>
					</td>
				</tr>
		</tbody>
		
	</table>
	</div>
</body>
</html>