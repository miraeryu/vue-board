package com.bbs.vue.service;

import java.util.List;

import com.bbs.vue.vo.VueVO;


public interface VueService {
	

	//전체 조회
	public List<VueVO> allList(VueVO vo);
	
	//글 갯수 조회
	public int rowCnt(VueVO vo);
	
	//상세 조회
	public VueVO readOne(int bbsId);
		
	//새글 쓰기
	public int newPost(VueVO vo);
	
	//maxBbsId 값 구하기
	public int maxBbsId();
		
	//글 수정
	public int editPost(VueVO vo);
		
	//글 삭제
	public int deletePost(int bbsId);
		
	//조회수 업데이트
	public int updateReadCnt(int bbsId);

}
