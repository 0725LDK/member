<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="vo.*"%>
<%@ page import="java.sql.*"%>

<%
	if(session.getAttribute("loginMemberId")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	String memberId = (String)(session.getAttribute("loginMemberId"));
	System.out.println(memberId + "<---아이디 ");
	String memberName = request.getParameter("memberName");
	System.out.println(memberName + "<---이름 ");
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
		<h1>탈퇴하기</h1>
		<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
			<table class="table table-hover">
				<tr>
					<td> ID </td>
					<td> <input type="text" value="<%=memberId%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td> 비밀번호 입력 </td>
					<td> <input type="password" name="memberPw"></td>
				</tr>
			</table>
			
			<div style="float:right;">
				<button type="submit">탈퇴하기</button>
			</div>
		</form>
		<div style="float:left;">
			<%
				if(request.getParameter("msg")!= null)
				{
			%>
					<div><span style="color:red">경고! </span><%=request.getParameter("msg") %></div>
			<%		
				}
			%>
		</div>
	</div>
</body>
</html>