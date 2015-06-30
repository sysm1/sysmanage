var dialog;
var grid;

$(function() {
	//grid = window.lanyuan.ui.lyGrid();
	$("#search").click("click", function() {//绑定查询按扭
		$('#pageNow').attr('value',1);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action',rootPath + '/background/flower/list.html');
		f.submit();
	});
	
	$("#exportExcel").click("click", function() {
		var f = $('#fenye');
		f.attr('target','_blank');
		f.attr('action', rootPath + '/background/flower/exportExcel.html');
		f.submit();
	});
	
	$("#add").click("click", function() {
		dialog = parent.$.ligerDialog.open({
			width : 750,
			height : 500,
			url : rootPath + '/background/flower/addUI.html',
			title : "花色基本资料录入",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	});
	$("#editView").click("click", function() {//绑定编辑按扭
		var cbox=getSelectedCheckbox();
		if(cbox==""){
			parent.$.ligerDialog.alert("请选择一条记录修改");
			return;
		}
		if (cbox.length > 1) {
			parent.$.ligerDialog.alert("一次只能修改一条记录");
			return;
		}
		dialog = parent.$.ligerDialog.open({
			width : 750,
			height : 500,
			url : rootPath + '/background/flower/editUI.html?id='+cbox,
			title : "花号修改",
			isHidden : false
		});
	});
	
	$("#updateView").click("click", function() {//绑定删除按扭
		var cbox=getSelectedCheckbox();
		if(cbox==""){
			parent.$.ligerDialog.alert("请选择一条记录");
			return;
		}
		if (cbox.length > 1) {
			parent.$.ligerDialog.alert("一次只能修改一条记录");
			return;
		}
		parent.$.ligerDialog.confirm('确定变更状态吗？', function(confirm) {
			if (confirm) {
				$.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/flower/updateStatus.html', //要访问的后台地址
				    data: {ids:cbox.join(",")}, //要发送的数据
				    // data:{id:cbox},
				    success: function(data){
				    	if (data.flag == "true") {
				    		parent.$.ligerDialog.success('变更成功!', '提示', function() {
				    			loadGird();//重新加载表格数据
							});
						}else{
							parent.$.ligerDialog.warn("变更失败！！");
						}
					}
				});
			}
		});
	});
	
	
	$("#deleteView").click("click", function() {//绑定删除按扭
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
				    url: rootPath + '/background/flower/deleteById.html', //要访问的后台地址
				    data: {ids:cbox.join(",")}, //要发送的数据
				    success: function(data){
				    	if (data.flag == "true") {
				    		parent.$.ligerDialog.success('删除成功!', '提示', function() {
				    			loadGird();//重新加载表格数据
							});
						}else if(data.flag == "nodelete"){
							alert("资料已经被使用，不能删除");
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
	//grid.loadData();
	$('#pageNow').attr('value',"${pageView.pageNow}");
	var f = $('#fenye');
	//f.attr('target','_blank');
	f.attr('action',window.location.href);
	f.submit();
}
function page(pageNO){
	$('#pageNow').attr('value',pageNO);
	var f = $('#fenye');
	//f.attr('target','_blank');
	f.attr('action', rootPath + '/background/flower/list.html');
	f.submit();
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


function mycolor_detail(flowerId) {
	dialog = parent.$.ligerDialog.open({
		width : 750,
		height : 500,
		url : rootPath + '/background/flower/colorDetail.html?flowerId='+flowerId,
		title : "花号查看",
		isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
	});
}