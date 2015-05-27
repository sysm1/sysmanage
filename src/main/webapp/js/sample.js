/***显示图片**/
	function showPic(id,sampId){
		//alert((document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2));
		document.getElementById(id).style.top = (document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2) + "px"; 
		document.getElementById(id).src="${pageContext.request.contextPath}/background/pic/getPic.html?id="+sampId;
	}
	
	function show(id,sampId){
		document.getElementById(id).style.display="";
		document.getElementById(id).style.top = (document.documentElement.scrollTop + (document.documentElement.clientHeight - document.getElementById(id).offsetHeight) / 2) + "px"; 
		document.getElementById(id).src="${pageContext.request.contextPath}/background/pic/getPic.html?id="+sampId;
	}
	
	function hiddenDiv(id){
		document.getElementById(id).style.display="none";
	}
	
	function test(){
		document.getElementById('middle').style.display="block";
		document.getElementById('surface').style.display="block";
	}
	
	/**全选**/
	function checkAll(obj){
		var checkIds=document.getElementsByName("checkId");
		var length=checkIds.length;
		for(var i=0;i<length;i++){
			checkIds[i].checked =obj.checked;
		}
	}