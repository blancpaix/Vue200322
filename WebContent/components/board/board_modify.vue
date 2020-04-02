<template>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<!-- <form action="board_modify.html" method="post" onsubmit="return check_input()"></form> 폼은 안서요~-->
						<div class="form-group">
							<label for="board_writer_name">작성자</label>
							<input type="text" id="board_writer_name" v-model="server_data.content_writer_name" class="form-control" disabled="disabled"/>
						</div>
						<div class="form-group">
							<label for="board_date">작성날짜</label>
							<input type="text" id="board_date" v-model="server_data.content_date" class="form-control" disabled="disabled"/>
						</div>
						<div class="form-group">
							<label for="board_subject">제목</label>
							<input type="text" id="board_subject" v-model="server_data.content_subject" class="form-control"/>
						</div>
						<div class="form-group">
							<label for="board_content">내용</label>
							<textarea id="board_content" v-model="server_data.content_text" class="form-control" rows="10" style="resize:none"></textarea>
						</div>
						<div class="form-group">
							<label for="board_file">첨부 이미지</label>
							<img :src="'upload/' + server_data.content_file" width="100%" v-if='server_data.content_file != null'/>	
							<input type="file" name="board_image" id="board_file" class="form-control" accept="image/*"/>
							<!-- 파일을 호출하는것은 일반적으로 데이터를 불러오는것과 같이 처리해서는 안됌 	그래서 일단은 name 으로 놔둘게요 나중에 알아봅시다-->
							<!-- 파일이 존재한다면 그대로 들고가고 없다면 완전히 새로 만들어서 들고갑니다! -->					
						</div>
						<div class="form-group">
							<div class="text-right">
								<button type="button" @click='check_input' class="btn btn-primary">수정완료</button>
								<router-link to='/board_read' class="btn btn-info">취소</router-link>
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
		data : function () {
			return {
				server_data : {}
			}
		},
		methods : {
			check_input : function () {
				var board_subject = $("#board_subject").val();
				var board_content = $("#board_content").val();
				
				if(this.server_data.content_subject.length == 0){
					alert("제목을 입력해주세요")
					$("#board_subject").focus()
					
					return
					// form 태그와 연동된것이 아니라서 return false 할 필요가 없다랍니다
				}
				if(this.server_data.content_text.length == 0) {
					alert("내용을 입력해주세요")
					$("#board_content").focus()
					
					return	// 수행 중단됨.
				}
				// alert($('#board_file')[0].files[0])  Undefinded 뜹니다!
				
				var params = new FormData();
				params.append('content_subject', this.server_data.contet_subject);
				params.append('content_text', this.server_data.content_text);
				params.append('content_idx', this.$route.params.content_idx);

				if ($('#board_file')[0].files[0] != undefined) {
					params.append('content_file', $('#board_file')[0].files[0])
				}

				axios.post('server/board/modify_content.jsp', params).then((res) => {
					if (res.data.result == true) {
						alert('수정되었습니다.')
						this.$router.push('/board_read/' + this.$route.params.board_idx + '/' + this.$route.params.page + '/' + this.$route.params.content_idx)
					}
				})
			}
		},
		created() {
			var params = new URLSearchParams();
			params.append('content_idx', this.$route.params.content_idx)
			
			axios.post('server/board/get_content.jsp', params).then((res) => {
				this.server_data = res.data;
			})
		}
	}

</script>
