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
			<select id="category" name="category" v-model="category">
				<option value="all">제목/내용</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="updtNm">작성자</option>
			</select>
			<input type="text" id="keyword" name="keyword" v-model="keyword" @keyup:enter="search()">
			<button type="button" id="searchBtn" name="searchBtn" @click="search()">검색</button>
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
				<tr v-if="list.length" v-for="(row, idx) in list">
					<td>{{ row.bbsId }}</td>
					<td><a class="selectTitle" href="#" @click="readPost()">{{ row.title }}</a></td>
					<td>{{ row.updtNm }}</td>
					<td>{{ row.updtDt }}</td>
					<td>{{ row.readCnt }}</td>
				</tr>
				<tr v-if="nothing">
					<td colspan="5"><h4>검색 결과가 없습니다.</h4></td>
				</tr>
				</tr>
			</tbody>
		</table>
</body>
<script>
/* vue 객체 
 * el : 선택 html요소 내부에 있는 html요소들을 vue가 컨트롤 해줌.
 * data : vue 객체 내부에서 컨트롤 할 수 있는 변수
 * methods : vue 객체 내부에서 컨트롤 할 수 있는 메소드
 * filters : 데이터 값을 로직을 통해 걸러 데이터를 화면에 반환해줌, 실 데이터는 바뀌지 않음
 * computed : vue data 객체 내부에 있는 변수들의 값이 바뀔때 감지를 해주고 function을 통해 로직 처리가 가능
 * watch : vue data 객체 내부에 있는 변수들의 값이 바뀔때 감지를 해주고 function을 통해 로직 처리가 가능
    - computed와 watch가 하는 기능은 비슷하지만 다름.
 * mounted : vue 객체가 메모리에 올라가고, 화면에 로드될 때 function을 통해 로직이 실행됨. 
 */
	const table = Vue.createApp({
		el : "#listTable",
		data : function(){
			return {
				list : ${ list },
				category : null,
				keyword : null,
				nothing : false
			}
		},
	
		methods : {
			search : function(){
				let list = [];
				console.log("category : " + this.category + ", keyword : " + this.keyword)
				$.ajax({
					url : "/listLoad",
					data : { 
						category : this.category,
						keyword : this.keyword
					},
					success : function(data){
						$('#listTabletbody tr').remove();
						console.log(data);
						data.forEach(element => {
							list.push(element);
						});
						if (!data){
							this.nothing = true;
						}
						console.log(list);
					},
					error : function(error){
						alert(error);
					}
				})
			},
			readPost : function() {
				console.log(this.bbsId)
			}
		}
	}).mount('#listTable')
</script>
</html>