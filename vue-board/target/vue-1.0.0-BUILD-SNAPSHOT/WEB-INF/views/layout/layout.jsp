<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>

<!-- Jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 공통 코드 연결 -->
<!-- 
<script src="/resources/js/common.js"></script>
 -->
<link rel="stylesheet" href="/resources/css/board.css">
<!-- vue.js CDN -->
<script src="https://unpkg.com/vue@2"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body>
		<tiles:insertAttribute name="header"/>
		<tiles:insertAttribute name="content" ignore="true"/>
		<tiles:insertAttribute name="footer"/>
</body>
</html>