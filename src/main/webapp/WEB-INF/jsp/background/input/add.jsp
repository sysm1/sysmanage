<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>下单预录入</title>
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript" src="${ctx}/js/input/add.js"></script>
<style type="text/css">
   .tdw80 {width: 80px;}
   .tdw100 {width: 100px;}
   .tdw150 {width: 150px;}
</style>
</head>
<body>
<div class="divdialog">
	<div style="width: 1150px;">
		<table width="450px">
			<tr>
				<td class="tdw80">
					<a class="btn btn-primary" href="javascript:void(0)" id="copyone"><span>复制新增</span> </a>
				</td>
				<td  class="tdw80">
					<a class="btn btn-primary" href="javascript:void(0)" id="addTable"><span>新增一行</span> </a>
				</td>
				<td class="tdw80">
					<a class="btn btn-primary" href="javascript:void(0)" style=width:60px;"
						id="saveWin_form" ><span>保存</span> </a>
				</td>
				<td style="text-align: right;">
					<a class="btn btn-primary" href="javascript:void(0)" id="deleteTable" style="background-color: red;"><span>删除</span></a>
				</td>
			</tr>
		</table>
	</div>
	
	<form name="form" id="form" action="${ctx}/background/input/add.html" method="post">
		<table>
			<tr>
				<td valign="top">
	
	
				
					<table id="table1" border="1" name="table1" class="dataintable">
						<tbody>
							<tr>
								<th style="height: 30px;width: 35px;text-align: center;">
									<input type="checkbox" id="checkAll" name="checkAll">
								</th>
								
								<th align="right">布种</th>
								<th align="right">工艺</th>
								<th align="right" style="width: 150px;">我司编号</th>
								<th align="right">我司颜色</th>
								<th >数量</th>
								
								<th style="width: 35px;text-align: center">单位</th>
								<th>备注</th>
								<th align="right">业务员</th>
								<th>未回数量</th>
							</tr>
	
							<tr name="initfirst">
								<td style="text-align: center;">
									<input type="checkbox"  name="checkId" value="1">
								</td>
								<td class="l_left tdw100" >
									<select  name="clothId"  style="width:110px;">
										<option value="">请选择</option>
										<c:forEach items="${ cloths }" var = "cloth">
											<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
										</c:forEach>
									</select>
								</td>
								<td class="l_left tdw100" >
									<select  name="technologyId" style="width:110px;">
										<c:forEach items="${ technologys }" var = "technology">
											<option <c:if test="${technology.id eq bean.technologyId }">selected="selected"</c:if> value="${technology.id }">${technology.name}</option>
										</c:forEach>
									</select>
								</td>
								<td name="companyCode">
									<input  name="myCompanyCode" style="width:99%;"  />
								</td>
								<td class="l_left tdw150" >
									<input type="text" name="myCompanyColor" style="width:150px;" value="" onchange="queryNoReturnNum(this)">
								</td>
								<td >
									<input type="text"  name="num" value="" style="width: 80px">
								</td>
								
								<td name="danwei" style="font-weight: bold;text-align: center;">条</td>
								<td><input type="text" name="mark" value=""></td>
								<td>
									<select  name="salesmanId" style="width:140px;">
										<option value="">请选择</option>
										<c:forEach items="${salesmanInfos }" var="saleman">
											<option value="${saleman.id }">${saleman.name }</option>
										</c:forEach>
									</select>
								</td>
								<td name="sum">0</td>
							</tr>
						</tbody>
					</table>
			
				</td>
				<!--td>
					图片预览<img alt="" src="http://d.hiphotos.baidu.com/baike/w%3D268/sign=9855e88c3912b31bc76cca2fbe1a3674/a8ec8a13632762d01cdbd074a0ec08fa503dc610.jpg">
				</td-->
			</tr>
		</table>
	</form>
	</div>
	
</body>

</html>