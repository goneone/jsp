<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
   Member 테이블의 내용
   <table width="100%" border="1">
      <tr>
         <td>이름</td>
         <td>아이디</td>
         <td>이메일</td>
      </tr>
      <%
         //1. JDBC 드라이버 로딩
     /*     Class.forName("com.mysql.jdbc.Driver"); */
     	 Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection conn = null;
         Statement stmt = null;
         ResultSet rs = null;

         try {

         /*    String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" + "useUnicode=true&characterEncoding=utf8"; */
            String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";

            String dbUser = "jspexam";
            String dbPass = "jsppw";

            String query = "select *from MEMBER order by MEMBERID"; 

            //2. 데이터베이스 커넥션 생성 -db에 접속을 하는 코드 
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            //3. Statement 생성
            stmt = conn.createStatement();

            //4. 쿼리실행
            rs = stmt.executeQuery(query);

            //5. 쿼리실행 결과 출력
            while (rs.next()) { //데이터에 접근해서 데이터가있는지 체크 ResultSet에서 제공해주는 기능임. 레코드 단위로 데이터를 읽어올수 있게끔.. 
      %>

      <tr>
         <td><%=rs.getString("NAME")%></td>
         <td><%=rs.getString("MEMBERID")%></td>
         <td><%=rs.getString("EMAIL")%></td>
      </tr>

      <%
         }
         } catch (SQLException ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
         } finally {
            //6.사용한 statment 종료
            if (rs != null)
               try {
                  rs.close();
               } catch (SQLException ex) {
               }
            if (stmt != null)
               
               try {
                  stmt.close();
               } catch (SQLException ex) {
               }

            //7. 커넥션 종료
            if (conn != null)
               try {
                  conn.close();
               } catch (SQLException ex) {
               }
         }
      %>
   </table>
</body>
</html>