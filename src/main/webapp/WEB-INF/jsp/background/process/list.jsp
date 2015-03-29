<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
.ordersearchDivCss { 
	position: absolute; 
	z-index: 100; 
	display: block; 
	padding-left: 150px;
}

/* CSS Document */

body {
 font: normal 13px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
}

a {
 color: #c75f3e;
}

#mytable {
 width: 150%;
 padding: 0;
 margin: 0;
}

caption {
 padding: 0 0 5px 0;
 width: 660px;  
 font: italic 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 text-align: right;
}

th {
 font: bold 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 letter-spacing: 2px;
 text-transform: uppercase;
 text-align: left;
 padding: 6px 6px 6px 12px;
}

th.nobg {
 border-top: 0;
 border-left: 0;
 border-right: 1px solid #C1DAD7;
 background: none;
}

#mytable td {
 border-left: 1px solid #C1DAD7;
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 //background: #fff;
 font-size:12px;
 padding: 2px 6px 2px 12px;
 color: #4f6b72;
}

.lanyuan_bb{
border-bottom: 1px solid #C1DAD7;
}

td.alt {
 background: #F5FAFA;
 color: #797268;
}

th.spec {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #fff ;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
}

th.specalt {
 border-left: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 background: #f5fafa ;
 font: bold 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #797268;
}
/*---------for IE 5.x bug*/
html>body td{ font-size:13px;}
</style>


<script type="text/javascript">
	var dialog;
	var grid;
	$(function() {
		$("#seach").click("click", function() {//绑定查询按扭
			var searchParams = $("#fenye").serialize();
			grid.setOptions({
				data : searchParams
			});
		});
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/role/addUI.html',
				title : "增加角色",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		$("#permissions").click("click", function() {
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			parent.addTabEvent("permissions", "分配权限", rootPath + '/background/resources/aution.html?roleId='+cbox);
		});
		$("#editView").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/role/editUI.html?roleId='+cbox,
				title : "修改角色",
				isHidden : false
			});
		});
		$("#deleteView").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
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
					    url: rootPath + '/background/role/deleteById.html', //要访问的后台地址
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
	});
	function loadGird(){
		grid.loadData();
	}
</script>
</head>
<body>
	<div class="divBody" style="width: 2000px">
		<div class="search">
			<form name="fenye" id="fenye">
				<table>
					<tr>
						<td>工厂：</td>
						<td>
							<select  id="factoryId" name="factoryId">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factoryInfos }" var = "factoryInfo">
									<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
								</c:forEach>
							  </select>
						</td><td>&nbsp;&nbsp;编号：</td>
						<td>
							<input type="text" id="code" name="code" value="">
						</td><td>
							&nbsp;&nbsp;<a class="btn btn-primary" href="javascript:void(0)" id="seach"> <span>查询</span></a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>暂存数据</span>
			</a><a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> 已回
			</a>
		</div>
		<div id="paging" class="pagclass">
			<table>
				<tr>
					<th>状态</th>
					<th>序号</th>
					<th>下单日期</th>
					<th>工厂</th>
					<th>工厂编号</th>
					<th>布种</th>
					<th>工艺</th>
					<th>我司编号</th>
					<th >回货日期</th>
					<th>下单数量</th>
					<th>实到数量</th>
					<th>我司颜色</th>
					<th>实到颜色</th>
					<th>备注</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
				<tr>
					<td>${item.returnStatusName }</td>
					<td>${item.id }</td>
					<td title="<fmt:formatDate value='${item.orderDate }' pattern='yyyy-MM-dd'/>">
						<fmt:formatDate value='${item.orderDate }' pattern='MM-dd'/>
					</td>
					<td>${item.factoryName }</td>
					<td>${item.factoryCode }</td>
					<td>${item.clothName }</td>
					<td>${item.technologyName }</td>
					<td>${item.myCompanyCode }</td>
					<td style="width:100px;">
						<c:if test="${item.returnDate =='' || item.returnDate==null }">
							<input type="text" id="returnDate" name="returnDate" style="width:70px" value="${returnDate }"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:if><c:if test="${item.returnDate !='' && item.returnDate !=null}">
							<input type="text" id="returnDate" name="returnDate" style="width:70px" 
								value="<fmt:formatDate value='${item.returnDate }' pattern='yyyy-MM-dd'/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:if>
						<span onclick="showReturnDate();">+</span><br>
						<input type="text" id="returnDate" name="returnDate" style="width:70px" 
								value=""
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
					</td>
					<td>${item.num }</td>
					<td>${item.returnNum }
						<input type="text" id="returnNum" name="returnNum" value="" style="width: 60px">
					</td>
					<td>${item.myCompanyColor }</td>
					<td>
						<input type="text" id="returnColor" name="returnColor" value="" style="width: 60px">
					</td>
					<td>
						<input type="text" id="returnColor" name="returnColor" value="${item.mark }" >
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>