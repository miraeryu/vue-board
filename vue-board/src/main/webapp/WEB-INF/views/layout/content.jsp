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
		<p>{{ x }}<input v-model="x"></p>
		<p>{{ y }}<input v-model="y"></p>
		<p>= <span v-text="result"></span></p>
	</div>
</body>
<script>
	
	const app = Vue.createApp({
		data() {
			return {
				x : 0, 
				y : 0, 
				lastResult : 0,
				message : 'Hello Vue!'
			}
		},
		methods : {
			change : function() {
					this.message = this.message == 'Hello Vue!' ?  'Hello Vue button' : 'Hello Vue!'
						
				}
			},
		computed : {
			
		}
	}).mount("#app")
</script>
</html>