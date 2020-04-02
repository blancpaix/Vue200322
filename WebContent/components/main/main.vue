<template>

<!-- 게시판 미리보기 부분 -->
<div class="container" style="margin-top:100px">
	<div class="row">
		<main-board-list v-bind:board_idx="1"></main-board-list>
		<main-board-list v-bind:board_idx="2"></main-board-list>
		<main-board-list v-bind:board_idx="3"></main-board-list>
		<main-board-list v-bind:board_idx="4"></main-board-list>
	
	</div>
</div>

</template>

<script>
	module.exports = {
		components : {
			'main-board-list' : httpVueLoader('components/main/main_board_list.vue')
		}
	}
</script>