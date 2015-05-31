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
	var recordCount = "${recordCount}";
	
	$(function() {
		
		$("#cancelView").click("click", function() {//绑定查询按扭
			
			// String model = "notify";
			// String opType = "cancel";
			var cbox = getSelectedCheckbox();
			if (cbox=="") {
				parent.$.ligerDialog.alert("请选择撤销打印项！！");
				return;
			}
			
			var count = parseInt(recordCount) + cbox.length;
			// 检查册除次数
			if(count > 5) {
				// 提示输入密码
				dialog = $.ligerDialog.open({
					 target:$("#pwd_div"),
					 buttons: [  { text: '提交', onclick: function (i, d) { pwd_valid_fun(); }}]                                  
				});
			} else {
				ajaxCancel();
			}
		});
		
		
		$('#checkAllId').click(function(){
	         //判断apple是否被选中
	         var bischecked=$('#checkAllId').is(':checked');
	         //alert(bischecked);
	         var fruit=$('input[name="checkId"]');
	         bischecked?fruit.attr('checked',true):fruit.attr('checked',false);
	    });
		
		$("#seach").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/notify/list.html');
			f.submit();
		});
		
		$(".detail").click("click", function(){
			var rid = $(this).attr("rid");
			if(rid == '' || rid == undefined) return;
			dialog = parent.$.ligerDialog.open({
				width : 600,
				height : 410,
				url : rootPath + '/background/notify/detail.html?id=' + rid,
				title : "查看详情",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
	});
	
	
	function pwd_valid_fun(){
		var v = $("#pwd").val();
		// alert(v);
		$.ajax({
			 type: "post", //使用get方法访问后台
			 dataType: "json", //json格式的数据
			 async: false, //同步   不写的情况下 默认为true
			 url: rootPath + '/background/password/validpwd.html', //要访问的后台地址
			 data: {"pwd":v}, //要发送的数据
			 success: function(data){
				 if(data.code == 0) {
						dialog.hidden();
						ajaxCancel();
					} else {
						parent.$.ligerDialog.alert("密码不对！！");
					}
			 }
		});
	}
	
	function ajaxCancel() {
		var cbox = getSelectedCheckbox();
		if (cbox=="") {
			parent.$.ligerDialog.alert("请选择撤销打印项！！");
			return;
		}
		parent.$.ligerDialog.confirm('确定择撤销打印吗？', function(confirm) {
			if (confirm) {
				$.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/notify/cancel.html', //要访问的后台地址
				    data: {ids:cbox.join(",")}, //要发送的数据
				    success: function(data){
				    	if (data.flag == "true") {
				    		parent.$.ligerDialog.success('撤销成功!', '提示', function() {
				    			// loadGird();//重新加载表格数据
				    			// window.location.reload();
				    			window.location.href = "${pageContext.request.contextPath}/background/printsummary/list.html"
							});
						}else{
							parent.$.ligerDialog.warn("撤销失败！！");
						}
					}
				});
			}
		});
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
	

	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		f.attr('action','${pageContext.request.contextPath}/background/notify/list.html');
		f.submit();
	}
	
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
			<table>
				<tr>
					<td style="text-align: right;">下单日期：</td>
					<td>
						<input type="text" name="beginTime" style="width:90px" value="<fmt:formatDate value="${model.beginTime }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">至
						<input type="text" name="endTime" style="width:92px" value="<fmt:formatDate value="${model.endTime }" pattern="yyyy-MM-dd"/>"
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
					</td><td style="text-align: right;">工&nbsp;厂：</td>
					<td>
						<select id="factoryId" name="factoryId" style="width:150px;">
							<option value="">请选择工厂</option>
							<c:forEach items="${ factorys }" var = "factory">
								<option value="${factory.id }">${factory.name}</option>
							</c:forEach>
						</select>
					</td><td style="text-align: right;">工&nbsp;艺：</td>
					<td>
						<select id="factoryId" name="factoryId" style="width:150px;">
							<option value="">请选择工艺</option>
							<c:forEach items="${ technologys }" var = "technology">
								<option value="${technology.id }">${technology.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr><tr>
					<td style="text-align: right;">布&nbsp;种：</td>
					<td>
						<select id="clothId" name="clothId" style="width:150px;">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</td>
					<td style="text-align: right;">工厂编号：</td>
					<td><input type="text" name="factoryCode" value="${model.factoryCode}" style="width:140px;" /></td>
					<td style="text-align: right;">工厂颜色：</td>
					<td><input type="text" name="factoryColor" value="${model.factoryColor}" style="width:140px;" /></td>
					<td>
						&nbsp;<a class="btn btn-primary" href="javascript:void(0)" id="seach"> 查&nbsp;询</a>
					</td>
				</tr>
			</table>
				
			</form>
		</div>
		<div class="topBtn">

			<a class="btn btn-danger" href="javascript:void(0)" id="cancelView"> <i
				class="icon-trash icon-white"></i> 撤销打印
			</a>
			
		</div>
		<div id="paging" class="pagclass">
			
			<table id="rowspan" cellspacing="0" class="tablesorter">
				<thead>
					<tr>
						<th><input type="checkbox" id="checkAllId" onclick="checkAllId();"/></th>
						<th style="font-size: 14px;">序号</th>
						<th style="font-size: 14px;">单号</th>
						<th style="font-size: 14px;">工厂</th>
						<th style="font-size: 14px;">下单日期</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ pageView.records }" var="summary">
						<tr>
							<td style="font-size: 12px;"><input type="checkbox" name="checkId" value="${summary.notifyId}" /></td>
							<td style="font-size: 12px;"><span class="detail" rid="${summary.notifyId}">${summary.notifyId}</span></td>
							<td style="font-size: 12px;">${summary.no}</td>
							<td style="font-size: 12px;">${summary.factoryName}</td>
							<td style="font-size: 12px;">${summary.notifyTimeStr }</td>
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
	
	<div id="pwd_div" style="display:none">
		<table>
			<tr><td>请输入密码</td></tr>
			<tr><td><input type="text" name="pwd" id="pwd"></input></td></tr>
		</table>
	</div>
	
</body>
</html>