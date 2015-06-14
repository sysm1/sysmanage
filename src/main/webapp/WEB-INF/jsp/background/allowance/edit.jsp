<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<link href="${ctx}/css/unsub.css" rel="stylesheet">
<script type="text/javascript">


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
								parent.allowance.loadGird();
								closeWin();
							});
							//parent.window.document.getElementById("username").focus();
						} else {
							$.ligerDialog.warn("提交失败！！");
						}
					}
				});
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
	function closeWin() {
		 parent.$.ligerDialog.close(); //关闭弹出窗; //关闭弹出窗
		parent.$(".l-dialog,.l-window-mask").css("display","none"); 
	}
	
</script>
</head>
<body style="text-align: center;">
<div class="divdialog">
	<div class="l_err" style="width: 400px;"></div>
	<form name="form" id="form" action="${ctx}/background/allowance/update.html" method="post">
		<input id='id' name="id" type="hidden" value="${allowance.id}">
		<table style="width: 400px; height: 300px;" border="1" class="dataintable">
			<tbody>
			
			<tr>
				<td style="text-align: right;">日期：</td>
				<td class="l_left">
					<input type="text" id="inputDate" name="inputDate" 
						value="<fmt:formatDate value='${allowance.inputDate}' pattern='yyyy-MM-dd'/>" 
						onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
				</td>
			</tr><tr>
				<td style="text-align: right;height: 35px;">出胚单位：</td>
				<td style="text-align: left;">
					&nbsp;${allowance.supplierName }
					<input type="hidden" id="supplierId" name="supplierId" value="${allowance.supplierId }">
				</td>
			</tr><tr>
				<td style="text-align: right;height: 35px;">布种：</td>
				<td style="text-align: left;">
					<div class="lanyuan_input">
						<input id='clothId' name="clothId" type="hidden" value="${allowance.clothId}">
						&nbsp;${allowance.clothName}
					</div>
				</td>
			</tr><!--tr>
				<td style="text-align: right;height: 35px;">颜色：</td>
				<td class="l_left">
					<div class="lanyuan_input">
						<input id='color' name="color" type="hidden" value="${allowance.color}">
						&nbsp;${allowance.color}
					</div>
				</td>
			</tr--><tr <c:if test="${ allowance.unit==1}"> style="display: none;"</c:if> >
				<td style="text-align: right;">条数：</td>
				<td class="l_left">
					<div class="lanyuan_input">
					<input id='allowance' name="allowance" type="text" class="isNum" value="${allowance.allowance}">
					</div>
				</td>
			</tr><tr>
				<td style="text-align: right;">重量(KG)：</td>
				<td style="text-align: left;" nowrap="nowrap" style="width: 290px;">
					<div class="lanyuan_input">
						<input id='allowancekg' name="allowancekg" type="text" value="${allowance.allowancekg}">
					</div>
				</td>
			</tr><tr>
				<td style="text-align: right;">单价(元/KG)：</td>
				<td style="text-align: left;" nowrap="nowrap" style="width: 290px;">
					<div class="lanyuan_input">
						<input id='price' name="price" type="text" value="${allowance.allowancekg}">
					</div>
				</td>
			</tr><tr>
				<td style="text-align: right;">金额(元)：</td>
				<td style="text-align: left;" nowrap="nowrap" style="width: 290px;">
					<div class="lanyuan_input">
						<input id='money' name="money" type="text" value="${allowance.allowancekg}">
					</div>
				</td>
			</tr><tr>
				<td style="text-align: right;height: 35px;">工厂：</td>
				<td style="text-align: left;">
					<div class="lanyuan_input">
						<input id='factoryId' name="factoryId" type="hidden" value="${allowance.factoryId}">
						&nbsp;${allowance.factoryName}
					</div>
				</td>
			</tr><tr>
				<td style="text-align: right;">备注：</td>
				<td class="l_left">
					<div class="lanyuan_input">
					<input id='mark' name="mark" type="text" value="${allowance.mark}">
					</div>
				</td>
			</tr><tr>
				<td colspan="2">
					<div class="l_btn_centent">
						<!-- saveWin_form   from是表单Ｉd-->
						<a class="btn btn-primary" href="javascript:void(0)" id="saveWin_form" onclick="saveWin();"><span>保&nbsp;&nbsp;&nbsp;&nbsp;存</span> </a> 
						<!--a class="btn btn-primary" href="javascript:void(0)" id="closeWin" onclick="closeWin()"><span>关闭</span> </a-->
					</div>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>