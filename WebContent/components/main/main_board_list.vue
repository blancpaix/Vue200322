<template>
<!-- 게시판별 상위 5개씩 추출 -->
<div class="col-lg-6" style="margin-top:20px">
	<div class="card shadow">
		<div class="card-body">

			<h4 class="card-title">{{ server_data.board_info_name }}</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
					<tr>
						<th class="text-center w-25">INDEX</th>
						<th>SUBJECT</th>
						<th class="text-center w-25 d-none d-xl-table-cell">DATE</th>
					</tr>
				</thead>
				<tbody>
					<!-- 한줄에 변수 할당하고 바로 사용하기가 가능하네?? -->
					<tr v-for='bl in server_data.board_list' @click='go_board_read(bl.content_idx)'>
						<td class="text-center">{{bl.content_idx}}</td>
						<td >{{bl.content_subject}}</td>
						<td class="text-center d-none d-xl-table-cell">{{bl.content_date}}</td>
					</tr>
					
				</tbody>
			</table>
			
			<!-- 더보기는 1페이지로 가야하는게 맞으니 1으로 강제 할당 -->
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
	// 템플릿에서 사용할 데이터는 module.exports 를 통해서 사용
	module.exports = {
		// module 사용 data 는 리턴으로 해야함 Vue 생성자에서는 바로 생성해서 쓰면 되는데 여기서는 아님
		data : function () {
			return {				
				server_data : {}
			}
		},
		// 컴포넌트에서 받은 데이터, 여기서는 배열이라서 이렇게 받아서 처리. 사용중인 템플릿 어디에서든 접근이 가능한듯??
		props : ['board_idx'],
		methods : {
			go_board_read : function (content_idx) {
				this.$router.push('/board_read/' + this.board_idx +'/1/' + content_idx)
			}
		}, 
		// 렌더링 시 생성할 데이터들
		created: function () {
			// alert(this.board_idx);
			// 파라미터 값을 받기 위해서 URLSearchParams 사용
			var params = new URLSearchParams()
			params.append('board_idx', this.board_idx)

			axios.post('server/board/get_top5.jsp', params).then((res) => {
			 	this.server_data = res.data
			})
		}
	}

</script>