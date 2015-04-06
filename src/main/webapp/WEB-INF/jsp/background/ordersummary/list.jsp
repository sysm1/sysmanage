<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>下单录入汇总查询</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
.ordersearchDivCss { 
	position: absolute; 
	z-index: 100; 
	display: block; 
	background-color: #6ec1df; 
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
 width: 100%;
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
 background: #fff;
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

<style type="text/css">
* { margin:0; padding:0;}
a { color:#333; text-decoration:none;}
ul { list-style:none;}
#pagelist {width:600px; margin:5px auto; padding:6px 0px; height:20px;}
#pagelist ul li { float:left; border:2px solid #5d9cdf; height:23px; line-height:20px; margin:1px 3px;}
#pagelist ul li a, .pageinfo { display:block; padding:0px 6px; background:#e6f2fe;}
.pageinfo  { color:#555;}
.current { background:#CCCC00; display:block; padding:0px 6px; font-weight:bold;}
</style>
<script type="text/javascript">
	var dialog;
	var grid;
	$(function() {
		
		$("#search").click("click", function() {//绑定查询按扭
			if($('#oprator').val()!=''){
				if($('#num').val()==''){
					alert("请输入下单数量！");
					$('#num').focus();
					return false;
				}
			}
			if($('#num').val()!=''){
				if($('#oprator').val()==''){
					alert("请选择比较符号！");
					$('#oprator').focus();
					return false;
				}
			}
			$('#pageNow').attr('value',1);
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/ordersummary/list.html');
			f.submit();
		});
		
		$("#fororder").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/cloth/exportExcel.html');
			f.submit();
		});
		
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 300,
				height : 310,
				url : rootPath + '/background/cloth/addUI.html',
				title : "增加布种信息",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		$("#editView").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 700,
				height : 510,
				url : rootPath + '/background/ordersummary/editUI.html?id='+cbox,
				title : "下单录入汇总修改页面",
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
					    url: rootPath + '/background/cloth/deleteById.html', //要访问的后台地址
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
	function loadGird(){
		grid.loadData();
	}
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/ordersummary/list.html');
		f.submit();
	}
</script>
</head>
<body  >
	<div class="divBody" style="width: 1500px">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<table border="1">
					<tr>
						<td style="width:70px;text-align: right;">下单日期：</td>
						<td>
							<input type="text" id="startDate" name="startDate" value="<fmt:formatDate value='${bean.startDate}' pattern='yyyy-MM-dd'/>" style="width:91px;" 
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">至
							<input type="text" id="endDate" name="endDate" value="<fmt:formatDate value='${bean.endDate}' pattern='yyyy-MM-dd'/>" style="width:91px;"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
						</td>
						<td style="width:70px;text-align: right;">单号：</td>
						<td>
							<input type="text" id="orderCode" name="orderCode" value="${bean.orderCode }">
						</td>
						<td style="width:70px;text-align: right;">工厂：</td>
						<td>
							<select  id="factoryId" name="factoryId">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factoryInfos }" var = "factoryInfo">
										<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
									</c:forEach>
							  </select>
						</td>
					</tr><tr>
						<td style="width:70px;text-align: right;">布种：</td>
						<td>
							<select id="clothId" name="clothId">
								<option value="">请选择布种</option>
								<c:forEach items="${ cloths }" var = "cloth">
									<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
								</c:forEach>
							</select>
						</td><td style="width:70px;text-align: right;">
							工厂编号：
						</td><td>
							<input type="text" id="factoryCode" name="factoryCode" value="${bean.factoryCode}">
						</td><td style="width:70px;text-align: right;">我司编号：</td>
						<td>
							<select>
								<option value="">请选择</option>
							</select>
						</td>
					</tr><tr>
						<td style="width:70px;text-align: right;">我司颜色：</td>
						<td>
							<input type="text" id="myCompanyColor" name="myCompanyColor" value="${bean.myCompanyColor}">
						</td>
						<td style="width:70px;text-align: right;">业务员：</td>
						<td>
							<select id="salesmans" name="salesmans">
								<option value="">请选择</option>
								<c:forEach var="sale" items="${salesmanInfos }">
								<option value="${sale.id }" <c:if test="${sale.id==bean.salesmans }">selected="selected"</c:if>>${sale.name }</option>
								</c:forEach>
							</select>
						</td><td style="width:70px;text-align: right;">备注：</td>
						<td>
							<input type="text" id="mark" name="mark" value="${bean.mark }">
						</td>
					</tr><tr>
						<td style="width:70px;text-align: right;">工艺：</td>
						<td>
						    <select id="technologyId" name="technologyId">
								<option value="">请选择工艺</option>
								<c:forEach items="${ technologyInfos }" var = "technologyInfo">
								<option <c:if test="${technologyInfo.id eq bean.technologyId }">selected="selected"</c:if> value="${technologyInfo.id }">${technologyInfo.name}</option>
								</c:forEach>
							</select>
						</td><td style="width:70px;text-align: right;">下单次数：</td>
						<td colspan="3">
							<select id="oprator" name="oprator" style="width: 100px">
								<option value="">请选择</option>
								<option value="1" <c:if test="${bean.oprator ==1 }">selected="selected"</c:if>>大于等于</option>
								<option value="2" <c:if test="${bean.oprator ==2 }">selected="selected"</c:if>>小于等于</option>
							</select>
							下单数量：<input type="text" id="num" name="num" value="${bean.num }">							
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> 
				<i class="icon-zoom-add icon-white"></i> <span>下单预录入修改</span>
			</a> 
			
			<!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> 
				<i class="icon-edit icon-white"></i> 下单汇总修改
			</a> 
			
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="search"> 
				<i class="icon-trash icon-white"></i> 查询
			</a>
			
			<c:if test="${flag eq 1 }">
				<a class="btn btn-large btn-success" href="javascript:void(0)" id="fororder">
					<i class="icon-trash icon-white"></i>输出到汇总页面
				</a>
			</c:if>
			
		</div>
		<div id="paging" class="pagclass" >
		<table id="mytable" cellspacing="0" border="1" summary="The technical specifications of the Apple PowerMac G5 series">
				<tr >
					<th class="specalt" style="width:15px" rowspan="2">
						<input type="checkbox" id="checkIds" name="checkIds">
					</th>
					<th class="specalt" style="width:40px" rowspan="2">id</th>
					<th class="specalt" style="width:50px" rowspan="2">日期</th>
					<th class="specalt" style="width:50px" rowspan="2">布种</th>
					<th class="specalt" rowspan="2">工艺</th>
					<th class="specalt" rowspan="2">我司编号</th>
					<th class="specalt" rowspan="2">我司颜色</th>
					<th class="specalt" rowspan="2">工厂</th>
					<th class="specalt" rowspan="2">工厂编号</th>
					<th class="specalt" rowspan="2">工厂颜色</th>
					<th class="specalt" rowspan="2">数量</th>
					<th class="specalt" rowspan="2">规格</th>
					<th class="specalt" colspan="3" style="text-align: center">包装方式</th>
					
					<th class="specalt" rowspan="2" style="text-align: center">备注</th>
					<th class="specalt" rowspan="2">业务员</th>
				</tr><tr>
					<th class="specalt" >纸管</th>
					<th class="specalt" >空差</th>
					<th class="specalt" >胶袋</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr>
					 	<td>
					 		<input type="checkbox" id="checkId" name="checkId" value="${item.id }">
					 	</td><td>
					 		${item.id }
					 	</td>
					 	<td title="<fmt:formatDate value='${item.orderDate }' pattern='yyyy-MM-dd'/>">
							<fmt:formatDate value='${item.orderDate }' pattern='MM-dd'/>
						</td>
					 	
					 	<td>
					 		${item.clothName }
					 	</td><td>
					 		${item.technologyName }
					 	</td><td>
					 		${item.myCompanyCode }
					 	</td><td>
					 		${item.myCompanyColor }
					 	</td><td>
					 		${item.factoryName }
					 	</td><td>
					 		${item.factoryCode }
					 	</td><td>
					 		${item.factoryColor }
					 	</td><td>
					 		${item.num }
					 	</td><td>
					 		${item.standard }
					 	</td><td>
					 		${item.zhiguan }
					 	</td><td>
					 		${item.kongcha }
					 	</td><td>
					 		${item.jiaodai }
					 	</td>					 	
					 	<td title="${item.mark }">
							${fn:substring(item.mark,0,10)}  
							<c:if test="${fn:length(item.mark)>10}">...</c:if>
						</td>
					 	<td>
					 		
					 	</td>
					<tr>
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="9" style="text-align: center;font-size: 14px;">
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
</body>
</html>