<template>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
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
		data : function () {
			return {
				is_login_fail : false,
				user_id : '',
				user_pw : '',
			}
		},
		methods : {
			check_input : function () {
				// 유효성 검사
				if(this.user_id.length < 4){
					alert("아이디는 4글자 이상입니다")
					this.user_id = ''
					// 이건 어떻게 처리되는거임?? 뭐임??
					$("#user_id").focus()
					
					return
				}
				if(this.user_pw.length < 4){
					alert("비밀번호는 4글자 이상입니다")
					this.user_pw = ''
					$("#user_pw").focus()
					
					return
				}

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