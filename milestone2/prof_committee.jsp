<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    String dbURL = "jdbc:postgresql:cse132b?user=postgres&password=Tc0504%25";
                    Connection conn = DriverManager.getConnection(dbURL);

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO prof_commitee VALUES (?, ?)");

                        
			            pstmt.setString(1, request.getParameter("prof_name"));
                        pstmt.setString(2, request.getParameter("commitee_name"));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM prof_commitee WHERE prof_name = ? AND commitee_name = ?");
                        
                        pstmt.setString(1, request.getParameter("prof_name"));
                        pstmt.setString(2, request.getParameter("commitee_name"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM prof_commitee");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>prof_name</th>
                        <th>commitee_name</th>
                        
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="prof_committee.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="prof_name" size="15"></th>
                            <th><input value="" name="commitee_name" size="10"></th>
                            
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="prof_committee.jsp" method="get">
                            

                            
    
                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getString("prof_name") %>" 
                                    name="prof_name" size="10">
                            </td>
    
                          

                            <%-- Get the section_id --%>
                            <td>
                                <input value="<%= rs.getString("commitee_name") %>" 
                                    name="commitee_name" size="15">
                            </td>
    
                            
                        </form>
                        <form action="prof_committee.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("prof_name") %>" name="prof_name">
                            <input type="hidden" 
                                value="<%= rs.getString("commitee_name") %>" name="commitee_name">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
