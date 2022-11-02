<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="listTable">
		<div id="searchKey">
			<form>
				<select id="category" name="category" class="category">
					<option value="all">제목/내용</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="updtNm">작성자</option>
				</select>
				<input type="text" id="keyword" name="keyword" class="keyword">
				<button type="button" id="searchBtn" name="searchBtn" @click="search">검색</button>
			</form>
		</div>
		<table id="table-main">
			<colgroup>
				<col width="10%">
				<col width="45%">
				<col width="15%">
				<col width="20%">
				<col width="10%">
			</colgroup>
			<thead>
				<th>글번호</th>
				<th>글제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</thead>
			<tbody id="listTabletbody">
				<tr v-if="list.length > 0" v-for="(row, idx) in list" :key="row">
					<td>{{ row.bbsId }}</td>
					<td><a class="selectTitle" href="#" @click="readPost({{row.bbsId}})">{{ row.title }}</a></td>
					<td>{{ row.updtNm }}</td>
					<td>{{ row.updtDt }}</td>
					<td>{{ row.readCnt }}</td>
				</tr>
				<tr v-if="list.length == 0">
					<td colspan="5"><h4>검색 결과가 없습니다.</h4></td>
				</tr>
			</tbody>
		</table>
</body>
<script>
	const table = Vue.createApp({
		el : "#listTable",
		data : function(){
			return {
				list : []
			}
		},
		created : function(){
			let list = this.list;
			$.ajax({
				url : "/listLoad",
				data : { },
				success : function(data){
					console.log(data)
					data.forEach(element => {
						list.push(element);
					});
				},
				error : function(error){
					alert(error);
				}
			})
		},
		methods : {
			search : function(){
				let list = this.list;
				console.log($("#category").val())
				$.ajax({
					url : "/listLoad",
					data : { 
						category : $("#category").val(),
						keyword : $("#keyword").val()
					},
					success : function(data){
						$('#listTabletbody tr').remove();
						console.log(data)
						data.forEach(element => {
							list.push(element);
						});
					},
					error : function(error){
						alert(error);
					}
				})
			}
		}
	}).mount('#listTable')
</script>
</html>