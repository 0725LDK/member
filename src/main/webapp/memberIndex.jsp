<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//1 요청분석
	if(session.getAttribute("loginMemberId")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<br>
	<div class="container">
		<h1>
			<%=(String)(session.getAttribute("loginMemberId")) %>님, 반갑습니다.
		</h1><br>
		
		<h3>메뉴</h3>
		<a href="<%=request.getContextPath()%>/memberOne.jsp">마이페이지</a><br>
		<a href="<%=request.getContextPath()%>/logOut.jsp">로그아웃</a>
		
		
		<div>
			<input type="hidden" name="memberId" value="<%=memberId%>">
			<input type="hidden" name="memberPw" value="<%=memberPw%>">
		</div>
	</div>
</body>
</html>