package com.bbs.vue.service;

import java.util.List;

import com.bbs.vue.vo.VueVO;


public interface VueService {
	

	//전체 조회
	public List<VueVO> allList(VueVO vo) throws Exception;
	
	//글 갯수 조회
	public int rowCnt(VueVO vo) throws Exception;
	
	//상세 조회
	public VueVO readOne(int bbsId) throws Exception;
		
	//maxBbsId 값 구하기
	public int maxBbsId() throws Exception;
		
	//글 수정, 등록
	public int editPost(VueVO vo) throws Exception;
		
	//글 삭제
	public int deletePost(int bbsId) throws Exception;
		
	//조회수 업데이트
	public int updateReadCnt(int bbsId) throws Exception;

}
