<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/list-main.css" rel="stylesheet">
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">
	var dialog;
	var grid;
	var delarr = [];
	$(function() {
		$("#seach").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/unsubInput/list.html');
			f.submit();
		});
		$("#add").click("click", function() {//绑定新增按扭
			dialog = parent.$.ligerDialog.open({
				width : 650,
				height : 385,
				url : rootPath + '/background/unsubInput/addUI.html',
				title : "退货次品预登记",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		$("#editView").click("click", function() {//绑定编辑按扭
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 650,
				height : 385,
				url : rootPath + '/background/unsubInput/editUI.html?id='+cbox,
				title : "修改退货次品预登记",
				isHidden : false
			});
		});
		
		/***过滤查询**/
		$("#clothName").ligerComboBox({
	        url: '/background/pinyin/cloth.html',
	        valueField: 'id',
	        textField: 'clothName', 
	        selectBoxWidth: 215,
	        selectBoxHeight: 215,
	        autocomplete: true,
	        width: 215,
	        height:20,
	        onSelected:function(e) {
	            $("#clothId").val(e);
	            //alert($("#clothId").val());
	            var clothId=$("#clothId").val();
	            $.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/inputsummary/queryMyCompanyCodeByClothId.html', //要访问的后台地址
				    data: {clothId:clothId}, //要发送的数据
				    success: function(data){
				    	var myCompanyCode = $("#myCompanyCode");
				    	myCompanyCode.empty();
				    	if(data!=null&&data!=''){
					    	myCompanyCode.append($("<option>").text("请选择").val(""));
					    	for(var i=0;i<data.length;i++) {
					    	    var option = $("<option>").text(data[i]).val(data[i]);
					    	    myCompanyCode.append(option);
					    	}
				    	}else{
				    		//alert('没有相关联的我司编号');
				    	}
					}
				});
	        }
	    });
		
		$("#deleteView").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			if (cbox=="") {
				parent.$.ligerDialog.alert("请选择删除项！！");
				return;
			}
			parent.$.ligerDialog.confirm('删除后不能恢复，确定删除吗？', function(confirm) {
				if (confirm) {
					$.ajax({
					    type: "post", //使用get方法访问后台
					    dataType: "json", //json格式的数据
					    async: false, //同步   不写的情况下 默认为true
					    url: rootPath + '/background/unsubInput/deleteById.html', //要访问的后台地址
					    data: {ids:cbox.join(",")}, //要发送的数据
					    success: function(data){
					    	if (data.flag == "true") {
					    		parent.$.ligerDialog.success('删除成功!', '提示', function() {
					    			loadGird();//重新加载表格数据
								});
							}else{
								parent.$.ligerDialog.warn("删除失败！！");
							}
						}
					});
				}
			});
		});
		
		$("#view").click("click", function() {//查看按钮
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 650,
				height : 400,
				url : rootPath + '/background/unsubInput/editUI.html?id='+cbox+"&type=view",
				title : "查看退货次品登记",
				isHidden : false
			});
		});
	});
	function loadGird(){
		 window.location.reload();
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
	
	function selectMyCompanyCode(obj){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/inputsummary/queryMyCompanyColorByMyCompanyCode.html', //要访问的后台地址
		    data: {myCompanyCode:obj.value}, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	var myCompanyCode = $("#myCompanyColor");
			    myCompanyCode.empty();
		    	if(data!=null&&data!=''){
			    	myCompanyCode.append($("<option>").text("请选择").val(""));
			    	for(var i=0;i<data.length;i++) {
			    	    var option = $("<option>").text(data[i]).val(data[i]);
			    	    myCompanyCode.append(option);
			    	}
		    	}else{
		    		//alert('没有相关联的我司编号');
		    	}
			}
		});
	}
	/**单选***/
	function checkId(obj){
		var flag=obj.checked;
		 $(":checkbox").attr("checked", false);
		 if(flag){
			 obj.checked=flag;
		 }else{
			 obj.checked=flag;
		 }
	}
	/**
	 * 获取选中的值
	 */
	function getSelectedCheckbox() {
		var arr = [];
		$('input[name="checkId"]:checked').each(function() {
			arr.push($(this).val());
			delarr.push($(this).val());
		});
		return arr;
	};
</script>
</head>
<body>
	<div class="divBody" >
		<div class="search" >
			<form name="fenye" id="fenye" method="post" action="${ctx}/background/register/list.html">
			<table class="datasearch">
				<tr>
					<td align="right">退货日期：</td>
					<td>
						<input type="text" id="unsubdates" name="unsubdates" value="<fmt:formatDate value='${bean.unsubdates}' pattern='yyyy-MM-dd'/>" style="width:91px;" 
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">至
						<input type="text" id="unsubdatee" name="unsubdatee" value="<fmt:formatDate value='${bean.unsubdatee}' pattern='yyyy-MM-dd'/>" style="width:91px;"
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
					</td>
					<td align="right">布种：</td>
					<td>
						<!--select id="clothId" name="clothId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
							<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select-->
						<input type="hidden" id="clothId" name="clothId" value="${ bean.clothId }">
					  	<input type="text" id="clothName" name="clothName" style="width: 200px;" value="${bean.clothName }" 
					  		onchange="changeTextValue('clothId',this);"/>
					</td>
					<td align="right">我司编号：</td>
					<td>
						<select id="myCompanyCode" name="myCompanyCode" onchange="selectMyCompanyCode(this)">
							<option value="">请选择</option>
							<c:forEach var="code" items="${myCompanyCodes }">
								<option value="${code }">${code }</option>
							</c:forEach>
						</select>
					</td>
					
				</tr><tr>
					<td align="right">我司颜色：</td>
					<td>
						<select id="myCompanyColor" name="myCompanyColor">
							<option value="">请选择</option>
						</select>
					</td>
					<td align="right">客户质量反应问题：</td>
					<td><input type="text" id="qualityProblem" name="qualityProblem" value="${unsub.qualityProblem }"></td>
					<td>工艺：</td>
					<td>
						<select id="technologyId" name="technologyId">
							<option value="">请选择</option>
							<c:forEach items="${technologyInfos }" var="tech">
							<option value="${tech.id }" <c:if test="${tech.id ==param.technologyId }">selected="selected"</c:if> >${tech.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
				 
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> 新增</a>&nbsp;&nbsp;			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> 修改</a> &nbsp;&nbsp;			
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="view">查看</a>&nbsp;&nbsp;
			<a class="btn btn-primary" href="javascript:void(0)" id="seach"> 查询</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> 删除</a>
		</div>
		<div id="paging" class="pagclass" >
			<table id="mytable" cellspacing="0" border="1"  class="dataintable">
				<tr>
					<th class="specalt" style="width:35px;">选择</th>
					<!--th>序号</th-->
					<th style="width:80px;">退货日期</th>
					<th style="width:70px;">布种</th>
					<th style="width:70px;">工艺</th>
					<th style="widht:100px;">我司编号</th>
					<th>我司颜色</th>
					<th>数量(条)</th>
					<th>客户反映质量问题</th>
					<!--th>工厂</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					<th style="width:80px;">到货日期</th>
					<th>我司验货报告</th>
					<th>工厂交涉情况</th-->
				</tr>
				
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr style="background-color:#1FFF" id="${status.index }" >
						<td style="width:50px;">
					 		<input type="checkbox"  id="${item.id }" name="checkId" value="${item.id }" onclick="checkId(this);">
					 	</td>
						<!--td >${item.id }</td-->
						<td ><fmt:formatDate value="${item.unsubdate }" pattern="yyyy-MM-dd"/></td>
						<td >${item.clothName }</td>
						<td >${item.technologyName }</td>
						<td >${item.myCompanyCode }</td>
						<td >${item.myCompanyColor }</td>
						<td >${item.num }</td>
						<td  title="${item.qualityProblem }">
							${fn:substring(item.qualityProblem,0,25) }
							<c:if test="${fn:length(item.qualityProblem)>25 }">...</c:if>
						</td>
						<!--td >${item.factoryName }</td>
						<td >${item.factoryCode }</td>
						<td >${item.factoryColor }</td>
						<td >
							<fmt:formatDate value="${item.returnDate }" pattern="yyyy-MM-dd"/>
						</td>
						<td title="${item.myCompanyReport }">
							${fn:substring(item.myCompanyReport,0,10) }
							<c:if test="${fn:length(item.myCompanyReport)>10 }">...</c:if>
						</td>
						<td title="${item.negotiate }">
							${fn:substring(item.negotiate,0,10) }
							<c:if test="${fn:length(item.negotiate)>10 }">...</c:if>
						</td-->
					<tr>
				</c:forEach>
				
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="10" style="text-align: center;font-size: 14px;">
						<div id="pagelist">
  <ul style="font-size: 14px;">
  	<c:if test="${pageView.pageNow==1}">
  		<li><a href="#">首页</a></li>
  		<li><a href="#">上一页</a></li>
  	</c:if><c:if test="${pageView.pageNow>1}">
  		<li><a href="javascript:page(1)">首页</a></li>
    	<li><a href="javascript:page(${pageView.pageNow-1>0?pageView.pageNow-1:1 })">上一页</a></li>
  	</c:if>
    
    <c:if test="${pageView.pageNow>3 }"><li style="width:15px;border: 0">...</li></c:if>
    <c:if test="${pageView.pageNow>2 }">
		<li><a href="javascript:page(${pageView.pageNow-2 })">${pageView.pageNow-2 }</a></li>
	</c:if><c:if test="${pageView.pageNow>1 }">					
		<li><a href="javascript:page(${pageView.pageNow-1 })">${pageView.pageNow-1 }</a></li>
	</c:if>	
		<li class="current">${pageView.pageNow }</li>
	<c:if test="${pageView.pageCount-1>=pageView.pageNow }">
		<li><a href="javascript:page(${pageView.pageNow+1 })">${pageView.pageNow+1 }</a></li>
	</c:if><c:if test="${pageView.pageCount-2>=pageView.pageNow }">
		<li><a href="javascript:page(${pageView.pageNow+2 })">${pageView.pageNow+2 }</a></li>
	</c:if><c:if test="${pageView.pageCount-3>=pageView.pageNow }">
		<li style="width:15px;border: 0">...</li>
	</c:if>
    
    <c:if test="${pageView.pageNow>=pageView.pageCount }">
		<li><a href="#">下一页</a></li>
		<li><a href="#">尾页</a></li>
	</c:if><c:if test="${pageView.pageNow<pageView.pageCount }">
		<li><a href="javascript:page(${pageView.pageNow+1 })">下一页</a></li>
		<li><a href="javascript:page(${pageView.pageCount })">尾页</a></li>
	</c:if>
	
    <li class="pageinfo">第${pageView.pageNow }页</li>
    <li class="pageinfo">共${pageView.pageCount }页</li>
  </ul>
</div>
					</td>
				</tr>
				
			</table>
		</div>
	</div>
</body>
</html>