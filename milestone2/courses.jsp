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
                            "INSERT INTO course VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("id")));
                        pstmt.setString(2, request.getParameter("number"));
                        pstmt.setString(3, request.getParameter("department"));
                        pstmt.setString(4, request.getParameter("lab_course"));
                        pstmt.setString(5, request.getParameter("grading"));
                        
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
                            "UPDATE course SET Course_number = ?, department = ?, lab_course = ?, grading = ?" +
                            "WHERE id = ?");

                        pstmt.setString(1, request.getParameter("number"));
                        pstmt.setString(2, request.getParameter("department"));
                        pstmt.setString(3, request.getParameter("lab_course"));
                        pstmt.setString(4, request.getParameter("grading"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));

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
                            "DELETE FROM course WHERE id = ?");

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
                        ("SELECT * FROM course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>id</th>
                        <th>number</th>
                        <th>department</th>
                        <th>lab_course</th>
                        <th>grading</th>
                        <th>Action</th>
                        
                    </tr>
                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="id" size="10"></th>
                            <th><input value="" name="number" size="10"></th>
                            <th><input value="" name="department" size="10"></th>
                            <th><input type = "radio" value="YES" name="lab_course" size="15">YES
                                <input type = "radio" value="NO" name="lab_course" size="15">NO</th>
                            <th><input type = "radio" value="PNP" name="grading" size="15">PNP
                                <input type = "radio" value="Letter" name="grading" size="15">Letter</th>
                            
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            
    
                            <%-- Get the id --%>
                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="id" size="10">
                            </td>
    
                            <%-- Get the number --%>
                            <td>
                                <input value="<%= rs.getString("course_number") %>"
                                    name="number" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("department") %>"
                                    name="department" size="15">
                            </td>
                            <td>
                                <input value="<%= rs.getString("lab_course") %>"
                                    name="lab_course" size="15">
                            </td>
                            <td>
                                <input value="<%= rs.getString("grading") %>"
                                    name="grading" size="15">
                            </td>
    
                            
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="courses.jsp" method="get">
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