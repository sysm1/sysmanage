<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	var dialog;
	var grid;

	$(function() {
		// 布种
		$("#export6").click("click", function() {
			if($("#date6").attr("checked")){
				// alert($("#date6").attr("checked"));
			} else {
				$("#beginTime").attr("value", $("#beginTime6").attr("value"));
				$("#endTime").attr("value", $("#endTime6").attr("value"));
			}
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/report/exportClothExcel.html');
			f.submit();
		});
		
		// 工厂
		$("#export5").click("click", function() {
			if($("#date5").attr("checked")){
				// alert($("#date6").attr("checked"));
			} else {
				$("#beginTime").attr("value", $("#beginTime5").attr("value"));
				$("#endTime").attr("value", $("#endTime5").attr("value"));
			}
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/report/exportFactoryExcel.html');
			f.submit();
		});
		
		// 花号
		$("#export4").click("click", function() {
			if($("#date4").attr("checked")){
				// alert($("#date6").attr("checked"));
			} else {
				$("#beginTime").attr("value", $("#beginTime4").attr("value"));
				$("#endTime").attr("value", $("#endTime4").attr("value"));
			}
			var f = $('#fenye');
			f.attr('target','_blank');
			f.attr('action','${pageContext.request.contextPath}/background/flower/exportExcel.html');
			f.submit();
		});
		
	});
</script>
</head>
<body>
	<div class="divBody">
		<form name="fenye" id="fenye">
			
			<input type="hidden" id="beginTime" name="beginTime"  />
			<input type="hidden" id="endTime" name="endTime"  />
		</form>

		<div id="paging" class="pagclass">

			<table id="table_head"
				class="pp-list table table-striped table-bordered"
				style="margin-bottom: -3px; width: 1008px;">

			</table>

			<div
				style="overflow-y: auto; overflow-x: auto; height: 348px; border: 1px solid #DDDDDD;"
				class="t_table">
				<table id="mytable"
					class="pp-list table table-striped table-bordered"
					style="margin-bottom: -3px;">
					<thead>
						<tr style="line-height: 27px;">
							<td style="text-align: center;">序号</td>
							<td style="text-align: center; display:;">功能</td>
							<td style="text-align: center;">时间</td>
							<td style="text-align: center;">操作</td>
						</tr>
					</thead>

					<tbody>

						<tr style="line-height: 27px;">
							<td style="text-align: center;">1</td>
							<td style="text-align: center;">开版进度查询</td>
							<td style="text-align: center;">
								<input type="checkbox" name="date1" id="date1" /> 全部日期
								开始日期:<input type="text" id="beginTime1" name="beginTime1" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
								结束日期:<input type="text" id="endTime1" name="endTime1" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
							</td>
							<td style="text-align: center;"><a class="btn btn-large btn-success" href="javascript:void(0)" id="export1">导出excel</a></td>
						</tr>
						<tr style="line-height: 27px;">
							<td style="text-align: center;">2</td>
							<td style="text-align: center;">下单录入汇总查询</td>
							<td style="text-align: center;">
								<input type="checkbox" name="date2" id="date2" /> 全部日期
								开始日期:<input type="text" id="beginTime2" name="beginTime2" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
								结束日期:<input type="text" id="endTime2" name="endTime2" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
							</td>
							<td style="text-align: center;"><a class="btn btn-large btn-success" href="javascript:void(0)" id="export2">导出excel</a></td>
						</tr>
						
						<tr style="line-height: 27px;">
							<td style="text-align: center;">3</td>
							<td style="text-align: center;">编号对应表</td>
							<td style="text-align: center;">
								<input type="checkbox" name="date3" id="date3" /> 全部日期
								开始日期:<input type="text" id="beginTime3" name="beginTime3" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
								结束日期:<input type="text" id="endTime3" name="endTime3" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
							</td>
							<td style="text-align: center;"><a class="btn btn-large btn-success" href="javascript:void(0)" id="export3">导出excel</a></td>
						</tr>
						<tr style="line-height: 27px;">
							<td style="text-align: center;">4</td>
							<td style="text-align: center;">花号基础资料</td>
							<td style="text-align: center;">
								<input type="checkbox" name="date4" id="date4" /> 全部日期
								开始日期:<input type="text" id="beginTime4" name="beginTime4" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
								结束日期:<input type="text" id="endTime4" name="endTime4" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
							</td>
							<td style="text-align: center;"><a class="btn btn-large btn-success" href="javascript:void(0)" id="export4">导出excel</a></td>
						</tr>
						
						<tr style="line-height: 27px;">
							<td style="text-align: center;">5</td>
							<td style="text-align: center;">下单报表（工厂）</td>
							<td style="text-align: center;">
								<input type="checkbox" name="date5" id="date5" /> 全部日期
								开始日期:<input type="text" id="beginTime5" name="beginTime5" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
								结束日期:<input type="text" id="endTime5" name="endTime5" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
							</td>
							<td style="text-align: center;"><a class="btn btn-large btn-success" href="javascript:void(0)" id="export5">导出excel</a></td>
						</tr>
						
						<tr style="line-height: 27px;">
							<td style="text-align: center;">6</td>
							<td style="text-align: center;">下单报表（布种）</td>
							<td style="text-align: center;">
								<input type="checkbox" name="date6" id="date6" /> 全部日期
								开始日期:<input type="text" id="beginTime6" name="beginTime6" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
								结束日期:<input type="text" id="endTime6" name="endTime6" value="" style="width:100px;" onfocus="WdatePicker({isShowClear:true,readOnly:true})"/>
							</td>
							<td style="text-align: center;"><a class="btn btn-large btn-success" href="javascript:void(0)" id="export6">导出excel</a></td>
						</tr>
						
					</tbody>
				</table>
			</div>


		</div>

	</div>
</body>
</html>