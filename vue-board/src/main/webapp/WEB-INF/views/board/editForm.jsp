<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>EditForm</h1>
	<div id="page-info">
		<input type="hidden" id="nowPage" value="${ vo.nowPage }">
		<input type="hidden" id="hiddenCategory" value="${ vo.category }">
		<input type="hidden" id="keyword" value="${ vo.keyword }">
	</div>
	<div class="edit-form">
		<form>
			<input type="hidden" name="bbsId" id="bbsId" v-model="post.bbsId ">
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
						<td colspan="2">
						<span v-if="info.bbsId != 0">
							<button type="button" @click="editConfirm()">확인</button>
						</span>
						<span v-else>
							<button type="button" @click="insertConfirm()">등록</button>
						</span>
							<button type="button" @click="listConfirm()">취소</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
</body>
<script>
	const editTable = Vue.createApp({
		el : "#edit-form-table",
		data : function(){
			return {
				post : ${post}
			}
		}
	}).mount("#edit-form-table")
		
</script>
</html>