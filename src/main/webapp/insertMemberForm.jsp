<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

	<div class="container">
		<h1>회원가입</h1>
		<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
			<table class="table table-hover">
				<tr>
					<td>사용할 ID</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<td>사용할 PW</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
				<tr>
					<td>사용할 이름</td>
					<td><input type="text" name="memberName"></td>
				</tr>
			</table>
			<div style="float:right;">	
				<button type="submit">회원가입하기</button>
			</div>
		</form>
	
		<%
			if(request.getParameter("msg")!= null)
			{
		%>
				<span style="float:left;" ><span style="color:red">경고! </span><%=request.getParameter("msg") %></span>
		<%		
			}
		%>
	</div>
</body>
</html>