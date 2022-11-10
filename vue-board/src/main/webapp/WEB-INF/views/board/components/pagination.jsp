<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<template id="pagination">
	<div class="pagination">
		<ul class="pageUl">
			<li><a href="#" v-if="pageinfo.nowPage != 1" @click="movePage(pageinfo.nowPage-1)">prev</a></li>
			<li><a href="#" v-for="num in page" @click="movePage(num)">{{ num }}</a></li>
			<li><a href="#" v-if="pageinfo.nowPage != pageinfo.maxPageCnt" @click="movePage(pageinfo.nowPage+1)">next</a></li>
		</ul>
	</div>
</template>

<script>
	Vue.component('pagination', {
		template : '#pagination',
		props : ['pageinfo'],			// 부모로부터 받은 데이터
		methods : {
			movePage : function(num) {
				console.log("어디냐")
				this.pageinfo.nowPage = num;
				this.$emit('movePage', num);		// 부모 component에 전송할 데이터, component 이름 옆에 표기
			}
		},
		computed : {
			page : function() {
				console.log("????")
				var numbers = [];
				for(var i = this.pageinfo.startPage; i <= this.pageinfo.endPage; i++) {
					numbers.push(i);
				}
				return numbers;
			}
		}
	})
</script>