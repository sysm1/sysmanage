<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/common/header.jsp"%>
		
		<title>Untitled Document</title>
		<link rel="stylesheet" href="${ctx}/themes/blue/style.css" type="text/css" id="" media="print, projection, screen" />
		<script type="text/javascript" src="${ctx}/js/jquery.tablesorter.js"></script>
		<script type="text/javascript">
		$(function() {
			$("table").tablesorter({debug: true});
		});
		</script>
	</head>
	<body>
	<table id="rowspan" cellspacing="0" class="tablesorter">
	<thead>
		<tr>
			<th>Major</th>
			<th>Gender</th>
			<th>English</th>
			<th>Japanese</th>
			<th>Calculus</th>
			<th>Geometry</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Student01</td>
			<td>Languages</td>
			<td>male</td>
			<td>80</td>
			<td>70</td>
			<td>75</td>
			<td>80%</td>
		</tr>
		<tr>
			<td>Student02</td>
			<td>Mathematics</td>
			<td>male</td>
			<td>90</td>
			<td>88</td>
			<td>100</td>
			<td>90%</td>

		</tr>
		<tr>
			<td>Student03</td>
			<td>Languages</td>
			<td>female</td>
			<td>85</td>
			<td>95</td>
			<td>80</td>
			<td>85%</td>
		</tr>
	</tbody>
</table>

<table id="rowspan2" cellspacing="0">
	<thead>

       <tr>
               <th colspan="2"> something</th>
               <th> Group of information 1</th>
               <th colspan="2"> Group of information 2</th>
       </tr>
       <tr>
               <th> Col 1</th>
               <th> Col 2</th>
               <th> Col 3</th>
               <th> Col 4</th>
               <th> Col 5</th>
       </tr>

	</thead>
	<tbody>
		<tr>
			<td>Student01</td>
			<td>Languages</td>
			<td>male</td>
			<td>80</td>
			<td>70</td>
			
		</tr>
		<tr>
			<td>Student02</td>
			<td>Mathematics</td>
			<td>male</td>
			<td>90</td>
			<td>88</td>
			
		</tr>
		<tr>
			<td>Student03</td>
			<td>Languages</td>
			<td>female</td>
			<td>85</td>
			<td>95</td>
			
		</tr>
	</tbody>
</table>
<table id="rowspan3" cellspacing="0">
	<thead>
       <tr>
               <th> Col 1</th>
               <th> Col 2</th>
               <th> Col 3</th>
               <th> Col 4</th>
               <th> Col 5</th>
       </tr>

	</thead>
	<tbody>
		<tr>
			<td>Student01</td>
			<td>Languages</td>
			<td>male</td>
			<td>80</td>
			<td>70</td>
			
		</tr>
		<tr>
			<td>Student02</td>
			<td>Mathematics</td>
			<td>male</td>
			<td>90</td>
			<td>88</td>
			
		</tr>
		<tr>
			<td>Student03</td>
			<td>Languages</td>
			<td>female</td>
			<td>85</td>
			<td>95</td>
			
		</tr>
	</tbody>
</table>
	</body>
</html>

