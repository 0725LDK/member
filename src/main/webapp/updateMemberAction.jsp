<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="vo.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%
	request.setCharacterEncoding("utf-8");
	String msg = null;
	if(request.getParameter("memberName")==null || request.getParameter("memberName").equals("") )
	{
		msg = URLEncoder.encode("이름을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	String memberId = (String)(session.getAttribute("loginMemberId"));
	System.out.println(memberId + "<---아이디 ");
	String memberName = request.getParameter("memberName");
	
	System.out.println(memberName + "<---이름 ");
	
	
	
	
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결

	String chkSql="SELECT * FROM member WHERE member_name = ? "; //입력하기전에 같은 memberName가 존재하는지
	PreparedStatement chkStmt = conn.prepareStatement(chkSql);
	chkStmt.setString(1, memberName);
	ResultSet chkRs = chkStmt.executeQuery();
	if(chkRs.next())//결과물이 있으면 같은 memberId가 존재
	{
		msg = URLEncoder.encode("중복된 이름", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		
		chkRs.close();
		chkStmt.close();
		conn.close();
		
		return;
	}
	
	String updateNameSql = "UPDATE member SET member_name = ? WHERE member_id=?";
	PreparedStatement updateNameStmt = conn.prepareStatement(updateNameSql);
	updateNameStmt.setString(1, memberName);
	updateNameStmt.setString(2, memberId);
	
	updateNameStmt.executeUpdate();
	
	response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
	
	
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