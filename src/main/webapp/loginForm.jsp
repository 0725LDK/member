<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//1 로그인이 되어 있을대는 접근불가
	if(session.getAttribute("loginMemberId") != null)
	{
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
		return;
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
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
		#btnSubmit
			{
				width:100px;
				margin:auto;
				display:block;
			}
	</style>
</head>
<body>
	<br>
	<div class="container">
		<h1>로그인</h1>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table class="table table-hover">
				<tr>
					<td>ID</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
			</table>
			<div style="float:right;">
				<button type="submit">로그인</button>
			</div>
		</form>
		<div style="float:left;">
			<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
			<!--/insertMemberFrom.jsp insertMemberAction.jsp redirect loginform  -->
			<%
				if(request.getParameter("msg") != null)
				{
			%>
					<span><span style="color:red">경고! </span><%=request.getParameter("msg") %></span>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>