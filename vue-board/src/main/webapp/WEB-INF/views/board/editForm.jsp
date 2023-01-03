<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="edit-insert" id="edit-insert">
		<p><h1 v-if="post.bbsId == 0">InsertForm</h1></p>
		<p><h1 v-if="post.bbsId != 0">editForm</h1></p>
		<div id="page-info">
			<input type="hidden" id="nowPage" :value="post.nowPage">
			<input type="hidden" id="hiddenCategory" :value="post.category">
			<input type="hidden" id="keyword" :value="post.keyword">
		</div>
		<div class="edit-form">
			<form>
				<input type="hidden" name="bbsId" id="bbsId" v-model="post.bbsId">
				<table id="edit-form-table">
					<tbody>
						<tr>
							<td>글제목</td>
							<td><input type="text" name="title" id="title" placeholder="제목을 입력하세요." v-model="post.title"></td>
						</tr>
						<tr>
							<td>수정자</td>
							<td><input type="text" name="updtNm" id="updtNm" placeholder="작성자를 입력하세요." v-model="post.updtNm"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea name="content" id="content" placeholder="내용을 입력하세요." v-model="post.content"></textarea></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td>{{ txtLength }}</td>
							<td>
							<span v-if="post.bbsId == 0">
								<button type="button" @click="editConfirm()">등록</button>
							</span>
							<span v-if="post.bbsId != 0">
								<button type="button" @click="editConfirm()">확인</button>
							</span>
								<button type="button" @click="listConfirm()">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</form>
		</div>
	</div>
</body>
<script>
	var editTable = new Vue({
		el : "#edit-insert",
		data : function(){
			return {
				post : ${post},
				formTitle : 'InsertForm',
				txtLength : 0
			}
		},
		methods : {
			editConfirm : function(){
				let vo = {
						bbsId : this.post.bbsId,
						title : this.post.title,
						registNm : this.post.updtNm,
						content : this.post.content
						};
				
				if(!vo.title || !vo.registNm || !vo.content){
					alert("입력되지 않은 데이터가 있습니다.")
				}else{
					$.ajax({
						url : "/editPost",
						method : "POST",
						data : JSON.stringify(vo),
						contentType: "application/json; charset=UTF-8",
						success : function(result){
							if(result = 1 && vo.bbsId != 0){
								alert("수정 성공");
								location.href="/list";
							} else if(result = 1 && vo.bbsId == 0){
								alert("등록 성공");
								location.href="/list";
							} else if(result = 0){
								alert("알 수 없는 오류로 인한 전송 실패")
							}
						},
						error : function(err){
							alert("에러 발생 : " + err);
						}
						
					})
				}
			},
			listConfirm : function() {
				var result = confirm("작성중이던 내용이 모두 사라집니다. \n목록으로 돌아가시겠습니까?");
				console.log("/list?keyword=" + this.post.keyword
						+ "&category="+ this.post.category
						+ "&nowPage=" 
						+ this.post.nowPage)
				if(result){
					if(!this.post.keyword){
						this.post.keyword = '';
					}
					location.href="/list?keyword=" + this.post.keyword
					+ "&category="+ this.post.category
					+ "&nowPage=" + this.post.nowPage;
				}else{
					alert("요청을 취소하였습니다.")
				}
			},
			getTextLength : function() {
				var txt = this.post.content;
				var txtLength = 0;
				for (var i = 0; i < txt.length; i ++){
					if (escape(txt.charAt(i)).length == 6){
						txtLength++;
					}
					txtLength++;
				}
				return txtLength;
			}
		},
		watch : {
			/*
			'post.title' : function(value, oldValue){
				console.log(value);
			}
			*/
			//내용 글자수세기
			'post.content' : function (value){
				var txt = value;
				var length = 0;
				for (var i = 0; i < txt.length; i++){
					if (escape(txt.charAt(i)).length == 6){
						length++;
					}
					length++;
				}
				this.txtLength = length;
			}
		},
		mounted : function() {
			var editTable = this;
		}
	})
		
</script>
</html>