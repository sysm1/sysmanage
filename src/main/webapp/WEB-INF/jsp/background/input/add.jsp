<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>下单预录入</title>
<%@ include file="/common/header.jsp"%>
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
                 // alert($("#factoryId").val());
            }
       });
		
	});
	function saveWin() {
		var table =document.getElementById("table1");
		var rows = table.rows.length;
		var row=null;
		//var valueTd=document.getElementById ("tbl").rows [1].cells[2];
		for(var i=1;i<rows;i++){
			row=table.rows[i];
			//alert(row.cells[2].childNodes[0].value);
			if(row.cells[1].childNodes[0].value==''){
				alert("请选择布种");
				row.cells[1].childNodes[0].focus();
				return false;
			}if(row.cells[2].childNodes[0].value==''){
				alert("请选择我司编号");
				row.cells[2].childNodes[0].focus();
				return false;
			}if(row.cells[3].childNodes[0].value==''){
				alert("请选择我司颜色");
				row.cells[3].childNodes[0].focus();
				return false;
			}if(row.cells[4].childNodes[0].value==''){
				alert("请添加下单数量");
				row.cells[4].childNodes[0].focus();
				return false;
			}if(row.cells[7].childNodes[0].value==''){
				alert("请选择业务员");
				row.cells[7].childNodes[0].focus();
				return false;
			}
		}
		$("#form").submit();
	}
	
	
	var i=2;
	$(document).ready(function(){
	    $("#addTable").click(function(){
	    	var tr=$("#table1 tr:eq(2) ");
			i++;
	  		$("#table1 tr:last").clone().insertAfter($("#table1 tr:last"));
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
		    	//$("#myCompanyCode").empty();
		    	//alert(obj.parentNode.parentNode.children[2].childNodes[0]);
		    	var select = obj.parentNode.parentNode.children[2].childNodes[0];
		    	var sl=select.options.length-1;
		    	//alert(select.options.length);
		    	for(var i=sl;i>0;i--){
		    		select.options.remove(i);
		    	}
		    	for(var i=0;i<data.length;i++){
		    		//alert(i);
		    		if(null!=data[i]){
		    			select.options.add(new Option(data[i],data[i]));
		    		}
		    		//select.append("<option value='"+data[i].myCompanyCode+"'>"+data[i].myCompanyCode+"</option>");
		    	}
			},error : function() {    
		          // view("异常！");    
		          alert("异常！");    
		     } 
		});
	}
	
	function changeUnitName(name,obj){
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
	
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 1270px;"></div>
	<form name="form" id="form" action="${ctx}/background/input/add.html" method="post">
	<table><tr><td valign="top">
		<table id="table1" border="1" name="table1">
			<tbody>
				<tr>
					<th>
						<input type="checkbox" id="checkAll" name="checkAll">
					</th>
					<th align="right">布种</th>
					<th align="right">我司编号</th>
					<th align="right">我司颜色</th>
					<th >数量</th>
					<th>单位</th>
					<th>备注</th>
					<th align="right">业务员</th>
					<th>未回数量</th>
				</tr><tr>
					<td>
						<input type="checkbox" id="checkId" name="checkId" value="1">
					</td>
					<td class="l_left">
						<select id="clothId" name="clothId" onchange="changeClothSelect(this);" style="width:110px;">
							<option value="">请选择</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option <c:if test="${cloth.id eq bean.clothId }">selected="selected"</c:if> value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						
						<select id="myCompanyCode" name="myCompanyCode" style="width:150px;" onchange="queryNoReturnNum(this)">
							<option value="">请选择</option>
						</select>
						
						
						<!--input type="hidden" value="" id="myCompanyCode" name="myCompanyCode">
						<input type="text" id="myCompanyCode_text" style="width: 110px;"/-->
						
					</td><td class="l_left">
						<input type="text" name="myCompanyColor" style="width:150px;" value="" onchange="queryNoReturnNum(this)">
					</td>
					<td >
						<input type="text" id="num" name="num" value="" style="width: 80px">
					</td><td>
						条
					</td>
					<td><input type="text" id="mark" name="mark" value=""></td>
					<td>
						<select id="salesmanId" name="salesmanId" style="width:140px;">
							<option value="">请选择</option>
							<c:forEach items="${salesmanInfos }" var="saleman">
								<option value="${saleman.id }">${saleman.name }</option>
							</c:forEach>
						</select>
					</td>
					<td>0</td>
				</tr>
			</tbody>
		</table>
		<table width="850px">
			<tr>
				<td>
					<div class="l_btn_centent">
						<!-- saveWin_form   from是表单Ｉd-->
						<!--a class="btn btn-primary" href="javascript:void(0)" id="copyaddTable"><span>复制新增</span> </a-->
						<a class="btn btn-primary" href="javascript:void(0)" id="addTable"><span>新增一行</span> </a>
						<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();"><span>保存</span> </a>
						<a class="btn btn-primary" href="javascript:void(0)" id="closeWin" onclick="closeWin()"><span>关闭</span> </a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="btn btn-primary" href="javascript:void(0)" id="deleteTable" ><span>删除</span></a>
					</div>
				</td>
			</tr>
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