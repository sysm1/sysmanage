<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"	src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/ajaxfileupload.js"></script>
<%@ include file="/common/header.jsp"%>
<!-- 开办进度查询 -->

<style type="text/css">
.ordersearchDivCss { 
	position: absolute; 
	z-index: 100; 
	display: block; 
	padding-left: 150px;
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
 padding: 6px 6px 6px 6px;
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
 //background: #fff;
 font-size:12px;
 color: #4f6b72;
 padding: 1px 3px ;
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
		//grid = window.lanyuan.ui.lyGrid();
		$("#search").click("click", function() {//绑定查询按扭
			$('#pageNow').attr('value',1);
			$("#delay").attr('value','');
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
			for(var i=0;i<cbox.length;i++){
				/**
				var f = $('#'+cbox[i]+'_form');
				f.attr('target','iframe');
				f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/saveTemp.html');
				f.submit();
				*/
				
				var f = $('#'+cbox[i]+'_form');
				//f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/answer.html?type=1');
				//f.submit();
				$.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: '${pageContext.request.contextPath}/background/sampleProcess/saveTemp.html', //要访问的后台地址
				    data: f.serialize(), //要发送的数据
				    success: function(data){
				    	//alert(data);
					},error : function(XMLHttpRequest, textStatus, errorThrown,data) {    
						alert(XMLHttpRequest.status);
						alert(XMLHttpRequest.readyState);
						alert(data);  
				     }
				});
			}
			alert("数据暂存成功");
		});
		$("#answer").click("click", function() {//绑定新增按扭
			var cbox=getSelectedCheckbox();
			if(cbox==""){
				parent.$.ligerDialog.alert("请选择一条记录修改");
				return;
			}
			var flag='true';
			for(var i=0;i<cbox.length;i++){
				//alert(check(cbox[i]));
				if(!check(cbox[i])){
					flag='false';
					break;
				}
			}
			if(flag=='false'){
				return false;
			}
			for(var i=0;i<cbox.length;i++){
				if(check(cbox[i])){
					var f = $('#'+cbox[i]+'_form');
					//f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/answer.html?type=1');
					//f.submit();
					$.ajax({
					    type: "post", //使用get方法访问后台
					    dataType: "json", //json格式的数据
					    async: false, //同步   不写的情况下 默认为true
					    url: '${pageContext.request.contextPath}/background/sampleProcess/answer.html?type=1', //要访问的后台地址
					    data: f.serialize(), //要发送的数据
					    success: function(data){
					    	//alert(data);
						},error : function(XMLHttpRequest, textStatus, errorThrown,data) {    
							alert(XMLHttpRequest.status);
							alert(XMLHttpRequest.readyState);
							alert(data);  
					     }
					});
				}
			}
			alert("已回成功");
			location.reload();
		});
		$("#delaybtn").click("click", function() {//绑定编辑按扭
			$('#pageNow').attr('value',1);
			$("#delay").attr('value',1);
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/sampleProcess/list.html');
			f.submit();
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
		document.getElementById(index+"factoryCode2").style.display='block';
		document.getElementById(index+"1factoryColor2").style.display='';
		document.getElementById(index+"2factoryColor2").style.display='';
		document.getElementById(index+"3factoryColor2").style.display='';
		document.getElementById(index+"jiahao2").style.display='';
		document.getElementById(index+"jiahao").innerHTML='';
	}
	function addColor(st,param){
		var flag=document.getElementById(st+"flag"+param).value;
		//alert(st+""+flag+"factoryColor"+param);
		document.getElementById(st+""+flag+"factoryColor"+param).style.display='';
		document.getElementById(st+"flag"+param).value=parseInt(document.getElementById(st+"flag"+param).value)+parseInt(1);
	}
	/**已回按钮验证**/
	function check(id){
		var fileCode=document.getElementById(id+"fileCode");
		if(fileCode.value==''){
			alert("分色文件号不能为空！");
			fileCode.focus();
			return false;
		}
		var myCompanyCode=document.getElementById(id+"myCompanyCode");
		if(myCompanyCode.value==''){
			alert("我司编号不能为空！");
			myCompanyCode.focus();
			return false;
		}
		var factoryCode1=document.getElementById(id+"factoryCode1");
		var factoryCode2=document.getElementById(id+"factoryCode2");
		if(factoryCode1.value==''&&factoryCode2.value==''){
			alert("工厂编号不能为空");
			return false;
		}
		if(checkColor(id)=='false'){
			return false;
		}
		return true;
	}
	/**验证颜色**/
	function checkColor(id){
		for(var i=1;i<=9;i++){
			var fColor=document.getElementById(id+i+"factoryColor1");
			if(undefined!=fColor){
				if(fColor.value!=''){
					return true;
				}
			}
		}
		alert("工厂颜色不能为空！");
		return false;
	}
	
	/**改变默认值***/
	function changeValue(obj,id){
		document.getElementById(id).value=obj.value;
	}
	
	/**鼠标移动到行的颜色**/
	function changeTrColor(target){
		target.bgColor="#EEDC82";
	}
	
	/**鼠标移出时显示颜色**/
	function outTr(target){
		//alert(1);
		target.bgColor="";
	}
	/***点击时改变颜色*/
	function changeColorClick(target,id){
		target.bgColor="#eedc83";
		document.getElementById(id+"checkId").checked=true;
	}
	/***双点击时改变颜色*/
	function changeColorDClick(target,id){
		target.bgColor="";
		document.getElementById(id+"checkId").checked =false;
	}
	
	function show(id,sampId){
		document.getElementById(id).style.display="";
		var height=(document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2);
		if(height>16){
			height=16;
		}
		document.getElementById(id).style.top = height + "px"; 
		document.getElementById(id).src="${pageContext.request.contextPath}/background/pic/getPic.html?id="+sampId;
	}
	
	function hiddenDiv(id){
		document.getElementById(id).style.display="none";
	}
	
	/***点击**/
	function onclickTr(id){
		//obj.style.backgroundColor ="#EEDC82";
		for(var i=0;i<=12;i++){
			document.getElementById(i+"_"+id).style.backgroundColor ="#EEDC82";
		}
		document.getElementById(id+"checkId").checked=true;
	}
	/***选择一个checkbox**/
	function clickCheckId(id){
		var checkFlag=document.getElementById(id+"checkId").checked;
		if(checkFlag){
			for(var i=0;i<=12;i++){
				document.getElementById(i+"_"+id).style.backgroundColor ="#EEDC82";
			}
		}else{
			for(var i=0;i<=12;i++){
				document.getElementById(i+"_"+id).style.backgroundColor ="";
			}
		}
	}
	/**全选checkbox**/
	function checkAllIds(obj){
		var falg=obj.checked;
		var checkIds=document.getElementsByName("checkId");
		for(var i=0;i<checkIds.length;i++){
			checkIds[i].checked=falg;
			clickCheckId(checkIds[i].value);
		}
	}
	function changeTextValue(id,obj){
		if(obj.value==''){
			$('#'+id).attr('value','');
		}
	}
	
	/**图片上传**/
	function picUpload(id,index) {
		alert(id);
		$.ajaxFileUpload(
	            {
	                url: '/background/upload.html', //用于文件上传的服务器端请求地址
	                secureuri: false, //是否需要安全协议，一般设置为false
	                fileElementId: id, //文件上传域的ID
	                dataType: 'json', //返回值类型 一般设置为json
	                success: function (data, status)  //服务器成功响应处理函数 
	                // string res = "{ error:'" + error + "', msg:'" + msg + "',imgurl:'" + imgurl + "'}";
	                {
	                	/**
	                    $("#img1").attr("src", data.imgurl);
	                    if (typeof (data.error) != 'undefined') {
	                        if (data.error != '') {
	                            alert(data.error);
	                        } else {
	                            alert(data.msg);
	                        }
	                    }
	                    **/
	                    if( data.code == '0') {
	                    	alert(data.msg);
	                    } else {
	                    	$("#img1").attr("src", data.url);
	                    	$("#picture").val(data.picture);
	                    }
	                },
	                error: function (data, status, e)//服务器响应失败处理函数
	                {
	                    alert(e);
	                }
	            }
	        )
        return false;
    }
</script>
</head>
<body>
	<div class="divBody" style="width: 2000px">
		<div class="search">
			<form name="fenye" id="fenye">
				<input type="hidden" id="pageNow" name="pageNow" value="">
				<input type="hidden" id="status" name="status" value="0">
				<input type="hidden" id="delay" name="delay" value="">
				<table>
				<tr>
				<td>工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;厂：</td>
				      <!--select  id="factoryId" name="factoryId">
						<option value="">请选择工厂</option>
						<c:forEach items="${ factoryInfos }" var = "factoryInfo">
							<option <c:if test="${factoryInfo.id eq bean.factoryId }">selected="selected"</c:if> value="${factoryInfo.id }">${factoryInfo.name}</option>
						</c:forEach>
					  </select-->
			    <td>
			    	<input type="hidden" id="factoryId" name="factoryId" value="${ bean.factoryId }">
					<input type="text" id="factory_text" style="width: 200px;" value="${factoryInfo.name }" 
					  		onchange="changeTextValue('factoryId',this);"/>
			    </td><td>布种：</td>
			    <td><!--select id="clothId" name="clothId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select-->
						<input type="hidden" id="clothId" name="clothId" value="${ bean.clothId }">
					  	<input type="text" id="cloth_text" style="width: 200px;" value="${cloth.clothName }" 
					  		onchange="changeTextValue('clothId',this);"/>
			    </td>
				<td>
			    <a class="btn btn-large btn-success" href="javascript:void(0)" id="search">查询	</a>
			    </td>
			</tr>
			</table>
			</form>
		</div>
		<div class="topBtn">
			<a class="btn btn-large btn-primary" href="javascript:void(0)" id="answer">
				已回
			</a>&nbsp;
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="saveTemp">
				暂存数据
			</a>&nbsp;
			<a class="btn btn-large btn-success" href="javascript:void(0)" id="delaybtn" title="拖延单：${delayDates }单">
				拖延&nbsp;<span style="color: red">${delayDates }</span>&nbsp;单
			</a>
		</div>
		<div id="paging" class="pagclass">
			<table id="mytable" cellspacing="0" border="1" summary="The technical specifications of the Apple PowerMac G5 series">
				<tr >
					<th class="specalt" style="width:15px">
						<input type="checkbox" id="checkIds" name="checkIds" onclick="checkAllIds(this);">
					</th>
					<th class="specalt" style="width:50px">id</th>
					<th class="specalt" style="width:45px">日期</th>
					<th class="specalt" style="width:80px">分色文件号</th>
					<th class="specalt" style="width:75px">布种</th>
					<th class="specalt" style="width:248px">我司编号</th>
					<th class="specalt" style="width:100px">工厂</th>
					<th class="specalt" style="width:75px">工艺</th>
					<th class="specalt" style="width:110px">开版录入备注</th>
					<th class="specalt" style="width:110px">工厂编号</th>
					<th class="specalt"  style="min-width: 150px;">工厂颜色</th>
					<th class="specalt">回版日期</th>
					<th class="specalt">备注</th>
				</tr>
				<c:forEach var="item" items="${pageView.records }" varStatus="status">
				<% int i=0; %>
					<tr id="${item.id }_tr" >
					<form id="${item.id }_form" action="${ctx}/background/sample/add.html" method="post">
					 	<td id="0_${item.id }">
					 		<input type="checkbox" id="${item.id }checkId" name="checkId" onclick="clickCheckId(${item.id });" value="${item.id }" >
					 		<input type="hidden" id="id" name="id" value="${item.id }">
					 		<input type="hidden" id="fid" name="fid" value="${bean.factoryId }">
					 		<input type="hidden" id="cid" name="cid" value="${bean.clothId }">
					 		
					 		<input type="hidden" id="${item.id }fileCode" name="${item.id }fileCode" value="${item.fileCode}">
					 		<input type="hidden" id="${item.id }myCompanyCode" name="${item.id }myCompanyCode" value="${item.myCompanyCode }">
					 	</td>
						<td id="1_${item.id }" onclick="onclickTr(${item.id })" onmouseover="show('DivMain','${item.id}')" onmouseout="hiddenDiv('DivMain');">${item.id }</td>
						<td id="2_${item.id }" onclick="onclickTr(${item.id })" title="<fmt:formatDate value='${item.sampleDate }' pattern='yyyy-MM-dd'/>" >
							<fmt:formatDate value='${item.sampleDate }' pattern='MM-dd'/>
						</td>
						<td id="3_${item.id }" style="width:80px" >
							<input type="text" id="fileCode" name="fileCode" style="width:78px;" value="${item.fileCode }" 
								onchange="changeValue(this,'${item.id }fileCode');" onclick="onclickTr(${item.id })" >
						</td>
						<td id="4_${item.id }" onclick="onclickTr(${item.id })">${item.clothName }</td>
						<td id="5_${item.id }" onclick="onclickTr(${item.id })">
							<input type="text" id="myCompanyCode" name="myCompanyCode" style="width:90px" 
								onchange="changeValue(this,'${item.id }myCompanyCode')" value="${item.myCompanyCode }">
							<input type="file" id="9_myFile" name="myFile" style="width: 135px" onchange="picUpload('${item.id }_myFile',${item.id })">
							<input type="hidden" id="${item.id }_picture" name="picture" value="${item.picture }">
						</td>
						<td id="6_${item.id }" onclick="onclickTr(${item.id })">${item.factoryName }</td>
						<td id="7_${item.id }" onclick="onclickTr(${item.id })">${item.technologyName }</td>
						<td id="8_${item.id }" onclick="onclickTr(${item.id })" title="${item.mark }">
							${fn:substring(item.mark,0,10)}  
							<c:if test="${fn:length(item.mark)>10}">...</c:if>
						</td>
						<td id="9_${item.id }" onclick="onclickTr(${item.id })" style="width:120px" >
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<% i++; %>
								 <input type="text" id="${item.id }factoryCode${status1.index+1 }" style="width:80px" 
								 	onchange="changeValue(this,'${item.id  }factoryCode${status1.index+1 }')" name="factoryCode${status1.index+1 }" value="${item1.key }">
							</c:forEach>
							<%if(i==0){ %>
								<input type="text" id="${item.id }factoryCode1" style="width:80px" name="factoryCode1" value="">
								<input type="text" id="${item.id }factoryCode2" style="width:80px;display: none" name="factoryCode2" value="">
							<%}if(i!=2){ %>
								<input type="text" id="${item.id }factoryCode2" style="width:80px;display: none" name="factoryCode2" value="">
								<span onclick="addFactoryCode(${item.id })" id="${item.id  }jiahao" style="cursor:pointer;">+</span>
							<%} %>
						</td>
						<td id="10_${item.id }" onclick="onclickTr(${item.id })" style="min-width: 150px;">
						<% int f=1; %>						
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<% int ff=1; %>
							<div>
								<c:forEach var="item2" items="${item1.value}" varStatus="status2">
								<c:if test="${item2.factoryColor !=null }"><%f++; ff++;%>
									<input type="text" id="${item.id }${status2.index+1 }factoryColor${status1.index+1 }" 
										name="factoryColor${status1.index+1 }" style="width:50px" value="${item2.factoryColor }">
								</c:if>
								</c:forEach>
								<%if(ff>1){ %>
								<% if(ff<9){
								  for(int s=ff;s<=9;s++){%>
									  <input type="text" id="${item.id  }<%=s %>factoryColor${status1.index+1 }" name="factoryColor${status1.index+1 }" style="width:50px;display: none" value="">
								<%} }%>
								<span onclick="addColor(${item.id  },${status1.index+1})" style="cursor:pointer;">+</span>
								<input type="hidden" id="${item.id }flag${status1.index+1}" value="<%=ff%>">
								<%} %>
							</div>
							</c:forEach>
							<% if(f==1){ %>
							<div >
								<input type="text" id="${item.id  }1factoryColor1" name="factoryColor1" style="width:50px" value="">
								<input type="text" id="${item.id  }2factoryColor1" name="factoryColor1" style="width:50px" value="">
								<input type="text" id="${item.id  }3factoryColor1" name="factoryColor1" style="width:50px" value="">
								<input type="text" id="${item.id  }4factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }5factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }6factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }7factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }8factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }9factoryColor1" name="factoryColor1" style="width:50px;display: none" value="">
								<span onclick="addColor(${item.id  },1)" style="cursor:pointer;">+</span>
								<input type="hidden" id="${item.id  }flag1" value="4">
							</div>
							<div>
								<input type="text" id="${item.id  }1factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }2factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }3factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }4factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }5factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }6factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }7factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }8factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }9factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<span onclick="addColor(${item.id  },2)" id="${item.id  }jiahao2" style="cursor:pointer;display: none">+</span>
								<input type="hidden" id="${item.id  }flag2" value="4">
							</div>
						<%} if(f>1){%>
							<div>
								<input type="text" id="${item.id  }1factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }2factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }3factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }4factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }5factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }6factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }7factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }8factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<input type="text" id="${item.id  }9factoryColor2" name="factoryColor2" style="width:50px;display: none" value="">
								<span onclick="addColor(${item.id  },2)" id="${item.id  }jiahao2" style="cursor:pointer;display: none">+</span>
								<input type="hidden" id="${item.id  }flag2" value="4">
							</div>
						<%} %>
						</td><td id="11_${item.id }" onclick="onclickTr(${item.id })" style="width:75px">
							<c:if test="${item.replyDate ==null ||item.replyDate==''}">
								<input type="text" id="replyDate" name="replyDate" style="width:70px" value="${replyDate }"
									onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
							</c:if><c:if test="${item.replyDate !=null }">
								<input type="text" id="replyDate" name="replyDate" style="width:70px" 
									value="<fmt:formatDate value='${item.replyDate }' pattern='yyyy-MM-dd'/>"
									onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
							</c:if>
						</td><td id="12_${item.id }" onclick="onclickTr(${item.id })">
							<input type="text" id="replyMark" name="replyMark" style="width:200px" value="${item.replyMark }">
						</td>
						</form>
					<tr>
				
				</c:forEach>
				<!-- 分页 -->
				<tr style="height: 35px">
					<td colspan="4" style="text-align: center;font-size: 14px;">
						总${pageView.rowCount }条&nbsp;&nbsp;&nbsp;每页${pageView.pageSize }条&nbsp;&nbsp;&nbsp; 
						共${pageView.pageCount }页&nbsp;&nbsp;当前${pageView.pageNow }页</td>
					<td colspan="5" style="text-align: right;font-size: 14px;">
						<a href="javascript:page(1)">首页</a>
						<a href="javascript:page(${pageView.pageNow-1>0?pageView.pageNow-1:1 })">上一页</a>
						<c:if test="${pageView.pageNow>2 }">
							...<a href="javascript:page(${pageView.pageNow-2 })">${pageView.pageNow-2 }</a>
						</c:if><c:if test="${pageView.pageNow>1 }">					
							<a href="javascript:page(${pageView.pageNow-1 })">${pageView.pageNow-1 }</a>
						</c:if>	
							<b><a href="javascript:page(${pageView.pageNow })">[${pageView.pageNow }]</a></b>
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
						<a href="javascript:page(${pageView.pageCount })">尾页&nbsp;</a>
					</td>
				</tr>
			</table><br>
		</div>
		
	</div>
</body>
<img  src="" class="ordersearchDivCss" id="DivMain" style="display: none;max-height:95%;padding-left: 150px" />
<iframe id="iframe" name="iframe" style="display: none"></iframe>
</html>	