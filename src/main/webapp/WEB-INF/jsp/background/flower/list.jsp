<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="${ctx}/js/myjs/flower.js"></script>

</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="${pageView.pageNow}" />
				<table>
					<tr>
						<td>我司编号: </td>
						<td><input type="text" id="myCompanyCode"  name="myCompanyCode" value="${info.myCompanyCode }" style="width:100px;"></td>
						<td>布种: </td>
						<td>
							<select id="clothId" name="clothId" style="width:110px;">
								<option value="">请选择布种</option>
								<c:forEach items="${ cloths }" var = "cloth">
									<option value="${cloth.id }">${cloth.clothName}</option>
								</c:forEach>
							</select>
						</td>
						<td>工厂: </td>
						<td>
							<select id="factoryId" name="factoryId" style="width:110px;">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factorys }" var = "factory">
									<option value="${factory.id }">${factory.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>工厂编号: </td>
						<td><input type="text" id="factoryCode"  name="factoryCode" value="${info.factoryCode }" style="width:100px;"></td>
						<td>分色文件号: </td>
						<td>
							<input type="text" id="fileColor"  name="fileColor" value="${info.fileColor}" style="width:100px;">
						</td>
						<td>工艺: </td>
						<td>
							<select id="technologyId" name="technologyId" style="width:110px;">
								<option value="">请选择工艺</option>
								<c:forEach items="${ technologys }" var = "technology">
									<option value="${technology.id }">${technology.name}</option>
								</c:forEach>
							</select>
							<a class="btn btn-primary" href="javascript:void(0)" id="search"> 查询</a>
						</td>
					</tr>
				</table>
				
			</form>
		</div>
		
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>新增</span>
			</a> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> 修改
			</a> 
			
			<a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <i
				class="icon-trash icon-white"></i> Delete
			</a>
			<!--a class="btn btn-danger" href="javascript:void(0)" id="updateView"> <i
				class="icon-trash icon-white"></i>停用/正常
			</a-->
			
			  
			<!--a class="btn btn-large btn-success" href="javascript:void(0)" id="exportExcel">
				导出excel
			</a-->
			
		</div>
		
		<div id="paging" class="pagclass">
		
		<table id="table_head" class="pp-list table table-striped table-bordered" style="margin-bottom: -3px; width: 1008px;">
		
		</table>
		
		<div style="overflow-y: auto; overflow-x: auto; height: 348px; border: 1px solid #DDDDDD;" class="t_table">
			<table id="mytable" class="pp-list table table-striped table-bordered" style="margin-bottom: -3px;">
				<thead>
					<tr style="line-height:27px;">
						<td style="text-align:center;"><input type="checkbox" ></td>
						<td style="text-align:center;">序号</td>
						<td style="text-align:center;display: ;">我司编号</td>
						<td style="text-align:center;">布种</td>
						<td style="text-align:center;">工艺</td>
						<td style="text-align:center;">工厂</td>
						<td style="text-align:center;">工厂编号</td>
						<td style="text-align:center;">我司颜色</td>
						<td style="text-align:center;">工厂颜色</td>
						<td style="text-align:center;">分色文件号</td>
						<!--td style="text-align:center;">状态</td-->
					</tr>
				</thead>
			
				<tbody>
				<c:forEach items="${ pageView.records }" var="flower">
				<tr style="line-height:27px;" id="${flower.id}">
					<td style="text-align:center;"><input type="checkbox" name="checkId" value="${flower.id}" /></td>
					<td style="text-align:center;">${flower.id}</td>
					<td style="text-align:center;">${flower.myCompanyCode}</td>
					<td style="text-align:center;">${flower.clothName }</td>
					<td style="text-align:center;">${flower.technologyName }</td>
					<td style="text-align:center;">${flower.factoryName }</td>
					<td style="text-align:center;">${flower.factoryCode}</td>
					<td style="text-align:center;"><a href="javascript:mycolor_detail('${flower.id}');">点击见详情</a></td>
					<td style="text-align:center;"><a href="javascript:mycolor_detail('${flower.id}');">点击见详情</a></td>
					<td style="text-align:center;">${flower.fileColor }</td>
					<!--td style="text-align:center;">${flower.statusName }</td-->
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