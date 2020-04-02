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
	
	String sql = "SELECT BOARD_INFO_IDX, BOARD_INFO_NAME FROM BOARD_INFO_TABLE ORDER BY BOARD_INFO_IDX";
	PreparedStatement pstmt = db.prepareStatement(sql);
	
	// 쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	
	JSONArray root = new JSONArray();
	
	while(rs.next() ) {
		JSONObject obj = new JSONObject();
		
		obj.put("board_info_idx", rs.getInt("board_info_idx"));
		obj.put("board_info_name", rs.getString("board_info_name"));
		
		root.add(obj);
	}
%>

<%= root.toJSONString() %>
<% db.close(); %>