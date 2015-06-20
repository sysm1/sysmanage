<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
	var dialog;
	var grid;
	$(function() {
		
		$("#seach").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			var f = $('#fenye');
			f.attr('action','${pageContext.request.contextPath}/background/input/list.html');
			f.submit();
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/salesman/exportExcel.html');
			f.submit();
		});
		
		
		$("#add").click("click", function() {//绑定新增按扭
			dialog = parent.$.ligerDialog.open({
				width : 1150,
				height : 550,
				url : rootPath + '/background/input/addUI.html',
				title : "下单预录入",
				isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			});
		});
		
		$("#editView").click("click", function() {//绑定编辑按扭
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 950,
				height : 550,
				url : rootPath + '/background/input/editUI.html?id='+cbox,
				title : "修改下单预录入",
				isHidden : false
			});
		});
		
		$("#copyAdd").click("click", function() {//复制新增按钮
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 1150,
				height :550,
				url : rootPath + '/background/input/editUI.html?id='+cbox+"&type=copy",
				title : "复制新增下单预录入",
				isHidden : false
			});
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
	        height:20,
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
		
		$("#view").click("click", function() {//查看按钮
			var cbox=grid.getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 950,
				height : 550,
				url : rootPath + '/background/input/editUI.html?id='+cbox+"&type=view",
				title : "复制新增下单预录入",
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
					    url: rootPath + '/background/salesman/deleteById.html', //要访问的后台地址
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
		window.location.reload();
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
			delarr.push($(this).val());
		});
		return arr;
	};
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/input/list.html');
		f.submit();
	}
</script>
</head>
<body>
	<div class="divBody" >
		<div class="search" >
			<form name="fenye" id="fenye">
			<input type="hidden" id="pageNow" name="pageNow" value="">
			<table>
				<tr>
					<td align="right">下单日期：</td>
					<td>
						<input type="text" id="startDate" name="startDate" value="<fmt:formatDate value='${bean.startDate}' pattern='yyyy-MM-dd'/>" style="width:91px;" 
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">至
						<input type="text" id="endDate" name="endDate" value="<fmt:formatDate value='${bean.endDate}' pattern='yyyy-MM-dd'/>" style="width:91px;"
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
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
					  	<input type="text" id="cloth_text" style="width: 200px;" value="${cloth.clothName }" 
					  		onchange="changeTextValue('clothId',this);"/>
					</td>
					<td align="right">我司颜色：</td>
					<td>
						<input type="text" id="myCompanyColor" name="myCompanyColor" value="">
					</td>
				</tr><tr>
					<td align="right">我司编号：</td>
					<td>
						<select id="myCompanyCode" name="myCompanyCode">
							<option value="">请选择</option>
							<c:forEach var="code" items="${myCompanyCodes }">
								<option value="${code }">${code }</option>
							</c:forEach>
						</select>
					</td>
					<td align="right">业务员：</td>
					<td>
						<select id="salesmanId" name="salesmanId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
							<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</td>
					<td align="right">备注：</td>
					<td><input type="text" id="mark" name="mark" value=""></td>
				</tr><tr>
					<td>工艺：</td>
					<td>
						<select id="technologyId" name="technologyId">
							<option value="">请选择</option>
							<c:forEach items="${technologys }" var="tech">
							<option value="${tech.id }" <c:if test="${tech.id == param.technologyId }">selected="selected"</c:if> >${tech.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
				 
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>新增</span>
			</a> 
			
			<a class="btn btn-success" href="javascript:void(0)" id="copyAdd"> <i
				class="icon-zoom-in icon-white" id="View"></i> 复制新增
			</a>
			
			<!--a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> 修改
			</a--> 
			
			<!--<a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <i
				class="icon-trash icon-white"></i> Delete-->
			</a>
			
			<!--a class="btn btn-large btn-success" href="javascript:void(0)" id="view">
				查看
			</a-->
			<a class="btn btn-primary" href="javascript:void(0)" id="seach"> 查询</a>
		</div>
		<div id="paging" class="pagclass"  >
		<table class="dataintable" style="width: 100%;">
				<tr>
					<th >选择</th>
					<th>序号</th>
					<th >下单日期</th>
					<th >布种</th>
					<th >工艺</th>
					<th >我司编号</th>
					<th >我司颜色</th>
					<th>数量</th>
					<th>备注</th>
					<th>业务员</th>
				</tr>
				
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr  id="${status.index }" >
						<td style="width:5%;text-align: center;">
					 		<input type="checkbox"  id="${item.id }" name="checkId" value="${item.id }" onclick="checkId(this);">
					 	</td><td>
					 		${item.id }
					 	</td><td style="text-align: center;width: 80px;">
					 		<fmt:formatDate value="${item.createTime  }" pattern="yyyy-MM-dd"/>
					 	</td><td style="text-align: center;">
					 		${item.clothName }
					 	</td><td style="text-align: center;">
					 		${item.technologyName }
					 		<c:if test="${item.technologyName ==null }">-</c:if>
					 	</td><td style="text-align: center;">
					 		${item.myCompanyCode }
					 	</td><td>
					 		${item.myCompanyColor }
					 	</td><td>
					 		${item.unit }
					 	</td><td style="text-align: left;width: 15%;" title="${item.mark }">
					 		${fn:substring(item.mark,0,15) }
							<c:if test="${fn:length(item.mark)>15 }">...</c:if>
					 	</td><td>
					 		${item.saleManName }
					 	</td>
					<tr>
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 30px">
					<td colspan="10" style="text-align: center;font-size: 12px;">
						<%@ include file="../page.jsp"%>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>