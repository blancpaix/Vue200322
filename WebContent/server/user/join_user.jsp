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

	// 파라미터 한글 처리
	request.setCharacterEncoding("utf-8");
	
	// 브라우저가 전달하는 파라미터를 추출한다.
	String user_name = request.getParameter("user_name");
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	
	String sql = "INSERT INTO USER_TABLE(USER_IDX, USER_NAME, USER_ID, USER_PW) VALUES (USER_SEQ.NEXTVAL, ?, ?, ?)";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_name);
	pstmt.setString(2, user_id);
	pstmt.setString(3, user_pw);
	
	pstmt.execute();
	
	db.close();
	
%>

{
	"result" : true
	
}
	