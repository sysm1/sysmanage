<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>javascript获得客户端硬件信息</title>
<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
<meta name="vs_targetSchema"
	content="http://schemas.microsoft.com/intellisense/ie5">
<script id=clientEventHandlersJS language=javascript>
<!--
	function Button2_onclick() {//CPU 信息 
		var locator = new ActiveXObject("WbemScripting.SWbemLocator");
		var service = locator.ConnectServer(".");
		var properties = service.ExecQuery("SELECT * FROM Win32_Processor");
		var e = new Enumerator(properties);
		document.write("<table border=1>");
		for (; !e.atEnd(); e.moveNext()) {
			var p = e.item();
			document.write("<tr>");
			document.write("<td>" + p.Caption + "</td>");
			document.write("<td>" + p.DeviceID + "</td>");
			document.write("<td>" + p.Name + "</td>");
			document.write("<td>" + p.CpuStatus + "</td>");
			document.write("<td>" + p.Availability + "</td>");
			document.write("<td>" + p.Level + "</td>");
			document.write("<td>" + p.ProcessorID + "</td>");
			document.write("<td>" + p.SystemName + "</td>");
			document.write("<td>" + p.ProcessorType + "</td>");
			document.write("</tr>");
		}
		document.write("</table>");
	}

	function Button1_onclick() {//软盘信息 
		var locator = new ActiveXObject("WbemScripting.SWbemLocator");
		var service = locator.ConnectServer(".");
		var properties = service.ExecQuery("SELECT * FROM Win32_FloppyDrive");
		var e = new Enumerator(properties);
		document.write("<table border=1>");
		for (; !e.atEnd(); e.moveNext()) {
			var p = e.item();
			document.write("<tr>");
			document.write("<td>" + p.Description + "</td>");
			document.write("<td>" + p.DeviceID + "</td>");
			document.write("<td>" + p.Status + "</td>");
			document.write("<td>" + p.Manufacuturer + "</td>");
			document.write("</tr>");
		}
		document.write("</table>");
	}

	function Button1_onclick() {//CD-ROM 信息 
		var locator = new ActiveXObject("WbemScripting.SWbemLocator");
		var service = locator.ConnectServer(".");
		var properties = service.ExecQuery("SELECT * FROM Win32_CDROMDrive");
		var e = new Enumerator(properties);
		document.write("<table border=1>");
		for (; !e.atEnd(); e.moveNext()) {
			var p = e.item();
			document.write("<tr>");
			document.write("<td>" + p.Caption + "</td>");
			document.write("<td>" + p.Description + "</td>");
			document.write("<td>" + p.Drive + "</td>");
			document.write("<td>" + p.Status + "</td>");
			document.write("<td>" + p.MediaLoaded + "</td>");
			document.write("</tr>");
		}
		document.write("</table>");
	}

	function Button1_onclick() {//键盘信息 
		var locator = new ActiveXObject("WbemScripting.SWbemLocator");
		var service = locator.ConnectServer(".");
		var properties = service.ExecQuery("SELECT * FROM Win32_Keyboard");
		var e = new Enumerator(properties);
		document.write("<table border=1>");
		for (; !e.atEnd(); e.moveNext()) {
			var p = e.item();
			document.write("<tr>");
			document.write("<td>" + p.Description + "</td>");
			document.write("<td>" + p.Name + "</td>");
			document.write("<td>" + p.Status + "</td>");
			document.write("</tr>");
		}
		document.write("</table>");
	}

	function Button1_onclick() {//主板信息 
		var locator = new ActiveXObject("WbemScripting.SWbemLocator");
		var service = locator.ConnectServer(".");
		var properties = service.ExecQuery("SELECT * FROM Win32_BaseBoard");
		var e = new Enumerator(properties);
		document.write("<table border=1>");
		for (; !e.atEnd(); e.moveNext()) {
			var p = e.item();
			document.write("<tr>");
			document.write("<td>" + p.HostingBoard + "</td>");
			document.write("<td>" + p.Manufacturer + "</td>");
			document.write("<td>" + p.PoweredOn + "</td>");
			document.write("<td>" + p.Product + "</td>");
			document.write("<td>" + p.SerialNumber + "</td>");
			document.write("<td>" + p.Version + "</td>");
			document.write("</tr>");
		}
		document.write("</table>");
	}
//-->
</script>
</head>
<body>
	<INPUT id="Button1" type="button" value="Button" name="Button1"
		language=javascript onclick="return Button1_onclick()">
</body>
</html>