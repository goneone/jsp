<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<!-- DB연동하기 위한 자바 패키지 임포트 -->
	
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

</head>

<body>

	<% request.setCharacterEncoding("utf-8"); %>
	<!-- 한글 인코딩 지정하기 -->

	<h2>DB 연결 테스트</h2>

	<hr />

	<%

 String name = request.getParameter("name");

 String content = request.getParameter("contents");

 

   

 try{

  Class.forName("com.mysql.jdbc.Driver");  //JDBC Driver 지정

  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/blogdb?characterEncoding=utf8", "root", "1234");  //연결할 DB 서버 정보 지정

  out.println("연결 성공");

  

 }catch(Exception e){

  System.out.println(e.toString());

 }

 

%>

</body>

</html>
