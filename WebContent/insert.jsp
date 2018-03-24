<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
       request.setCharacterEncoding("utf-8");
    
       String memberID = request.getParameter("memberID");
       String password = request.getParameter("password");
       String name = request.getParameter("name");
       String email = request.getParameter("email");
       
     //1. JDBC 드라이버 로딩  - JDBC 드라이버를 로딩해야 DB에 연결해서 원하는 작업을 수행할 수 있다.
      /* Class.forName("com.mysql.jdbc.Driver"); */
       Class.forName("oracle.jdbc.driver.OracleDriver");
       
       Connection conn = null;
       PreparedStatement pstmt = null;
       
       try{
          /* String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?"+
                         "useUnicde=true&characterEncoding=utf8"; */
          String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
          String dbUser = "jspexam";
          String dbPass = "jsppw";
          
        //2. 데이터베이스 커넥션 생성 -db에 접속을 하는 코드 dbuser에 아이디 dbpass에 비밀번호. 
        //drivermangㅁer.getconnection메서드는 db와 연결된 connection 객체를 리턴한다. 
         conn=DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
        
        //3. 틀을 미리 생성해 놓고 값을 넣음. 
         pstmt=conn.prepareStatement("insert into MEMBER values(?,?,?,?)");
         pstmt.setString(1, memberID);
         pstmt.setString(2, password);
         pstmt.setString(3, name);
         pstmt.setString(4, email);
         
         //4. 쿼리 실행 
         pstmt.executeUpdate();
         
         //5. 사용한pstmt 종료
       }finally{
          if(pstmt!=null)
            try{
               pstmt.close();
            }catch(SQLException ex){}
         
         //6. 커넥션 종료
         if(conn!=null)
            try{
               conn.close();
            }catch(SQLException ex){}
       }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>삽입</title>
</head>
<body>


   MEMBER 테이블에 새로운 레코드를 삽입했습니다.
</body>
</html>