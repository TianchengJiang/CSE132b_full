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
                            "INSERT INTO probation VALUES (?, ?, ?, ?, ?)");

                        
			            pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setString(3, request.getParameter("begin"));
                        pstmt.setString(4, request.getParameter("end"));
                        pstmt.setString(5, request.getParameter("info"));

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
                            "UPDATE probation SET begindate = ?, enddate = ?, info = ? WHERE id = ?");

                        pstmt.setString(1, request.getParameter("begin"));
                        pstmt.setString(2, request.getParameter("end"));
                        pstmt.setString(3, request.getParameter("info"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));
                        
                      
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
                            "DELETE FROM probation WHERE id = ?");
                        
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                        
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
                        ("SELECT * FROM probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>id</th>
                        <th>student_SSN</th>
                        <th>BeginDate</th>
                        <th>EndDate</th>
                        <th>Info</th>
                        
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="id" size="15"></th>
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="begin" size="10"></th>
                            <th><input value="" name="end" size="10"></th>
                            <th><input value="" name="info" size="10"></th>
                            
                            
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            
    
                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="id" size="10">
                            </td>
    
                          

                            <%-- Get the section_id --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("begindate") %>" 
                                    name="begin" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("enddate") %>" 
                                    name="end" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("info") %>" 
                                    name="info" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
    
                            
                        </form>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            
                            <input type="hidden" 
                                value="<%= rs.getInt("id") %>" name="id">
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
