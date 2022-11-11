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
		<form action="/list" method="GET">
			<select id="category" name="category" v-model="info.category">
				<option value="all">제목/내용</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="updtNm">작성자</option>
			</select>
			<input type="text" id="keyword" name="keyword" v-bind:value="info.keyword">
			<button type="submit" id="searchBtn" name="searchBtn">검색</button>
			<!-- 
			<input type="text" id="keyword" name="keyword" v-model="info.keyword" @keyup:enter="search(1)">
			<button type="button" id="searchBtn" name="searchBtn" @click="search(1)">검색</button>
			 -->
		</form>
		</div>
		<div id="page-info">
			<input type="hidden" id="nowPage" v-bind:value="info.nowPage">
			<input type="hidden" id="hiddenCategory" v-bind:value="info.category">
			<input type="hidden" id="hiddenKeyword" v-bind:value="info.keyword">
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
					<td><a class="selectTitle" href="#" v-on:click="readPost(row.bbsId)">{{ row.title }}</a></td>
					<td>{{ row.updtNm }}</td>
					<td>{{ row.registDt | cuttingHour }}</td>
					<td>{{ row.readCnt }}</td>
				</tr>
				<tr v-if="list.length == 0">
					<td colspan="5"><h4>검색 결과가 없습니다.</h4></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>{{ info.nowPage }} 페이지</td>
					<td colspan="4">
					<!-- 
					<pagination :pageinfo="info"></pagination>
					 -->
					<ul class="page">
						<li v-if="info.nowPage != 1 ">
							<a href="#" v-on:click="search()">prev</a>
						</li>
						<li v-for="i in numbers"><a v-on:click="search()">{{ i }}</a></li>
						<li v-if="info.maxPageCnt > 1 && info.nowPage != info.maxPageCnt">
							<a href="#" v-on:click="search()">next</a>
						</li>
					</ul>
					</td>
				</tr>
				<tr>
					<td colspan="5"><button type="button" v-on:click="goForm()">새글쓰기</button></td>
				</tr>
			</tfoot>
		</table>
	</div>
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
 
	var table = new Vue({
		el : "#listTable",
		data : {
			list : ${ list },
			info : ${ info },
			category : 'all'
		},
		computed : {
			page : function() {
				let numbers = [];
				for (let i = (info.nowPage-1); i <= (info.nowPage +1); i++ ) {
					if (i > 0 && info.maxPageCnt >= i) {
						number.push(i);
					}
				}
				console.log(number)
				return numbers;
			}
		},
		filters : {
			/*
			 원하는 항목에 {{ row.registDt(=값) | cuttingHour(=filters 안에 생성된 메소드명) }} 형식으로 작성
			 이미 나와있는 데이터를 한번 더 조작할 수 있음(실제 값은 변경되지않음 >> readPost에서는 시간까지 나옴)
			*/
			cuttingHour : function(cutDate){			// 시간 정보 자르기
				return cutDate.substr(0, 10);
			}
		},
		methods : {
			search : function(prop){
				console.log("category : " + this.info.category + ", keyword : " + this.info.keyword + ", nowPage : " + this.info.nowPage)
				console.log(prop)
				$.ajax({
					url : "/listLoad2",
					method : "POST",
					data : JSON.stringify(prop),
					dataType : "JSON",
					contentType: "application/json; charset=UTF-8",
					success : function(data){
						table.list = data;
						console.log(data);
					},
					error : function(error){
						alert(error);
					}
				})
				
			},
			readPost : function(id) {
				location.href="/readPost?category=" + this.info.category
							+ "&keyword=" + this.info.keyword + "&nowPage=" 
							+ this.info.nowPage + "&bbsId=" + id;
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