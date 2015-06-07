<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>下单录入汇总查询</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<style type="text/css">

.textcss{height: 99%;border:1px solid green;}

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
		
		$("#out2order").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			//alert(cbox.parent());
			//alert($('#'+cbox).parent().parent().children().length);
			parent.inputsummary.overrideText($('#'+cbox).parent().parent().children());
			closeWin();
		});
		
		$("#editView").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			//window.location.href=rootPath +'/background/ordersummary/editUI.html?id='+cbox;
			$.ajax({
			    type: "post", //使用get方法访问后台
			    dataType: "json", //json格式的数据
			    async: false, //同步   不写的情况下 默认为true
			    url: rootPath + '/background/orderAudit/checkTime.html?type=2', //要访问的后台地址
			    data: {ids:cbox.join(",")}, //要发送的数据
			    success: function(data){
			    	if (data.flag == "false") {
			    		if(confirm("过期单据，修改需要审核，点击确定进行审核处理")){
			    			toAudit(cbox.join(","));
			    			/**
			    			dialog = parent.$.ligerDialog.open({
			    				width : 1150,
			    				height : 550,
			    				url : rootPath + '/background/inputsummary/editUI.html?addId='+data.newIds,
			    				title : "修改下单预录入",
			    				isHidden : false
			    			});**/
			    		}
					}else if(data.flag=="false2"){
						alert("单据审核不通过不能修改，审核原因："+data.reason);
					}else{
						window.location.href=rootPath +'/background/ordersummary/editUI.html?id='+cbox;
					}
				}
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
		
		/***过滤查询**/
		$("#factory_text").ligerComboBox({
	        url: '/background/pinyin/factory.html',
	        valueField: 'id',
	        textField: 'name', 
	        selectBoxWidth: 220,
	        autocomplete: true,
	        width: 220,
	        height:15,
	        onSelected:function(e) {
	            $("#factoryId").val(e);
	             // alert($("#factoryId").val());
	        }
	   });
		/***过滤查询**/
		$("#cloth_text").ligerComboBox({
	        url: '/background/pinyin/cloth.html',
	        valueField: 'id',
	        textField: 'clothName', 
	        selectBoxWidth: 215,
	        selectBoxHeight: 215,
	        autocomplete: true,
	        width: 215,
	        height:15,
	        onSelected:function(e) {
	            $("#clothId").val(e);
	            //alert($("#clothId").val());
	            var clothId=$("#clothId").val();
	            $.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/sample/queryMycompanyCodeByCloth.html', //要访问的后台地址
				    data: {clothId:clothId}, //要发送的数据
				    success: function(data){
				    	if(data!=null&&data!=''){
					    	var myCompanyCode = $("#myCompanyCode");
					    	myCompanyCode.empty();
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
		
	});
	
	/***审核**/
	function toAudit(ids){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/orderAudit/toAudit.html?type=2', //要访问的后台地址
		    data: {ids:ids}, //要发送的数据
		    success: function(data){
		    	if (data.flag == "true") {
		    		parent.$.ligerDialog.success('单据已经发送至审核!', '提示', function() {
		    			for(var i=0;i<delarr.length;i++){
		    				//alert(document.getElementById(delarr[i]).parentNode.parentNode.style.display);
		    				document.getElementById(delarr[i]).parentNode.parentNode.style.display="none";
		    			}
		    			loadGird();//重新加载表格数据
					});
				}else{
					parent.$.ligerDialog.warn("操作失败！！");
				}
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
	function loadGird(){
		location.reload();
	}
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/ordersummary/list.html');
		f.submit();
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
</script>
</head>
<body  >
	<div class="divBody" style="width: 1550px">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<input type="hidden" id="flag" name="flag" value="${flag }">
				<table border="1" class='dataintable'>
					<tr>
						<td style="width:70px;text-align: right;">下单日期：</td>
						<td>
							<input type="text" id="startDate" name="startDate" value="<fmt:formatDate value='${bean.startDate}' pattern='yyyy-MM-dd'/>" 
								style="width:91px;height: 99%;border:1px solid green;margin-top: 1px" 
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">至
							<input type="text" id="endDate" name="endDate" value="<fmt:formatDate value='${bean.endDate}' pattern='yyyy-MM-dd'/>" 
								style="width:91px;height: 99%;border:1px solid green;margin-top: 1px"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
						</td>
						<td style="width:70px;text-align: right;">单号：</td>
						<td>
							<input type="text" id="orderCode" name="orderCode" value="${bean.orderCode }" 
								style="height: 99%;margin-top: 1px">
						</td>
						<td style="width:70px;text-align: right;">工厂：</td>
						<td>
							<!--select  id="factoryId" name="factoryId">
								<option value="">请选择工厂</option>
								<c:forEach items="${ factoryInfos }" var = "factoryInfo">
										<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
									</c:forEach>
							</select-->
							<input type="hidden" id="factoryId" name="factoryId" value="${ bean.factoryId }">
							<input type="text" id="factory_text" style="width: 200px;height: 99%;margin-top: -3px" value="${factoryInfo.name }" 
								onchange="changeTextValue('factoryId',this);"/> 
						</td>
					</tr><tr>
						<td style="width:70px;text-align: right;">布种：</td>
						<td>
							<!--select id="clothId" name="clothId">
								<option value="">请选择布种</option>
								<c:forEach items="${ cloths }" var = "cloth">
									<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
								</c:forEach>
							</select-->
							
							<input type="hidden" id="clothId" name="clothId" value="${ bean.clothId }">
						  	<input type="text" id="cloth_text" style="width: 200px;height: 99%;margin-top: -3px" value="${cloth.clothName }" 
						  		onchange="changeTextValue('clothId',this);"/>
						</td><td style="width:70px;text-align: right;">
							工厂编号：
						</td><td>
							<input type="text" id="factoryCode" name="factoryCode" value="${bean.factoryCode}" >
						</td><td style="width:70px;text-align: right;">我司编号：</td>
						<td>
							<select id="myCompanyCode" name="myCompanyCode" >
								<option value="">请选择</option>
								<c:forEach var="code" items="${myCompanyCodes }">
									<option value="${code }">${code }</option>
								</c:forEach>
							</select>
						</td>
					</tr><tr>
						<td style="width:70px;text-align: right;">我司颜色：</td>
						<td>
							<input type="text" id="myCompanyColor" name="myCompanyColor" value="${bean.myCompanyColor}" >
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
						    <select id="technologyId" name="technologyId" >
								<option value="">请选择工艺</option>
								<c:forEach items="${ technologyInfos }" var = "technologyInfo">
								<option <c:if test="${technologyInfo.id eq bean.technologyId }">selected="selected"</c:if> value="${technologyInfo.id }">${technologyInfo.name}</option>
								</c:forEach>
							</select>
						</td><td style="width:70px;text-align: right;">下单次数：</td>
						<td colspan="3" style="text-align: left;">
							<select id="oprator" name="oprator" style="width: 100px;">
								<option value="">请选择</option>
								<option value="1" <c:if test="${bean.oprator ==1 }">selected="selected"</c:if>>大于等于</option>
								<option value="2" <c:if test="${bean.oprator ==2 }">selected="selected"</c:if>>小于等于</option>
							</select>
							下单数量：<input type="text" id="num" name="num" value="${bean.num }" >							
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="topBtn">
			<c:if test="${flag eq null }">
			<!--a class="btn btn-primary" href="javascript:void(0)" id="add"> 
				<span>下单预录入修改</span>
			</a--> 
			
			<!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> 
				下单汇总修改
			</a> 
			</c:if>
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="search"> 
				查询
			</a>
			
			<c:if test="${flag eq 1 }">
				<a class="btn btn-large btn-success" href="javascript:void(0)" id="out2order">
					输出到汇总页面
				</a>
			</c:if>
			
		</div>
		<div id="paging" class="pagclass" >
		<table id="mytable" cellspacing="0" border="1" style="datalist" class='dataintable'>
				<tr >
					<th class="specalt" style="width:15px" rowspan="2">
						<input type="checkbox" id="checkIds" name="checkIds">
					</th>
					<th class="specalt" style="width:40px" rowspan="2">id</th>
					<th class="specalt" style="width:45px" rowspan="2">日期</th>
					<th class="specalt" style="width:85px" rowspan="2">布种</th>
					<th class="specalt" style="width:85px" rowspan="2">布种颜色</th>
					<th class="specalt" rowspan="2">工艺</th>
					<th class="specalt" rowspan="2">我司编号</th>
					<th class="specalt" rowspan="2">我司颜色</th>
					<th class="specalt" rowspan="2">工厂</th>
					<th class="specalt" rowspan="2">工厂编号</th>
					<th class="specalt" rowspan="2">工厂颜色</th>
					<th class="specalt" rowspan="2">数量</th>
					<th class="specalt" colspan="2" style="text-align: center">规格</th>
					<th class="specalt" colspan="3" style="text-align: center">包装方式</th>
					
					<th class="specalt" rowspan="2" style="text-align: center">备注</th>
					<th class="specalt" rowspan="2">业务员</th>
				</tr><tr>
					<th class="specalt" >宽幅</th>
					<th class="specalt" >克重</th>
					<th class="specalt" >纸管</th>
					<th class="specalt" >空差</th>
					<th class="specalt" >胶袋</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr >
					 	<td style="height: 25px;">
					 		<input type="checkbox" id="${item.id }" name="checkId" value="${item.id }">
					 	</td><td>
					 		${item.id }
					 	</td>
					 	<td title="<fmt:formatDate value='${item.orderDate }' pattern='yyyy-MM-dd'/>">
							<fmt:formatDate value='${item.orderDate }' pattern='MM-dd'/>
						</td><td>
					 		${item.clothName }
					 	</td><td>
					 		${item.color }
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
					 	</td><td style="text-align: right;">
					 		${item.numText }
					 	</td><td>
					 		${item.kuanfu }CM
					 		<c:if test="${item.kuanfufs==0 }">包边</c:if>
					 		<c:if test="${item.kuanfufs==1 }">实用</c:if>
					 	</td><td>
					 		${item.kezhong }
					 		<c:if test="${item.kezhongUnit==0 }">G/M2</c:if>
					 		<c:if test="${item.kezhongUnit==1 }">G/Y</c:if>
					 		<c:if test="${item.kezhongUnit==2 }">G/M</c:if>
					 		<c:if test="${item.kezhongfs==0 }">回后</c:if>
					 		<c:if test="${item.kezhongfs==1 }">出机</c:if>
					 	</td><td>
					 		${item.zhiguan }
					 	</td><td>
					 		${item.kongcha }
					 	</td><td>
					 		${item.jiaodai }
					 	</td><td title="${item.mark }">
							${fn:substring(item.mark,0,10)}  
							<c:if test="${fn:length(item.mark)>10}">...</c:if>
						</td><td >
					 		<span id="${status.index }_salesId">${item.salesmans }</span>
					 	</td>
					<tr>
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="14" style="text-align: center;font-size: 14px;">
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
<script type="text/javascript">
/**初始化业务员名称***/
var size=${size};
var salmanId='';
for(var i=0;i<=size;i++){
	var id=i+'_salesId';
	salmanId=$('#'+id)[0].innerHTML;
	$.ajax({
	    type: "post", //使用get方法访问后台
	    dataType: "json", //json格式的数据
	    async: false, //同步   不写的情况下 默认为true
	    url: rootPath + '/background/salesman/getSalmansName.html', //要访问的后台地址
	    data: {ids:salmanId}, //要发送的数据
	    success: function(data){
	    	$('#'+id)[0].innerHTML=data;		    	
		}
	});
}
</script>
</html>