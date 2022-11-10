<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<template id="pagination">
	<div class="pagination">
		<ul class="pageUl">
			<li><a href="#" v-if="pageinfo.nowPage != 1" @click="movePage(pageinfo.nowPage-1)">prev</a></li>
			<li v-for="num in page" ><a href="#" @click="movePage(num)">{{ num }}</a></li>
			<li><a href="#" v-if="pageinfo.nowPage != pageinfo.maxPageCnt" @click="movePage(pageinfo.nowPage+1)">next</a></li>
		</ul>
	</div>
</template>

<script>
		//export default {
	Vue.component('pagination', {
		template : '#pagination',
		props : ['pageinfo'],			// 부모로부터 받은 데이터
		methods : {
			movePage : function(num) {
				console.log("페이지 변경 메소드")
				this.pageinfo.nowPage = num;
				this.$emit('move', num);		// 부모 component에 전송할 데이터, component 이름 옆에 표기
			}
		},
		computed : {
			page : function() {
				console.log("페이지for문")
				var numbers = [];
				for(var i = this.pageinfo.startPage; i <= this.pageinfo.endPage; i++) {
					numbers.push(i);
				}
				return numbers;
			}
		}
	})
</script>