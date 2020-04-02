// 제이쿼리에서의 window.onload 랑 같은거임
$(function() {
	
	var app = new Vue ({
		// 타겟 지정 id = "app"
		el : '#app',
		// 사용자 지정 컴포넌트 사용
		components : {
			'top-menu' : httpVueLoader('components/common/top_menu.vue'),
			'bottom-info' : httpVueLoader('components/common/bottom_info.vue')
		},
		// 어플리케이션 전체에서 사용이 가능하다!
		store : store,
		router : router,
		// Vuex 스토어라는 객체를 만들건데 여기서 만들어도되는데 우리는 다른곳에서 만듦. router 에서 만드는데 그럴 이유는 스토어에 저장된 로그인 여부값을 라우터에서 쓸 예정...
		// 로그인 여부에 따라 회원 정보 수정 등 이러한거 바꿔줘야 하니까 편하게 라우터에서! 인덱스페이지에서도 먼저 선언한게 router 이라서...
		
		// DOM 생성 이전에 체크하고 넘어갈 데이터 (여기서는 로그인 여부 판별)
		beforeCreate : function () {
			if (sessionStorage.user_login_chk != undefined) {
				
				if (sessionStorage.user_login_chk == 'true') {
					// 전역변수 store에 접근하기 위해서는 $store 필요한데 $el $ref 이런거랑 좀 헷갈림..?												%%%%%%%%%%%%%%%%%%%%%%%%
					this.$store.state.user_login_chk = true
				}
				
				this.$store.state.user_id = sessionStorage.user_id;
				this.$store.state.user_name = sessionStorage.user_name;
				this.$store.state.user_idx = parseInt(sessionStorage.user_idx);

			}
		}
	})
})
