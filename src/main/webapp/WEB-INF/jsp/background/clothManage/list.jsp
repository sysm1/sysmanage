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
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/clothManage/list.html');
			f.submit(); 
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/clothManage/exportExcel.html');
			f.submit();
		});
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 330,
				height : 346,
				url : rootPath + '/background/clothManage/addUI.html',
				title : "增加",
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
				width : 330,
				height : 346,
				url : rootPath + '/background/clothManage/editUI.html?id='+cbox,
				title : "修改",
				isHidden : false
			});
		});
		$("#perrole").click("click", function() {//绑定查询按扭
			var cbox=grid.selectRow();
			if (cbox.id == undefined || cbox.id=="") {
				parent.$.ligerDialog.alert("请选择一条数据!");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 500,
				height : 410,
				url : rootPath + '/background/account/accRole.html?id='+cbox.id+'&accountName='+encodeURI(encodeURI(cbox.accountName))+'&roleName='+encodeURI(encodeURI(cbox.roleName)),
				title : "分配角色",
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
					    url: rootPath + '/background/clothManage/deleteById.html', //要访问的后台地址
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
		location.reload();
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
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
</script>
</head>
<body>
	<div class="divBody">
		<div class="search" >
			<form name="fenye" id="fenye">
				<table  class="dataintable">
					<tr>
						<td>
							布种名称：
						</td><td>
							<input type="hidden" id="clothId" name="clothId" value="${ clothManage.clothId }">
						  	<input type="text" id="cloth_text" name="clothName" style="width: 200px;" value="${clothManage.clothName }" 
						  		onchange="changeTextValue('clothId',this);"/> 
						</td><td style="width: 100px;">
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
				class="icon-zoom-add icon-white"></i> <span>添加</span>
			</a> <!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> <a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> 修改
			</a> <a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <i
				class="icon-trash icon-white"></i> 删除
			</a>
		</div>
		<div id="paging" class="pagclass">
		<table class="dataintable" style="width: 100%;">
				<tr>
					<th class="specalt" style="width:35px;">选择</th>
					<th>日期</th>
					<th style="width:80px;">工厂</th>
					<th style="width:70px;">布种</th>
					<th style="widht:100px;">账面条数</th>
					<th>账面公斤数</th>
					<th>实际条数</th>
					<th>实际公斤数</th>
					<th>调整条数</th>
					<th>调整公斤数</th>
					<th>调整原因</th>
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
					 		<fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd"/>
					 	</td><td>
					 		${item.factoryName }
					 	</td><td>
					 		${item.clothName }
					 	</td><td>
					 		${item.paperNum }
					 	</td><td>
					 		${item.paperNumKg }
					 	</td><td>
					 		${item.factNum }
					 	</td><td>
					 		${item.factNumKg }
					 	</td><td>
					 		${item.adjustNum }
					 	</td><td>
					 		${item.adjustNumKg }
					 	</td><td style="width: 200px;" title="${item.mark }">
					 		${fn:substring(item.mark,0,20) }
							<c:if test="${fn:length(item.mark)>20 }">...</c:if>
					 	</td>
					<tr>
				</c:forEach>
				
				<!-- 分页 -->
				<tr style="height: 30px">
					<td colspan="11" style="text-align: center;font-size: 14px;">
						<%@ include file="../page.jsp"%>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>