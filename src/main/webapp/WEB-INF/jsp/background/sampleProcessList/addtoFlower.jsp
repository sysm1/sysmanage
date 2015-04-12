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
		var factoryCodes=$('#factoryCodes').val();
		var myCompanyColors=document.getElementsByName("myCompanyColors");
		//var myCompanyColors2=document.getElementsByName("myCompanyColors2");
		var count=0;
		if(factoryCodes!=''){
			var length=myCompanyColors.length;
			for(var i=0;i<length-1;i++){
				if(myCompanyColors[i].value=='我司颜色'||myCompanyColors[i].value==''){
					count++;
				}
			}
		}
		if(count>0){
			if(confirm("我司颜色未填写是否需要保存，点击‘是’保存")){
				$("#form").submit();
			}
		}else{
			$("#form").submit();
		}
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
		var tr=document.getElementById('addtable').insertRow(5);
		var td0=tr.insertCell(0);
		var td1=tr.insertCell(1);
		var td2=tr.insertCell(2);
		td0.innerHTML='工厂编号：';
		td1.innerHTML='<input type="text" id="factoryCodes2" name="factoryCodes2" >';
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
<div class="divdialog" style="padding-top: -60px;">
	<form name="form" id="form" action="${ctx}/background/flower/add.html" method="post">
		<input id='picture' name="picture" type="hidden" value="" >
		<input id='factoryId' name="factoryId" type="hidden" value="${bean.factoryId }" >
		<input id='clothId' name="clothId" type="hidden" value="${bean.clothId }" >
		<input id='myCompanyCode' name="myCompanyCode" type="hidden" value="${bean.myCompanyCode }" >
		<table class="pp-list table table-striped table-bordered" id="addtable">
			<tbody>
			<tr>
				<td style="width: 13%;background-color: #00FFFF">我司名称：</td>
				<td>飞翔</td>
				<td style="width: 13%;background-color: #00FFFF">工厂：</td>
				<td>${bean.factoryName}</td>
			</tr><tr>
				<td style="background-color: #00FFFF">我司编号：</td>
				<td>${bean.myCompanyCode}</td>
				<td style="background-color: #00FFFF">布种：</td>
				<td>${bean.clothName }</td>
			</tr><tr>
				<td style="background-color: #00FFFF">工艺：</td>
				<td>${bean.technologyName }</td>
				<td style="background-color: #00FFFF">分色文件号：</td>
				<td>${bean.fileCode}</td>
			</tr><tr style="background-color: #00FFFF">
				<td colspan="2" style="text-align: center">工厂编号</td>
				<td colspan="2">
					&nbsp;&nbsp;我司颜色&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					工厂颜色&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp; 备注</td>
			</tr>
			<c:forEach var="item" items="${facotoryCodeMap}" varStatus="status1">
			<tr>
				<td>工厂编号：</td>
				<td>				
					<span class="factoryCodeInputcss" id="factoryCodeInputID">
					<input id="factoryCodes" name="factoryCodes" type="text" value="${item.key }" style="width:200px;"/>
					</span>
					<!--span id="addonerow"><a onclick="addOneRow();">++</a></span-->
				</td>
				<td colspan="2">
					<c:forEach var="item2" items="${item.value}" varStatus="status2">
						<div id="colors0">
						<input name="myCompanyColors" type="text" onclick="clickText(this,'我司颜色');" 
							onblur="changeValue(this,'我司颜色');" value="我司颜色" style="width:100px;"/>
						<input name="factoryColors" type="text"  value="${item2.factoryColor }" style="width:100px;"/>
						<input name="mark" type="text" value="备注" onclick="clickText(this,'备注');" 
							onblur="changeValue(this,'备注');" style="width:100px;"/>
						<span id="addFacotyMyCode"><a onclick="addcolors();">+</a></span>
					</div>
					</c:forEach>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="2" >上传图片:
					<input type="file" id="file1" name="file" style="height: 23px;"/>
					<input id="uploadFile" type="button" value="上传" />
				</td>
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