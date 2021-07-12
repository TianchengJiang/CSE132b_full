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
                            "INSERT INTO meeting VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                        pstmt.setString(2, request.getParameter("weekday"));
                        pstmt.setString(3, request.getParameter("time"));
                        pstmt.setString(4, request.getParameter("room"));
                        pstmt.setString(5, request.getParameter("type"));
                        pstmt.setString(6, request.getParameter("mandatory"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("section_id")));
                        
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
                            "UPDATE meeting SET weekday = ?, time = ?, room = ?, type = ?, mandatory = ? WHERE id = ?");

                        pstmt.setString(1, request.getParameter("weekday"));
                        pstmt.setString(2, request.getParameter("time"));
                        pstmt.setString(3, request.getParameter("room"));
                        pstmt.setString(4, request.getParameter("type"));
                        pstmt.setString(5, request.getParameter("mandatory"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("id")));

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
                        
                        // Create the prepared statement 
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM meeting WHERE id = ?");

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
                        ("SELECT * FROM meeting");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>id</th>
                        <th>weekday</th>
                        <th>time</th>
                        <th>room</th>
                        <th>type</th>
                        <th>mandatory</th>
                        <th>section_id</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="meetings.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="id" size="10"></th>
                            <th><input value="" name="weekday" size="10"></th>
                            <th><input value="" name="time" size="10"></th>
                           
                            <th><input value="" name="room" size="15"></th>
                                
                            <th><input type="radio"  value="LE"  name="type" size="15">LE
                                <input type="radio"  value="DI"  name="type" size="15">DI
                                <input type="radio"  value="Lab"  name="type" size="15">Lab</th>

                            
                            <th><input value="" name="mandatory" size="10"></th>
    
                            <th><input value="" name="section_id" size="10"></th>

                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="meetings.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            
    
                            <%-- Get the id --%>
                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="id" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("weekday") %>" 
                                    name="weekday" size="10">
                            </td>
    
                            <%-- Get the number --%>
                            <td>
                                <input value="<%= rs.getString("time") %>"
                                    name="time" size="15">
                            </td>

                            <td>
                                    <input value="<%= rs.getString("room") %>"
                                        name="room" size="15">
                                </td>

                            <td>
                                <input value="<%= rs.getString("type") %>"
                                    name="type" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("mandatory") %>"
                                    name="mandatory" size="15">
                            </td>
                            
                            <td>
                                <input value="<%= rs.getString("section_id") %>"
                                    name="section_id" size="15">
                            </td>
                            
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="meetings.jsp" method="get">
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