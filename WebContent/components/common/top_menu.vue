<template>
		
<!-- 상단 메뉴 부분 -->
<nav class="navbar navbar-expand-md bg-dark navbar-dark fixed-top shadow-lg">
 	<!-- <a class="navbar-brand" href="index.html">SoftCampus</a> -->
 	<router-link to='/' class="navbar-brand">SoftCampus</router-link>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
	        data-target="#navMenu">
		<span class="navbar-toggler-icon"></span>        
	</button>
	<div class="collapse navbar-collapse" id="navMenu">
		<ul class="navbar-nav">
			<li class="nav-item" v-for='obj in server_data'>
				<router-link :to="'/board_main/' + obj.board_info_idx + '/1'" class="nav-link">{{obj.board_info_name}}</router-link>
			</li>
		</ul>
		
		<ul class="navbar-nav ml-auto" v-if='$store.state.user_login_chk === false'>
			<li class="nav-item">
				<router-link to='/login' class="nav-link">로그인</router-link>
			</li>
			<li class="nav-item">
				<router-link to='/join' class="nav-link">회원가입</router-link>
			</li>
		</ul>
		<ul class="navbar-nav ml-auto" v-else>
			<li class="nav-item">
				<router-link to='/modify_user' class="nav-link">정보수정</router-link>
			</li>
			<li class="nav-item">
				<router-link to='/logout' class="nav-link">로그아웃</router-link>
			</li>
		</ul>
	</div>
</nav>

</template>

<script>
	module.exports = {
		data : function () {
			return {
				server_data : []
			}
		},
		created() {
			axios.get('server/board/get_board_info.jsp').then((res) => {
				this.server_data = res.data
			})
		}
	}
	
</script>