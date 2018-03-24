<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
       request.setCharacterEncoding("utf-8");
    
       String memberID = request.getParameter("memberID");
       String name = request.getParameter("name");
      
       int updateCount = 0;
       
      //1. JDBC 드라이버 로딩  - JDBC 드라이버를 로딩해야 DB에 연결해서 원하는 작업을 수행할 수 있다.
      /* Class.forName("com.mysql.jdbc.Driver"); */
      Class.forName("oracle.jdbc.driver.OracleDriver");
       
       Connection conn = null;
       Statement stmt = null;
       
       try{
          /* String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?"+
                         "useUnicde=true&characterEncoding=utf8"; */
          String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
          String dbUser = "jspexam";
          String dbPass = "jsppw";
          String query = "update MEMBER set NAME ='"+name+"' "+
          				"where MEMBERID ='"+memberID+"'";
         
         //2. 데이터베이스 커넥션 생성 -db에 접속을 하는 코드 dbuser에 아이디 dbpass에 비밀번호. drivermanger.getconnection메서드는 db와 연결된 connection 객체를 리턴한다.  
         conn=DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
         
         //3. Statement 생성 - Statement 객체를 사용하면 쿼리(SELECT,INSERT,UPDATE,DELETE)를 실행 할 수 있다.
         stmt=conn.createStatement();
         
       	 //4. 쿼리실행
         updateCount =stmt.executeUpdate(query);
        		
       }finally{
    	  //6.사용한 statment 종료
          if(stmt!=null)
            try{
               stmt.close();
            }catch(SQLException ex){}
         
         //7. 커넥션 종료
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
<% if(updateCount > 0){ %>
<%= memberID %>의 이름을 <%=name%>(으)로 변경
<%}else{ %>
<%=memberID %>아이디가 존재하지 않음
<%} %>
</body>
</html>