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
	/*
	Vue@3에서의 방식
	Vue@2 >> Vue@3 : CDN에서 Vue@2 >> Vue@3만 바꿔주면 됨
	Vue.createApp({
		el : 안넣어도됨(mount 옆에서 알려주고있으니까)
		기타는 기본 Vue@2와 비슷함
	}).mount("구현위치")
	*/
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