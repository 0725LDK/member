<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="vo.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String msg = null;
	if(request.getParameter("memberPw")==null || request.getParameter("memberPw").equals("")
		||request.getParameter("newPw")==null || request.getParameter("newPw").equals(""))
	{
		msg = URLEncoder.encode("비밀번호를 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
	String memberId = (String)(session.getAttribute("loginMemberId"));
	System.out.println(memberId + "<---아이디 ");
	
	String memberPw = request.getParameter("memberPw");
	String newPw = request.getParameter("newPw");
	System.out.println(memberPw + "<---기존 PW ");
	System.out.println(newPw + "<---신규 PW ");
	
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	
	String chkSql="SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?) "; //입력하기전에 같은 memberPW가 존재하는지
	PreparedStatement chkStmt = conn.prepareStatement(chkSql);
	chkStmt.setString(1, memberId);
	chkStmt.setString(2, memberPw);
	ResultSet chkRs = chkStmt.executeQuery();
	if(chkRs.next())//결과물이 있으면 현재 비밀번호 맞음
	{
		String sql = "UPDATE MEMBER SET member_pw = PASSWORD(?) WHERE member_id= ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, memberId);
		stmt.setString(3, memberPw);
		
		stmt.executeUpdate();
		
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
		
	}
	
	else //현재비밀번호 안맞음
	{
		msg = URLEncoder.encode("기존 PW가 다릅니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		
		chkRs.close();
		chkStmt.close();
		conn.close();
		
		return;
	}
	
	
	
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