<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
var object=null;
//单独验证某一个input  class="checkpass"
jQuery.validator.addMethod("checkpass", function(value, element) {
	 return this.optional(element) || ((value.length <= 16) && (value.length>=6));
}, "编号由6至16位字符组合构成");


	$(function() {
		$("form").validate({
			submitHandler : function(form) {//必须写在验证前面，否则无法ajax提交
				$(form).ajaxSubmit({//验证新增是否成功
					type : "post",
					dataType:"json",
					success : function(data) {
						if (data.flag == "true") {
							$.ligerDialog.success('提交成功!', '提示', function() {
								//这个是调用同一个页面趾两个iframe里的js方法
								//account是iframe的id
								parent.input.loadGird();
								closeWin();
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
			},
			rules : {
				name : {
					required : true,
					remote:{ //异步验证是否存在
						type:"POST",
						url: rootPath + '/background/salesman/isExist.html',
						data:{
							name:function(){return $("#name").val();}
						 }
						}
				}
			},
			messages : {
				name : {
					required : "请输入业务员名称",
				    remote:"该名称已经存在"
				}
			},
			errorPlacement : function(error, element) {//自定义提示错误位置
				$(".l_err").css('display','block');
				//element.css('border','3px solid #FFCCCC');
				$(".l_err").html(error.html());
			},
			success: function(label) {//验证通过后
				$(".l_err").css('display','none');
			}
		});
	});
	function popCloth(obj){
		object=obj;
		dialog = parent.$.ligerDialog.open({
			width : 550,
			height : 500,
			url : rootPath + '/background/cloth/addlist.html',
			title : "布种选择",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function popMyCompanyCode(obj){
		var clothId=obj.parentNode.parentNode.children[1].firstChild.value;
		var technologyId=obj.parentNode.parentNode.children[2].firstChild.value;
		object=obj;
		dialog = parent.$.ligerDialog.open({
			width : 550,
			height : 500,
			url : rootPath + '/background/flower/addMyCompanyCode.html?clothId='+clothId+'&technologyId='+technologyId,
			title : "我司编号选择",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function popMyCompanyColor(obj){
		var clothId=obj.parentNode.parentNode.children[1].firstChild.value;
		var technologyId=obj.parentNode.parentNode.children[2].firstChild.value;
		var companyCode=obj.parentNode.parentNode.children[3].firstChild.value;
		object=obj;
		dialog = parent.$.ligerDialog.open({
			width : 550,
			height : 500,
			url : rootPath + '/background/flower/addMyCompanyColor.html?clothId='+clothId+'&technologyId='+technologyId+'&companyCode='+companyCode,
			title : "我司编号选择",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	/**设置备注信息**/
	function addCloth(name,id){
		object.value=name;
		object.parentNode.parentNode.children[1].firstChild.value=id;
		
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/cloth/getClothUnit.html', //要访问的后台地址
		    data: {id:id}, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	object.parentNode.parentNode.children[6].innerHTML=data;
			},error : function() {    
		          alert("异常！");
		     } 
		});
	}
	/**设置备注信息**/
	function addData(data){
		object.value=data;
	}

	/**设置备注信息**/
	function addColorData(data){
		object.value=data;
		var clothId=object.parentNode.parentNode.children[1].firstChild.value;
		var technologyId=object.parentNode.parentNode.children[2].firstChild.value;
		var companyCode=object.parentNode.parentNode.children[3].firstChild.value;
		var myCompanyColor=data;
		if(checkNull(clothId)&&checkNull(companyCode)&&checkNull(myCompanyColor)){
			var param = {
						clothId:clothId,
						myCompanyCode:companyCode,
						technologyId:technologyId,
						myCompanyColor:myCompanyColor
						};
			$.ajax({
			    type: "post", //使用get方法访问后台
			    dataType: "json", //json格式的数据
			    async: false, //同步   不写的情况下 默认为true
			    url: rootPath + '/background/ordersummary/queryNoReturnNum.html', //要访问的后台地址
			    data: param, //要发送的数据
			    success: function(data){
			    	//alert(data);
			    	if(null==data){
			    		data='未下单';
			    	}
			    	object.parentNode.parentNode.children[9].innerHTML=data;
				},error : function() {
			          alert("异常！");
			    }
			});
		}
	}
	function clothIdCheck(){
		var b = true;
		$("#table1 input[name=clothId]").each(function(){
			var v = $(this).val();
			if(v==""){
				alert("请选择布种");
				b = false;
				return false;
			}
		});
		return b;
	}

	function salesmanIdCheck(){
		var b = true;
		$("#table1 select[name=salesmanId]").each(function(){
			var v = $(this).val();
			if(v==""){
				alert("请选择业务员");
				b = false;
				return false;
			}
		});
		return b;
	}
	function queryNoReturnNum($this){
		var $tr = $($this).parents("tr[name=initfirst]");
		var clothId=$($tr).find("select[name=clothId]").val();
		var myCompanyCode=$($tr).find("input[name=myCompanyCode]").val();
		var myCompanyColor=$($tr).find("input[name=myCompanyColor]").val();
		if(checkNull(clothId)&&checkNull(myCompanyCode)&&checkNull(myCompanyColor)){
		var param = {
					clothId:clothId,
					myCompanyCode:myCompanyCode,
					myCompanyColor:myCompanyColor
					};
			
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/ordersummary/queryNoReturnNum.html', //要访问的后台地址
		    data: param, //要发送的数据
		    success: function(data){
		    	if(null==data){
		    		data='未下单';
		    	}
		    	$($tr).find("td[name=sum]").html(data);
			},error : function() {    
		          alert("异常！");    
		     } 
		    });
		}
	}
	function checkNull(value){
		if(null==value||value==""){
			return false;
		}
		return true;
	}
	
	var i=2;
	$(document).ready(function(){
	    $("#addTable").click(function(){
	    	var tr=$("#table1 tr:eq(1) ");
	　  		$("#table1 tr:last").clone().insertAfter($("#table1 tr:last"));
	　  		var tr=$("#table1 tr:last");
	　  		var codeValue='<input id="codeValue" name="codeValue" class="isNum" type="text" value="" style="width: 100px;">';
	　  		var mark='<input type="text" id="mark" name="mark" style="width:200px;" value="双击选择备注信息" onblur="blurValue(this);" onclick="clearText(this);" ondblclick="pop(this)">';
	　  		tr.children('td').eq(1).html('<input type="hidden" name="clothId" value=""><input type="text" title="双击选择布种" name="clothName" value="" style="width: 110px;" ondblclick="popCloth(this)" readonly="readonly">');
	　  		tr.children('td').eq(3).html('<input type="text" title="双击选择我司编号" name="myCompanyCode" value="" style="width: 110px;" ondblclick="popMyCompanyCode(this)" readonly="readonly">');
	　  		tr.children('td').eq(4).html('<input type="text" title="双击选择我司颜色" name="myCompanyColor" value="" style="width: 110px;" ondblclick="popMyCompanyColor(this)" readonly="readonly">');
	　  		tr.children('td').eq(5).html('<input type="text"  name="num" value="" style="width: 80px">');
	　  		tr.children('td').eq(7).html('<input type="text" name="mark" value="">');
	　  		$("input[name='checkId']").attr("checked",false);
	    });
	    $('#copyone').click(function(){
	    	var i=0;
	    	var row='';
	    	var clothId="";
	    	var factoryId="";
	    	var newRow="";
	    	var codeType='';
	    	var teln='';
	    	var salman='';
	    	$('input:checkbox[name=checkId]:checked').each(function(){
	    		 i++;
	    		 row=$(this).parent().parent();
	    		 newRow=row.clone();
	    		 factoryId=row.find("select").eq(0).val();
	    		 clothId=row.find("select").eq(1).val();
	    		 codeType=row.find("select").eq(2).val();
	    		 teln=row.find("select").eq(3).val();
	    		 salman=row.find("select").eq(4).val();
	    		 
	    		 newRow.insertAfter($("#table1 tr:last"));
	    		 newRow.find("select").eq(0).attr("value",factoryId);
	    		 newRow.find("select").eq(1).attr("value",clothId);
	    		 newRow.find("select").eq(2).attr("value",codeType);
	    		 newRow.find("select").eq(3).attr("value",teln);
	    		 newRow.find("select").eq(4).attr("value",salman);
	    		 $("input[name='checkId']").attr("checked",false);
	    	});
	    	if(i==0){
	    		alert("请选择一条数据复制");
	    	}
	    });
	    $("#deleteTable").click(function(){
	    	var checkId=document.getElementsByName("checkId");
	    	for(var i=checkId.length-1;i>=0;i--){
	    		if(checkId[i].checked){
	    			checkId[i].parentNode.parentNode.parentNode.removeChild(checkId[i].parentNode.parentNode);
	    		}
	    	}
	    });
		$("#saveWin_form").click(function(){
			if(!clothIdCheck()){
				return false;
			}
			if(!salesmanIdCheck()){
				return false;
			}
			$.ajax({
				cache: true,
				type: "POST",
				url:rootPath + '/background/input/add.html',
				data:$('#form').serialize(),// 你的formid
				async: false,
			    error: function(request) {
			        alert("Connection error");
			    },
			    success: function(data) {
				    alert("保存成功");
				    location.href=rootPath+"/background/input/list.html";
			    }
			});
		});
		$("#fh").click(function(){
			location.href=rootPath+"/background/input/list.html";
		});
	});
	
	
</script>
</head>
<body>
<div class="divdialog">
	<div style="width: 1150px;">
		<table width="400px">
			<tr>
				<td style="width: 80px;">
					<a class="btn btn-primary" href="javascript:void(0)" id="copyone"><span>复制新增</span> </a>
				</td><td style="width: 80px;">
					<a class="btn btn-primary" href="javascript:void(0)" id="addTable"><span>新增一行</span> </a>
				</td><td style="width: 80px;">
					<a class="btn btn-primary" href="javascript:void(0)" style=width:60px;"
						id="saveWin_form" onclick="saveWin();"><span>保存</span> </a>
				</td>
				<td>
					<a class="btn btn-primary" href="javascript:void(0)" id="fh"><span>返回</span> </a>
				</td><td style="text-align: right;">
					<a class="btn btn-primary" href="javascript:void(0)" id="deleteTable" style="background-color: red;"><span>删除</span></a>
				</td>
			</tr>
		</table>
	</div>
	<form name="form" id="form" action="${ctx}/background/input/add.html" method="post">
		<table id="table1" border="1" name="table1">
			<tbody>
				<tr>
					<th style="height: 30px;width: 35px;text-align: center;">
						<input type="checkbox" id="checkAll" name="checkAll">
					</th>
					<th align="right" style="width: 110px;">布种</th>
					<th style="width: 100px;">工艺</th>
					<th align="right" style="width: 110px;">我司编号</th>
					<th align="right" style="width: 110px;">我司颜色</th>
					<th >数量</th>
					<th>单位</th>
					<th>备注</th>
					<th align="right">业务员</th>
					<th>未回数量</th>
				</tr><tr>
					<td style="text-align: center;">
						<input type="checkbox" id="checkId" name="checkId" value="1">
					</td>
					<td class="l_left" style="width: 110px;">
						<input type="hidden" name="clothId" value="${input.clothId}">
						<input type="text"  name="clothName" value="${input.clothName}" style="width: 110px;" ondblclick="popCloth(this)" readonly="readonly">
					</td><td class="l_left" style="width: 100px;">
						<select id="technologyId" name="technologyId" style="width:100px;">
							<c:forEach items="${ technologys }" var = "technology">
								<option <c:if test="${technology.id eq input.technologyId }">selected="selected"</c:if> value="${technology.id }">${technology.name}</option>
							</c:forEach>
						</select>
					</td>
					<td style="width:110px;">
						<input name="myCompanyCode" style="width:110px;" ondblclick="popMyCompanyCode(this)" value="${input.myCompanyColor }" readonly="readonly"/>
					</td><td class="l_left" style="width:110px;">
						<input type="text" name="myCompanyColor" style="width:110px;" value="${input.myCompanyColor }" ondblclick="popMyCompanyColor(this);" readonly="readonly">
					</td>
					<td >
						<input type="text" id="num" name="num" value="${input.num }" style="width: 80px">
					</td><td id="unit">
						条
					</td>
					<td><input type="text" id="mark" name="mark" value="${input.mark }"></td>
					<td>
						<select id="salesmanId" name="salesmanId" style="width:140px;">
							<option>请选择</option>
							<c:forEach items="${salesmanInfos }" var="saleman">
								<option value="${saleman.id }" <c:if test="${saleman.id==input.salesmanId }">selected="selected"</c:if> >${saleman.name }</option>
							</c:forEach>
						</select>
					</td>
					<td name="sum">0</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
	//initUnit(${input.clothId});
	var cloth=document.getElementById("clothId");
	//alert(${input.myCompanyCode});
	//initClothSelect(cloth,'${input.myCompanyCode}');
</script>
</html>