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
	
	String str1 = mr.getParameter("content_idx");
	int content_idx = Integer.parseInt(str1);
	
	String content_subject = mr.getParameter("content_subject");
	String content_text = mr.getParameter("content_text");
	String content_file = mr.getParameter("content_file");
	
	String sql = "UPDATE CONTENT_TABLE SET CONTENT_SUBJECT = ?, CONTENT_TEXT = ?";
	
	if (content_file != null) {
		sql += ", CONTENT_FILE =?";
	}
	sql +=" WHERE CONTENT_IDX=?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, content_subject);
	pstmt.setString(2, content_text);
	
	if (content_file != null) {
		pstmt.setString(3, content_file);
		pstmt.setInt(4, content_idx);
	} else {
		pstmt.setInt(3, content_idx);
	}
	
	pstmt.execute();
	
	db.close();
	
%>
{
	"result" : true
}
