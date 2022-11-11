<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<template id="pagination">
	<div class="pagination">
		<ul class="pageUl">
			<li><a href="#" v-if="pageinfo.nowPage != 1 " @click="movePage(pageinfo.nowPage-1)">prev</a></li>
			<li v-for="num in page" ><a href="#" @click="movePage(num)">{{ num }}</a></li>
			<li><a href="#" v-if="pageinfo.maxPageCnt > 1 && pageinfo.nowPage != pageinfo.maxPageCnt" @click="movePage(pageinfo.nowPage+1)">next</a></li>
		</ul>
		<div id="page-info">
				<input type="hidden" id="nowPage" :value="pageinfo.nowPage">
				<input type="hidden" id="hiddenCategory" :value="pageinfo.category">
				<input type="hidden" id="hiddenKeyword" :value="pageinfo.keyword">
		</div>
	</div>
</template>

<script>
		//export default {
	Vue.component('pagination', {
		template : '#pagination',
		props : ['pageinfo'],			// 부모로부터 받은 데이터
		methods : {
			movePage : function(num) {
				//console.log("페이지 변경 메소드")
				this.pageinfo.nowPage = num;
				this.$emit('move', this.pageinfo);		// 부모 component에 전송할 데이터, component 이름 옆에 표기
			}
		},
		computed : {
			page : function() {
				//console.log("페이지for문")
				var endPage = parseInt(Math.ceil(this.pageinfo.nowPage / this.pageinfo.displayPage)) * 3;
				var startPage = endPage - 2 ;
				if (endPage > this.pageinfo.maxPageCnt){
					endPage = this.pageinfo.maxPageCnt;
				}
				this.pageinfo.endPage = endPage;
				this.pageinfo.startPage = startPage;
				console.log('start : ' + this.pageinfo.startPage + ' end : ' + this.pageinfo.endPage)
				var numbers = [];
				for(var i = this.pageinfo.startPage; i <= this.pageinfo.endPage; i++) {
					numbers.push(i);
				}
				return numbers;
			}
		}
	})
</script>