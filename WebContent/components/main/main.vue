<template>

<div class="container" style="margin-top:100px">
	<div class="row">
		<!-- 컴포넌트 board_idx의 value 값을 v-bind 로 전송  -->
		<!-- props : [] 으로 받던가 props : { propA : [] } 이렇게 받던가  -->
		<main-board-list v-bind:board_idx="1"></main-board-list>
		<main-board-list v-bind:board_idx="2"></main-board-list>
		<main-board-list v-bind:board_idx="3"></main-board-list>
		<main-board-list v-bind:board_idx="4"></main-board-list>
	
	</div>
</div>

</template>

<script>
	// 여기 있는 데이터를 전송한다는 말인데??? 아무튼 v-bind의 값을  main_board_list.vue 에 전송해서 처리를 한다!
	module.exports = {
		// 위에서 지정한 컴포넌트에 대해서 지정
		components : {
			'main-board-list' : httpVueLoader('components/main/main_board_list.vue')
		}
	}
</script>