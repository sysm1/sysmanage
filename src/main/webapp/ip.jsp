<!DOCTYPE HTML>
<html>
<head>
<title>js获取本机mac地址，IP地址，计算机名</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="MSHTML 6.00.2800.1106" name="GENERATOR">
</head>
    
<body> 
<object id=locator classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></object> 
<object id=foo classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></object> 
<script language="JScript"> 
alert(1);
    var service = locator.ConnectServer(); 
    var MACAddr ; 
    var IPAddr ; 
    var DomainAddr; 
    var sDNSName; 
    service.Security_.ImpersonationLevel=3; 
    service.InstancesOfAsync(foo, 'Win32_NetworkAdapterConfiguration'); 
</script> 
<script language="JScript" event="OnCompleted(hResult,pErrorObject, pAsyncContext)" for="foo"> 
    document.forms[0].txtMACAddr.value=unescape(MACAddr); 
    document.all.txtIPAddr.value=unescape(IPAddr); 
    document.forms[0].txtDNSName.value=unescape(sDNSName); 
    //document.formbar.submit(); 
</script> 
<script language="JScript" event="OnObjectReady(objObject,objAsyncContext)" for="foo"> 
if(objObject.IPEnabled != null && objObject.IPEnabled != "undefined" && objObject.IPEnabled == true) { 
    if(objObject.MACAddress != null && objObject.MACAddress != "undefined") {
        MACAddr = objObject.MACAddress; 
    }
    if(objObject.IPEnabled && objObject.IPAddress(0) != null && objObject.IPAddress(0) != "undefined") {
        IPAddr = objObject.IPAddress(0); 
    }
    if(objObject.DNSHostName != null && objObject.DNSHostName != "undefined") {
        sDNSName = objObject.DNSHostName; 
    }
}
alert(1);
</script> 
    
<form id="formfoo" name="formbar" action="#" method="post">
<input value="00:05:5D:0E:C7:FA" name="txtMACAddr">
<input value="10.241.91.51" name="txtIPAddr">
<input value="typ" name="txtDNSName">
</form>
</body>
</html>