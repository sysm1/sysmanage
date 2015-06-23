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
			f.attr('action','${pageContext.request.contextPath}/background/account/list.html');
			f.submit();
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/account/exportExcel.html');
			f.submit();
		});
		$("#add").click("click", function() {//绑定查询按扭
			dialog = parent.$.ligerDialog.open({
				width : 320,
				height : 274,
				url : rootPath + '/background/account/addUI.html',
				title : "增加账号",
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
				width : 320,
				height : 274,
				url : rootPath + '/background/account/editUI.html?accountId='+cbox,
				title : "修改账号",
				isHidden : false
			});
		});
		$("#perrole").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 500,
				height : 410,
				url : rootPath + '/background/account/accRole.html?id='+cbox,
				title : "分配角色",
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
					    url: rootPath + '/background/account/deleteById.html', //要访问的后台地址
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
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				名称：<input type="text" name="accountName" value="${param.accountName}"
					style="height: 20px" /> <a class="btn btn-primary"
					href="javascript:void(0)" id="seach"> 查询
				</a>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> <i
				class="icon-zoom-add icon-white"></i> <span>add</span>
			</a> <!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> <a class="btn btn-info" href="javascript:void(0)" id="editView"> <i
				class="icon-edit icon-white"></i> Edit
			</a> <!--a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> <i
				class="icon-trash icon-white"></i> Delete
			</a-->
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="perrole">
				分配角色
			</a>
		</div>
		<div id="paging" class="pagclass">
		<table class="dataintable" style="width: 100%;">
				<tr>
					<th >选择</th>
					<th >用户名</th>
					<th >分点</th>
					<th >所属角色</th>
					<th >账号状态</th>
					<th >描述</th>
					<th>创建时间</th>
				</tr>
				
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr  id="${status.index }" >
						<td style="width:10%;text-align: center;">
					 		<input type="checkbox"  id="${item.id }" name="checkId" value="${item.id }" onclick="checkId(this);">
					 	</td><td style="width: 15%;text-align: center;">
					 		${item.accountName }
					 	</td><td style="text-align: center;">
					 		<c:if test="${item.cityId == null }">-</c:if>
					 		${item.cityName }
					 	</td><td style="width: 25%;text-align: center;">
					 		${item.roleName }
					 	</td><td style="text-align: center;">
					 		${item.stateName }
					 	</td><td>
					 		${item.description }
					 	</td><td>
					 		<fmt:formatDate value="${item.createTime  }" pattern="yyyy-MM-dd"/>
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