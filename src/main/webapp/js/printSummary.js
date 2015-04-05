
$(function () {
		
		$("#printSummary").click("click", function() {//绑定删除按扭
			var cbox=getSelectedCheckbox();
			// alert(cbox);
			if (cbox=="") {
				parent.$.ligerDialog.alert("请选择打印项！！");
				return;
			}
			var result = false;
			var factoryIds = new Array(cbox.length);
			var ids = new Array(cbox.length);
			// alert(factoryIds + ":" + ids);
			for(var m = 0; m < cbox.length; m++) {
				factoryIds[m] = cbox[m].toString().split("-")[0];
				ids[m] = cbox[m].toString().split("-")[1];
			}
			
			var first = factoryIds[0];
			if(cbox.length > 1) {
				for (var i=1; i< cbox.length; i++) {
					if(first != factoryIds[i]) {
						result = true;
						break;
					}
				}
			}
			if(result) {
				parent.$.ligerDialog.alert("请选择同一工厂的订单进行打印！！");
				return;
			} else {
				// alert("drup")
				window.location.href = "printnotify.html?ids=" + ids.join(",") + "&factoryId=" + first;
			}
			
		});
		
		
		$("#printsave").click("click", function() {
			
			var f = $('#fenye');
			//f.attr('target','_blank');
			f.attr('action','printsave.html');
			f.submit();
			
		});
		
	
		/**
		$(".reduce").live("click", function() {
			var rid = $(this).attr("rid");
			// alert($(this).html());
			// $(this).parent("span").remove();
		});
		**/
		
	});


function reduce( h ) {
	// alert($(this).attr("rid"));
	// alert(this);
	// alert($(h).text());
	// alert($(this).text());
	// $(this[0]).parent().remove();
	$(h).parent().remove();
}


