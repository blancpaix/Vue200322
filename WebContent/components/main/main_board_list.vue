<template>
<!-- 게시판 미리보기 부분 -->
<div class="col-lg-6" style="margin-top:20px">
	<div class="card shadow">
		<div class="card-body">
			<h4 class="card-title">자유게시판</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
					<tr>
						<th class="text-center w-25">글번호</th>
						<th>제목</th>
						<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for='obj in server_data.board_list'>
						<td class="text-center">{{obj.content_idx}}</td>
						<td @click='go_board_read(obj.content_idx)'>{{obj.content_subject}}</td>
						<td class="text-center d-none d-xl-table-cell">{{obj.content_date}}</td>
					</tr>
					
				</tbody>
			</table>
			
			<router-link :to="'/board_main/' + board_idx + '/1'" class="btn btn-primary">더보기</router-link>
		</div>
	</div>
</div>

</template>
<style>
	#board_list > tbody > tr {
		cursor: pointer;
	}
</style>
<script>
	module.exports = {
		data : function () {
			return {
				temp_list : [1,2,3,4,5],
				server_data : {}
			}
		},
		props : ['board_idx'],
		methods : {
			go_board_read : function (content_idx) {
				this.$router.push('/board_read/' + this.board_idx +'/1/' + content_idx)
		},
		created :function () {
			alert(this.board_idx)
			console.log(this.board_idx);
			
			var params = new URLSearchParams()
			params.append('board_idx', this.board_idx)

			axios.post('server/board/get_top5.jsp', params).then((res) => {
			 	this.server_data = res.data
			})
		}
	}
}
	/* $(function(){
		$("#board_list > tbody > tr").click(function(){
			location.href = "board_read.html"
		})
		
	}) */
</script>