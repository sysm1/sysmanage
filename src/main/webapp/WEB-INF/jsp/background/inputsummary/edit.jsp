<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>下单预录入</title>
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">
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
								//parent.inputsummary.loadGird();
								//closeWin();
								location.href=rootPath+'/background/inputsummary/list.html';
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
		
		$("#myCompanyCode_text").ligerComboBox({
            url: '/background/pinyin/factory.html',
            valueField: 'id',
            textField: 'name', 
            selectBoxWidth: 110,
            autocomplete: true,
            width: 110,
            onSelected:function(e) {
            	alert(e);
                //$("#factoryId").val(e);
            }
       });
		
	});
	function saveWin() {
		var table =document.getElementById("table1");
		var rows = table.rows.length;
		//alert(rows);
		var row=null;
		//var valueTd=document.getElementById ("tbl").rows [1].cells[2];
		
		if(rows==2){
			var clothIds=document.getElementsByName("clothId");
			if(clothIds[0].value==''){
				alert("请选择布种");
				return false;
			}
			var salesmanIds=document.getElementsByName("salesmanId");
			if(salesmanIds[0].value==''){
				alert("请选择业务员");
				return false;
			}
		}
		
		for(var i=1;i<rows;i++){
			row=table.rows[i];
			//alert(row.cells[2].innerHTML);
			//alert(row.cells[2].childNodes[0].value);
			if(row.cells[1].childNodes[0].value==''){
				alert("请选择布种");
				row.cells[1].childNodes[0].focus();
				return false;
			}
			//alert(row.cells[2].childNodes[0].value);
			/*if(row.cells[2].childNodes[0].value==''){
				alert("请选择我司编号");
				row.cells[2].childNodes[0].focus();
				return false;
			}if(row.cells[3].childNodes[0].value==''){
				alert("请选择我司颜色");
				row.cells[3].childNodes[0].focus();
				return false;
			}
			*/if(row.cells[5].childNodes[0].value==''){
				alert("请添加下单数量");
				row.cells[5].childNodes[0].focus();
				return false;
			}if(row.cells[8].childNodes[0].value==''){
				alert("请选择业务员");
				row.cells[8].childNodes[0].focus();
				return false;
			}
		}
		$("#form").submit();
	}
	
	
	var i=2;
	$(document).ready(function(){
	    $("#addTable").click(function(){
	  		var newtr=$("#table1 tr:last").clone();
	  		newtr.insertAfter($("#table1 tr:last"))
	  		var select='<select id="myCompanyCode" name="myCompanyCode" style="width:99%;" onchange="queryNoReturnNum(this)">'+
				'<option value="">请选择</option>'+
				'</select>';
	  		newtr.find("input").eq(0).attr("value",'');
	　  		newtr.find("input").eq(1).attr("value",'');
	　  		newtr.find("input").eq(2).attr("value",'');
	　  		newtr.find("input").eq(3).attr("value",'');
	　  		newtr.find("input").eq(4).attr("value",'');
	　  		$("input[name='checkId']").attr("checked",false);
	    });
	    $('#copyone').click(function(){
	    	var row='';
	    	var clothId="";
	    	var factoryId="";
	    	var newRow="";
	    	var codeType='';
	    	var teln='';
	    	var salman='';
	    	var i=0;
	    	$('input:checkbox[name=checkId]:checked').each(function(){
	    		 i++;
	    		 //alert($(this).parent().parent());
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
	});
	
	
	/**改变布种的值时联动**/
	function changeClothSelect(obj){
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/cloth/getClothUnit.html', //要访问的后台地址
		    data: {id:obj.value}, //要发送的数据
		    success: function(data){
		    	changeUnitName(data,obj);
			},error : function() {    
		          // view("异常！");    
		          alert("异常！");    
		     } 
		});
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/sample/queryMycompanyCodeByCloth.html', //要访问的后台地址
		    data: {clothId:obj.value}, //要发送的数据
		    success: function(data){
		    	var td2 = obj.parentNode.parentNode.children[2];
		    	if(data!=null&&data!=''){
			    	var selectb=null;
			    	var selecte=null;
			    	var options='';
			    	selectb='<select id="myCompanyCode" name="myCompanyCode" style="width:99%;" onchange="queryNoReturnNum(this)">';
			    	for(var i=0;i<data.length;i++){
			    		if(null!=data[i]){
			    			options+='<option value="'+data[i]+'">'+data[i]+'</option>';
			    		}
			    	}
			    	selecte='</select>';
			    	td2.innerHTML=selectb+options+selecte;
		    	}else{
		    		td2.innerHTML='<input type="text" id="myCompanyCode" name="myCompanyCode" value="" style="width:92%;">';
		    	}
			},error : function() {    
		          // view("异常！");
		          alert("异常！");    
		     } 
		});
	}
	
	function changeUnitName(name,obj){
		if(name=='包'){
			name="KG";
		}
		obj.parentNode.parentNode.children[5].innerHTML=name;
	}
	
	/**查询未回数量**/
	function queryNoReturnNum(obj){
		var clothId=obj.parentNode.parentNode.children[1].childNodes[0].value;
		var myCompanyCode=obj.parentNode.parentNode.children[2].childNodes[0].value;
		var myCompanyColor=obj.parentNode.parentNode.children[3].childNodes[0].value;
		if(checkNull(clothId)&&checkNull(myCompanyCode)&&checkNull(myCompanyColor)){
			$.ajax({
			    type: "post", //使用get方法访问后台
			    dataType: "json", //json格式的数据
			    async: false, //同步   不写的情况下 默认为true
			    url: rootPath + '/background/ordersummary/queryNoReturnNum.html', //要访问的后台地址
			    data: {clothId:clothId,myCompanyCode:myCompanyCode,myCompanyColor:myCompanyColor}, //要发送的数据
			    success: function(data){
			    	if(null==data){
			    		data='未下单';
			    	}
			    	obj.parentNode.parentNode.children[8].innerHTML=data;
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
	var object=null;
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
	/**设置布种信息**/
	function addCloth(name,id){
		object.value=name;
		object.parentNode.parentNode.childNodes[1].childNodes[0].value=id;
		
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
		
		$.ajax({
		    type: "post", //使用get方法访问后台
		    dataType: "json", //json格式的数据
		    async: false, //同步   不写的情况下 默认为true
		    url: rootPath + '/background/flower/queryTechnology.html', //要访问的后台地址
		    data: {clothId:id}, //要发送的数据
		    success: function(data){
		    	//alert(data);
		    	var vvv='<select  name="technologyId" style="width:100px;">';
		    	for(var i=0;i<data.length;i++){
		    		vvv+='<option  value="'+data[i].id+'">'+data[i].name+'</option>';
		    	}
		    	vvv+='</select>';
		    	//alert(vvv);
		    	object.parentNode.parentNode.children[2].innerHTML=vvv;
			},error : function() {    
		          alert("异常！");
		     } 
		});
	}
	function popMyCompanyCode(obj){
		var clothId=obj.parentNode.parentNode.cells[1].childNodes[0].value;
		if(clothId==''||clothId==undefined){
			alert("请选择布种");
			return false;
		}
		var technologyId=obj.parentNode.parentNode.cells[2].childNodes[0].value1;
		if(technologyId==undefined){
			technologyId=obj.parentNode.parentNode.cells[2].innerHTML;
			//alert(technologyId);
			technologyId=technologyId.split("selected value=")[1].split(">")[0];
		}
		object=obj;
		dialog = parent.$.ligerDialog.open({
			width : 550,
			height : 500,
			url : '/background/flower/addMyCompanyCode.html?clothId='+clothId+'&technologyId='+technologyId,
			title : "我司编号选择",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function popMyCompanyColor(obj){
		var clothId=obj.parentNode.parentNode.children[1].firstChild.value;
		clothId=obj.parentNode.parentNode.cells[1].childNodes[0].value;
		if(clothId==''||clothId==undefined){
			alert("请选择布种");
			return false;
		}
		var technologyId=obj.parentNode.parentNode.cells[2].childNodes[0].value;
		var companyCode=obj.parentNode.parentNode.cells[3].childNodes[0].value;
		companyCode=encodeURI(encodeURI(companyCode));
		object=obj;
		dialog = parent.$.ligerDialog.open({
			width : 550,
			height : 500,
			url : rootPath + '/background/flower/addMyCompanyColor.html?clothId='+clothId+'&technologyId='+technologyId+'&code='+companyCode,
			//url : rootPath + '/background/flower/addMyCompanyColor.html',
			title : "我司编号选择",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	function addData(data){
		object.value=data;
	}
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
</script>
</head>
<body>
<div class="divdialog">
	<div style="width: 1145px;">
		<table width="450px">
			<tr>
				<!--td style="width: 80px;">
					<a class="btn btn-primary" href="javascript:void(0)" id="copyone"><span>复制新增</span> </a>
				</td><td style="width: 80px;">
					<a class="btn btn-primary" href="javascript:void(0)" id="addTable"><span>新增一行</span> </a>
				</td--><td style="width: 80px;">
					<a class="btn btn-primary" href="javascript:void(0)" style=width:60px;"
						id="saveWin_form" onclick="saveWin();"><span>保存</span> </a>
				</td><!--td style="text-align: right;">
					<a class="btn btn-primary" href="javascript:void(0)" id="deleteTable" style="background-color: red;"><span>删除</span></a>
				</td-->
			</tr>
		</table>
	</div>
	<form name="form" id="form" action="${ctx}/background/input/update2.html" method="post">
	<input type="hidden" id="insumId" name="insumId" value="${insumId}">
	<table><tr><td valign="top">
		<table id="table1" border="1" name="table1" class="dataintable">
			<tbody>
				<tr>
					<th style="height: 30px;width: 40px;text-align: center;">
						<input type="checkbox" id="checkAll" name="checkAll">
					</th>
					<th align="right" style="width: 100px;">布种</th>
					<th align="right" style="width: 100px;">工艺</th>
					<th align="right" style="width: 110px;">我司编号</th>
					<th align="right">我司颜色</th>
					<th >数量</th>
					<th style="width: 35px;text-align: center">单位</th>
					<th>备注</th>
					<th align="right">业务员</th>
					<th>未回数量</th>
				</tr>
				<c:forEach items="${list }" var="input">
				<tr>
					<td style="width: 40px;text-align: center;" >
						<input type="checkbox" id="checkId" name="checkId" value="1">
						<input type="hidden" id="id" name="id" value="${input.id }">
					</td>
					<td class="l_left" style="width: 100px;" title="双击选择布种">
						<input type="hidden" name="clothId" value="${input.clothId }">
						<input type="text"  name="clothName" value="${input.clothName }" style="width: 110px;" ondblclick="popCloth(this)" readonly="readonly">
					</td><td class="l_left" style="width: 100px;">
						<select id="technologyId" name="technologyId" style="width:110px;">
							<c:forEach items="${ technologys }" var = "technology">
								<option <c:if test="${technology.id eq input.technologyId }">selected="selected"</c:if> value="${technology.id }">${technology.name}</option>
							</c:forEach>
						</select>
					</td>
					<td name="companyCode" title="双击选择我司编号">
						<input type="text" name="myCompanyCode" style="width:110px;" value="${input.myCompanyCode }" ondblclick="popMyCompanyCode(this)" readonly="readonly"/>
					</td>
					<td title="双击选择我司颜色">
						<input type="text" name="myCompanyColor" style="width:110px;" value="${input.myCompanyColor }" ondblclick="popMyCompanyColor(this);" readonly="readonly">
					</td>
					<td >
						<input type="text" id="num" name="num" value="${input.num }" style="width: 80px">
					</td><td style="font-weight: bold;text-align: center;">
						${input.unitName }
					</td>
					<td><input type="text" id="mark" name="mark" value="${input.mark }"></td>
					<td>
						<select id="salesmanId" name="salesmanId" style="width:100px;">
							<option value="">请选择</option>
							<c:forEach items="${salesmanInfos }" var="saleman">
								<option value="${saleman.id }" <c:if test="${input.salesmanId== saleman.id}">selected="selected"</c:if> >${saleman.name }</option>
							</c:forEach>
						</select>
					</td>
					<td>0</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		</td>
		<!--td>
			图片预览<img alt="" src="http://d.hiphotos.baidu.com/baike/w%3D268/sign=9855e88c3912b31bc76cca2fbe1a3674/a8ec8a13632762d01cdbd074a0ec08fa503dc610.jpg">
		</td-->
		</tr></table>
	</form>
	</div>
</body>
</html>