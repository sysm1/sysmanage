<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<!-- 开办录入查询 -->
<style type="text/css">

.ordersearchDivCss { 
	position: absolute; 
	z-index: 100; 
	display: block; 
	//background-color: #6ec1df; 
	padding-left: 150px;
}

/* CSS Document */

body {
 font: normal 13px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
}

a {color: #c75f3e;}

#mytable {
	width:1300px;
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
 padding: 3px 6px 6px 3px;
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
 padding: 3px 6px 2px;
 color: #4f6b72;
}

.lanyuan_bb{border-bottom: 1px solid #C1DAD7;}

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
		//grid = window.lanyuan.ui.lyGrid();
		$("#search").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/sampleProcessList/list.html');
			f.submit();
		});
		$("#saveTemp").click("click", function() {//绑定查询按扭
			var cbox=getSelectedCheckbox();
			
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			for(var i=0;i<cbox.length;i++){
				var f = $('#'+cbox[i]+'_form');
				//document.getElementById(cbox[i]+'_form').target="iframet";
				f.attr('target','iframet');
				f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/saveTemp.html');
				f.submit();
			}
			alert("数据暂存成功");
		});
		
		$("#addtoFlower").click("click",function(){
			var cbox=getSelectedCheckbox();
			if(cbox.length==1){				
				dialog = parent.$.ligerDialog.open({
					width : 750,
					height : 500,
					url : rootPath + '/background/sampleProcessList/addtoFlowerUI.html?id='+cbox[0],
					title : "添加到花号基本资料",
					isHidden : false
				});
			}else{
				alert("选择一条记录添加到花号基本资料");
			}
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
		$("#edit").click("click", function() {//绑定编辑按扭
			var cbox=getSelectedCheckbox();
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			if (cbox.length > 1) {
				parent.$.ligerDialog.alert("一次只能修改一条记录");
				return;
			}
			/**dialog = parent.$.ligerDialog.open({
				width : 950,
				height : 500,
				url : rootPath + '/background/sample/editUI.html?id='+cbox,
				title : "修改开版录入",
				isHidden : false
			});
			*/
			location.href=rootPath + '/background/sampleProcess/toUpdate.html?ids='+cbox
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
		f.attr('action','${pageContext.request.contextPath}/background/sampleProcessList/list.html');
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
	
	/***显示图片**/
	function show(id,sampId){
		document.getElementById(id).style.display="";
		var height=(document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2);
		if(height>16){
			height=16;
		}
		document.getElementById(id).style.top = height + "px"; 
		document.getElementById(id).src="${pageContext.request.contextPath}/background/pic/getPic.html?id="+sampId;
	}
	/***隐藏图片**/
	function hiddenDiv(id){
		document.getElementById(id).style.display="none";
	}
	
	function changeCheckId(obj){
		var id=obj.value;
		if(obj.checked){
			$.ajax({
			    type: "post", //使用get方法访问后台
			    dataType: "json", //json格式的数据
			    async: false, //同步   不写的情况下 默认为true
			    url: rootPath + '/background/sampleProcess/queryStatus.html', //要访问的后台地址
			    data: {id:id}, //要发送的数据
			    success: function(data){
			    	if(data==0){
			    		//$('#addtoFlower').hide();
			    		
			    	}else{
			    		$('#addtoFlower').show();
			    	}
				}
			});
		}else{
			$('#addtoFlower').show();
		}
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
</script>
</head>
<body style="width: 1250px;">
<div class="divBody" >
		<div class="search">
<form name="fenye" id="fenye">
	<input type="hidden" id="pageNow" name="pageNow" value="">
	<table>
		<tr>
			<td style="width:70px;text-align: right;">开版日期：</td>
			<td>
				<input type="text" id="startDate" name="startDate" value="<fmt:formatDate value='${bean.startDate}' pattern='yyyy-MM-dd'/>" style="width:91px;" 
					onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">至
				<input type="text" id="endDate" name="endDate" value="<fmt:formatDate value='${bean.endDate}' pattern='yyyy-MM-dd'/>" style="width:91px;"
					onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
			</td><td style="width:70px;text-align: right;">备注：</td>
			<td><input type="text" id="mark" name="mark" value="${bean.mark }" ></td>
			<td style="width:70px;text-align: right;">工厂：</td>
			<td>
				<!--select  id="factoryId" name="factoryId">
					<option value="">请选择工厂</option>
					<c:forEach items="${ factoryInfos }" var = "factoryInfo">
					<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
					</c:forEach>
				</select-->
				<input type="hidden" id="factoryId" name="factoryId" value="${ bean.factoryId }">
				<input type="text" id="factory_text" style="width: 200px;" value="${factoryInfo.name }" 
				  		onchange="changeTextValue('factoryId',this);"/>
			</td>
		 </tr>
			 <td style="width:70px;text-align: right;">回版日期：</td>
			 <td>
			 	<input type="text" id="rstartDate" name="rstartDate" value="<fmt:formatDate value='${bean.rstartDate}' pattern='yyyy-MM-dd'/>" style="width:91px;" 
					onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">至
				<input type="text" id="rendDate" name="rendDate" value="<fmt:formatDate value='${bean.rendDate}' pattern='yyyy-MM-dd'/>" style="width:91px;"
					onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
			</td><td style="width:70px;text-align: right;">编号：</td>
			<td>
			    <input type="text" id="codeValue" name="codeValue" value="${bean.codeValue }"/>
			</td><td style="width:70px;text-align: right;">布种：</td>
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
		</tr><tr>
			<td style="width:70px;text-align: right;">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</td>
			<td>
			    <select id="status" name="status">
			   	<option value="">请选择</option>
			   	<option value="0" <c:if test="${0 eq bean.status }">selected="selected"</c:if> >未回</option>
			   	<option value="1" <c:if test="${1 eq bean.status }">selected="selected"</c:if> >新版</option>
			   	<option value="2" <c:if test="${2 eq bean.status }">selected="selected"</c:if> >新厂</option>
			   	<option value="3" <c:if test="${3 eq bean.status }">selected="selected"</c:if> >新色</option>
			   	<option value="4" <c:if test="${4 eq bean.status }">selected="selected"</c:if> >重复</option>
			    </select>
			</td><td style="width:70px;text-align: right;">工艺：</td>
			<td>
			    <select id="technologyId" name="technologyId">
					<option value="">请选择工艺</option>
					<c:forEach items="${ technologyInfos }" var = "technologyInfo">
					<option <c:if test="${technologyInfo.id eq bean.technologyId }">selected="selected"</c:if> value="${technologyInfo.id }">${technologyInfo.name}</option>
					</c:forEach>
				</select>
			</td>
			<td colspan="2" align="right">&nbsp;</td>
		</tr>
	</table>
</form>
		</div>
		<div class="topBtn" style="width:800px;text-align: center">
			<a class="btn btn-large btn-primary" href="javascript:void(0)" id="edit">
				修改
			</a>
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="addtoFlower">
				添加到花号基本资料
			</a>
			 <a class="btn btn-large btn-success" href="javascript:void(0)" id="search">查询</a>
		</div>
		<div id="paging" class="pagclass">
			<table id="mytable" cellspacing="0" border="1" summary="The technical specifications of the Apple PowerMac G5 series">
				<tr style="height: 30px;">
					<th style="width:20px">
						<input type="checkbox" id="checkIds" name="checkIds" style="width:18px">
					</th>
					<th class="specalt"  style="width:35px">id</th>
					<th class="specalt" style="width:40px">状态</th>
					<th class="specalt" style="width:40px">日期</th>
					<th class="specalt" style="width:75px">分色文件号</th>
					<th  style="width:85px">布种</th>
					<th class="specalt" style="width:85px">我司编号</th>
					<th class="specalt" style="width:100px">工厂</th>
					<th class="specalt" style="width:75px">工艺</th>
					<th class="specalt" style="width:130px">开版录入备注</th>
					<th class="specalt" >工厂编号</th>
					<th  >工厂颜色</th>
					<th style="width:60px">回版日期</th>
					<th >备注</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
				<% int i=0; %>
					<tr style="height: 30px;">
					<form id="${item.id }_form" action="${ctx}/background/sample/add.html" method="post" enctype="multipart/form-data">
					 	<input type="hidden" id="id" name="id" value="${item.id }">
					 		<input type="hidden" id="fid" name="fid" value="${bean.factoryId }">
					 		<input type="hidden" id="cid" name="cid" value="${bean.clothId }">
					 	<td style="width: 20px;">
					 		<input type="checkbox" id="checkId" name="checkId" value="${item.id }" onclick="changeCheckId(this);" style="width:18px">
					 	</td>
						<td onmouseover="show('DivMain','${item.id}')" onmouseout="hiddenDiv('DivMain');">${item.id }</td>
						<td>
							<c:if test="${item.status eq 0 }">未回</c:if>
							<c:if test="${item.status eq 1 }">新版</c:if>
							<c:if test="${item.status eq 2 }">新厂</c:if>
							<c:if test="${item.status eq 3 }">新色</c:if>
							<c:if test="${item.status eq 4 }">重复</c:if>
						</td>
						<td title="<fmt:formatDate value='${item.sampleDate }' pattern='yyyy-MM-dd'/>">
							<fmt:formatDate value='${item.sampleDate }' pattern='MM-dd'/>
						</td>
						<td>${item.fileCode }</td>
						<td>${item.clothName }</td>
						<td>
							${item.myCompanyCode }
						</td>
						<td>${item.factoryName }</td>
						<td>${item.technologyName }</td>
						<td title="${item.mark }">
							${fn:substring(item.mark,0,8)}
							<c:if test="${fn:length(item.mark)>8}">...</c:if>
						</td>
						<td>
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								 ${item1.key }
							</c:forEach>
						</td>
						<td>
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<div>
								<c:forEach var="item2" items="${item1.value}" varStatus="status2">
								<c:if test="${item2.factoryColor !=null }">
									<c:if test="${status2.index>0 }">,</c:if>
									${item2.factoryColor }
								</c:if>
								</c:forEach>
							</div>
							</c:forEach>
						</td><td title="<fmt:formatDate value='${item.replyDate }' pattern='yyyy-MM-dd'/>">
							<fmt:formatDate value='${item.replyDate }' pattern='MM-dd'/>
						</td><td title="${item.replyMark }">
							${fn:substring(item.replyMark,0,10)}  
							<c:if test="${fn:length(item.replyMark)>10}">...</c:if>
						</td>
						</form>
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
  </ul>
</div></td>
				</tr>
			</table><br>
		</div>
		
	</div>
</body>
<img  src="" class="ordersearchDivCss" id="DivMain" style="display: none;max-height:95%;padding-left: 150px" />
<iframe id="iframet" name="iframet" style="display: none"></iframe>
</html>	