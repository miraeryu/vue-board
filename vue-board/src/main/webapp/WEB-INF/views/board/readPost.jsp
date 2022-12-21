<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#reply-table-head{
	background-color : lightgray;
	height : 2em;
}

#reply-table-head tr, td{
	border : 0 !important;
}

#reply{
	width : 100%;
	border : none;
	padding : 0;
}

#new-reply-title{
	text-align : left;
	font-weight : 800;
	font-size : 18px;
	background-color : lightgray;
}
.material-symbols-outlined {
  font-variation-settings:
  'FILL' 0,
  'wght' 400,
  'GRAD' 0,
  'opsz' 24
}

#edit-icon {
text-align : right;
}
</style>
</head>
<body>
	<h1>readPost</h1>
	<div id="page-info">
		<input type="hidden" id="nowPage" v-bind:value="vo.nowPage">
		<input type="hidden" id="hiddenCategory" v-bind:value="vo.category">
		<input type="hidden" id="keyword" v-bind:value="vo.keyword">
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
						<button type="button" v-on:click="goModify(post.bbsId)">수정하기</button>
						<button type="button" v-on:click="delConfirm(post.bbsId)">삭제하기</button>
						<button type="button" v-on:click="goList()">목록으로</button>
					</td>
				</tr>
			</tfoot>
		</table>
		<table id="reply-table">
			<thead id="reply-table-head">
				<tr><td colspan="3"><h3>  댓글</h3></td></tr>
			</thead>
			<tbody v-for="(reply, idx) in reply">
				<tr>
					<td>{{ reply.writer }}</td>
					<td>{{ reply.regDt | cuttingDate }}</td>
					<td id="edit-icon">
					<!-- 수정을 어떻게 할건지? component로 edit창을 새로 내보낼건지? 고민해야할부분임 -->
						<span class="material-symbols-outlined" v-on:click="reReply(reply.replyId)">border_color</span>
						<span class="material-symbols-outlined" v-on:click="replyEdit(reply.replyId)">edit_square</span>
						<span class="material-symbols-outlined" v-on:click="replyDel(reply.replyId)">close</span>
					</td>
				</tr>
				<tr>
					<td colspan="3"><pre>{{ reply.content }}</pre></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3" id="new-reply-title">  새로운 댓글 입력</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" id="writer" name="writer" placeholder="작성자명입력" v-model="newWriter">
					</td>
					<td>
						<input type="password" placeholder="비밀번호입력" v-model="newPassword">
						<button type="button" v-on:click="replySubmit()">등록</button>
					</td>
				</tr>
				<tr>
					<td colspan="3" id="reply-textarea">
						<textarea name="reply" id="reply" placeholder="댓글 내용 입력" v-model="newContent"></textarea>
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
				vo : ${vo},
				reply : ${reply},
				newWriter : '',
				newPassword : '',
				newContent : ''
			}
		},
		filters : {
			/*
			1.댓글 작성일자 오늘>시간만 표시, 오늘 이전>시간/날짜 모두 표시
			*/
			cuttingDate : function(cutDate){			// 시간 정보 자르기
				let today = new Date();
				let nowDate = today.getFullYear() + '-' + (today.getMonth() + 1)
								+ '-' + today.getDate();
				if(nowDate == cutDate.substr(0, 10)){
					return cutDate.substr(10, 6);
				} else {				
					return cutDate.substr(0, 10);
				}
			}
		},
		computed : {
			/*
			1.댓글번호(인덱스)+작성자
			2.작성일자!=수정일자의 경우 작성일자(수정됨:날짜) 표시
			*/
			
		},
		methods : {
			goModify : function(id) {
				location.href="/editForm?category=" + this.vo.category
				+ "&keyword=" + this.vo.keyword + "&nowPage=" 
				+ this.vo.nowPage + "&bbsId=" + id;
			},
			delConfirm : function(id) {
				let result = confirm("정말 삭제하시겠습니까?");
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
			},
			
			/*
			댓글 작업 메소드
			1.댓글 수정버튼
				ㄴ비밀번호 확인작업
			2.댓글 등록버튼
				ㄴ작성자명/비밀번호/내용 모두 필수 입력 확인
			3.댓글 삭제버튼
				ㄴ비밀번호 확인 작업
			*/
			reReply : function(replyId) {
				
			},
			replyEdit : function(replyId) {
				
			},
			replyDel : function(replyId) {
				let password = prompt("삭제를 원하시면 비밀번호를 입력해주세요.");
				if(password){
					let param = {
							rplPass : password,
							replyId : replyId,
							bbsId : this.post.bbsId
					}
					console.log(param);
					
					$.ajax({
						url : "/reply/delReply",
						method : "POST",
						timeout : 5000,
						data : JSON.stringify(param),
						dataType : "JSON",
						contentType : "application/json; charset=UTF-8",
						success : function(data) {
							if(data.passResult = 0){
								alert("댓글 삭제에 실패하였습니다.")
							} else if (data.passResult = 1){
								alert("댓글을 삭제하였습니다.")
							} else if (data.passResult = 2){
								alert("비밀번호가 맞지 않습니다.")
							}
							console.log(data.reply);
							readPostDiv.reply = data.reply;
						},
						error : function(error) {
							alert(error);
						}
					})
				}else{
					alert("삭제를 취소하였습니다.")
				}
			},
			replySubmit : function() {
				let replyVO = {
						content : this.newContent,
						writer : this.newWriter,
						rplPass : this.newPassword,
						bbsId : this.post.bbsId
				}
				console.log(replyVO);
				
				// 완료 후 새로고침을 위한 url 변수 선언
				/*
				let url = location.href="/readPost?category=" + this.vo.category
						+ "&keyword=" + this.vo.keyword + "&nowPage=" 
						+ this.vo.nowPage + "&bbsId=" + this.post.bbsId;
				*/
				$.ajax({
					url : "/reply/inAndUp",
					method : "POST",
					timeout : 5000,
					data : JSON.stringify(replyVO),
					dataType : "JSON",
					contentType : "application/json; charset=UTF-8",
					async : false,
					success : function(data) {
						if(data.result == 1){
							alert("댓글 등록 완료");
							readPostDiv.reply = data.reply;
							//location.href = url;
							this.newContent = null;
							this.newWriter = null;
							this.newPassword = null;
						} else {
							alert("알 수 없는 오류로 인한 데이터 전송 실패");
						}
					},
					error : function(error) {
						alert(error);
					}
				})
			}
		},
		mounted : function() {
			var readPostDiv = this;
		}
	})
</script>
</html>