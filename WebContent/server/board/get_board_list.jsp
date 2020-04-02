<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>

<%
	// 데이터 베이스 접속 정보
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String id = "NULL";
	String pw = "1004";
	
	// 접속
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url, id, pw);
	
	request.setCharacterEncoding("utf-8");
	
	// 게시글 인덱스 번호
	String int1 = request.getParameter("board_idx");
	System.out.println("int1:" + int1);
	int board_idx = Integer.parseInt(int1);
	
	// 페이지 번호
	String str2 = request.getParameter("page");
	int now_page = Integer.parseInt(str2);
	
	// 모든 데이터를 담아 높을 JSON Object
	JSONObject root = new JSONObject();
	
	// 게시판 정보를 가져오는 부분
	String sql = "SELECT BOARD_INFO_NAME FROM BOARD_INFO_TABLE WHERE BOARD_INFO_IDX = ?";
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1, board_idx);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	String board_info_name = rs.getString("board_info_name");
	
	root.put("board_info_name", board_info_name);
	
	// 게시글 목록을 가져오는 부분
	// String sql2 = "SELECT CT.CONTENT_IDX, CT.CONTENT_SUBJECT, TO_CHAR(CT.CONTENT_DATE, 'YYYY-MM-DD') AS CONTENT_DATE, UT.USER_NAME FROM CONTENT_TABLE CT, USER_TABLE UT WHERE CONTENT_WRITER_IDX = UT.USER_IDX AND CT.CONTENT_BOARD_IDX=? ORDER BY CT.CONTENT_IDX DESC";
	String sql2 = "select p2.* from (select rownum as num, p1.* from (SELECT CT.CONTENT_IDX, CT.CONTENT_SUBJECT, TO_CHAR(CT.CONTENT_DATE, 'YYYY-MM-DD') AS CONTENT_DATE, UT.USER_NAME FROM CONTENT_TABLE CT, USER_TABLE UT WHERE CONTENT_WRITER_IDX = UT.USER_IDX AND CT.CONTENT_BOARD_IDX=? ORDER BY CT.CONTENT_IDX DESC) p1) p2 where p2.num >= ? and p2.num <= ?";
	
	// 1: 1~10	2: 11~20
	int idx_min = (now_page -1) * 10 + 1;
	int idx_max = idx_min + 9;
	
	PreparedStatement pstmt2 = db.prepareStatement(sql2);
	pstmt2.setInt(1, board_idx);
	pstmt2.setInt(2, idx_min);
	pstmt2.setInt(3, idx_max);
	
	ResultSet rs2 = pstmt2.executeQuery();
	
	JSONArray board_list = new JSONArray();
	while(rs2.next()) {
		JSONObject obj = new JSONObject();
		obj.put("content_idx", rs2.getInt("CONTENT_IDX"));
		obj.put("content_subject", rs2.getString("CONTENT_SUBJECT"));
		obj.put("content_date", rs2.getString("CONTENT_DATE"));
		obj.put("content_writer_name", rs2.getString("USER_NAME"));
		
		board_list.add(obj);
	}
	
	root.put("board_list", board_list);
	
	// 하단 페이지 번호를 위한 데이터 세팅
	String sql3 =  "SELECT COUNT(*) AS CNT FROM CONTENT_TABLE WHERE CONTENT_BOARD_IDX = ?";
	
	PreparedStatement pstmt3 = db.prepareStatement(sql3);
	pstmt3.setInt(1, board_idx);
	
	ResultSet rs3 = pstmt3.executeQuery();
	rs3.next();
	int cnt = rs3.getInt("cnt");
	
	int page_cnt = cnt/10;
	
	if (page_cnt % 10 > 0) {
		page_cnt++;
	}
	if (page_cnt == 0) {
		page_cnt++;
	}
	
	// 1~10 : 1		11~20 : 2
	int page_min = ((now_page - 1) / 10) * 10 + 1;
	int page_max = page_min + 9;
	
	if (page_max > page_cnt) {
		page_max = page_cnt;
	}
	JSONArray page_array = new JSONArray();
	for(int i = page_min; i <= page_max; i++) {
		page_array.add(i);
	}
	
	// 이전 버튼
	int pre = page_min - 1;
	if (pre < 1) {
		pre = 1;
	}
	
	// e다음
	int next = page_max + 1;
	if (next > page_cnt) {
		next = page_cnt;
	}
	
	root.put("pre", pre);
	root.put("next", next);
	
	root.put("page_array", page_array);
	
	db.close();
%>

<%= root.toJSONString() %>