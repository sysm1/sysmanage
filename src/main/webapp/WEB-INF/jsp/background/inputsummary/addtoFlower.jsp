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
							//parent.sample.loadGird();
							closeWin();
						});
					} else {
						$.ligerDialog.warn("提交失败！！");
					}
				}
			});
		}
	});
});

	$(function(){
		$("#uploadFile").click(function () {
			ajaxFileUpload();
        });
	});
	
	function saveWin() {
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
	function addOneRow(){
		var tr=document.getElementById('addtable').insertRow(4);
		var td0=tr.insertCell(0);
		var td1=tr.insertCell(1);
		var td2=tr.insertCell(2);
		td0.innerHTML='工厂编号：';
		td1.innerHTML='<input type="text" name="myCompanyColors2" >';
		td2.colSpan=2;
		td2.innerHTML='<div id="colors20"><input name="myCompanyColors2" onclick="clickText(this,\'我司颜色\');" '+
				'onblur="changeValue(this,\'我司颜色\');" type="text" value="我司颜色" style="width:100px;"/>&nbsp;'+
			'<input name="factoryColors2" type="text" value="工厂颜色" onclick="clickText(this,\'工厂颜色\');" '+
				'onblur="changeValue(this,\'工厂颜色\');"  style="width:100px;"/>&nbsp;'+
		    '<input name="mark2" type="text" value="备注" onclick="clickText(this,\'备注\');" '+
		   		'onblur="changeValue(this,\'备注\');" style="width:100px;"/>&nbsp;'+
		    '<span id="addFacotyMyCode"><a onclick="addcolors2();">+</a></span></div>';
		$('#addonerow')[0].innerHTML="";
	}
	
	function deleteRow(){
		alert(00);
	}
	
	var index=0;
	var index1=1;
	function addcolors(){
		var id="colors"+index1;
		$('#colors'+index).after('<div id="'+id+'">'+
				'<input name="myCompanyColors" type="text" onclick="clickText(this,\'我司颜色\');" '+
				'onblur="changeValue(this,\'我司颜色\');" value="我司颜色" style="width:100px;"/>&nbsp;'+
				'<input name="factoryColors" type="text" value="工厂颜色" onclick="clickText(this,\'工厂颜色\');" '+
				'onblur="changeValue(this,\'工厂颜色\');"  style="width:100px;"/>&nbsp;'+
				'<input name="mark" type="text" value="备注" onclick="clickText(this,\'备注\');" '+
				'onblur="changeValue(this,\'备注\');"  style="width:100px;"/>&nbsp;'+
			'</div>');
		index1++;
		index++;
	}
	
	var index2=0;
	var index21=1;
	function addcolors2(){
		var id="colors2"+index21;
		$('#colors2'+index2).after('<div id="'+id+'">'+
				'<input name="myCompanyColors2" type="text" onclick="clickText(this,\'我司颜色\');" '+
				'onblur="changeValue(this,\'我司颜色\');" value="我司颜色" style="width:100px;"/>&nbsp;'+
				'<input name="factoryColors2" type="text" value="工厂颜色" onclick="clickText(this,\'工厂颜色\');" '+
				'onblur="changeValue(this,\'工厂颜色\');" style="width:100px;"/>&nbsp;'+
				'<input name="mark2" type="text" value="备注" onclick="clickText(this,\'备注\');" '+
				'onblur="changeValue(this,\'备注\');" style="width:100px;"/>&nbsp;'+
			'</div>');
		index21++;
		index2++;
	}
    
	function clickText(obj,value){
		if(obj.value==value){
			obj.value="";
		}
	}
	function changeValue(obj,value){
		if(obj.value==''){
			obj.value=value;
		}
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 370px;"></div>
	<form name="form" id="form" action="${ctx}/background/flower/add.html" method="post">
		<input id='picture' name="picture" type="hidden" value="" >
		<input id='clothId' name="clothId" type="hidden" value="${clothInfo.id }" >
		<table class="pp-list table table-striped table-bordered" style="margin-bottom: -3px;" id="addtable">
			<tbody>
			<tr>
				<td>我司名称：</td>
				<td>飞翔</td>
				<td>工厂：</td>
				<td>
					<select id="factoryId" name="factoryId" onchange="changeFactory(this);">
						<option value="">请选择</option>
						<c:forEach var="item" items="${factoryInfos }" varStatus="status">
						<option value="${item.id }" <c:if test="${item.id eq factoryInfo.id }">selected="selected"</c:if>  >${item.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr><tr>
				<td>我司编号：</td>
				<td>
					${myCompanyCode }
				</td>
				<td>布种：</td>
				<td>${clothInfo.clothName }</td>
			</tr><tr>
				<td>工艺：</td>
				<td>
					<select id='technologyId' name="technologyId">
						<option>请选择</option>
						<c:forEach var="item" items="${technologyInfos }">
						<option value="${item.id }" <c:if test="${item.id eq technologyId }"> selected="selected"</c:if> >${item.name }</option>
						</c:forEach>
					</select>
				</td>
				<td>分色文件号：</td>
				<td>
					<input id='fileColor' name="fileColor" type="text" value="${bean.fileCode}" style="width:100px;">
				</td>
			</tr><tr>
				<td colspan="2">工厂编号</td>
				<td colspan="2">
					&nbsp;&nbsp;我司颜色&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					工厂颜色&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp; 备注</td>
			</tr>
			<tr>
				<td>工厂编号：</td>
				<td>				
					<span class="factoryCodeInputcss" id="factoryCodeInputID">
					<input name="factoryCodes" type="text" value="${factoryCode}" />
					</span>
					<span id="addonerow"><a onclick="addOneRow();">++</a></span>
				</td>
				<td colspan="2">
						<div id="colors0">
						<input name="myCompanyColors" type="text" onclick="clickText(this,'我司颜色');" 
							onblur="changeValue(this,'我司颜色');" value="${myCompanyColor }" style="width:100px;"/>
						<input name="factoryColors" type="text"  value="${item2.factoryColor }" style="width:100px;"/>
						<input name="mark" type="text" value="备注" onclick="clickText(this,'备注');" 
							onblur="changeValue(this,'备注');" style="width:100px;"/>
						<span id="addFacotyMyCode"><a onclick="addcolors();">+</a></span>
					</div>
				</td>
			</tr>
			<tr id="fctr2" class="factoryCodeTrCss" style="display: none">
				<td>工厂编号：</td>
				<td>
					<span class="factoryCodeInputcss" id="factoryCodeInputID2">
					<input name="factoryCodes" type="text" value="工厂编号" style="width:100px;"/><br/>
					</span><span id="addFacotyCodeId2"><a href="javascript:void(0);">-</a></span>
				</td>
				<td colspan="2">
							<input name="myCompanyColors" type="text" value="我司颜色1" style="width:100px;"/>
							<input name="factoryColors" type="text" value="工厂颜色" style="width:100px;"/>
							<input name="mark" type="text" value="备注" style="width:100px;"/>
							<span id="addFacotyMyCode2"><a href="javascript:void(0);">+</a></span><br/>
				</td>
			</tr><tr>
				<td colspan="2" >上传图片:<input type="file" id="file1" name="file" /><input id="uploadFile" type="button" value="上传" /></td>
				<td colspan="2" rowspan="2"><img id="img1" alt="图片预览" src="" /></td>
			</tr><tr>
				<td colspan="2">
					<div class="l_btn_centent">
						<!-- saveWin_form   from是表单Ｉd-->
						<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();"><span>保存</span> </a>
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