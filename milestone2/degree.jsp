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
                            "INSERT INTO degree VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("LD_units")));
                        pstmt.setString(3, request.getParameter("LD_GPA"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UD_units")));
                        pstmt.setString(5, request.getParameter("UD_GPA"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("Total_units")));
                        pstmt.setString(7, request.getParameter("Total_GPA"));
                        pstmt.setString(8, request.getParameter("Major_GPA"));
                        pstmt.setString(9, request.getParameter("IS_MS"));

                        
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
                            "UPDATE degree SET LD_units = ?, LD_GPA = ?, UD_units = ?, UD_GPA = ?, Total_units = ? , Total_GPA = ?, Major_GPA = ?, IS_MS = ? WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("LD_units")));
                        pstmt.setString(2, request.getParameter("LD_GPA"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("UD_units")));
                        pstmt.setString(4, request.getParameter("UD_GPA"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("Total_units")));
                        pstmt.setString(6, request.getParameter("Total_GPA"));
                        pstmt.setString(7, request.getParameter("Major_GPA"));
                        pstmt.setString(8, request.getParameter("IS_MS"));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("id")));

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
                            "DELETE FROM degree WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("id")));
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
                        ("SELECT * FROM degree");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>id</th>
                        <th>LD_units</th>
                        <th>LD_GPA</th>
                        <th>UD_units</th>
                        <th>UD_GPA</th>
                        <th>Total_units</th>
                        <th>Total_GPA</th>
                        <th>Major_GPA</th>
                        <th>IS_MS</th>

                        <th>Action</th>
                        
                    </tr>
                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="id" size="10"></th>
                            <th><input value="" name="LD_units" size="10"></th>
                            <th><input value="" name="LD_GPA" size="15"></th>
                            <th><input value="" name="UD_units" size="15"></th>
                            <th><input value="" name="UD_GPA" size="15"></th>
                            <th><input value="" name="Total_units" size="10"></th>
                            <th><input value="" name="Total_GPA" size="10"></th>
                            <th><input value="" name="Major_GPA" size="15"></th>
                            <th><input type="radio" value="YES" name="IS_MS" size="15">YES
                                <input type="radio" value="NO" name="IS_MS" size="15">NO</th>


                            <th><input type="submit" value="Insert"></th>

                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            
    
                            <%-- Get the id --%>
                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="id" size="10">
                            </td>
    
                            <%-- Get the number --%>
                            <td>
                                <input value="<%= rs.getInt("LD_units") %>"
                                    name="LD_units" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("LD_GPA") %>"
                                    name="LD_GPA" size="15">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("UD_units") %>"
                                    name="UD_units" size="15">
                            </td>
                            <td>
                                <input value="<%= rs.getString("UD_GPA") %>"
                                    name="UD_GPA" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("Total_units") %>"
                                    name="Total_units" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("Total_GPA") %>"
                                    name="Total_GPA" size="15">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Major_GPA") %>"
                                    name="Major_GPA" size="15">
                            </td>
                            <td>
                                <input value="<%= rs.getString("IS_MS") %>"
                                    name="IS_MS" size="15">
                            </td>


    
                            
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degree.jsp" method="get">
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