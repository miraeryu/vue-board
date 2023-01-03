<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>edit reply</title>
</head>
<body>

	<div>
		<table id="reply-table">
			<thead id="reply-table-head">
				<tr><td colspan="2"><h3>  댓글 수정</h3></td></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<input type="text" id="writer" name="writer" placeholder="작성자명입력" v-model="newWriter">
					</td>
					<td>
						<input type="password" placeholder="비밀번호입력" v-model="newPassword">
					</td>
				</tr>
				<tr>
					<td colspan="2" id="reply-textarea">
						<textarea name="reply" id="reply" placeholder="댓글 내용 입력" v-model="newContent"></textarea>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<button type="button" v-on:click="replySubmit()">등록</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</body>
</html>