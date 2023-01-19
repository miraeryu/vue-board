<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>edit reply</title>
</head>
<body>

	<div id="reply-edit-table">
		<table id="reply-table">
			<thead id="reply-table-head">
				<tr><td colspan="2"><h3>  댓글 수정</h3></td></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<input type="text" id="writer" name="writer" placeholder="작성자명입력" v-model="reply.writer">
					</td>
					<td>
						<input type="password" placeholder="비밀번호입력" v-model="newPassword">
					</td>
				</tr>
				<tr>
					<td colspan="2" id="reply-textarea">
						<textarea name="reply" id="reply" placeholder="댓글 내용 입력" v-model="reply.content"></textarea>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<button type="button" v-on:click="editCancel()">취소</button>
						<button type="button" v-on:click="replySubmit()">등록</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</body>
<script>
	var editReplyForm = new Vue({
		el : "#reply-edit-table",
		data : function(){
			return {
				reply : ${ reply },
				newPassword : ''
			}
		},
		methods : {
			replySubmit : function (){
				var newPass = this.newPassword;
				if(!this.reply.content || !newPass || !this.reply.writer){
					alert("누락된 부분 있음.")
				}
				var editReply = {
					writer : this.reply.writer,
					contetn : this.reply.content,
					rplPass : newPass
				}
				console.log(editReply);
			},
			editCancel : function(){
				location.href="";
			}
		},
		watch : {
			
		},
		mounted : function() {
			var editReplyForm = this;
		}
	})
</script>
</html>