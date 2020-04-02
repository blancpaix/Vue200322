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
	
	// 글 번호를 받음
	String str1 = request.getParameter("content_idx");
	int content_idx = Integer.parseInt(str1);
	
	String sql = "SELECT CT.CONTENT_IDX, CT.CONTENT_SUBJECT, CT.CONTENT_TEXT, CT.CONTENT_FILE, CT.CONTENT_WRITER_IDX, UT.USER_NAME, TO_CHAR(CT.CONTENT_DATE, 'YYYY-MM-DD') AS CONTENT_DATE FROM CONTENT_TABLE CT, USER_TABLE UT	WHERE CT.CONTENT_WRITER_IDX =  UT.USER_IDX AND CT.CONTENT_IDX=?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1, content_idx);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	JSONObject root = new JSONObject();
	
	root.put("content_idx", rs.getInt("CONTENT_IDX"));
	root.put("content_subject", rs.getString("CONTENT_SUBJECT"));
	root.put("content_text", rs.getString("CONTENT_TEXT"));
	root.put("content_file", rs.getString("CONTENT_FILE"));
	root.put("content_writer_idx", rs.getString("CONTENT_WRITER_IDX"));
	root.put("content_writer_name", rs.getString("USER_NAME"));
	root.put("content_date", rs.getString("CONTENT_DATE"));
	
	db.close();
%>

<%= root.toJSONString() %>