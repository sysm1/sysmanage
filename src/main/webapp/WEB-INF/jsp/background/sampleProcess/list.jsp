<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<!-- 开办录入查询 -->

<style type="text/css">
/* CSS Document */

body {
 font: normal 13px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
}

a {
 color: #c75f3e;
}

#mytable {
 width: 150%;
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


<script type="text/javascript">
	var dialog;
	var grid;
	
	$(function() {
		grid = window.lanyuan.ui.lyGrid();
	
	
		$("#search").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/list.html');
			f.submit();
		});
		$("#saveTemp").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			//if (cbox.length > 1) {
			//	parent.$.ligerDialog.alert("一次只能修改一条记录");
			//	return;
			//}
			for(var i=0;i<cbox.length;i++){
				var f = $('#'+cbox[i]+'_form');
				//document.getElementById(cbox[i]+'_form').target="iframet";
				f.attr('target','iframet');
				f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/saveTemp.html');
				f.submit();
			}
			alert("数据暂存成功");
		});
		$("#answer").click("click", function() {//绑定新增按扭
			var cbox=getSelectedCheckbox();
			
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			for(var i=0;i<cbox.length;i++){
				var f = $('#'+cbox[i]+'_form');
				//document.getElementById(cbox[i]+'_form').target="iframet";
				//f.attr('target','iframet');
				f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/answer.html?type=1');
				f.submit();
			}
			alert("开版进度已回成功");
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
	});
	function loadGird(){
		grid.loadData();
		$('#pageNow').attr('value',1);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action',window.location.href);
		f.submit();
	}
	function page(pageNO){
		$('#pageNow').attr('value',pageNO);
		var f = $('#fenye');
		//f.attr('target','_blank');
		f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/list.html');
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
	
	/***增加工厂编号**/
	function addFactoryCode(index){
		alert(index);
		document.getElementById(index+"factoryCode2").style.display='block';
		document.getElementById(index+"1factoryColor2").style.display='';
		document.getElementById(index+"2factoryColor2").style.display='';
		document.getElementById(index+"3factoryColor2").style.display='';
		document.getElementById(index+"jiahao2").style.display='';
		document.getElementById(index+"jiahao").innerHTML='';
	}
	function addColor(st,param){
		var flag=document.getElementById(st+"flag"+param).value;
		alert(st+""+flag+"factoryColor"+param);
		document.getElementById(st+""+flag+"factoryColor"+param).style.display='';
		document.getElementById(st+"flag"+param).value=parseInt(document.getElementById(st+"flag"+param).value)+parseInt(1);
	}
</script>
</head>
<body>
	<div class="divBody" style="width: 2000px">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<input type="hidden" id="status" name="status" value="0">
				工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;厂：&nbsp;
				      <select  id="factoryId" name="factoryId">
						<option value="">请选择工厂</option>
						<c:forEach items="${ factoryInfos }" var = "factoryInfo">
								<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
							</c:forEach>
					  </select>
			          布种：<select id="clothId" name="clothId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
			    <a class="btn btn-large btn-success" href="javascript:void(0)" id="search">
				查询
			</a>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-large btn-primary" href="javascript:void(0)" id="answer">
				已回
			</a>
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="saveTemp">
				暂存数据
			</a>
			
		</div>
		<div id="paging" class="pagclass">
			<table id="mytable" cellspacing="0" border="1" summary="The technical specifications of the Apple PowerMac G5 series">
				<tr >
					<th class="specalt" style="width:15px">
						<input type="checkbox" id="checkIds" name="checkIds">
					</th>
					<th class="specalt" style="width:50px">id</th>
					<th class="specalt" style="width:45px">日期</th>
					<th class="specalt" style="width:75px">分色文件号</th>
					<th class="specalt" style="width:75px">布种</th>
					<th class="specalt" style="width:105px">我司编号</th>
					<th class="specalt" style="width:100px">工厂</th>
					<th class="specalt" style="width:75px">工艺</th>
					<th class="specalt" style="width:110px">开版录入备注</th>
					<th class="specalt" style="width:110px">工厂编号</th>
					<th class="specalt" >工厂颜色</th>
					<th class="specalt">回版日期</th>
					<th class="specalt">备注</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
				<% int i=0; %>
					<tr>
					<form id="${item.id }_form" action="${ctx}/background/sample/add.html" method="post" enctype="multipart/form-data">
					 	<td>
					 		<input type="checkbox" id="checkId" name="checkId" value="${item.id }">
					 		<input type="hidden" id="id" name="id" value="${item.id }">
					 		<input type="hidden" id="fid" name="fid" value="${bean.factoryId }">
					 		<input type="hidden" id="cid" name="cid" value="${bean.clothId }">
					 	</td>
						<td>${item.id }</td>
						<td title="<fmt:formatDate value='${item.sampleDate }' pattern='yyyy-MM-dd'/>">
							<fmt:formatDate value='${item.sampleDate }' pattern='MM-dd'/>
						</td>
						<td>${item.fileCode }</td>
						<td>${item.clothName }</td>
						<td>
							<input type="text" id="myCompanyCode" name="myCompanyCode" style="width:100px" value="${item.myCompanyCode }">
						</td>
						<td>${item.factoryName }</td>
						<td>${item.technologyName }</td>
						<td title="${item.mark }">
							${fn:substring(item.mark,0,10)}  
							<c:if test="${fn:length(item.mark)>10}">...</c:if>
						</td>
						<td>
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<% i++; %>
								 <input type="text" id="${status.index }factoryCode${status1.index+1 }" style="width:80px" name="factoryCode${status1.index+1 }" value="${item1.key }">
							</c:forEach>
							<%if(i==0){ %>
								<input type="text" id="${status.index }factoryCode1" style="width:80px" name="factoryCode1" value="">
								<input type="text" id="${status.index }factoryCode2" style="width:80px;display: none" name="factoryCode2" value="">
							<%}if(i!=2){ %>
								<input type="text" id="${status.index }factoryCode2" style="width:80px;display: none" name="factoryCode2" value="">
								<span onclick="addFactoryCode(${status.index })" id="${status.index }jiahao" style="cursor:pointer;">+</span>
							<%} %>
						</td>
						<td>
						<% int f=1; %>						
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<% int ff=1; %>
							<div>
								<c:forEach var="item2" items="${item1.value}" varStatus="status2">
								<c:if test="${item2.factoryColor !=null }"><%f++; ff++;%>
									<input type="text" id="${status.index }${status2.index+1 }factoryColor${status1.index+1 }" name="factoryColor${status1.index+1 }" style="width:50px" value="${item2.factoryColor }">
								</c:if>
								</c:forEach>
								<% if(ff<9){ 
								  for(int s=ff;s<=9;s++){%>
									  <input type="text" id="${status.index }<%=s %>factoryColor${status1.index+1 }" name="factoryColor${status1.index+1 }" style="width:50px;display: none" value="">
								<%} }%>
								<span onclick="addColor(${status.index },${status1.index+1})" style="cursor:pointer;">+</span>
								<input type="hidden" id="${status.index }flag${status1.index+1}" value="<%=ff%>">
							</div>
							</c:forEach>
							<% if(f==1){ %>
							<div>
								<input type="text" id="${status.index }1factoryColor1" name="factoryColor1" style="width:50px" value="">
								<input type="text" id="${status.index }2factoryColor1" name="factoryColor1" style="width:50px" value="">
								<input type="text" id="${status.index }3factoryColor1" name="factoryColor1" style="width:50px" value="">
								<input type="text" id="${status.index }4factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }5factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }6factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }7factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }8factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }9factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<span onclick="addColor(${status.index },1)" style="cursor:pointer;">+</span>
								<input type="hidden" id="${status.index }flag1" value="4">
							</div>
							<div>
								<input type="text" id="${status.index }1factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }2factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }3factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }4factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }5factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }6factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }7factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }8factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }9factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<span onclick="addColor(${status.index },2)" id="${status.index }jiahao2" style="cursor:pointer;display: none">+</span>
								<input type="hidden" id="${status.index }flag2" value="4">
							</div>
						<%} if(f==3){%>
							<div>
								<input type="text" id="${status.index }1factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }2factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }3factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }4factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }5factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }6factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }7factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }8factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${status.index }9factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<span onclick="addColor(${status.index },2)" id="${status.index }jiahao2" style="cursor:pointer;display: none">+</span>
								<input type="hidden" id="${status.index }flag2" value="4">
							</div>
						<%} %>
						</td><td>
							<c:if test="${item.replyDate ==null }">
								<input type="text" id="replyDate" name="replyDate" style="width:70px" value="${replyDate }">
							</c:if><c:if test="${item.replyDate !=null }">
								<input type="text" id="replyDate" name="replyDate" style="width:70px" value="<fmt:formatDate value='${item.replyDate }' pattern='yyyy-MM-dd'/>">
							</c:if>
						</td><td>
							<input type="text" id="replyMark" name="replyMark" style="width:200px" value="${item.replyMark }">
						</td>
						</form>
					<tr>
				
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 20px">
					<td colspan="4" style="text-align: center">
						总${pageView.rowCount }条&nbsp;&nbsp;&nbsp;每页${pageView.pageSize }条&nbsp;&nbsp;&nbsp; 
						共${pageView.pageCount }页&nbsp;&nbsp;当前${pageView.pageNow }页</td>
					<td colspan="5" style="text-align: right">
						<a href="javascript:page(1)">首页</a>
						<a href="javascript:page(${pageView.pageNow-1>0?pageView.pageNow-1:1 })">上一页</a>
						<c:if test="${pageView.pageNow>2 }">
							...<a href="javascript:page(${pageView.pageNow-2 })">${pageView.pageNow-2 }</a>
						</c:if><c:if test="${pageView.pageNow>1 }">					
							<a href="javascript:page(${pageView.pageNow-1 })">${pageView.pageNow-1 }</a>
						</c:if>	
							<b><a href="javascript:page(${pageView.pageNow })">${pageView.pageNow }</a></b>
						<c:if test="${pageView.pageCount-1>=pageView.pageNow }">
							<a href="javascript:page(${pageView.pageNow+1 })">${pageView.pageNow+1 }</a>
						</c:if><c:if test="${pageView.pageCount-2>=pageView.pageNow }">
							<a href="javascript:page(${pageView.pageNow+2 })">${pageView.pageNow+2 }</a>...
						</c:if>
						<c:if test="${pageView.pageNow>=pageView.pageCount }">
							<a href="javascript:page(${pageView.pageNow })">下一页</a>
						</c:if><c:if test="${pageView.pageNow<pageView.pageCount }">
							<a href="javascript:page(${pageView.pageNow+1 })">下一页</a>
						</c:if>
						<a href="javascript:page(${pageView.pageCount })">尾页</a>
					</td>
				</tr>			
			</table><br>
		</div>
		
	</div>
</body>
<iframe id="iframet" ></iframe>
</html>	