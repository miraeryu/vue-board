package com.bbs.vue.vo;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class VueVO extends VueCommonVO{
	
private int bbsId;				// 글번호
	
	private String title;			// 글제목
	
	private String content;			// 글내용
	
	private int readCnt;			// 조회수
	
	private String registNm;		// 작성자
	
	private Date registDt;			// 작성일
	
	private String updtNm;			// 수정자
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updtDt;			// 수정일
	
	private String useAt;			// 사용여부

	public int getBbsId() {
		return bbsId;
	}

	public void setBbsId(int bbsId) {
		this.bbsId = bbsId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public String getRegistNm() {
		return registNm;
	}

	public void setRegistNm(String registNm) {
		this.registNm = registNm;
	}

	public Date getRegistDt() {
		return registDt;
	}

	public void setRegistDt(Date registDt) {
		this.registDt = registDt;
	}

	public String getUpdtNm() {
		return updtNm;
	}

	public void setUpdtNm(String updtNm) {
		this.updtNm = updtNm;
	}

	public Date getUpdtDt() {
		return updtDt;
	}

	public void setUpdtDt(Date updtDt) {
		this.updtDt = updtDt;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

}
