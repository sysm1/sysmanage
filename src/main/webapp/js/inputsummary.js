//下单录入列表js
function hiddenDetail(id,inputId,index){
	var tds=document.getElementsByName("chtd"+id);
	for(var i=0;i<tds.length;i++){
		//alert(tds[i].parentNode.parentNode.nodeName);
		tds[i].parentNode.parentNode.style.display="none";
	}
	$("#td"+index)[0].innerHTML='<span onclick="showDetail('+index+','+inputId+')">+</span>';
	$('#'+inputId)[0].checked=false;
}

function addTr(tab, row, trHtml){
     //获取table最后一行 $("#tab tr:last")
     //获取table第一行 $("#tab tr").eq(0)
     //获取table倒数第二行 $("#tab tr").eq(-2)
     var $tr=$("#"+tab+" tr").eq(row);
     if($tr.size()==0){
        alert("指定的table id或行数不存在！");
        return;
     }
     $tr.after(trHtml);
  }

function page(pageNO){
	$('#pageNow').attr('value',pageNO);
	var f = $('#fenye');
	//f.attr('target','_blank');
	f.attr('action','${pageContext.request.contextPath}/background/inputsummary/list.html');
	f.submit();
}

/****反向选择checkbox*/
function checkAllChild(obj){
	var summId=obj.value.split("_")[1];
	var childcheckId=document.getElementsByName("childcheckId");
	var childValue="";
	var chsize=0;
	var size=0;
	for(var i=0;i<childcheckId.length;i++){
		childValue=childcheckId[i].value;
		if(childValue.split("_")[1]==summId){
			size++;
			if(childcheckId[i].checked ){
				chsize++;
			}
		}
	}
	if(chsize==size){
		document.getElementById(summId).checked=true;
	}else{
		document.getElementById(summId).checked=false;
	}
	showOrHiddenBtn();
}

/**全选 当前父节点下的子节点**/
function checkAll(index,obj){
	var summId=obj.value;
	if(obj.checked){
		if($("#td"+index)[0].innerHTML.split('+').length>1){
			showDetail(index,summId);//加载子节点
		}
		
	}
	var childcheckId=document.getElementsByName("childcheckId");
	var childValue="";
	for(var i=0;i<childcheckId.length;i++){
		childValue=childcheckId[i].value;
		if(childValue.split("_")[1]==summId){
			childcheckId[i].checked = obj.checked;
		}
	}
	showOrHiddenBtn();
}

function showOrHiddenBtn(){
	var csize=0;
	var checkId=document.getElementsByName("checkId");
	for(var i=0;i<checkId.length;i++){
		if(checkId[i].checked){
			csize++;
		}
	}
	if(csize>1){
		document.getElementById("order").style.display="none";
		document.getElementById("order2").style.display="";
	}else{
		document.getElementById("order").style.display="";
		document.getElementById("order2").style.display="none";
	}
	if(childcheckId.length>1){
		document.getElementById("order").style.display="none";
		document.getElementById("order2").style.display="";
	}
	var childcheckId=document.getElementsByName("childcheckId");
	
}
//下单列表js结束



function saveWin() {
	var factoryId=$("#factoryId").val();
	if(factoryId==""){
		alert("工厂不能为空");
		$("#factoryId").focus();
		return false;
	}
	var technologyId=$("#technologyId").val();
	if(technologyId==""){
		alert("工艺不能为空");
		$("#technologyId").focus();
		return false;
	}
	var factoryCode=$("#factoryCode").val();
	if(factoryCode==""){
		alert("工厂编号不能为空");
		$("#factoryCode").focus();
		return false;
	}
	var factoryColor=$("#factoryColor").val();
	if(factoryColor==""){
		alert("工厂颜色不能为空");
		$("#factoryColor").focus();
		return false;
	}
	
	$("#form").ajaxSubmit({//验证新增是否成功
		type : "post",
		dataType:"json",
		success : function(data) {
			if (data.flag == "true") {
				$.ligerDialog.success('提交成功!', '提示', function() {
					//这个是调用同一个页面趾两个iframe里的js方法
					//account是iframe的id
					window.location.href=rootPath + "/background/inputsummary/list.html";
				});
			} else {
				$.ligerDialog.warn("提交失败！！");
			}
		}
	});
}
function changeNum(obj){
	var beforNum=$("#num1").val();
	var nowNum=obj.value;
	if(nowNum==''){
		$("#num").attr("value",beforNum);
	}
	var chae=parseInt(nowNum)-parseInt(beforNum);
	//alert(chae);
	if(chae>0){
		$("#balancetext").show();
		$("#balance").attr("value",chae);
		$("#ywy").show();
		$("#ywy2").show();
		$("#balancemarkTr").show();
	}else if(chae<0){
		alert("修改后的数量不能小于当前数量！");
		$("#num").attr("value",beforNum);
		$("#balancetext").hide();
		$("#ywy").hide();
		$("#ywy2").hide();
		$("#balancemarkTr").hide();
	}else if(chae==0){
		$("#num").attr("value",beforNum);
		$("#balance").attr("value",chae);
		$("#balancetext").hide();
		$("#ywy").hide();
		$("#ywy2").hide();
		$("#balancemarkTr").hide();
	}
}
function overrideText(data){
	var technology=data[4].innerHTML;
	var factory=data[7].innerHTML;//工厂名称
	var factoryCode=data[8].innerHTML;//工厂编号
	var factoryColor=data[9].innerHTML;//工厂颜色
	var fac=document.getElementById("factoryId");
	var tec=document.getElementById("technologyId");//工艺
	var facCode=document.getElementById("factoryCode");//工厂编号 
	var facColor=document.getElementById("factoryColor");
	for(var i=0;i<fac.options.length;i++){
		if(fac.options[i].text.trim()==factory.trim()){
			fac.options[i].selected='selected';
		}
	}
	//设定工艺
	for(var i=0;i<tec.options.length;i++){
		if(tec.options[i].text.trim()==technology.trim()){
			tec.options[i].selected='selected';
		}
	}
	//设定工厂编号
	for(var i=0;i<facCode.options.length;i++){
		if(facCode.options[i].text.trim()==factoryCode.trim()){
			facCode.options[i].selected='selected';
		}
	}
	//设定工厂颜色
	for(var i=0;i<facColor.options.length;i++){
		if(facColor.options[i].text.trim()==factoryColor.trim()){
			facColor.options[i].selected='selected';
		}
	}
}

function changeColor(){
	document.getElementById("myCompanyCodediv").style.color="";
	document.getElementById("myCompanyColor").style.color="";
	location.reload();
}