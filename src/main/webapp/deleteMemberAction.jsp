<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="vo.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	if(session.getAttribute("loginMemberId")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = (String)(session.getAttribute("loginMemberId"));
	System.out.println(memberId + "<---아이디 ");
	
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberPw + "<---기존 PW ");
	
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	
	String chkSql="SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?) "; //삭제하기전에 memberPW가 맞는지
	PreparedStatement chkStmt = conn.prepareStatement(chkSql);
	chkStmt.setString(1, memberId);
	chkStmt.setString(2, memberPw);
	ResultSet chkRs = chkStmt.executeQuery();
	
	if(chkRs.next())
	{
		String sql = "DELETE FROM MEMBER WHERE member_id= ? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		
		stmt.executeUpdate();
		chkRs.close();
		stmt.close();
		conn.close();
		
		
		response.sendRedirect(request.getContextPath()+"/logOut.jsp");
	}
	else
	{
		String msg = URLEncoder.encode("기존 PW가 다릅니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		
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