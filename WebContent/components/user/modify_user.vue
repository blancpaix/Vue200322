<template>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form action="modify_user.html" method="post" onsubmit="return check_input()">
					<div class="form-group">
						<label for="user_name">이름</label>
						<input type="text" id="user_name" v-model="user_name" class="form-control" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="user_id">아이디</label>
						<input type="text" id="user_id" v-model="user_id" class="form-control" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="user_pw">비밀번호</label>
						<input type="password" id="user_pw" v-model="user_pw" class="form-control" />
					</div>
					<div class="form-group">
						<label for="user_pw2">비밀번호 확인</label>
						<input type="password" id="user_pw2" v-model="user_pw2" class="form-control" />
					</div>
					<div class="form-group">
						<div class="text-right">
							<button type="submit" class="btn btn-primary">정보수정</button>
						</div>
					</div>
					
					</form>
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
				// Vue.store에 저장된 변수 접근 (로그인하면서 할당)
				user_name : this.$store.state.user_name,
				user_id : this.$store.state.user_id,
				user_pw : '',
				user_pw2 : '',
			}
		},
		methods : {
			check_input : function () {
				if(this.user_pw.length < 4){
					alert("비밀번호는 4글자 이상입니다")
					this.user_pw = ''
					$("#user_pw").focus()
					return
				}
				if(this.user_pw2.length < 4){
					alert("비밀번호는 4글자 이상입니다")
					this.user_pw2 = ''
					$("#user_pw2").focus()
					return
				}
				if(this.user_pw != user_pw2){
					alert("비밀번호가 일치하지 않습니다")
					this.user_pw = ''
					this.user_pw2 = ''
					$("#user_pw").focus()
					return
				}
				
				var params = new URLSearchParams();
				params.append("user_idx", this.$store.state.user_idx);
				params.append("user_pw", this.$store.state.user_pw);


				axios.post('server/user/user_modify.jsp', params).then ((res) => {
					alert('정보가 수정되었습니다!')
					this.user_pw = ''
					this.user_pw2 = '';
				})
			}
		},
		created () {
			// 로그인처리가 되지 않고 페이지에 접근한 경우 처
			if (this.$store.state.user_login_chk == false) {
				alert('잘못된 접근입니다');
				this.$router.push('/');
			}
		}
	}

</script>