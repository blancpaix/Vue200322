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
	
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	
	String sql = "SELECT USER_IDX, USER_NAME FROM USER_TABLE WHERE USER_ID = ? AND USER_PW = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	pstmt.setString(2, user_pw);
	
	ResultSet rs = pstmt.executeQuery();
	
	boolean chk = rs.next();
	
	JSONObject root = new JSONObject();
	
	if (chk == false) {
		root.put("result", false);
	} else {
		root.put("result", true);
		root.put("user_idx", rs.getInt("user_idx"));
		root.put("user_name", rs.getString("user_name"));
		root.put("user_id", user_id);
		
		session.setAttribute("login_chk", true);
	}
	
	db.close();
	
%>

<%= root.toJSONString() %>