<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript">
jQuery.validator.addMethod("checkpass", function(value, element) {
	 return this.optional(element) || ((value.length <= 16) && (value.length>=6));
}, "密码由6至16位字符组合构成");
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
								parent.role.loadGird();
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
				enable : {
					required : true
				}
			},
			messages : {
				enable : {
					required : "选择状态"
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
	$(function() {
		$("input:radio[value='${role.enable}']").attr('checked','true');
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
<body>
<div class="divdialog">
	<div class="l_err" style="width: 100%;"></div>
	<form name="form" id="form" action="${ctx}/background/role/update.html" method="post">
		<table style="width: 100%; " class="dataintable">
			<tbody>
				<tr>
					<th style="text-align: right;">&nbsp;状态&nbsp;</th>
					<td id="1_${item.id }" colspan="2" style="text-align: left;">${item.status }</td>
					<th style="text-align: right;">下单日期</th>
					<td style="text-align: left;">
						<fmt:formatDate value='${item.orderDate }' pattern='yyyy-MM-dd'/>
					</td>
					<th style="min-width: 60px;" style="text-align: right;">工&nbsp;厂</th>
					<td id="3_${item.id }" colspan="2" style="text-align: left;">${item.factoryName }</td>
				</tr>
				<tr>
					<th colspan="11">下单</th>
				</tr><tr>
					<th style="min-width:60px;">&nbsp;布&nbsp;种&nbsp;</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					<th>&nbsp;工&nbsp;艺&nbsp;</th>
					<th>我司编号</th>
					<th>我司颜色</th>
					<th>纸管</th>
					<th>空差</th>
					<th>胶袋</th>
					<th>条数</th>
					<th>数量(KG)</th>
				</tr><tr>
					<td id="5_${item.id }">${item.clothName }</td>
					<td id="6_${item.id }">${item.factoryCode }</td>
					<td id="7_${item.id }">${item.factoryColor }</td>
					
					<td id="8_${item.id }">${item.technologyName }</td>
					<td id="9_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyCode }</td>
					<td id="10_${item.id }" onclick="onclickTr(${item.id })">${item.myCompanyColor }</td>
					
					<td id="11_${item.id }">${item.zhiguan }</td>
					<td id="12_${item.id }">${item.kongcha }</td>
					<td id="13_${item.id }">${item.jiaodai }</td>
					<td id="14_${item.id }">${item.num }</td>
					<td id="15_${item.id }">${item.numKg }</td>
				</tr>
				<tr>
					<th colspan="13">实到</th>
				</tr><tr>
					<th>收货单位</th>
					<th>布种</th>
					<th>工厂编号</th>
					<th>工厂颜色</th>
					<th>工艺</th>
					<th>我司编号</th>
					<th>我司颜色</th>
					
					<th style="width: 50px;">纸管</th>
					<th style="width: 50px;">空差</th>
					<th style="width: 50px;">胶袋</th>
					<!--th >回货日期</th-->
					<th style="width: 68px;">条数</th>
					<th style="width: 68px;">数量(KG)</th>
					<th style="width: 68px;">备注</th>
				</tr><tr>
					<td>
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							${item1.factoryName }<br>
						</c:forEach>
					</td>
					<td id="26_${item.id }" style="width: 90px;" >
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.clothName }<br>
							</c:forEach>
						</c:if>
					</td>
					<td id="17_${item.id }" onclick="onclickTr(${item.id })" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnCode }<br>
							</c:forEach>
						</c:if>
					</td>
					
					<td id="18_${item.id }" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnColor }<br>
							</c:forEach>
						</c:if>
					</td>
					<td id="19_${item.id }" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.technologyName }<br>
							</c:forEach>
						</c:if>
					</td>
					<td id="20_${item.id }" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.myCompanyCode }<br>
							</c:forEach>
						</c:if>
					</td>
					
					
					<!--td id="8_${item.id }" style="width:120px;" onclick="onclickTr(${item.id })">
					<c:if test="${fn:length(map[item.id]) ==0}">
						<input type="text" name="${item.id }returnDate" style="width:70px" value=""
							onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
					</c:if><c:if test="${map[item.id] != null }">
						<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
							<input type="text" name="${item.id }returnDate" style="width:70px" value="<fmt:formatDate value="${item1.returnDate }" pattern="yyyy-MM-dd"/>"
								onfocus="WdatePicker({isShowClear:true,readOnly:true,maxDate:''})">
						</c:forEach>
					</c:if>
						<span id="${item.id }returnDate" onclick="addOneRow(${item.id });" style="cursor:pointer;vertical-align:bottom;">
							<img alt="点击新增编号" width="20px;" src="../../images/jiahao.jpg" />
						</span>
					</td-->
					<td id="21_${item.id }" style="width: 90px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.myCompanyColor }<br>
							</c:forEach>
						</c:if>
					</td>
					
					<td id="22_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.zhiguan }<br>
							</c:forEach>
						</c:if>
					</td><td id="23_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.kongcha }<br>
							</c:forEach>
						</c:if>
					</td><td id="24_${item.id }" onclick="onclickTr(${item.id })" style="width: 50px;">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.jiaodai }<br>
							</c:forEach>
						</c:if>
					</td>
					
					<td id="25_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnNum }<br>
							</c:forEach>
						</c:if>
					</td><td id="4_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.returnNumKg }<br>
							</c:forEach>
						</c:if>
					</td><td id="4_${item.id }" onclick="onclickTr(${item.id })">
						<c:if test="${map[item.id] != null }">
							<c:forEach var="item1" items="${map[item.id]}" varStatus="status1">
								${item1.mark }<br>
							</c:forEach>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<td colspan="13">
						<div class="l_btn_centent">
							<a class="btn btn-primary" href="javascript:void(0)" id="closeWin"
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