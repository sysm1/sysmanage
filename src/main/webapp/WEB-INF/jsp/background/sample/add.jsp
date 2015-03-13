<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
								parent.sample.loadGird();
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
	function saveWin() {
		$("#form").submit();
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
		alert(obj.value+"||"+id+"||"+document.getElementById("picture").value);
		var url = document.getElementById("picture").value;
		alert(url);
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
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" ></div>
	<form name="form" id="form" action="${ctx}/background/sample/add.html" method="post"  enctype="multipart/form-data">
		<table style="height: 100%;" border="1">
			<tbody>
				<tr>
					<td class="l_right" >开版日期：</td>
					<td class="l_left">
						<input id='sampleDate' name="sampleDate" class="isNum" style="height:30px;" readonly="readonly" type="text" value="${nowDate }">
					</td><td rowspan="9"  id="pictd">
						<div id="imgPreview" style="width:600px;height:350px"> 
					    	图片预览区&nbsp;<img src="" style="max-width:700px;"/> 
					   </div>
					</td>
				</tr><tr>
					<td style="height:35px;">工厂：</td>
					<td >
						<select id="factoryId" name="factoryId" style="height:35px;">
							<option value="">请选择工厂</option>
							<c:forEach items="${ factoryInfos }" var = "factoryInfo">
								<option value="${factoryInfo.id }">${factoryInfo.name}</option>
							</c:forEach>
					    </select>
					</td>
				</tr><tr>
					<td style="height:30px;">布种：</td>
					<td>
						<select id="clothId" name="clothId">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option value="${cloth.id }">${cloth.clothName}</option>
							</c:forEach>
						</select>
					</td>
				</tr><tr>
					<td>
						<select id="codeType" name="codeType" style="width:90px">
							<option value="">编号类型</option>
							<option value="0">分色文件号</option>
							<option value="1">工厂编号</option>
							<option value="2">我司编号</option>
					    </select></td>
					<td>
						<input id='codeValue' name="codeValue" class="isNum" type="text" value="">
					</td>
				</tr><tr>
					<td>工艺：</td>
					<td>
						<select id="technologyId" name="technologyId">
							<option value="">请选择工艺</option>
							<c:forEach items="${ technologyInfos }" var = "technologyInfo">
								<option value="${technologyInfo.id }">${technologyInfo.name}</option>
							</c:forEach>
					    </select>
					</td>
				</tr><tr>
					<td>图片：</td>
					<td>
						<input type="file" id="myFile" name="myFile" style="width: 220px"  onchange="PreviewImage(this);"/>
					</td>
				</tr><tr>
					<td>业务员：</td>
					<td>
						<select id="salemanId" name="salemanId">
							<option value="">请选择</option>
							<c:forEach items="${ salesmanInfos }" var = "salesmanInfo">
								<option value="${salesmanInfo.id }">${salesmanInfo.name}</option>
							</c:forEach>
					    </select>
					</td>
				</tr><tr>
					<td class="l_right">备注：</td>
					<td class="l_left">
						<textarea rows="5" cols="6" id='mark' name="mark" ></textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<div class="l_btn_centent">
								<!-- saveWin_form   from是表单Ｉd-->
								<a class="btn btn-primary" href="javascript:void(0)"
									id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> <a
									class="btn btn-primary" href="javascript:void(0)" id="closeWin"
									onclick="closeWin()"><span>关闭</span> </a>
							</div>
						</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>