<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml">
  <head>
   <title>JS获取客户端MAC地址</title>
   <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
   <meta name="generator" content="editplus" />
   <meta name="author" content="" />
   <meta name="keywords" content="" />
   <meta name="description" content="" />
   <style type="text/css">
   </style>
     <script event="OnObjectReady(objObject,objAsyncContext)" for="foo"> 
         if(objObject.IPEnabled != null && objObject.IPEnabled != "undefined" && objObject.IPEnabled == true) { 
             if(objObject.MACAddress != null && objObject.MACAddress != "undefined" && objObject.DNSServerSearchOrder!=null) 
                 MACAddr = objObject.MACAddress; 
             if(objObject.IPEnabled && objObject.IPAddress(0) != null && objObject.IPAddress(0) != "undefined" && objObject.DNSServerSearchOrder!=null) 
                 IPAddr = objObject.IPAddress(0); 
             if(objObject.DNSHostName != null && objObject.DNSHostName != "undefined") 
                 sDNSName = objObject.DNSHostName; 
         } 
     </script>
     <script type="text/javascript">
         var MACAddr ; 
         var IPAddr ; 
         var DomainAddr; 
         var sDNSName; 
         function init() {
             var service = locator.ConnectServer(); 
             service.Security_.ImpersonationLevel=3; 
             service.InstancesOfAsync(foo, 'Win32_NetworkAdapterConfiguration'); 
         }
         function getMac() {
             document.getElementById('txtMac').value = unescape(MACAddr);
         }
		 function getIp()
		 {
			 document.getElementById('txtIp').value = unescape(IPAddr);
		 }
     </script>
  </head>
  <body onload="init()">
     <object id="locator" classid="CLSID:76A64158-CB41-11D1-8B02-00600806D9B6" VIEWASTEXT></object> 
     <object id="foo" classid="CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223"></object> 
     <input type="text" id="txtMac" />
     <input type="button" id="btn" value="获取Mac地址" onclick="getMac();" />
	 <input type="text" id="txtIp" />
	 <input type="button" id="btn" value="获取ip地址" onclick="getIp();" />
  </body>
 </html>
