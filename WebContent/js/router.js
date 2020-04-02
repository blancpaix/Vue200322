var store = new Vuex.Store({
	// state 이름은 정해져있음 모든 Vue.js 어플리케이션에서 접근 가능하다!	
	state : {
		user_login_chk : false,
		user_id : '',
		user_name : '',
		user_idx : 0,
	}
})

var router = new VueRouter({
	routes : [
		{
			path : '/',
			component : httpVueLoader('components/main/main.vue')
		},
		
		{
			path : '/board_main/:board_idx/:page',
			component : httpVueLoader('components/board/board_main.vue')
		},
		{
			path : '/login',
			component : httpVueLoader('components/user/login.vue')
		},
		{
			path : '/join',
			component : httpVueLoader('components/user/join.vue')
		},
		{
			path : '/modify_user',
			component : httpVueLoader('components/user/modify_user.vue')
		},
		
		{
			path : '/board_read/:board_idx/:page/:content_idx',
			component : httpVueLoader('components/board/board_read.vue')
		},
		{
			path : '/board_modify/:board_idx/:page/:content_idx',
			component : httpVueLoader('components/board/board_modify.vue')
		},
		{
			path : '/board_delete/:board_idx/:page/:content_idx',
			// 이전에 위치, 이동할 위치, 넥스트로 다음 페이지 요청해주면 됨
			beforeEnter(to, from, next) {
				// 위의 path 가 to 에 들어감
				var params = new URLSearchParams();
				params.append('content_idx', to.params.content_idx)

				axios.post('server/board/delete_content.jsp', params).then((res) => {
					alert ('삭제됨')
					next('/board_main/' + to.params.board_idx + '/' + to.params.page)
				})
			}
		},
		{
			path : '/board_write/:board_idx',
			component : httpVueLoader('components/board/board_write.vue')
		},
		{
			path : '/logout',
			beforeEnter(to, from, next) {
				alert('로그아웃 되었습니다')

				store.state.user_login_chk = false;
				store.state.user_id = '';
				store.state.user_name = '';
				store.state.uesr_idx = 0;
				
				sessionStorage.clear();

				next('/board_main')
			}
		}
	],
	// 스크롤 위치 설정하기
	scrollBehavior(to, from, savePosition) {
		return {
			x: 0,
			y: 0
		}
	}
})