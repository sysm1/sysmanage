<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="${ctx}/js/ajaxfileupload.js"></script>
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
							location.href='${ctx}/background/sample/list.html';
							//parent.sample.loadGird();
							//closeWin();
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

	function saveWin() {
		var factoryIds =document.getElementsByName("factoryId");
		for(var i=0;i<factoryIds.length;i++){
			if(factoryIds[i].value==""){
				alert("请选择工厂");
				factoryIds[i].focus();
				return false;
			}
		}
		var clothId =document.getElementsByName("clothId");
		for(var i=0;i<clothId.length;i++){
			if(clothId[i].value==""){
				alert("请选择布种");
				clothId[i].focus();
				return false;
			}
		}
		var codeType =document.getElementsByName("codeType");
		for(var i=0;i<codeType.length;i++){
			if(codeType[i].value==""){
				alert("请选择编号类型");
				codeType[i].focus();
				return false;
			}
		}
		var codeValue =document.getElementsByName("codeValue");
		for(var i=0;i<codeValue.length;i++){
			if(codeValue[i].value==""){
				alert("请填写编号值");
				codeValue[i].focus();
				return false;
			}
		}
		
		/*var technologyId =document.getElementsByName("technologyId");
		for(var i=0;i<technologyId.length;i++){
			if(technologyId[i].value==""){
				alert("请选择工艺");
				technologyId[i].focus();
				return false;
			}
		}*/
		var myFile =document.getElementsByName("myFile");
		for(var i=0;i<myFile.length;i++){
			if(myFile[i].value==""){
				alert("请上传图片");
				myFile[i].focus();
				return false;
			}
		}
		var salemanId =document.getElementsByName("salemanId");
		for(var i=0;i<salemanId.length;i++){
			if(salemanId[i].value==""){
				alert("请选择业务员");
				salemanId[i].focus();
				return false;
			}
		}
		var mark =document.getElementsByName("mark");
		for(var i=0;i<mark.length;i++){
			if(mark[i].value==""||mark[i].value=="双击选择备注信息"){
				alert("请填写备注");
				mark[i].focus();
				return false;
			}
		}
		$("#form").submit();
		//alert('保存成功');
		//location.href='${ctx}/background/sample/list.html';
	}
	
	/** 
	* 从 file 域获取 本地图片 url 
	*/ 
	function getFileUrl(sourceId) { 
		var url; 
		if (navigator.userAgent.indexOf("MSIE")>=1) { // IE 
			url = document.getElementById(sourceId).value; 
		} else if(navigator.userAgent.indexOf("Firefox")>0) { // Firefox 
			url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
		} else if(navigator.userAgent.indexOf("Chrome")>0) { // Chrome 
			url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
		} 
		return url; 
	} 
	
	/**图片预览	*/
	function showPic(id,obj){
		//alert(obj.value+"||"+id+"||"+document.getElementById("picture").value);
		var url = document.getElementById("picture").value;
		//alert(url);
		//document.getElementById("pictd").innerHTML=url;
		document.getElementById("viewpic").src=url;
	}
	
	
	function PreviewImage(imgFile){ 
	    var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)|(\.*.bmp$)/;      
	    if(!pattern.test(imgFile.value)) { 
	      alert("系统仅支持jpg/jpeg/png/gif/bmp格式的照片！");  
	      imgFile.focus(); 
	    }else { 
	    	var path; 
	     	if(document.all){//IE 	      
		        imgFile.select(); 
		        path = document.selection.createRange().text; 
		        document.getElementById("imgPreview").innerHTML=""; 
		        document.getElementById("imgPreview").style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + path + "\")";//使用滤镜效果 
	        } else{//FF 
		        path = URL.createObjectURL(imgFile.files[0]);
		        document.getElementById("imgPreview").innerHTML = "<img src='"+path+"'/>"; 
	     	} 
	    } 
	}
	
	var i=2;
	$(document).ready(function(){
	    $("#addTable").click(function(){
	    	var tr=$("#table1 tr:eq(2) ");
			
	　  		$("#table1 tr:last").clone().insertAfter($("#table1 tr:last"));
	　  		var tr=$("#table1 tr:last");
	　  		var codeValue='<input id="codeValue" name="codeValue" class="isNum" type="text" value="" style="width: 100px;">';
	　  		var mark='<input type="text" id="mark" name="mark" style="width:200px;" value="双击选择备注信息" onblur="blurValue(this);" onclick="clearText(this);" ondblclick="pop(this)">';
	　  		var picture='<input type="file" id="'+i+'pic"  name="file" style="width: 135px" onchange="ajaxFileUpload(this)">'+
	   			'<input type="hidden" id="'+i+'pic_picture" name="picture" value="">'+
				'<input type="hidden" id="'+i+'pic_smallPicture" name="smallPicture" value="">';
	　  		tr.children('td').eq(5).html(codeValue);
	　  		tr.children('td').eq(7).html(picture);
	　  		tr.children('td').eq(9).html(mark);
	　  		$("input[name='checkId']").attr("checked",false);
	　  		i++;
	    });
	    $("#deleteTable").click(function(){
	    	var checkId=document.getElementsByName("checkId");
	    	for(var i=checkId.length-1;i>=0;i--){
	    		if(checkId[i].checked){
	    			checkId[i].parentNode.parentNode.parentNode.removeChild(checkId[i].parentNode.parentNode);
	    		}
	    	}
	    });
	    $('#copyone').click(function(){
	    	var row='';
	    	var clothId="";
	    	var factoryId="";
	    	var newRow="";
	    	var codeType='';
	    	var teln='';
	    	var salman='';
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
	    		 
	    		 var picture='<input type="file" id="'+i+'pic"  name="file" style="width: 135px" onchange="ajaxFileUpload(this)">'+
		   			'<input type="hidden" id="'+i+'pic_picture" name="picture" value="">'+
					'<input type="hidden" id="'+i+'pic_smallPicture" name="smallPicture" value="">';
				 newRow.children('td').eq(7).html(picture);
				 //alert(1);
	    		 //alert(newRow.find("file").eq(0).attr("id",i));
	    		 //alert(newRow.find("file").eq(0).attr('id'));
	    		 //newRow.find("file").eq(0).attr("value",row.find("file").eq(0).val());
	    	});
	    	if(i==0){
	    		alert("请选择一条数据复制");
	    	}
	    });
	});
	/**
	 * 获取选中的值
	 */
	function getSelectedCheckbox() {
		var arr = [];
		$('input[name="checkId"]:checked').each(function() {
			arr.push($(this));
		});
		return arr;
	};
	var object=null;
	function pop(obj){
		//alert(obj);
		//var arr = showModalDialog("${ctx}/background/mark/addlist.html", "", "dialogWidth:500px; dialogHeight:400px; status:0");
		//if (arr != null&&arr!=''){
			//alert(arr);
		//	obj.value=arr;
		//}
		object=obj;
		dialog = parent.$.ligerDialog.open({
			width : 550,
			height : 500,
			url : rootPath + '/background/mark/addlist.html',
			title : "开版录入",
			isHidden:false   //关闭对话框时是否只是隐藏，还是销毁对话框
		});
	}
	/**设置备注信息**/
	function addMark(data){
		object.value=data;
	}
	
	function clearText(obj){
		if(obj.value=="双击选择备注信息"){
			obj.value="";
		}
	}
	
	function blurValue(obj){
		if(obj.value==''){
			obj.value="双击选择备注信息";
		}
	}
	/**图片上传**/
	function ajaxFileUpload(obj) {
		var id=obj.id;
		var mycompanyCode='';
		var factoryCode='';
		if($('#codeType').val()==2){
			mycompanyCode=$('#codeValue').val();
		}else if($('#codeType').val()==1){
			factoryCode=$('#codeValue').val();
		}
		//alert(obj.id);
        $.ajaxFileUpload({
             url: rootPath+'/background/upload.html?myCompanyCode='+mycompanyCode+"&factoryCode1="+factoryCode, //用于文件上传的服务器端请求地址
             secureuri: false, //是否需要安全协议，一般设置为false
             fileElementId: obj.id, //文件上传域的ID
             dataType: 'json', //返回值类型 一般设置为json
             success: function (data, status){  //服务器成功响应处理函数 
            	 //alert(data);
                 if( data.code == '0') {
                 	alert(data.msg);
                 } else {
                 	//alert(data.picture.split("|")[0]);
                 	var pics=data.picture;
                 	//$("#img1").attr("src", data.url);
                 	//alert($("#"+obj.id+"_picture").attr("value"));
                 	//alert(document.getElementById(id+"_picture").value);
                 	document.getElementById(id+"_picture").value=pics.split("|")[0];
                 	document.getElementById(id+"_smallPicture").value=pics.split("|")[1];
                 	//$("#"+id+"_picture").attr("value",pics.split("|")[0]);
                 	//$("#"+obj.id+"_smallPicture").attr("value",pics.split("|")[1]);
                 	//alert(document.getElementById(id+"_picture").value);
                 }
             },
             error: function (data, status, e)//服务器响应失败处理函数
             {
                 alert(e);
             }
         } );
        return false;
    }
</script>
</head>
<body style="width: 1100px;">
<div class="divdialog">
<div style="padding-left: 350px;height: 30px;font-size: 16px;"><b>开版录入</b></div>
	<div >
<table width="400px;" border="0" >
	<tr>
		<td style="width: 80px;">
			<a class="btn btn-primary" href="javascript:void(0)" id="copyone" ><span>复制新增</span></a>
		</td><td style="width: 80px;">
			<a class="btn btn-primary" href="javascript:void(0)" id="addTable" ><span>新增一行</span></a>
		</td><td style="width: 60px;">
			<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" 
				 onclick="saveWin();"><span>保&nbsp;&nbsp;存</span></a>
		</td><td style="width: 80px;">	
			<a class="btn btn-primary" href="javascript:void(0)" id="closeWin" 
				onclick="javascript:history.go(-1);"><span>返&nbsp;&nbsp;回</span> </a>
		</td><td style="text-align: right;">
			<a class="btn btn-primary" style="background-color: red;" href="javascript:void(0)" id="deleteTable" ><span>删除</span></a>
		</td>
	</tr>
</table>
	</div>
	<form name="form" id="form" action="${ctx}/background/sample/add.html" method="post"  enctype="multipart/form-data">
		<table style="height: 100%;" id="table1" border="2" name="table1" class='dataintable'>
			<tbody>
				<tr>
					<td style="height: 30px;width: 30px;text-align: center;">
						<input type="checkbox" id="checkAll" name="checkAll">
					</td>
					<td>开版日期</td>
					<td>工厂</td>
					<td>布种</td>
					<td>编号类型</td>
					<td>编号值</td>
					<td>工艺</td>
					<td>图片</td>
					<td>业务员</td>
					<td>备注</td>
				</tr>
			
				<tr id="1">
					<td style="text-align: center;">
						<input type="checkbox" id="checkId" name="checkId" value="1">
					</td><td>
						<input id='sampleDate' name="sampleDate" class="isNum" style="height:20px;width: 70px;" 
							readonly="readonly" type="text" value="${nowDate }">
					</td><td >
						<select id="factoryId" name="factoryId" style="width: 100px;">
							<option value="">请选择工厂</option>
							<c:forEach items="${ factoryInfos }" var = "factoryInfo">
								<option value="${factoryInfo.id }">${factoryInfo.name}</option>
							</c:forEach>
					    </select>
					</td><td>
						<select id="clothId" name="clothId" style="width: 100px;">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</td><td>
						<select id="codeType" name="codeType" style="width:80px">
							<option value="0">分色文件号</option>
							<option value="1">工厂编号</option>
							<option value="2">我司编号</option>
					    </select>
					</td><td>
						<input id='codeValue' name="codeValue" class="isNum" type="text" value="" style="width: 100px;">
					</td><td>
						<select id="technologyId" name="technologyId" style="width: 100px;">
							<c:forEach items="${ technologyInfos }" var = "technologyInfo">
								<option value="${technologyInfo.id }">${technologyInfo.name}</option>
							</c:forEach>
					    </select>
					</td><td>
						<!--input type="file" id="myFile" name="myFile" style="width: 150px"  onchange="PreviewImage(this);"/-->
						<input type="file" id="1pic"  name="file" style="width: 135px" onchange="ajaxFileUpload(this)">
						<input type="hidden" id="1pic_picture" name="picture" value="">
						<input type="hidden" id="1pic_smallPicture" name="smallPicture" value="">
					</td><td>
						<select id="salemanId" name="salemanId" style="width: 100px;">
							<option value="">请选择</option>
							<c:forEach items="${ salesmanInfos }" var = "salesmanInfo">
								<option value="${salesmanInfo.id }">${salesmanInfo.name}</option>
							</c:forEach>
					    </select>
					</td><td >
						<input type="text" id="mark" name="mark" style="width:200px;" value="双击选择备注信息" onblur="blurValue(this);" onclick="clearText(this);" ondblclick="pop(this)">
					</td>
				</tr>
			</table>
	</form>
	</div>
</body>
</html>