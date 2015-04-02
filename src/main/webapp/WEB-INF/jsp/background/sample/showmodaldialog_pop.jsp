<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr align="center">
    <td>点击链接：</td>
    <td><a href="#" onclick="check('Share JavaScript')">Share JavaScript</a></td>
    <td><a href="#" onclick="check('sharejs.com')">sharejs.com</a></td>
</tr>
</table>
</body>
</html>
<script>
function check(s){
window.returnValue =s;
window.opener=null;
window.close();
}
</script>

</body>
</html>