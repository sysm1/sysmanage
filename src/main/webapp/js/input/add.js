$(function(){
	
	inputpagejs.init();
	
});

var inputpagejs = {
		
		initfirstDom : null,
		
		init : function(){
			
			inputpagejs.validate();
			
			$("#table1 tr[name=initfirst]").each(function(){
				/**
				$(this).find("select[name=clothId]").change(function(){
					inputpagejs.clothIdChangeAjax(this);
					
				});
				**/
				$(this).find("select[name=clothId]").bind({
					change : function(){
						inputpagejs.clothIdChangeAjax(this);
					},
				});
				/**
				$(this).find("select[name=clothId]").ligerComboBox({
					url: '/background/pinyin/cloth.html',
    				valueField: 'id',
    		        textField: 'clothName', 
    		        //selectBoxWidth: 133,
    		        //selectBoxHeight: 11,
    		        autocomplete: true,
    		        //width: 142,
    		        //height:20
    		        onSelected:function(e) {
    		            $("#clothId").val(e);
    		         }
		         });
				**/
				$(this).find("td[name=companyCode]").bind({
					getCompanyCode : function(e,d){
						inputpagejs.companyCodeAjax(d,this);
					},
					
					change : function(){
						inputpagejs.queryNoReturnNum(this);
					}
				});
				
				$(this).find("td[name=myCompanyColor]").bind({					
					change : function(){
						inputpagejs.queryNoReturnNum(this);
					}
				});
			});
			
			inputpagejs.initfirstDom = $("#table1 tr[name=initfirst]").clone(true);
			
			$("#addTable").click(function(){
				inputpagejs.addtr();
			});
			
			$("#copyone").click(function(){
				inputpagejs.addtrcp();
			});
			
			$("#deleteTable").click(function(){
				inputpagejs.deltr();
			});
			
			$("#checkAll").click(function(){
				var b = $(this).prop("checked");
				$("#table1 input[name=checkId]").prop("checked",b);
			});
			
			$("#table1 input[name=checkId]").click(function(){
				var len1 = $("#table1 input[name=checkId]:checked").length;
				var len2 =  $("#table1 input[name=checkId]").length;
				if(len1==len2){
					$("#checkAll").prop("checked",true);
				}else{
					$("#checkAll").prop("checked",false);
				}
			});
			
			$("#saveWin_form").click(function(){
				inputpagejs.submit();
			});
		},
		
		
		
		
		addtr : function(){
			$("#table1").append(inputpagejs.initfirstDom.clone(true));
		},
		
		addtrcp : function(){
			var checkids = $("#table1 input[name=checkId]:checked");
			if($(checkids).length==0){
				alert("请选择要复制的行");
				return;
			}
			$(checkids).each(function(){
				var tr = $(this).parent().parent();
				var tr2 = $(tr).clone(true);
				$(tr).find("select").each(function(){
					var v = $(this).val();
					var name = $(this).attr("name");
					$(tr2).find("select[name="+name+"] option[value="+v+"]").prop("selected",true);
				});
				
				$("#table1").append(tr2);
			});
		},
		
		deltr : function(){
			var checkids = $("#table1 input[name=checkId]:checked");
			var trs = $("#table1 tr[name=initfirst]");
			var checklen = $(checkids).length;
			var trslen = $(trs).length;
			
			if(checklen==0){
				alert("请选择要复制的行");
				return;
			}
			
			$(checkids).each(function(){
				var tr = $(this).parent().parent();
				$(tr).remove();
			});
			
			if(checklen==trslen){
				inputpagejs.addtr();
			}
			
		},
		
		
		
		submit : function () {
			
			var b = true;
			
			b = b && inputpagejs.clothIdCheck();
			b = b && inputpagejs.salesmanIdCheck();
			b = b && inputpagejs.numCheck();
			
			if(b){
				$("#form").submit();
			}
			
		},
		
		
		clothIdChangeAjax : function($this){
			var v = $($this).val();
			$.ajax({
			    type: "post", //使用get方法访问后台
			    dataType: "json", //json格式的数据
			    async: false, //同步   不写的情况下 默认为true
			    url: rootPath + '/background/cloth/getClothUnit.html', //要访问的后台地址
			    data: {id:v}, //要发送的数据
			    success: function(data){
			    	var $danwei = $($this).parents("tr[name=initfirst]").find("td[name=danwei]");
			    	if(data=="包"){
			    		$danwei.html("KG");
			    	}else{
			    		$danwei.html("条");
			    	}
			    	
				},error : function() {    
			          // view("异常！");    
			          alert("异常！");    
			     } 
			});
			
			$($this).parents("tr[name=initfirst]").find("td[name=companyCode]").trigger("getCompanyCode",[v]);
			
			
			
		},
		
		companyCodeAjax : function(v,$companyCodeTd){
			$.ajax({
			    type: "post", //使用get方法访问后台
			    dataType: "json", //json格式的数据
			    async: false, //同步   不写的情况下 默认为true
			    url: rootPath + '/background/sample/queryMycompanyCodeByCloth.html', //要访问的后台地址
			    data: {clothId:v}, //要发送的数据
			    success: function(data){
			    	if(data!=null&&data!=''){
				    	var list = [];
				    	for(var i=0;i<data.length;i++){
				    		if(null!=data[i]){
				    			list.push({ clothName: data[i]});
				    		}
				    	}
				    	var columns = [{ name: 'id'}];
				    	$($companyCodeTd).html('<input type="text"  name="myCompanyCode"  />');
				    	$($companyCodeTd)
				    		.find("input[name=myCompanyCode]")
				    			.ligerComboBox({
				    				data : list,
				    				valueField: 'id',
				    		        textField: 'clothName', 
				    		        //selectBoxWidth: 133,
				    		        //selectBoxHeight: 11,
				    		        autocomplete: true
				    		        //width: 142,
				    		        //height:20
	   				                }
	   				            );
				    	
				    	
			    	}else{
			    		$($companyCodeTd).html('<input type="text"  name="myCompanyCode"  />');
			    	}
				},error : function() {    
			          // view("异常！");
			          alert("异常！");    
			     } 
			});
			
		},
		
		queryNoReturnNum : function ($this){
			var $tr = $($this).parents("tr[name=initfirst]");
			
			var clothId=$($tr).find("select[name=clothId]").val();
			
			var myCompanyCode=$($tr).find("input[name=myCompanyCode]").val();
			var myCompanyColor=$($tr).find("input[name=myCompanyColor]").val();
			if(checkNull(clothId)&&checkNull(myCompanyCode)&&checkNull(myCompanyColor)){
				
				var param = {
							clothId:clothId,
							myCompanyCode:myCompanyCode,
							myCompanyColor:myCompanyColor
							};
				
				$.ajax({
				    type: "post", //使用get方法访问后台
				    dataType: "json", //json格式的数据
				    async: false, //同步   不写的情况下 默认为true
				    url: rootPath + '/background/ordersummary/queryNoReturnNum.html', //要访问的后台地址
				    data: param, //要发送的数据
				    success: function(data){
				    	if(null==data){
				    		data='未下单';
				    	}
				    	$($tr).find("td[name=sum]").html(data);
					},error : function() {    
				          alert("异常！");    
				     } 
				});
			}
		},
		
		clothIdCheck:function(){
			var b = true;
			$("#table1 select[name=clothId]").each(function(){
				var v = $(this).val();
				if(v==""){
					alert("请选择布种");
					b = false;
					return false;
				}
			});
			return b;
		},
		
		salesmanIdCheck : function(){
			var b = true;
			$("#table1 select[name=salesmanId]").each(function(){
				var v = $(this).val();
				if(v==""){
					alert("请选择业务员");
					b = false;
					return false;
				}
			});
			return b;
		},
		
		numCheck : function(){
			var b = true;
			$("#table1 select[name=num]").each(function(){
				var v = $(this).val();
				if(v==""){
					alert("请添加下单数量");
					b = false;
					return false;
				}
			});
			return b;
		},
		
		validate : function(){
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
									parent.input.loadGird();
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
			
		}
		
}

function checkNull(value){
	if(null==value||value==""){
		return false;
	}
	return true;
}