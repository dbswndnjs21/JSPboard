<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-17
  Time: 오전 10:53
  To change this template use File | Settings | File Templates.
--%>
<!-- 100개 데이터 강제로 넣기 위해 만든 jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.naming.Context" %>    
<%@ page import="javax.naming.InitialContext" %>    
<%@ page import="javax.naming.NamingException" %>
    
<%@ page import="javax.sql.DataSource" %>
    
<%@ page import="java.sql.Connection" %>    
<%@ page import="java.sql.SQLException" %>    
<%@ page import= "java.sql.PreparedStatement" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    int flag = 1;
    try {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context)initCtx.lookup("java:comp/env");
	    DataSource dataSource = (DataSource)envCtx.lookup("jdbc/mariadb2");
	    
	    conn = dataSource.getConnection();
	    
	    String sql = "insert into board1 values(0, ?, ?, ?, password(?), ? , 0 , ? , now() ) ";
	    pstmt = conn.prepareStatement(sql);

		for (int i = 1 ; i <= 100 ; i++) {
			pstmt.setString(1, "제목 " + i );
			pstmt.setString(2, "tester");
			pstmt.setString(3, "test" + i + "@test.com" );
			pstmt.setString(4, "1234" );
			pstmt.setString(5, "내용 " + i );
			pstmt.setString(6, "000.000.000.000" );

			if(pstmt.executeUpdate() == 1) {
				flag = 0;
			}
		}

	    
    } catch(NamingException e ) {
    	System.out.println("에러 : " + e.getMessage());
    }catch(SQLException e ) {
    	System.out.println("에러 : " + e.getMessage());
    }finally{
    	if(pstmt != null)pstmt.close();
    	if(conn != null)conn.close();
    }
    out.println("<script type = 'text/javascript'>");
    if (flag == 0 ) {
    	//System.out.println("정상 입력");
    	out.println("alert('글쓰기 성공');");
    	out.println("location.href = './board_list1.jsp';");
    } else {
    	//System.out.println("에러");
    	out.println("alert('글쓰기 실패');");
    	out.println("history.back();");
    }
    out.println("</script>");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
