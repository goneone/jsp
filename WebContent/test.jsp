<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>삽입</title>
</head>
<body>
	<% 
 // 데이터베이스 접속을 위한 클래스
    Connection conn = null;
    // 접속 후 질의문을 실행시킬 클래스
    PreparedStatement pstmt = null;
    // 질의문에 대한 결과값이 있는 클래스
    ResultSet rs = null;
    try {
       // MySQL Driver 를 불러 들인다.
       Class.forName("com.mysql.jdbc.Driver");
       // 데이터베이스 커넥션을 위한 정보를 인자로 넘기며 커넥션을 얻는다.
       conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3307/opentutorials", "root", "root");
       // 커넥션 객체를 얻은 후 질의문을 데이터베이스에 요청 한다.

       pstmt = conn.prepareStatement("select * from author");

       // 요청한 질의문을 실행 후 결과값을 받는다.

       rs = pstmt.executeQuery();

       while(rs.next()) {

          // 검색된 게시물의 결과값을 표시

       }

    // try 문 내에서 예외상황이 발생 했을 시 실행

    } catch (Exception e) {

       e.printStackTrace();

    // try, catch 문 실행 완료 후 실행되는 데 사용객체들을 닫아준다.

    } finally {

       if (rs != null) rs.close();

       if (pstmt != null) pstmt.close();

       if (conn != null) conn.close();

    }
    %>
</body>
</html>