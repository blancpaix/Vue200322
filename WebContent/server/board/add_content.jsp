<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

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
	
	// 첨부파일이 있을 경우 cos.jar 을 사용하기 때문에 위에서 추가해줌
	
	// 업로드 파일 최대 용량
	int maxSize = 1024 * 1024 * 100;			// 100Mb
	
	// 이름 변경 정책 (중복된 파일명이 올라왔을 경우 뒤에 숫자를 붙힌다)
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	// 저장될 서버상의 경로
	String path = getServletContext().getRealPath("/upload");
	
	// 업로드 처리
	MultipartRequest mr = new MultipartRequest(request, path, maxSize, "UTF-8", policy);
	// 파일 업로드를 할때는 request 객체로 접근하면 안됩니다!
	
	String str1 = mr.getParameter("board_writer_idx");
	int board_writer_idx = Integer.parseInt(str1);
	
	String str2 = mr.getParameter("board_content_idx");
	int board_content_idx = Integer.parseInt(str2);
	
	String board_subject = mr.getParameter("board_subject");
	String board_content = mr.getParameter("board_content");
	
	// String board_file = mr.getParameter("board_file");	 파일 이름 뽑아낼때는 getParameter 사용 안해요
	String board_file = mr.getFilesystemName("board_file");
	
	String sql = "INSERT INTO CONTENT_TABLE (CONTENT_IDX, CONTENT_SUBJECT, CONTENT_TEXT, CONTENT_FILE, CONTENT_WRITER_IDX, CONTENT_BOARD_IDX, CONTENT_DATE) VALUES ( CONTENT_SEQ.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE)";
	PreparedStatement pstmt = db.prepareStatement(sql);
	
	pstmt.setString(1, board_subject);
	pstmt.setString(2, board_content);
	pstmt.setString(3, board_file);
	pstmt.setInt(4, board_writer_idx);
	pstmt.setInt(5, board_content_idx);
			
	pstmt.execute();
	
	// 새롭게 추가된 글의 번호를 파악한다???
	String sql2 = "SELECT CONTENT_SEQ.CURRVAL AS CONTENT_IDX FROM DUAL";
	PreparedStatement pstmt2 = db.prepareStatement(sql2);
	ResultSet rs2 = pstmt2.executeQuery();
	rs2.next();
	
	int content_idx = rs2.getInt("content_idx");
	
	db.close();
	
%>
{
	"result" : true,
	"content_idx" : <%= content_idx %>
}