<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


    <link href="/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css">
    <style type="text/css">
    </style>
    <script src="/js/jquery-1.8.3.js" type="text/javascript"></script>  
    <script src="/ligerUI/js/core/base.js" type="text/javascript"></script>
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
                    url: '/background/pinyin/list.html',
                    valueField : 'id',
                    textField: 'name',
                    columns: columns,
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400
                }
            );
 
            $("#txt2").ligerComboBox(
                {
                    url: '/background/pinyin/list.html',
                    valueField: 'id',
                    textField: 'name', 
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400 
                }
            );
 
 
            $("#txt3").ligerComboBox(
                {
                    url: '/background/pinyin/list.html',
                    valueField: 'id',
                    textField: 'name',
                    selectBoxWidth: 400,
                    autocomplete: true,
                    width: 400,
                    renderItem: function (e)
                    { 
                        var data = e.data, key = e.key;
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
 
   
 
    <div class="l-text-wrapper"><div class="l-text l-text-combobox" style="width: 400px;"><input type="text" id="txt2" class="l-text-field" ligeruiid="txt2" style="width: 380px;"><div class="l-text-l"></div><div class="l-text-r"></div><div class="l-trigger"><div class="l-trigger-icon"></div></div><div class="l-trigger l-trigger-cancel" style="display: none;"><div class="l-trigger-icon"></div></div></div><input type="hidden" name="txt2_val" id="txt2_val" data-ligerid="txt2"></div><br>   
 
    <div class="l-text-wrapper"><div class="l-text l-text-combobox" style="width: 400px;"><input type="text" id="txt3" class="l-text-field" ligeruiid="txt3" style="width: 380px;"><div class="l-text-l"></div><div class="l-text-r"></div><div class="l-trigger"><div class="l-trigger-icon"></div></div><div class="l-trigger l-trigger-cancel" style="display: none;"><div class="l-trigger-icon"></div></div></div><input type="hidden" name="txt3_val" id="txt3_val" data-ligerid="txt3"></div>
    <div class="liger-button"></div>
 <div style="display:none;">
  
</div>
