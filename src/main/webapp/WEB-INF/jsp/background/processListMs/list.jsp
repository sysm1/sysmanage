<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>回货进度查询门市</title>
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
}

a {
 color: #c75f3e;
}

#mytable {
 width: 100%;
 padding: 0;
 margin: 0;
}

caption {
 padding: 0 0 5px 0;
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
 text-align: center;
 padding: 6px 5px 6px;
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
 font-size:12px;
 padding: 2px 3px 2px ;
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
</style>

<script type="text/javascript">
	var dialog;
	var grid;
	$(function() {
		$("#search").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			$("#delay").attr('value','');
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/processListMs/list.html');
			f.submit();
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
		$("#delaybtn").click("click", function() {
			$('#pageNow').attr('value',1);
			$("#delay").attr('value',1);
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/process/list.html');
			f.submit();
		});
	});
	function loadGird(){
		grid.loadData();
	}
	
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/processListMs/list.html');
		f.submit();
	}
</script>
</head>
<body>
	<div class="divBody" style="width:100%;">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<input type="hidden" id="delay" name="delay" value="">
				<table>
					<tr>
						<td>下单日期：</td>
						<td>
							<input type="text" name="returnDate" style="width:90px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">至
							<input type="text" name="returnDate" style="width:92px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</td>
						<td>工厂：</td>
						<td>
							<select  id="factoryId" name="factoryId">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factoryInfos }" var = "factoryInfo">
									<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
								</c:forEach>
							</select>
						</td><td>
							布种：
						</td><td>
							<select id="clothId" name="clothId">
								<option value="">请选择布种</option>
								<c:forEach items="${ cloths }" var = "cloth">
									<option value="${cloth.id }" <c:if test="${bean.clothId eq cloth.id }" >selected='selected'</c:if> >${cloth.clothName}</option>
								</c:forEach>
							</select>
						</td><td></td>
					</tr><tr>
						<td>&nbsp;&nbsp;编号：</td>
						<td>
							<input type="text" id="code" name="code" value="${bean.code }">
						</td><td>颜色:</td>
						<td>
							<select>
								<option>请选择</option>
							</select>
						</td><td>工艺:</td>
						<td>
							<select id="technologyId" name="technologyId">
								<option>请选择</option>
								<c:forEach items="${ technologys }" var = "technology">
									<option value="${technology.id }" <c:if test="${bean.technologyId eq cloth.id }" >selected='selected'</c:if> >${technology.name}</option>
								</c:forEach>
							</select>
						</td>
						<td></td>
					</tr><tr>
						<td>回货日期：</td>
						<td>
							<input type="text" name="returnDate" style="width:90px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">至
							<input type="text" name="returnDate" style="width:92px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</td><td>状态:</td>
						<td>
							<select id="returnStatus" name="returnStatus">
								<option value="">请选择</option>
								<option value="0">未回</option>
								<option value="1">未回完</option>
								<option value="2">已回</option>
							</select>
						</td><td>备注:</td>
						<td>
							<input type="text" id="mark" name="mark">
						</td>		
						<td colspan="6" align="center">
							&nbsp;&nbsp;<a class="btn btn-primary" href="javascript:void(0)" id="search"> <span>查询</span></a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="paging" class="pagclass" >
			<table border="1" id="mytable">
				<tr>
					<th>序号</th>
					<th width="60px;">下单日期</th>
					<th style="min-width:60px;">&nbsp;布种&nbsp;</th>
					<th>我司编号</th>
					<th width="80px;">回货日期</th>
					<th>下单数量</th>
					<th>实到数量</th>
					<th>纸管</th>
					<th>空差</th>
					<th>胶袋</th>
					<th>我司颜色</th>
					<th>实到颜色</th>
					<th width="120px;">备注</th>
					<th>&nbsp;状态&nbsp;</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
				<form id="${item.id }_form" action="${ctx}/background/sample/add.html" method="post" enctype="multipart/form-data">
				<tr id="${item.id }">
					<td id="2${item.id }">${item.id }</td>
					<td  title="<fmt:formatDate value='${item.orderDate }' pattern='yyyy-MM-dd'/>" onclick="clearColor(${item.id});">
						<fmt:formatDate value='${item.orderDate }' pattern='MM-dd'/>
					</td>
					<td id="5${item.id }">${item.clothName }</td>
					<td id="7${item.id }">${item.myCompanyCode }</td>
					<td id="8${item.id }" width="80px;">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/><br>
						</c:forEach>
					</td>
					<td id="9${item.id }">${item.num }${item.unitName }</td>
					<td id="10${item.id }" onclick="onclickTr(${item.id })">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							${item1.returnNum }<br>
						</c:forEach>
					</td><td id="11${item.id }">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							${item1.zhiguan }<br>
						</c:forEach>
					</td><td id="12${item.id }">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							${item1.kongcha }<br>
						</c:forEach>
						<span id="${item.id}kongcha" ></span>
					</td><td id="13${item.id }">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							${item1.jiaodai }<br>
						</c:forEach>
					</td>
					<td id="14${item.id }" >${item.myCompanyColor }</td>
					<td >
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							${item1.returnColor }<br>
						</c:forEach>
					</td>
					<td id="15${item.id }">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<span title="${item1.mark }">
								${fn:substring(item1.mark,0,8)}  
								<c:if test="${fn:length(item1.mark)>8}">...</c:if>
							</span><br>
						</c:forEach>
					</td>
					<td id="1${item.id }">${item.returnStatusName }</td>
				</tr>
				</form>
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="15" style="text-align: center;font-size: 14px;">
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
    <li class="pageinfo">共${pageView.rowCount }条</li>
  </ul>
</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<iframe id="iframe" name="iframe" style="display: none"></iframe>
</body>
</html>