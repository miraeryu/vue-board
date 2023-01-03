<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="header-div" id="header">
		<h1 id="header-title">==========게시판==========</h1>
	</div>
</body>
<script>
$(document).ready(function(){
	$("#header").on("click",function(){
		location.href="/list"
	})
})
</script>
</html>