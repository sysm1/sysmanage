<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>

<link rel="stylesheet" href="${ctx}/themes/blue/style.css" type="text/css" id="" media="print, projection, screen" />

<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

jQuery.validator.addMethod("isNum", function(value, element) {
	 var num = /^([0-9]+)$/;
	 return this.optional(element) || (num.test(value));
}, "只能输入数字");

	var dialog;
	var grid;
	$(function() {
		grid = window.lanyuan.ui.lyGrid({
					id : 'paging',
					l_column : [ {
						colkey : "id",
						name : "id",
						width : "50px"
					},{
						colkey : "strInputDate",
						name : "日期",
						width : "75px"
					},{
						colkey : "clothName",
						name : "坯布名称",
						width : "130px"
					},{
						colkey : "supplierName",
						name : "坯布供应商",
						width : "130px"
					},
					/*{
						colkey : "color",
						name : "坯布颜色",
						width : "130px"
					},*/ {
						colkey : "allowance",
						name : "坯布条数",
						width : "75px"
					},{
						colkey : "allowancekg",
						name : "坯布公斤数",
						width : "80px"
					},{
						colkey : "factoryName",
						name : "收坯单位",
						width : "130px"
					}, {
						colkey : "mark",
						name : "备注"
					}],
					jsonUrl : '${pageContext.request.contextPath}/background/allowance/queryByFind.html',
					checkbox : true
				});
		
		$("#seach").click("click", function() {//绑定查询按扭
			var num = $("#num").val();
			alert(num);
			var searchParams = $("#fenye").serialize();
			grid.setOptions({
				data : searchParams
			}); 
		});
		
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/allowance/exportExcel.html');
			f.submit();
		});
		
		
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 450,
				height : 400,
				url : rootPath + '/background/allowance/addUI.html',
				title : "增加坯布采购单",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		$("#editView").click("click", function() {//绑定查询按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 450,
				height : 400,
				url : rootPath + '/background/allowance/editUI.html?id='+cbox,
				title : "坯布采购单修改",
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
					    url: rootPath + '/background/allowance/deleteById.html', //要访问的后台地址
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
		
		$("#factory_text").ligerComboBox({
             url: '/background/pinyin/factory.html',
             valueField: 'id',
             textField: 'name', 
             selectBoxWidth: 110,
             autocomplete: true,
             width: 110,
             onSelected:function(e) {
                 $("#factoryId").val(e);
                  // alert($("#factoryId").val());
             }
        });
		
		$("#cloth_text").ligerComboBox({
            url: '/background/pinyin/cloth.html',
            valueField: 'id',
            textField: 'clothName', 
            selectBoxWidth: 110,
            autocomplete: true,
            width: 110,
            onSelected:function(e) {
                $("#clothId").val(e);
                 // alert($("#factoryId").val());
            }
       });
	});
	function loadGird(){
		grid.loadData();
	}
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<table style="margin: 2px">
				<tr>
				<td width="10%">布种：</td>
				<td width="20%">
				<input type="hidden" value="" id="clothId" name="clothId">
				<!-- 
				<select id="clothId" name="clothId" style="width:110px;">
					<option value="">请选择布种</option>
					<c:forEach items="${ cloths }" var = "cloth">
						<option value="${cloth.id }">${cloth.clothName}</option>
					</c:forEach>
				</select> 
				 -->
				 <input type="text" id="cloth_text" style="width: 110px;"/>
				</td>
				<td width="10%">工厂:</td>
				<td width="20%">
				<input type="hidden" value="" id="factoryId" name="factoryId">
				<!-- 
				<select id="factoryId" name="factoryId" style="width:110px;">
					<option value="">请选择工厂</option>
					<c:forEach items="${ factorys }" var = "factory">
						<option value="${factory.id }">${factory.name}</option>
					</c:forEach>
				</select>
				 -->
				 <input type="text" id="factory_text" style="width: 110px;"/>
				</td>
				<td width="10%">备注:</td>
				<td >
				<input type="text" name="mark" value="${param.mark}" style="width:100px;" />
				</td>
				</tr>
				
				<tr>
				<td>开始日期:</td>
				<td>
					<input type="text" name="beginTime" value="${param.beginTime}" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				</td>
				<td>结束日期:</td>
				<td>
					<input type="text" name="endTime" value="${param.endTime}" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				</td>
				<td>新增量:</td>
				<td>
				<select id="change" name="change" style="width:110px;">
					<option value="all">全部</option>
					<option value="positive">正数</option>
					<option value="negative">负数</option>
					<option value="zero">0</option>
				</select>
				</td>
				</tr>
				
				<tr>
				<td>单位:</td>
				<td>
				<select id="unit" name="unit" style="width:110px;">
					<option value="0">条</option>
					<!-- 
					<option value="1">公斤</option>
					<option value="2">米</option>
					<option value="3">码</option>   
					-->
					<option value="4">包</option>
				</select>
				</td>
				<td>余量:</td>
				<td>
				<input type="text" id="num" name="num" value="${param.num}" style="width:100px;" />
				</td>
				<td>条件:</td>
				<td>
				<select id="condition" name="condition" style="width:110px;">
					<option value="gt">大于</option>
					<option value="gte">大于等于</option>
					<option value="it">小于</option>
					<option value="ite">小于等于</option>
				</select>
				<a class="btn btn-primary"
					href="javascript:void(0)" id="seach"> 查询
				</a>
				
				</td>
				</tr>
				</table>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>新增</span>
			</a> 
			
			<!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> 修改
			</a> 
			
			<a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <i
				class="icon-trash icon-white"></i> 删除
			</a>
			 
			<!--a class="btn btn-large btn-success" href="javascript:void(0)" id="exportExcel">
				导出excel
			</a-->
			
		</div>
		<div id="paging" class="pagclass"></div>
	</div>
</body>
</html>