<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>
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
								parent.unsubInput.loadGird();
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
	function saveWin() {
		$("#form").submit();
	}
</script>
</head>
<body>
<div class="divdialog">
	<div class="l_err" style="width: 270px;"></div>
	<form name="form" id="form" action="${ctx}/background/unsubInput/update.html" method="post">
		<input type="hidden" id="id" name="id" value="${unsub.id }">
		<table style="width: 100%; height: 100%;" border="1">
			<tbody>
				<tr>
					<td style="text-align: right;height: 40px;width: 15%;">退货日期：</td>
					<td class="l_left">
					<div class="lanyuan_input">
					<input type="text" id="unsubdate" name="unsubdate" value="<fmt:formatDate value='${unsub.unsubdate }' pattern='yyyy-MM-dd'/>" 
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:'%y-%M-%d'})">
					</div>
					</td>
					<td style="text-align: right;width: 15%;">布种：</td>
					<td class="l_left" style="width: 35%;">
					<div class="lanyuan_input">${unsub.clothName }
					</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;height: 40px;">我司编号：</td>
					<td class="l_left">
					<div class="lanyuan_input">${unsub.myCompanyCode }
					</div>
					</td>
					<td style="text-align: right;">我司颜色：</td>
					<td class="l_left">${unsub.myCompanyColor }
					</td>
				</tr><tr>
					<td style="text-align: right;height: 40px;">数量：</td>
					<td colspan="3">
						<input type="text" id="num" name="num" value="${unsub.num }">
					</td>
				</tr><tr style="height: 30px;">
					<td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户反映质量问题</td>
				</tr><tr>
					<td colspan="4" style="text-align: center;">
						<textarea rows="3" style="width: 95%;" id="qualityProblem" name="qualityProblem">${unsub.qualityProblem }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<div class="l_btn_centent">
								<!-- saveWin_form   from是表单Ｉd-->
								<a class="btn btn-primary" href="javascript:void(0)"
									id="saveWin_form" onclick="saveWin();"><span>保存</span> </a> 
							</div>
						</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>