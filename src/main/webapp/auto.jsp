<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

 <script src="/js/jquery-1.8.3.js"></script>
 <script type="text/javascript" src="/ligerUI/js/ligerui.min.js"></script>
 
   <style type="text/css">
    </style>
    
    <script src="/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>

    <!-- {id:0, name:a0cname, desc:0desc} --> 

    <script type="text/javascript">
        $(function ()
        {
            var columns = [
                { header: 'ID', name: 'id', width: 80 },
                { header: '名字', name: 'clothName', width: 170 }
            ];

            $("#txt1").ligerComboBox(
                {
                    url: '/background/pinyin/cloth.html',
                    valueField : 'id',
                    textField: 'clothName',
                    columns: columns,
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400
                }
            );

            $("#txt2").ligerComboBox(
                {
                    url: '/background/pinyin/factory.html',
                    valueField: 'id',
                    textField: 'name', 
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400 
                }
            );


            $("#txt3").ligerComboBox(
                {
                    url: '/background/pinyin/technology.html',
                    valueField: 'id',
                    textField: 'name',
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400,
                    renderItem: function (e)
                    { 
                    	/**
                        var data = e.data, key = e.key;
                        var out = [];
                        out.push('<div>' + this._highLight(data.name, key) + '</div>');
                        out.push('<div class="desc">备注:' + data.desc + '</div>');
                        return out.join('');
                        **/
                        alert(e);
                    }
                }
            );
        });
         
    </script>
    
</head>
<body style="padding:10px">  
	
	布种：<input type="text" id="txt1"/><br /> 

    工厂：<input type="text" id="txt2"/><br />   

    工艺：<input type="text" id="txt3"/><br/>
    
    <div class="liger-button"></div>
    
 <div style="display:none;">
 
</div>
</body>
</html>
