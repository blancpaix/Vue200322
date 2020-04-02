<template>

<div class="container" style="margin-top:100px">
	<div class="card shadow">
		<div class="card-body">
			<h4 class="card-title">{{server_data.board_info_name}}</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
					<tr>
						<th class="text-center d-none d-md-table-cell">INDEX</th>
						<th class="w-50">SUBJECT</th>
						<th class="text-center d-none d-md-table-cell">WRITER</th>
						<th class="text-center d-none d-md-table-cell">DATE</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for='obj in server_data.board_list'>
						<td class="text-center d-none d-md-table-cell">{{ obj.content_idx }}</td>
						<td @click='go_board_read(obj.content_idx)'>{{ obj.content_subject }}</td>
						<td class="text-center d-none d-md-table-cell">{{obj.content_writer_name}}</td>
						<td class="text-center d-none d-md-table-cell">{{obj.content_date}}</td>
						
					</tr>
				</tbody>
			</table>
			
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<router-link :to="'/board_main' + $route.params.board_idx + '/' + server_data.pre" class="page-link">PRE</router-link>
					</li>
					<li class="page-item" v-for='a1 in temp_list'>
						<router-link :to="'/board_main/' + $route.params.board_idx + '/' + a1" class="page-link">{{ a1 }}</router-link>
					</li>
					<li class="page-item">
						<router-link :to="'/board_main' + $route.params.board_idx + '/' + server_data.next" class="page-link">NEXT</router-link>
					</li>
				</ul>
			</div>
			
			<!-- 이건 모바일용이라는데? -->
			<div class="d-block d-md-none">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<router-link to='/board_main' class="page-link">이전</router-link>
					</li>
					<li class="page-item">
						<router-link to='/board_main' class="page-link">다음</router-link>
					</li>
				</ul>
			</div>
			
			<div class="text-right" v-if='$store.state.user_login_chk == true'>
				<router-link :to="'/board_write/'+ $route.params.board_idx" class="btn btn-primary">글쓰기</router-link>
			</div>
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
		data : function() {
			// 템플릿에서 사용하고 싶은 변수가 있으면 반환해주면 됨
			return {
				temp_list : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
				server_data : {}
			}
		},
		methods : {
			go_board_read : function(content_idx) {
				// 라우터 객체 불러와서 사용하는거임 this.$router 를 말하는 거여
				// alert(content_idx);
				this.$router.push('/board_read/' + this.$route.params.board_idx + '/' + this.$route.params.page + '/' + content_idx);
				// 뒤로가기 할 경우 탐색중이던 페이지 번호랑 기타 등등을 기억해야지??
			},
			get_board_data : function () {
				// jsp 데이터 받아오는 작업
				var params = new URLSearchParams()
				params.append('board_idx', this.$route.params.board_idx)
				params.append('page', this.$route.params.page)

				axios.post('server/board/get_board_list.jsp', params).then((res) => {
					this.server_data = res.data
				})
			}
		},
		watch : {
			'$route' (to, from) {
				this.get_board_data()
			}
		},
		created () {
			this.get_board_data()
			//alert(this.$route.params.board_idx);
			// 왜 이건 $route 임???
		}
	}
</script>