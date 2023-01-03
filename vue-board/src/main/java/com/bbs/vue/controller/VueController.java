package com.bbs.vue.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bbs.reply.service.ReplyService;
import com.bbs.vue.service.VueService;
import com.bbs.vue.vo.VueVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class VueController {
	
	private static final Logger logger = LoggerFactory.getLogger(VueController.class);
	
	/*
	 * @Resource, @Service등 어노테이션 뒤에 name 입력 반드시 할것
	 */
	@Resource(name="vueService")
	private VueService vueService;
	
	@Resource(name="replyService")
	private ReplyService replyService;
	
	// 조회 메인 페이지
	@RequestMapping("/list")
	public String list(@ModelAttribute VueVO vo, Model model) throws Exception {
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		ObjectMapper mapper = new ObjectMapper();
		logger.info("=========================List========================="); 
		vo.setAllPostCnt(vueService.rowCnt(vo));				// 전체 행 개수 세팅
		if (vo.getNowPage() == 0) {							// 처음 로딩할 경우
			vo.setNowPage(1);
		}
		
		// 페이지 Array 만들기
		ArrayList<Integer> newPages = new ArrayList<Integer>();
		if (vo.getNowPage() == 1) {
			for(int i = 1; i <= 3; i++) {
				if (i <= vo.getMaxPageCnt()) {
					newPages.add(i);
				}
			}
		} else {
			if(vo.getNowPage() == vo.getMaxPageCnt()) {
				for (int i = (vo.getMaxPageCnt()-2); i <= vo.getMaxPageCnt() ; i++ ) {
					if (i > 0) {
						newPages.add(i);
					}
				}
			} else {
				for (int i = (vo.getNowPage() -1); i <= (vo.getNowPage()+1); i++) {
					newPages.add(i);
				}
			}
		}
		vo.setPages(newPages);				// 만든 pages 세팅
		model.addAttribute("list", mapper.writeValueAsString(vueService.allList(vo)));
		model.addAttribute("info", mapper.writeValueAsString(vo));
		return "board/list.tiles";
	}
	
	// 상세보기
	@RequestMapping("/readPost")
	public String readPost(@ModelAttribute VueVO vo, Model model) throws Exception {
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		ObjectMapper mapper = new ObjectMapper();
        
        logger.info("=========================Read=========================");
		String readPost = mapper.writeValueAsString(vueService.readOne(vo.getBbsId()));
		String replyList = mapper.writeValueAsString(replyService.replyList(vo.getBbsId()));
		model.addAttribute("post", readPost);
		model.addAttribute("vo", mapper.writeValueAsString(vo));
		model.addAttribute("reply", replyList);
		if (readPost != null) {
			vueService.updateReadCnt(vo.getBbsId());
			logger.info("======================ViewUpdate======================");
		}
		return "board/readPost.tiles";
	}
	
	// 글 등록/수정 폼
	@RequestMapping("/editForm")
	public String editForm(@ModelAttribute VueVO vo, Model model) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("category : " + vo.getCategory() + ", keyword : " + vo.getKeyword() + ", page : " + vo.getNowPage());
		logger.info("======================editForm======================");
		VueVO read = new VueVO();
		if(vo.getBbsId() == 0) {
			model.addAttribute("post", mapper.writeValueAsString(vo));
		}else {
			read = vueService.readOne(vo.getBbsId());
			read.setCategory(vo.getCategory());
			read.setKeyword(vo.getKeyword());
			read.setNowPage(vo.getNowPage());
			model.addAttribute("post", mapper.writeValueAsString(read));
		}
		return "board/editForm.tiles";
	}
	
	//엑셀 다운로드
	@RequestMapping("/excel/download")
	public void ExcelDownload(HttpServletResponse response) throws IOException {
		System.out.println("===============Excel=================");
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("첫번째 시트");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		
		//헤더
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue("번호");
		cell = row.createCell(1);
		cell.setCellValue("이름");
		cell = row.createCell(2);
		cell.setCellValue("제목");
		
		//바디
		for (int i=0; i<3; i++) {
			row = sheet.createRow(rowNum++);
			cell = row.createCell(0);
			cell.setCellValue(i);
			cell = row.createCell(1);
			cell.setCellValue(i+"_Name");
			cell = row.createCell(2);
			cell.setCellValue(i+"_title");
		}
		
		//컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=example.xlsx");
		
		//Excel File Output
		wb.write(response.getOutputStream());
		wb.close();
		
		}
	
	
}
