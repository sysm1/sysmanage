<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="${ctx}/js/ajaxfileupload.js"></script>

<script type="text/javascript">

//单独验证某一个input  class="checkpass"

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
								parent.flower.loadGird();
								closeWin();
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！" + data.msg);
						}
					}
				});
			}
		});
	});
	
	$(function() {
		
		$("#addFacotyMyCode").click("click", function() {
			//var $d = $("#company_color_id");
			//alert($d.html());
			var $html = $("#company_color_id");
			var $addH = $("<input name='myCompanyColors' type='text' style='width:100px;'/><input name='factoryColors' type='text' value='' style='width:100px;' /><input name='marks' type='text' value='' style='width:100px;'/><br/>");
			$html.append($addH);
		});
		
		
		$("#addFacotyMyCode2").click("click", function() {
			var $html = $("#company_color_id2");
			var $addH = $("<input name='myCompanyColors2' type='text' style='width:100px;'/><input name='factoryColors2' type='text' value='' style='width:100px;' /><input name='marks2' type='text' value='' style='width:100px;'/><br/>");
			$html.append($addH);
		});
		
		$("#addFacotyCodeId").click("click", function() {
			$("#fctr2").show();
		});
		
		$("#addFacotyCodeId2").click("click", function() {
			$("#fctr2").hide();
		});
		
		$("#uploadFile").click(function () {
			alert("dd");
			ajaxFileUpload();
        });
		
		var picture = $("#picture").val().split("|");
		
		$("#img1").attr("src", picture[1]);
		
	});
	
	function saveWin() {
		
		$("#form").submit();
	}
	
	function saveForm(){
		$("#form").submit();
	}
	
	function ajaxFileUpload() {
        $.ajaxFileUpload(
            {
                url: '/background/upload.html', //用于文件上传的服务器端请求地址
                secureuri: false, //是否需要安全协议，一般设置为false
                fileElementId: 'file1', //文件上传域的ID
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
<div class="divdialog">
	<div class="l_err" style="width: 370px;"></div>
	<form name="form" id="form" action="${ctx}/background/flower/update.html" method="post">
		<input id='id' name="id" type="hidden" value="${flower.id}">
		<input id='picture' name="picture" type="hidden" value="${flower.picture}" >
		
		<table class="pp-list table table-striped table-bordered" style="margin-bottom: -3px;">
			<tbody>
			<tr>
				<td>我司名称：</td>
				<td>飞翔</td>
				<td>工厂：</td>
				<td>
					<select id="factoryId" name="factoryId" style="width:100px;">
						<option value="">请选择工厂</option>
						<c:forEach items="${ factorys }" var = "factory">
							<option value="${factory.id }"  <c:if test="${flower.factoryId==factory.id }">selected="selected"</c:if> >${factory.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr><tr>
				<td>我司编号：</td>
				<td><input id='myCompanyCode' name="myCompanyCode" type="text" value="${flower.myCompanyCode}" style="width:100px;"></td>
				<td>布种：</td>
				<td>
					<select id="clothId" name="clothId" style="width:100px;">
							<option value="">请选择布种</option>
							<c:forEach items="${ cloths }" var = "cloth">
								<option value="${cloth.id }" <c:if test="${flower.clothId==cloth.id }">selected="selected"</c:if>>${cloth.clothName}</option>
							</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>工艺：</td>
				<td>
					<select id="technologyId" name="technologyId" style="width:100px;">
							<option value="">请选择工艺</option>
							<c:forEach items="${ technologys }" var = "technology">
								<option value="${technology.id }" <c:if test="${flower.technologyId==technology.id }">selected="selected"</c:if>>${technology.name}</option>
							</c:forEach>
					</select>
				</td>

				<td>分色文件号：</td>
				<td>
					<input id='fileColor' name="fileColor" type="text" value="${flower.fileColor}" style="width:100px;">
				</td>
			</tr>
			
			<tr>
				<td>工厂编号：</td>
				<td>
					<span class="factoryCodeInputcss" id="factoryCodeInputID">
					<input name="factoryCodes" type="text" value="${factoryCode}" style="width:100px;"/><br/>
					</span><span id="addFacotyCodeId"><a href="javascript:void(0);">+</a></span>
				</td>
				
				<td colspan="2">
					<ul>
						<li id=company_color_id>
							<c:forEach items="${flower.list}" var="fad">
								<c:if test="${fad.factoryCode == factoryCode }">
									<input name="myCompanyColors" type="text" value="${fad.myCompanyColor}" style="width:100px;"/>
									<input name="factoryColors" type="text" value="${fad.factoryColor}" style="width:100px;"/>
									<input name="marks" type="text" value="${fad.mark}" style="width:100px;"/><br/>
								</c:if>
							</c:forEach>
						</li>
						<li><span id="addFacotyMyCode"><a href="javascript:void(0);">+</a></span></li>
					</ul>
				</td>
			</tr>

			<tr id="fctr2" class="factoryCodeTrCss">
				<td>工厂编号：</td>
				<td>
					<span class="factoryCodeInputcss" id="factoryCodeInputID2">
					<input name="factoryCodes2" type="text" value="${factoryCode2}" style="width:100px;"/><br/>
					</span><span id="addFacotyCodeId2"><a href="javascript:void(0);">-</a></span>
				</td>
				
				<td colspan="2">
					<ul>
						<li id=company_color_id2>
						<c:forEach items="${flower.list}" var="fad">
							<c:if test="${fad.factoryCode == factoryCode2 }">
								<input name="myCompanyColors2" type="text" value="${fad.myCompanyColor}" style="width:100px;"/>
								<input name="factoryColors2" type="text" value="${fad.factoryColor}" style="width:100px;"/>
								<input name="marks2" type="text" value="${fad.mark}" style="width:100px;"/><br/>
							</c:if>
						</c:forEach>	
						</li>
						<li><span id="addFacotyMyCode2"><a href="javascript:void(0);">+</a></span></li>
					</ul>
				</td>
			</tr>
		<tr>
			<td colspan="2" >上传图片:<input type="file" id="file1" name="file" /><input id="uploadFile" type="button" value="上传" /></td>
			<td colspan="2" ><img id="img1" alt="图片预览" src="" /></td>
		</tr><tr>
			<td colspan="4">
				<div class="l_btn_centent">
					<!-- saveWin_form   from是表单Ｉd-->
					<a class="btn btn-primary" href="javascript:void(0)" id="bc" onclick="saveForm();"><span>保存</span> </a> 
					<a class="btn btn-primary" href="javascript:void(0)" id="closeWin" onclick="closeWin()"><span>关闭</span> </a>
				</div>
			</td>
		</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>