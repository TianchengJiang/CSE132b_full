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
                            "INSERT INTO thesis_commitee VALUES (?, ?, ?)");

                        
			            
                        pstmt.setString(1, request.getParameter("name"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("num_prof")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("num_prof_other_dept")));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Class SET num_prof = ?, num_prof_other_dept = ? WHERE name = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("num_prof")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("num_prof_other_dept")));
                        pstmt.setString(3, request.getParameter("name"));
                        
                      
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
                            "DELETE FROM thesis_commitee WHERE name = ?");

                        pstmt.setString(1, request.getParameter("name"));
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
                        ("SELECT * FROM thesis_commitee");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>name</th>
                        <th>num_prof</th>
                        <th>num_prof_other_dept</th>
                        
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="name" size="15"></th>
                            <th><input value="" name="num_prof" size="10"></th>
                            <th><input value="" name="num_prof_other_dept" size="10"></th>
                            
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("name") %>" 
                                    name="name" size="10">
                            </td>
    
                            <%-- Get the title --%>
                            <td>
                                <input value="<%= rs.getInt("num_prof") %>"
                                    name="num_prof" size="15">
                            </td>
    
                            <%-- Get the quarter --%>
                            <td>
                                <input value="<%= rs.getInt("num_prof_other_dept") %>" 
                                    name="num_prof_other_dept" size="15">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("name") %>" name="id">
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
