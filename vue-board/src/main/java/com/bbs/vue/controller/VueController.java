package com.bbs.vue.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbs.vue.service.VueService;
import com.bbs.vue.vo.VueVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class VueController {
	
	private static final Logger logger = LoggerFactory.getLogger(VueController.class);
	
	@Resource
	private VueService vueService;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute VueVO vo, Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		 // Date Format 설정
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        mapper.setDateFormat(dateFormat);
		
		logger.info("=========================List=========================");
		model.addAttribute("list", mapper.writeValueAsString(vueService.allList(vo)));
		System.out.println(mapper.writeValueAsString(vueService.allList(vo)));
		return "board/list.tiles";
	}
	
	@RequestMapping("/listLoad")
	public ResponseEntity<List<VueVO>> listLoad(@ModelAttribute VueVO vo) {
		logger.info("=========================Load=========================");
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword());
		List<VueVO> list = vueService.allList(vo);
		return new ResponseEntity<List<VueVO>>(list, HttpStatus.OK);
	}
	
	@RequestMapping("/readPost")
	public String readPost(@ModelAttribute VueVO vo, Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		// Date Format 설정
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        mapper.setDateFormat(dateFormat);
        
        logger.info("=========================Read=========================");
		String readPost = mapper.writeValueAsString(vueService.readOne(vo.getBbsId()));
		model.addAttribute("post", readPost);
		model.addAttribute("vo", vo);
		if (readPost != null) {
			vueService.updateReadCnt(vo.getBbsId());
			logger.info("======================ViewUpdate======================");
		}
		return "board/readPost.tiles";
	}
	
	// 글 수정 폼
	@RequestMapping("/editForm")
	public String editForm(@ModelAttribute VueVO vo, Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		// Date Format 설정
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		mapper.setDateFormat(dateFormat);
		
		String readPost = mapper.writeValueAsString(vueService.readOne(vo.getBbsId()));
		
		model.addAttribute("post", readPost);
		model.addAttribute("vo", vo);
		return "board/editForm.tiles";
	}
	
	
}
