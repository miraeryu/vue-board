<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.pageStyle {
		font-weight : bold;
		color : red;
	}
</style>
</head>
<body>
	<div id="listTable">
		<div id="searchKey">
		<form action="/list" method="GET">
			<select id="category" name="category" v-model="categoryInfo">
				<option value="all">제목/내용</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="updtNm">작성자</option>
			</select>
			<input type="text" id="keyword" name="keyword" v-bind:value="keyInfo">
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
					<td><a class="selectTitle" href="#" v-on:click="readPost(row.bbsId)">{{ row.title | cuttingTitle }}</a></td>
					<td>{{ row.updtNm }}</td>
					<td>{{ row.registDt | cuttingDate }}</td>
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
					<ul class="page">
						<li v-if="info.nowPage != 1 ">
							<a href="#" v-on:click="search('prev')">prev</a>
						</li>
						<li v-for="i in info.pages"><a href="#" v-on:click="search(i)" v-bind:class="{'pageStyle' : i == info.nowPage}">{{ i }}</a></li>
						<li v-if="info.maxPageCnt > 1 && info.nowPage != info.maxPageCnt">
							<a href="#" v-on:click="search('next')">next</a>
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

 	/*
 	Vue@2 기본 방식
 	var '뷰이름' = new Vue({
 		el : "뷰가 동작하는 위치"
 	})
 	*/

	var table = new Vue({
		/*
		원하는 템플릿을 가져오고 싶을 때
		template : "template의 클래스명/ID명" 혹은 `<html코드 내용>`
		*/
		
		/*
		el : vue 객체를 실행시킬 장소. 
		<div id="listTable"></div> 내부에 이 Vue를 동작시키겠습니다.
		*/
		el : "#listTable",
		/*
		data : el 안에서 내가 동작시키는/데이터를 주고 받는 변수 선언
		*/
		data : {
			list : ${ list },
			info : ${ info }
		},
		/*
		computed : 계산 프로퍼티. 계산된 내용을 뷰 안에서 나타낼 때 사용함!
			계산프로퍼티 이름 : function(){
				return ....;
			}
		*/
		computed : {				
			//keyword가 null값일경우 빈칸으로, 아닐경우 원래 keyword값으로 나오도록 계산
			keyInfo : function() {
				//console.log(this.info.keyword);
				if(this.info.keyword == 'null'){
					return this.info.keyword = '';
				}else {
					return this.info.keyword;
				}
			},
			categoryInfo : {
				/*
				keyword처럼 v-bind:value 에 입력할때는 필요없지만 
				v-model에 입력할때는 getter,setter가 필요함
				*/
				get () {
					if(this.info.category = 'null'){
						return this.info.category = 'all';
					} else {
						return this.info.category;
					}
				},
				set (newCategory){
					return newCategory;
				}
			}
			
		},
		filters : {
			/*
			 원하는 항목에 
			 {{ row.registDt(=값) | cuttingHour(=filters 안에 생성된 메소드명) | ...(여러개 연결가능)}} 
			 형식으로 작성
			 이미 나와있는 데이터를 한번 더 다듬을 수 있음(실제 값은 변경되지않음)
			 데이터를 계산 >> computed
			 데이터를 다듬음 >> filters
			 -조회수 일정이상  bold처리, 작성당일=시간표시/1일이상경과=날짜표시 등 할 수 있으면 해보기~~
			*/
			cuttingDate : function(cutDate){			// 시간 정보 자르기
				let today = new Date();
				let nowDate = today.getFullYear() + '-' + (today.getMonth() + 1)
								+ '-' + today.getDate();
				if(nowDate == cutDate.substr(0, 10)){
					return cutDate.substr(10);
				} else {				
					return cutDate.substr(0, 10);
				}
			},
			cuttingTitle : function(cutTitle){			// 제목 길이 자르기
				if(cutTitle.length > 20){
					return cutTitle.substr(0, 20) + "...";
				} else {
					return cutTitle;
				}
			}
		},
		/*
		watch : 특정 데이터의 변화를 감지하여 자동으로 로직을 수행
		동작 테스트 >> editForm>title
		*/
		watch : {
			
		},
		/*
		Vue 내부에서 쓸 함수들
		*/
		methods : {
			search : function(page){
				//넘어갈 페이지 넘버 구하기
				let pageNumber = 0;
				switch(page) {
					case 'prev' : 
						pageNumber = (this.info.nowPage - 1);
						break;
					case 'next' :
						pageNumber = (this.info.nowPage + 1);
						break;
					default :
						pageNumber = page;
						break;
				}
				//console.log("category : " + this.info.category + ", keyword : " + this.info.keyword + ", nowPage : " + this.info.nowPage)
				
				/*
				1.
				주소에 담아 전송
				*/
				/*
				location.href="/list?category=" + this.info.category
				+ "&keyword=" + this.info.keyword + "&nowPage=" 
				+ pageNumber;
				*/
				
				/*
				2.
				ajax 이용
				Map방식으로 두가지 데이터를 전송
				*/
				let prop = {
					category : this.info.category,
					keyword : this.info.keyword,
					nowPage : pageNumber
				}
				
				$.ajax({
					url : "/listLoad2",
					method : "POST",
					data : JSON.stringify(prop),
					dataType : "JSON",
					contentType: "application/json; charset=UTF-8",
					success : function(data){
						table.list = data.list;
						table.info = data.info;
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