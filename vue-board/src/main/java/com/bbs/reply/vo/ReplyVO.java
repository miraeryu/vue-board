package com.bbs.reply.vo;

public class ReplyVO {
	
	/*
	 * 계층형 게시판
	 * ex) 댓글1
	 * 		ㄴ대댓글1
	 * 			ㄴ대대댓글1
	 * 예시 형식으로 대댓글이 반복되는 경우, depth 컬럼으로 깊이를 지정하는 경우가 일반적임
	 * (댓글 depth=0, 대댓글 depth=1...)
	 * 
	 * 
	 * 내가 생각하는 조건
	 * 1.조회시 댓글,대댓글의 순서가 맞게 들어올 수 있도록 구조가 되어있어야함
	 * 2.작성시간순으로 프론트에서 번호부여할 수 있도록 해야함
	 * 3.대댓글은 일정부분 padding이 들어가야함
	 * 		>>class명으로 차이를 두는 방법은 어떤가?
	 * 4.수정할때는 어떤식으로 나타나게 할건지?
	 * 		-1.수정페이지로 넘어감(웹사이트에서 자주 쓰는 방법)
	 * 		-2.false로 수정창 숨겨두었다가 버튼 클릭하면 true로 바꿔서 나타나게함.
	 * 5.대댓글 수정은 어떻게 할건지...?
	 * */
	
	// 댓글 기본 구성
	private int replyId;			// 댓글 번호 : pk
	
	private String content;			// 댓글 내용
	
	private String writer;			// 댓글 작성자
	
	private String rplPass;		// 댓글 비밀번호
	
	private String regDt;			// 댓글 작성일자
	
	private String upDt;			// 댓글 수정일자
	
	private String rplUse;			// 댓글 삭제여부
	
	// 댓글 위치를 알려주는 컬럼
	private int bbsId;				// 댓글이 속한 게시물 번호
	
	private String rplGroup;				// 댓글이 속한 그룹
	
	private int grade;		 		// 댓글/대댓글 구분. 0 = 댓글, 1 = 대댓글

	public int getReplyId() {
		return replyId;
	}

	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getRplPass() {
		return rplPass;
	}

	public void setRplPass(String rplPass) {
		this.rplPass = rplPass;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getUpDt() {
		return upDt;
	}

	public void setUpDt(String upDt) {
		this.upDt = upDt;
	}

	public String getRplUse() {
		return rplUse;
	}

	public void setRplUse(String rplUse) {
		this.rplUse = rplUse;
	}

	public int getBbsId() {
		return bbsId;
	}

	public void setBbsId(int bbsId) {
		this.bbsId = bbsId;
	}

	public String getRplGroup() {
		return rplGroup;
	}

	public void setRplGroup(String rplGroup) {
		this.rplGroup = rplGroup;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
	
}
