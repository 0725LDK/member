<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>

<%
	
	//요청처리
	request.setCharacterEncoding("utf-8");
	String msg = null;
	if(request.getParameter("memberId")==null 
	     || request.getParameter("memberPw")==null
	     || request.getParameter("memberName")==null
	     || request.getParameter("memberId").equals("") 
	     || request.getParameter("memberPw").equals("")
	     || request.getParameter("memberName").equals(""))
	{
	  	msg = URLEncoder.encode("항목들을 빠짐없이 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}

	String memberId = request.getParameter("memberId");	
	String memberPw = request.getParameter("memberPw");	
	String memberName = request.getParameter("memberName");	
	
	//vo로 묶고 싶다면
	/* 
	Member member = new Member();
	member.memberId = memberId;
	member.memberPw = memberPw;
	member.memberName = memberName;
	 */
	//연결
	Class.forName("org.mariadb.jdbc.Driver");
	String conURL = "jdbc:mariadb://localhost:3306/gdj58";
	String conUser = "root";
	String conPw = "java1234";
	Connection conn = DriverManager.getConnection(conURL,conUser,conPw);

	//아이디 중복체크 쿼리
	String chkSql="SELECT * FROM member WHERE member_id = ? "; //입력하기전에 같은 memberId가 존재하는지
	PreparedStatement chkStmt = conn.prepareStatement(chkSql);
	chkStmt.setString(1, memberId);
	chkStmt.setString(2, memberName);
	ResultSet chkRs = chkStmt.executeQuery();
	if(chkRs.next())//결과물이 있으면 같은 memberId가 존재
	{
		msg = URLEncoder.encode("중복된 아이디", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		
		chkRs.close();
		chkStmt.close();
		conn.close();
		
		return;
	}
	
	//회원가입 쿼리
	String sql = "INSERT INTO MEMBER(member_id, member_pw, member_name) VALUES(?, PASSWORD(?), ?);";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberId);
	stmt.setString(2, memberPw);
	stmt.setString(3, memberName);
	stmt.executeUpdate();
	
	//회원가입 완료되면 연결되는 페이지
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");

	stmt.close();
	conn.close();
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>