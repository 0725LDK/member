<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.sql.*"%>
<%
	//1 요청분석
	if(session.getAttribute("loginMemberId")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	String memberId = (String)(session.getAttribute("loginMemberId"));
	System.out.println(memberId);
	
	
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
   
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	
	String sql = "SELECT member_id memberId, member_pw memberPw ,member_name memberName  FROM MEMBER WHERE member_id= ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberId);
	ResultSet rs = stmt.executeQuery();
	Member member =null;
	if(rs.next())
	{
		member = new Member();
		member.memberId = rs.getString("memberId");
		member.memberPw = rs.getString("memberPw");
		member.memberName = rs.getString("memberName");
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

	<style>

		a 
			{
		  		text-decoration: none;
			}
		tr,td
			{
				text-align: center;
			}
		.inner-div 
			{
			 	width : 300px;
			 	height : 30px;
			 	margin: auto;
			}
		.center
			{
				text-align : center;
			}
	</style>
</head>
<body>
	
	<div class="container">
		<br><h1>내정보</h1>
		<div>
			<span> ID : <%= member.memberId %></span><br>	
			<span> 이름 : <%= member.memberName%></span>
		</div><br>
		<!-- 비밀번호를 제외한 모든 정보(컬럼) 출력 -->
		<h3>메뉴</h3>
			
			<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">개인정보 수정</a><br>
			<!-- updateMemberAction 비밀번호수정 X-->
		
			<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호 수정</a><br>
			<!-- updateMemberPwAction 수정전 Pw와 변경할 Pw 입력받기-->
			
			<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a><br>
			<!-- deleteMemberAction 비밀번호 확인 후 삭제 후 session.invalidate();-->
			<a href="<%=request.getContextPath()%>/memberIndex.jsp">돌아가기</a> <br>
		
	</div>
</body>
</html>