<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>readPost</h1>
	<div id="page-info">
		<input type="hidden" id="nowPage" :value="vo.nowPage">
		<input type="hidden" id="hiddenCategory" :value="vo.category">
		<input type="hidden" id="keyword" :value="vo.keyword">
	</div>
	<div id="read-post-div">
		<table id="read-table">
			<tbody>
				<tr>
					<td>글 번호</td>
					<td colspan="5" id="bbsId">{{ post.bbsId }}</td>
				</tr>
				<tr>
					<td>글제목</td>
					<td colspan="3">{{ post.title }}</td>
					<td>조회 수</td>
					<td>{{ post.readCnt + 1 }}</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>{{ post.updtNm }}</td>
					<td>작성 날짜</td>
					<td>{{ post.registDt }}</td>
					<td>수정 날짜</td>
					<td>{{ post.updtDt }}</td>
				</tr>
				<tr>
					<td colspan="6"><pre>{{ post.content }}</pre></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6">
						<button type="button" @click="goModify(post.bbsId)">수정하기</button>
						<button type="button" @click="delConfirm(post.bbsId)">삭제하기</button>
						<button type="button" @click="goList()">목록으로</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
<script>
	var readPostDiv = new Vue({
		el : "#read-post-div",
		data : function(){
			return {
				post : ${post},
				vo : ${vo}
			}
		},
		methods : {
			goModify : function(id) {
				location.href="/editForm?category=" + this.vo.category
				+ "&keyword=" + this.vo.keyword + "&nowPage=" 
				+ this.vo.nowPage + "&bbsId=" + id;
			},
			delConfirm : function(id) {
				var result = confirm("정말 삭제하시겠습니까?");
				if(result){
					$.ajax({
						url : "/deletePost?bbsId=" + id,
						method : "GET",
						success : function(result){
							if(result = 1){
								alert("삭제 성공");
								location.href="/list";
							} else {
								alert("삭제 실패");
							}
						},
						error : function(error, status, msg){
							alert("데이터 전송 실패");
						}
					})
				}else{
					alert("삭제를 취소하였습니다.")
				}
			},
			goList : function() {
				location.href="/list?category=" + this.vo.category
				+ "&keyword=" + this.vo.keyword + "&nowPage=" 
				+ this.vo.nowPage;
			}
		},
		mounted : function() {
			var readPostDiv = this;
		}
	})
</script>
</html>