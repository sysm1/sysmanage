<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/header.jsp"%>

<script type="text/javascript" src="js/ajaxfileupload.js"></script>

<script type="text/javascript">

</script>
</head>
<body>

	
	<form action="${ctx}/background/upload.html" method="post" enctype="multipart/form-data">
	
	<table>
		<tr>
			<td colspan="2" >上传图片:<input type="file" id="file1" name="file" />
			<input id="uploadFile1" type="submit" value="上传" /></td>
			<td colspan="2" ></td>
		</tr>
	</table>
	
	</form>
	
</body>
</html>