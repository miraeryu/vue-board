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
			<select id="category" name="category" v-model="info.category">
				<option value="all">제목/내용</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="updtNm">작성자</option>
			</select>
			<input type="text" id="keyword" name="keyword" v-model="info.keyword" @keyup:enter="search(1)">
			<button type="submit" id="searchBtn" name="searchBtn" @click="search(1)">검색</button>
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
				<tr v-if="list.length > 0" v-for="(row, idx) in list">
					<td>{{ row.bbsId }}</td>
					<td><a class="selectTitle" href="#" @click="readPost(row.bbsId)">{{ row.title }}</a></td>
					<td>{{ row.updtNm }}</td>
					<td>{{ row.registDt }}</td>
					<td>{{ row.readCnt }}</td>
				</tr>
				<tr v-if="list.length = 0">
					<td colspan="5"><h4>검색 결과가 없습니다.</h4></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>{{ info.nowPage }} 페이지</td>
					<td colspan="4">
					<pagination :pageinfo="info" @move="search"></pagination>
					</td>
				</tr>
				<tr>
					<td colspan="5"><button type="button" @click="goForm()">새글쓰기</button></td>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
<jsp:include page="/WEB-INF/views/board/components/pagination.jsp"/>
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
 
	var table = new Vue({
		el : "#listTable",
		data : {
			list : ${ list },
			info : ${ info }
		},
		methods : {
			search : function(num){
				console.log("category : " + this.info.category + ", keyword : " + this.info.keyword + ", nowPage : " + this.info.nowPage)
				var table = this;
				this.info.nowPage = num;
				console.log(nowPage);
				$.ajax({
					url : "/listLoad",
					method : "GET",
					data : { 
						nowPage : this.info.nowPage,
						category : this.info.category,
						keyword : this.info.keyword
					},
					success : function(data){
						table.list = data;
						console.log(data)
					},
					error : function(error){
						alert(error);
					}
				})
			},
			readPost : function(id) {
				location.href="/readPost?bbsId=" + id;
			},
			goForm : function() {
				location.href="/editForm";
			}
		},
		mounted : function (){
			var table = this;
		}
	})
</script>
</html>