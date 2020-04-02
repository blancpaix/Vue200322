<template>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">

					<!-- 메서드에서 반환된 값을 가지고 렌더링 -->
 					<div class="alert alert-danger" v-if='is_login_fail == true'>
						<h3>로그인 실패</h3>
						<p>아이디 비밀번호를 확인해주세요</p>
					</div>
						<div class="form-group">
							<label for="user_id">아이디</label>
							<input type="text" id="user_id" v-model="user_id" class="form-control"/>
						</div>
						<div class="form-group">
							<label for="user_pw">비밀번호</label>
							<input type="password" id="user_pw" v-model="user_pw" class="form-control"/>
						</div>
						<div class="form-group text-right">
							<button type="button" @click='check_input' class="btn btn-primary">로그인</button>
							<router-link to='/join' class="btn btn-danger">회원가입</router-link>
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
		// 사용할 데이터 함수 형식으로 생성 및  반환
		data : function () {
			return {
				is_login_fail : false,
				user_id : '',
				user_pw : '',
			}
		},
		methods : {
			// 유효성 검사
			check_input : function () {
				if(this.user_id.length < 4){
					alert("아이디는 4글자 이상입니다")
					this.user_id = ''
					$("#user_id").focus()
					
					// 리턴 false 거나 이런거 상관없이 그냥 함수를 끝내버리는거라 괜찮
					return
				}
				if(this.user_pw.length < 4){
					alert("비밀번호는 4글자 이상입니다")
					this.user_pw = ''
					$("#user_pw").focus()
					
					return
				}

				// id랑 pw 파라미터로 보내면 굉장히 위험 나중에 수정....
				var params = new URLSearchParams()
				params.append('user_id', this.user_id)
				params.append('user_pw', this.user_pw)

				axios.post('server/user/login.jsp', params).then((res) => {
					if (res.data.result === false) {
						alert('로그인에 실패했습니다!')
						this.user_id = ''
						this.user_pw = '';
						this.is_login_fail = true;
					} else {
						alert('로그인 되었습니다.')

						// 서버가 전달한 데이터를 store 에 담는다
						this.$store.state.user_login_chk = true
						this.$store.state.user_id = res.data.user_id;
						this.$store.state.user_name = res.data.user_name;
						this.$store.state.user_idx = res.data.user_idx;

						// 세션 스토리지에도 저장한다 (새로고침 대비) => 웹 브라우저에 저장
						sessionStorage.user_login_chk = true;
						sessionStorage.user_id = res.data.user_id;
						sessionStorage.user_name = res.data.user_name;
						sessionStorage.user_idx = res.data.user_idx;
						// 치명적인 단점으로 웹 스토리지에 저장을 하면 (쿠키? 세션) 반환할때 boolean 값 등 을 싹다 문자열로 반환하게 됨. 그래서 추가적인 작업을 하는데 app.js 에서 할겨

						this.$router.push('/')
					}
				})	
			}
		}
	}
	
</script>