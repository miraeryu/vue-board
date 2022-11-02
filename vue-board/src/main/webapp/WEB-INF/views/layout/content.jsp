<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>CONTENT</h1>
	<div id="app">
		{{ message }}
		<button @click="change">change</button>
	</div>
</body>
<script>
	const { createApp } = Vue
	
	createApp({
		data() {
			return {
				message : 'Hello Vue!'
			}
		},
		methods : {
			change : function() {
					if(this.message == 'Hello Vue!'){
						this.message = 'Hello Vue Method!'
					} else {
						this.message = 'Hello Vue!'
					}
						
				}
			}
	}).mount('#app')
</script>
</html>