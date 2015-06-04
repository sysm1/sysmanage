<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<!-- 开办录入查询 -->

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


<style type="text/css">
		
		#pic span.img{display:none;}
	    #pic a{}
	    //#pic a:hover{position:relative;}
	    #pic a:hover span.img{display:block;position:absolute;right:130px;z-index: 100; }
		
	</style>
<script type="text/javascript">
	var dialog;
	var grid;
	
	$(function() {
		//grid = window.lanyuan.ui.lyGrid();
		$("#search").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/sample/list.html');
			f.submit();
		});
		$("#exportExcel").click("click", function() {//绑定查询按扭
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/account/exportExcel.html');
			f.submit();
		});
		$("#add").click("click", function() {//绑定新增按扭
			//dialog = parent.$.ligerDialog.open({
			//	width : 950,
			//	height : 500,
			//	url : rootPath + '/background/sample/addUI.html',
			//	title : "开版录入",
			//	isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
			//});
			location.href=rootPath + '/background/sample/addUI.html';
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
				width : 950,
				height : 500,
				url : rootPath + '/background/sample/editUI.html?id='+cbox,
				title : "修改开版录入",
				isHidden : false
			});
		});
		$("#copyadd").click("click", function() {//绑定复制新增按扭
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
				width : 950,
				height : 500,
				url : rootPath + '/background/sample/editUI.html?id='+cbox+"&copyadd=copyadd",
				title : "复制新增开版录入",
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
					    url: rootPath + '/background/sample/deleteById.html', //要访问的后台地址
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
	        height:20,
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
	        selectBoxWidth: 220,
	        autocomplete: true,
	        width: 220,
	        height:20,
	        onSelected:function(e) {
	            $("#clothId").val(e);
	             // alert($("#factoryId").val());
	        }
	   });
	});
	function loadGird(){
		//grid.loadData();
		$('#pageNow').attr('value',${pageView.pageNow });
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/sample/list.html');
		f.submit();
	}
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/sample/list.html');
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
	/***显示图片**/
	function showPic(id,sampId){
		//alert((document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2));
		document.getElementById(id).style.top = (document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2) + "px"; 
		document.getElementById(id).src="${pageContext.request.contextPath}/background/pic/getPic.html?id="+sampId;
	}
	
	function show(id,sampId){
		document.getElementById(id).style.display="";
		document.getElementById(id).style.top = (document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2) + "px"; 
		document.getElementById(id).src=sampId;
	}
	
	function hiddenDiv(id){
		document.getElementById(id).style.display="none";
	}
	
	function test(){
		document.getElementById('middle').style.display="block";
		document.getElementById('surface').style.display="block";
	}
	
	/**全选**/
	function checkAll(obj){
		var checkIds=document.getElementsByName("checkId");
		var length=checkIds.length;
		for(var i=0;i<length;i++){
			checkIds[i].checked =obj.checked;
		}
	}
	
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
	
</script>
</head>
<body>
	<div class="divBody">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
<table class='dataintable'>
<tr>
	<td style="width:70px;text-align: right;">
		开版日期：
	</td><td>
		<input type="text" id="startDate" name="startDate" value="<fmt:formatDate value='${bean.startDate}' pattern='yyyy-MM-dd'/>" style="width:91px;" 
			onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">至
		<input type="text" id="endDate" name="endDate" value="<fmt:formatDate value='${bean.endDate}' pattern='yyyy-MM-dd'/>" style="width:91px;"
			onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
	</td><td style="width:70px;text-align: right;">
		备注：
	</td><td>
		<input type="text" id="mark" name="mark" value="${bean.mark }">
	</td><td style="width:70px;text-align: right;">
		编号：
	</td><td>
		<input type="text" id="codeValue" name="codeValue" value="${bean.codeValue }">
	</td>
</tr><tr>
	<td style="text-align: right;">
		工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;厂：
	</td><td>
      <!--select  id="factoryId" name="factoryId">
		<option value="">请选择工厂</option>
		<c:forEach items="${ factoryInfos }" var = "factoryInfo">
				<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
			</c:forEach>
	  </select-->  
	  <input type="hidden" id="factoryId" name="factoryId" value="${ bean.factoryId }">
	  <input type="text" id="factory_text" style="width: 200px;height: 99%;border:1px solid green;margin-top: -3px" value="${factoryInfo.name }" 
	  		onchange="changeTextValue('factoryId',this);"/> 
    </td><td style="text-align: right;">
    	布种：
    </td><td>
    	<!--select id="clothId" name="clothId">
			<option value="">请选择布种</option>
			<c:forEach items="${ cloths }" var = "cloth">
				<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
			</c:forEach>
		</select-->
		<input type="hidden" id="clothId" name="clothId" value="${ bean.clothId }">
	  	<input type="text" id="cloth_text" style="width: 200px;" value="${cloth.clothName }" 
	  		onchange="changeTextValue('clothId',this);"/>
    </td><td style="text-align: right;">
    	工艺：
    </td><td>
    	<select id="technologyId" name="technologyId">
			<option value="">请选择工艺</option>
			<c:forEach items="${ technologyInfos }" var = "technologyInfo">
				<option <c:if test="${technologyInfo.id eq bean.technologyId }">selected="selected"</c:if> value="${technologyInfo.id }">${technologyInfo.name}</option>
			</c:forEach>
	    </select>
    </td>
</tr>         
</table>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-primary" href="javascript:void(0)" id="add"> 
				<i class="icon-zoom-add icon-white"></i> <span>新增</span>
			</a> <a class="btn btn-info" href="javascript:void(0)" id="editView"> 
				<i class="icon-edit icon-white"></i> 修改
			</a> <a class="btn btn-danger" href="javascript:void(0)" id="copyadd"> 
				<i class="icon-zoom-add icon-white"></i> 复制新增
			</a> 
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="search">
				查询
			</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btn btn-danger" href="javascript:void(0)" id="deleteView"> 
				<i class="icon-trash icon-white"></i> 删除
			</a>
		</div>
		<div id="paging" class="pagclass">
			<table id="mytable" cellspacing="0" border="1" class='dataintable'>
				<tr >
					<th class="specalt" style="width:15px">
						<input type="checkbox" id="checkIds" name="checkIds" onclick="checkAll(this);">
					</th>
					<th class="specalt" style="width:50px">id</th>
					<th class="specalt" style="width:65px">开版日期</th>
					<th class="specalt" style="width:160px">工厂</th>
					<th class="specalt">布种</th>
					<th class="specalt">编号</th>
					<th class="specalt">工艺</th>
					<th class="specalt">备注</th>
					<th class="specalt">图片</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
					<tr>
					 	<td>
					 		<input type="checkbox" id="checkId" name="checkId" value="${item.id }">
					 	</td>
						<td onmousemove="showPic('${item.id }');">${item.id }</td>
						<td title="<fmt:formatDate value='${item.sampleDate }' pattern='yyyy-MM-dd'/>">
							<fmt:formatDate value='${item.sampleDate }' pattern='MM-dd'/>
						</td>
						<td>${item.factoryName }</td>
						<td>${item.clothName }</td>
						<td>
							${item.codeValue }
							<c:if test="${item.codeValue != null }">
							<c:if test="${item.codeType eq 0 }">(分色)</c:if>
							<c:if test="${item.codeType eq 1 }">(工厂)</c:if>
							<c:if test="${item.codeType eq 2 }">(我司)</c:if>
							</c:if>
						</td>
						
						<td>${item.technologyName }</td>
						<td title="${item.mark }">
							${fn:substring(item.mark,0,10)}  
							<c:if test="${fn:length(item.mark)>10}">...</c:if>
						</td>
						<td  id="pic" >
							<img style="height: 35px;" alt="" src="${item.smallPicture }" onmousemove="show('DivMain','${item.picture }')" onmouseout="hiddenDiv('DivMain');"/>
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
  </ul>
</div>
					</td>
				</tr>
			</table><br>
		</div>
	</div>
	<img  src="" class="ordersearchDivCss" id="DivMain" style="display: none;max-height:95%;" />
</body>
</html>	