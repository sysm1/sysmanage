<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    
    <%@ include file="/common/header.jsp"%>
    
   

    <script src="/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function ()
        {
            var columns = [
                { header: 'ID', name: 'id', width: 80 },
                { header: '名字', name: 'name', width: 170 },
                { header: '描述', name: 'desc', width: 170 }
            ];

            $("#txt1").ligerComboBox(
                {
                    url: 'http://127.0.0.1:8080/background/pinyin/list.html',
                    valueField : 'id',
                    textField: 'name',
                    columns: columns,
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400,
                    onSelected:function(e) {
                    	 var data = e.data, key = e.key;
                    	 alert(data + "," + key);
                    }
                }
            );

            $("#txt2").ligerComboBox(
                {
                    url: 'http://127.0.0.1:8080/background/pinyin/list.html',
                    valueField: 'id',
                    textField: 'name', 
                    selectBoxWidth: 80,
                    autocomplete: true,
                    width: 80,
                    onSelected:function(e) {
                   		alert(e);
                   }
                }
            );


            $("#txt3").ligerComboBox(
                {
                    url: 'http://127.0.0.1:8080/background/pinyin/list.html',
                    valueField: 'id',
                    textField: 'name',
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400,
                    renderItem: function (e)
                    { 
                        var data = e.data, key = e.key;
                        // alert(data + "," + key);
                        var out = [];
                        out.push('<div>' + this._highLight(data.name, key) + '</div>');
                        out.push('<div class="desc">备注:' + data.desc + '</div>');
                        return out.join('');
                    }
                }
            );
        });
         
    </script>
    <style type="text/css">
        .desc {
            background: #fafafa; color:ActiveCaption;
            border-bottom:1px solid #d3d3d3; margin-top:3px; margin-bottom:3px;
        } 
        .l-over .desc,.l-selected .desc {
            background: none;
        }
    </style>
</head>
<body style="padding:10px">  
	
	
    <input type="text" id="txt2" style="width: 80px;"/><br />   

    <input type="text" id="txt3"/>
    
    <div class="liger-button"></div>
 <div style="display:none;">
 
</div>
</body>
</html>
