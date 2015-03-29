<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/list-main.css" rel="stylesheet">
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
	var delarr = [];
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
		$("#refresh").click("click", function() {
			window.location.reload();
		});
		$("#order").click("click", function() {//下单录入页面
			var cbox=getSelectedCheckbox();
			window.location.href=rootPath + "/background/inputsummary/order.html?id="+cbox.join(",");
			
			
			
		});
		$("#editView").click("click", function() {//绑定编辑按扭
			var cbox=getSelectedCheckbox();
			if (cbox.length > 1||cbox=="") {
				parent.$.ligerDialog.alert("只能选中一个");
				return;
			}
			dialog = parent.$.ligerDialog.open({
				width : 950,
				height : 550,
				url : rootPath + '/background/input/editUI.html?addId='+cbox[0].split("_")[0],
				title : "修改下单预录入",
				isHidden : false
			});
		});
		$("#delete").click("click", function() {//绑定删除按扭
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
					    url: rootPath + '/background/inputsummary/deleteById.html', //要访问的后台地址
					    data: {ids:cbox.join(",")}, //要发送的数据
					    success: function(data){
					    	if (data.flag == "true") {
					    		parent.$.ligerDialog.success('删除成功!', '提示', function() {
					    			for(var i=0;i<delarr.length;i++){
					    				//alert(document.getElementById(delarr[i]).parentNode.parentNode.style.display);
					    				document.getElementById(delarr[i]).parentNode.parentNode.style.display="none";
					    			}
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
	/**
	 * 获取选中的值
	 */
	function getSelectedCheckbox() {
		var arr = [];
		$('input[name="childcheckId"]:checked').each(function() {
			arr.push($(this).val());
			delarr.push($(this).val());
		});
		return arr;
	};
	
	//global var 
	var pos =0 
	//to find the position you mouse has pressed 
	function whichElement(e) {
		var targ =null;
		if (!e) {
			var e = window.event ;
		}
		if (e.target) {
			targ = e.target ;
		}else if (e.srcElement) {
			targ = e.srcElement;
		}
		if (targ.nodeType == 3){ // defeat Safari bug 
			targ = targ.parentNode;
		}
		if(targ.tagName=="SPAN"){//to adjust whether the element is tabledata 
			pos = targ.parentNode.parentNode.rowIndex+1;
		}else if(targ.tagName=="INPUT"){ 
			pos = targ.parentNode.parentNode.rowIndex+1;
		}else{
			pos=0;
		}
		//alert(pos+post);
	} 
	//to insert a row in the place 
	function insRow(data) {
		for(var i=0;i<data.length;i++){
			var tr=document.getElementById('mytable').insertRow(pos);
			var td0=tr.insertCell(0);
			var td1=tr.insertCell(1);
			var td2=tr.insertCell(2);
			var td3=tr.insertCell(3);
			var td4=tr.insertCell(4);
			var td5=tr.insertCell(5);
			var td6=tr.insertCell(6);
			var td7=tr.insertCell(7);
			var td8=tr.insertCell(8);
			var td9=tr.insertCell(9);
			td0.innerHTML='<input type="hidden" name="chtd'+pos+'" >';
			td1.innerHTML='&nbsp;&nbsp;&nbsp;&nbsp;<input onclick="checkAllChild(this);" type="checkbox" ismap="'+data[i].summId+'" id="'+data[i].id+'_'+data[i].summId+'" name="childcheckId" value="'+data[i].id+'_'+data[i].summId+'">';
			td2.innerHTML=data[i].id;
			td3.innerHTML=data[i].createTime;
			td4.innerHTML=data[i].clothName;
			td5.innerHTML=data[i].myCompanyCode;
			td6.innerHTML=data[i].myCompanyColor;
			td7.innerHTML=data[i].num;
			td8.innerHTML=data[i].mark;
			td9.innerHTML=data[i].saleManName;
		}
	} 
	
	function showDetail(index,inputId){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/inputsummary/queryList.html', //要访问的后台地址
		    data: {id:inputId}, //要发送的数据
		    success: function(data){
		    	insRow(data);
			},error : function(XMLHttpRequest, textStatus, errorThrown,data) {    
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(data);  
		     }
		});
		$("#td"+index)[0].innerHTML='<span onclick="hiddenDetail('+pos+','+inputId+','+index+')">-</span>';
	}
	
	function hiddenDetail(id,inputId,index){
		var tds=document.getElementsByName("chtd"+id);
		for(var i=0;i<tds.length;i++){
			//alert(tds[i].parentNode.parentNode.nodeName);
			tds[i].parentNode.parentNode.style.display="none";
		}
		$("#td"+index)[0].innerHTML='<span onclick="showDetail('+index+','+inputId+')">+</span>';
		$('#'+inputId)[0].checked=false;
	}
	
	function addTr(tab, row, trHtml){
	     //获取table最后一行 $("#tab tr:last")
	     //获取table第一行 $("#tab tr").eq(0)
	     //获取table倒数第二行 $("#tab tr").eq(-2)
	     var $tr=$("#"+tab+" tr").eq(row);
	     if($tr.size()==0){
	        alert("指定的table id或行数不存在！");
	        return;
	     }
	     $tr.after(trHtml);
	  }
	
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/inputsummary/list.html');
		f.submit();
	}
	
	/****反向选择checkbox*/
	function checkAllChild(obj){
		var summId=obj.value.split("_")[1];
		var childcheckId=document.getElementsByName("childcheckId");
		var childValue="";
		var chsize=0;
		var size=0;
		for(var i=0;i<childcheckId.length;i++){
			childValue=childcheckId[i].value;
			if(childValue.split("_")[1]==summId){
				size++;
				if(childcheckId[i].checked ){
					chsize++;
				}
			}
		}
		if(chsize==size){
			document.getElementById(summId).checked=true;
		}else{
			document.getElementById(summId).checked=false;
		}
		showOrHiddenBtn();
	}
	
	/**全选 当前父节点下的子节点**/
	function checkAll(index,obj){
		var summId=obj.value;
		if(obj.checked){
			if($("#td"+index)[0].innerHTML.split('+').length>1){
				showDetail(index,summId);//加载子节点
			}
			
		}
		var childcheckId=document.getElementsByName("childcheckId");
		var childValue="";
		for(var i=0;i<childcheckId.length;i++){
			childValue=childcheckId[i].value;
			if(childValue.split("_")[1]==summId){
				childcheckId[i].checked = obj.checked;
			}
		}
		showOrHiddenBtn();
	}
	
	function showOrHiddenBtn(){
		var csize=0;
		var checkId=document.getElementsByName("checkId");
		for(var i=0;i<checkId.length;i++){
			if(checkId[i].checked){
				csize++;
			}
		}
		if(csize>1){
			document.getElementById("order").style.display="none";
			document.getElementById("order2").style.display="";
		}else{
			document.getElementById("order").style.display="";
			document.getElementById("order2").style.display="none";
		}
		if(childcheckId.length>1){
			document.getElementById("order").style.display="none";
			document.getElementById("order2").style.display="";
		}
		var childcheckId=document.getElementsByName("childcheckId");
		
	}
</script>
</head>
<body onmousedown="whichElement(event);">
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
			<input type="hidden" id="pageNow" name="pageNow" value="">
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="editView"> <i
				class="icon-zoom-add icon-white"></i> <span>修改</span>
			</a> <!-- <a class="btn btn-success" href="javascript:void(0)"> <i
				class="icon-zoom-in icon-white" id="View"></i> View
			</a> --> <a class="btn btn-info" href="javascript:void(0)" id="refresh"> <i
				class="icon-edit icon-white"></i> 刷新
			</a> 
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="order" >
				开始下单
			</a>
			<a class="btn btn-large btn-success" style="background-color: #FFF5EE;display: none" href="javascript:void(0)" id="order2" >
				开始下单
			</a>
			 <a class="btn btn-danger" href="javascript:void(0)" id="delete" > <i
				class="icon-trash icon-white"></i> 删除
			</a>
			
		</div>
		<div id="paging" class="pagclass">
			<table id="mytable" cellspacing="0" border="1" summary="The technical specifications of the Apple PowerMac G5 series">
				<tr>
					<th class="specalt" style="width:50px;">详情</th>
					<th style="width:50px;">选择</th>
					<th style="width:50px;">序号</th>
					<th style="widht:100px;">下单时间</th>
					<th>布种</th>
					<th>我司编号</th>
					<th>我司颜色</th>
					<th>数量</th>
					<th>备注</th>
					<th>业务员</th>
				</tr>
				
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr style="background-color:#1FFF" id="${status.index }" >
						<td id="td${status.index+1 }" style="background:#FFE4B5;"><span onclick="showDetail('${status.index +1}','${item.id }');">+</span></td>
						<td style="background:#FFE4B5;width:50px;">
					 		<input type="checkbox"  id="${item.id }" name="checkId" value="${item.id }" onclick="checkAll('${status.index +1}',this);">
					 	</td>
						<td style="background:#FFE4B5;">${item.id }</td>
						<td style="background:#FFE4B5;"></td>
						<td style="background:#FFE4B5;">${item.clothName }</td>
						<td style="background:#FFE4B5;">${item.myCompanyCode }</td>
						<td style="background:#FFE4B5;">${item.myCompanyColor }</td>
						<td style="background:#FFE4B5;">${item.num }</td>
						<td style="background:#FFE4B5;">见明细</td>
						<td style="background:#FFE4B5;">业务员</td>
					<tr>
				</c:forEach>
				
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="10" style="text-align: center;font-size: 14px;">
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
  </ul>
</div>
					</td>
				</tr>
				
			</table>
		</div>
	</div>
</body>
</html>