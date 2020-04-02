<template>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<div class="form-group">
						<label for="board_writer_name">작성자</label>
						<!-- name 속성이 필요 없음 모두 다 v-model 로 바꿔줍니다 value 도 지우고.. 밑에서 매칭 되는거니까?-->
						<input type="text" id="board_writer_name" v-model="server_data.content_writer_name" class="form-control" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_date">작성날짜</label>
						<input type="text" id="board_date" v-model="server_data.content_date" class="form-control" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" id="board_subject" v-model="server_data.content_subject" class="form-control" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="board_content" v-model="server_data.content_text" class="form-control" rows="10" style="resize:none" disabled="disabled"></textarea>
					</div>
					<div class="form-group" v-if='server_data.content_file != null'>
						<label for="board_file">첨부 이미지</label>
						<img :src='"upload/" + server_data.content_file' width="100%"/>						
					</div>
					<div class="form-group">
						<div class="text-right">
							<router-link :to="'/board_main/' + $route.params.board_idx + '/' + $route.params.page" class="btn btn-primary">목록보기</router-link>
							<router-link :to="'/board_modify/' + $route.params.board_idx + '/' + $route.params.page + '/' + $route.params.content_idx" class="btn btn-info" v-if='server_data.content_writer_idx == $store.state.user_idx'>수정하기</router-link>
							<router-link :to="'/board_delete/' + $route.params.bodrd_idx + '/' + $route.params.page + '/' + $route.params.content_idx" class="btn btn-danger" v-if='server_data.content_writer_idx == $store.state.user_idx'>삭제하기</router-link>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

</template>

<script>
	module.exports = {
		data: function() {
			return {
				server_data : {}
			}
		},
		created () {
			var params = new URLSearchParams();
			params.append('content_idx', this.$route.params.content_idx);

			axios.post('server/board/get_content.jsp', params).then((res) => {
				this.server_data = res.data
			})
		}
	}
	
</script>