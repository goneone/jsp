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
         //1. JDBC 드라이버 로딩  - JDBC 드라이버를 로딩해야 DB에 연결해서 원하는 작업을 수행할 수 있다.
     	 /*Class.forName("com.mysql.jdbc.Driver");  <-- mysql 드라이버>*/
     	 Class.forName("oracle.jdbc.driver.OracleDriver");
     	 
         Connection conn = null;
         Statement stmt = null;
         ResultSet rs = null;

         try {

         	/*String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" + "useUnicode=true&characterEncoding=utf8"; */
            String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe"; //데이터베이스 식별을 위한 JDBC URL -> 웹주소를 구분할 때 google.com이나 daum.net과 같은 
            //url을 사용하는 것처럼 데이터베이스를 구분할 때에는 JDBC URL을 사용함. 
            String dbUser = "jspexam";
            String dbPass = "jsppw";
            String query = "select * from MEMBER order by MEMBERID"; 

            //2. 데이터베이스 커넥션 생성 -db에 접속을 하는 코드 dbuser에 아이디 dbpass에 비밀번호. drivermanger.getconnection메서드는 db와 연결된 connection 객체를 리턴한다. 
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
            
            //3. Statement 생성 - Statement 객체를 사용하면 쿼리(SELECT,INSERT,UPDATE,DELETE)를 실행 할 수 있다.
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
			<td><%=rs.getString("EMAIL")%></td>
		</tr>

		<%
         }
         } catch (SQLException ex) { //DriverManager.getConnection 메서드가 Connection객체를 생성하지 못하면 SQLException 예외 발생. 
            out.println(ex.getMessage());
            ex.printStackTrace();
         } finally { //finally는 예외 발생 여부와 상관없이 가장 마지막에 실행 됨.
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