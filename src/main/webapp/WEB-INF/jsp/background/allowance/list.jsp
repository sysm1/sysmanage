<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">

<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

jQuery.validator.addMethod("isNum", function(value, element) {
	 var num = /^([0-9]+)$/;
	 return this.optional(element) || (num.test(value));
}, "只能输入数字");

	var dialog;
	var grid;
	$(function() {
		
		$("#seach").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			$("#delay").attr('value','');
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/allowance/list.html');
			f.submit();
		});
		
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/allowance/exportExcel.html');
			f.submit();
		});
		
		
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 420,
				height : 450,
				url : rootPath + '/background/allowance/addUI.html',
				title : "增加坯布采购单",
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
				width : 420,
				height : 450,
				url : rootPath + '/background/allowance/editUI.html?id='+cbox,
				title : "坯布采购单修改",
				isHidden : false
			});
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
            	 alert(e);
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
		 location.reload();
	}
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/allowance/list.html');
		f.submit();
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
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
		});
		return arr;
	};
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<table style="margin: 2px"  class="dataintable" >
				<tr>
				<td width="10%">布种：</td>
				<td width="20%" style="text-align: left;">
				<!-- 
				<select id="clothId" name="clothId" style="width:110px;">
					<option value="">请选择布种</option>
					<c:forEach items="${ cloths }" var = "cloth">
						<option value="${cloth.id }">${cloth.clothName}</option>
					</c:forEach>
				</select> 
				 -->
				<input type="hidden" id="clothId" name="clothId" value="${ param.clothId }">
			  	<input type="text" id="cloth_text" name="cloth_text" style="width: 110px;" value="${param.cloth_text }" 
			  		onchange="changeTextValue('clothId',this);"/>
				 
				</td>
				<td width="10%">出胚单位：</td>
				<td width="20%" style="text-align: left;">
				<!-- 
				<select id="factoryId" name="factoryId" style="width:110px;">
					<option value="">请选择工厂</option>
					<c:forEach items="${ factorys }" var = "factory">
						<option value="${factory.id }">${factory.name}</option>
					</c:forEach>
				</select>
				 -->
				<input type="hidden" id="factoryId" name="factoryId" value="${ param.factoryId }">
			  	<input type="text" id="factory_text" name="factory_text" style="width: 110px;" value="${param.factory_text }" 
			  		onchange="changeTextValue('factoryId',this);"/>
				</td>
				<td width="10%">备注：</td>
				<td style="text-align: left;">
				<input type="text" name="mark" id="mark" value="${param.mark}" style="width:100px;" />
				</td>
				</tr>
				
				<tr>
				<td>开始日期：</td>
				<td style="text-align: left;">
					<input type="text" name="beginTime" value="${param.beginTime}" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				</td>
				<td style="width: 100px;">结束日期：</td>
				<td style="text-align: left;">
					<input type="text" name="endTime" value="${param.endTime}" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
				</td>
				<!--td>新增量:</td>
				<td style="text-align: left;">
				<select id="change" name="change" style="width:110px;">
					<option value="all">全部</option>
					<option value="positive">正数</option>
					<option value="negative">负数</option>
					<option value="zero">0</option>
				</select>
				</td-->
				<td>单位：</td>
				<td style="text-align: left;">
				<select id="unit" name="unit" style="width:110px;">
					<option value="">请选择</option>
					<option value="0" <c:if test="${param.unit==0 }">selected="selected"</c:if>  >条</option>
					<option value="1" <c:if test="${param.unit==1 }">selected="selected"</c:if> >公斤</option>
					<!-- <option value="2">米</option>
					<option value="3">码</option>   
					
					<option value="4">包</option>-->
				</select>
				</td>
				</tr>
				
				<!-- tr>
				<td>单位:</td>
				<td style="text-align: left;">
				<select id="unit" name="unit" style="width:110px;">
					<option value="0">条</option>
					<option value="1">公斤</option>
					<!-- <option value="2">米</option>
					<option value="3">码</option>   
					
					<option value="4">包</option>-->
				</select>
				</td>
				<!--td>余量:</td>
				<td style="text-align: left;">
				<input type="text" id="num" name="num" value="${param.num}" style="width:100px;" />
				</td>
				<td>条件:</td>
				<td style="text-align: left;">
				<select id="condition" name="condition" style="width:110px;">
					<option value="gt">大于</option>
					<option value="gte">大于等于</option>
					<option value="it">小于</option>
					<option value="ite">小于等于</option>
				</select>
				</td>
				</tr-->
				</table>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> 新增
			</a> 
			
			<!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> 
			
			<a class="btn btn-info" href="javascript:void(0)" id="editView">  修改
			</a> 
			
			<a class="btn btn-primary"
					href="javascript:void(0)" id="seach"> 查询
			</a>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btn btn-danger" href="javascript:void(0)" id="deleteView">  删除
			</a>
			 
			<!--a class="btn btn-large btn-success" href="javascript:void(0)" id="exportExcel">
				导出excel
			</a-->
			
		</div>
		<div id="paging" class="pagclass">
		<table class="dataintable" style="width: 100%;">
				<tr>
					<th class="specalt" style="width:35px;">选择</th>
					<th>日期</th>
					<th style="width:80px;">出胚单位</th>
					<th style="width:70px;">布种</th>
					<th style="widht:100px;">条数</th>
					<th>重量(KG)</th>
					<th>单价(元)</th>
					<th>金额(元)</th>
					<th>收胚单位</th>
					<th>备注</th>
					<!--th>工厂颜色</th>
					<th style="width:80px;">到货日期</th>
					<th>我司验货报告</th>
					<th>工厂交涉情况</th-->
				</tr>
				
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr  id="${status.index }" >
						<td style="width:50px;text-align: center;">
					 		<input type="checkbox"  id="${item.id }" name="checkId" value="${item.id }" onclick="checkId(this);">
					 	</td><td style="width: 70px;">
					 		${item.strInputDate }
					 	</td><td>
					 		${item.supplierName }
					 	</td><td>
					 		${item.clothName }
					 	</td><td>
					 		${item.allowance }
					 	</td><td>
					 		${item.allowancekg }
					 	</td><td>
					 		${item.price }
					 	</td><td>
					 		${item.money }
					 	</td><td>
					 		${item.factoryName }
					 	</td><td style="width: 200px;" title="${item.mark }">
					 		${fn:substring(item.mark,0,20) }
							<c:if test="${fn:length(item.mark)>20 }">...</c:if>
					 	</td>
					<tr>
				</c:forEach>
				
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="10" style="text-align: center;font-size: 14px;">
						<%@ include file="../page.jsp"%>
					</td>
				</tr>
				
			</table>
		</div>
	</div>
</body>
</html>