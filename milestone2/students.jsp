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

                        // Begin student table transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(3, request.getParameter("FIRSTNAME"));
                        pstmt.setString(4, request.getParameter("MIDDLENAME"));
                        pstmt.setString(5, request.getParameter("LASTNAME"));
                        pstmt.setString(6, request.getParameter("ORIGIN"));
                        pstmt.setString(7, request.getParameter("ENROLLED"));
                        pstmt.setString(8, request.getParameter("ISPROBATION"));
                        pstmt.setString(9, request.getParameter("ISGRADUATE"));
                        pstmt.setString(10, request.getParameter("PREVIOUSDEGREE"));

                        int rowCount = pstmt.executeUpdate();

        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
        
          
                     

                    if (request.getParameter("PREVIOUSDEGREE").equals("YES")) {
                        conn.setAutoCommit(false);
                        pstmt = conn.prepareStatement("Insert into previous_degree values(?, ?, ?)");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setString(2, request.getParameter("TYPE"));
                        pstmt.setString(3, request.getParameter("INSTITUTION"));
                        rowCount = pstmt.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
    
                    conn.setAutoCommit(false);
                        
                    if (request.getParameter("ISGRADUATE").equals("YES")){
                            pstmt = conn.prepareStatement("INSERT INTO graduate VALUES (?, ?, ?, ?, ?)");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setString(2, request.getParameter("DEPARTMENT"));
                        pstmt.setString(3, request.getParameter("ISPHD"));
                        pstmt.setString(4, request.getParameter("CANDIDACY"));
                        pstmt.setString(5, request.getParameter("FIFTHYEAR"));
                        
                        rowCount = pstmt.executeUpdate();
                    }else{
                        pstmt = conn.prepareStatement("INSERT INTO undergraduate VALUES (?, ?, ?, ?)");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setString(2, request.getParameter("COLLEGE"));
                        pstmt.setString(3, request.getParameter("MAJOR"));
                        pstmt.setString(4, request.getParameter("MINOR"));
                        rowCount = pstmt.executeUpdate();
                    }


        


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
                            "UPDATE Student SET ID = ?, FIRSTNAME = ?, " +
                            "MIDDLENAME = ?, LASTNAME = ?, ORIGIN = ?, ENROLLED = ?, ISPROBATION = ? WHERE SSN = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
                        pstmt.setString(3, request.getParameter("MIDDLENAME"));
                        pstmt.setString(4, request.getParameter("LASTNAME"));
                        pstmt.setString(5, request.getParameter("ORIGIN"));
                        pstmt.setString(6, request.getParameter("ENROLLED"));
                        pstmt.setString(7, request.getParameter("ISPROBATION"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("SSN")));
                        int rowCount = pstmt.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
        



                    


                    if (request.getParameter("PREVIOUSDEGREE").equals("YES")) {
                        conn.setAutoCommit(false);
                        pstmt = conn.prepareStatement("UPDATE previous_degree SET degree_TYPE = ?, INSTITUTION = ? WHERE SSN = ?");

                        pstmt.setString(1, request.getParameter("TYPE"));
                        pstmt.setString(2, request.getParameter("INSTITUTION"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("SSN")));
                        rowCount = pstmt.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
                    }

                    conn.setAutoCommit(false);

            
                    if (request.getParameter("ISGRADUATE").equals("YES")){
                      pstmt = conn.prepareStatement("update graduate SET department = ?, isPHD = ?, candidacy = ?, fifthyear = ? WHERE SSN = ?");

                    
                      pstmt.setString(1, request.getParameter("DEPARTMENT"));
                      pstmt.setString(2, request.getParameter("ISPHD"));
                      pstmt.setString(3, request.getParameter("CANDIDACY"));
                      pstmt.setString(4, request.getParameter("FIFTHYEAR"));
                      pstmt.setInt(5, Integer.parseInt(request.getParameter("SSN")));
                      rowCount = pstmt.executeUpdate();
                    }else{
                      pstmt = conn.prepareStatement("UPDATE undergraduate SET college = ?, major = ?, minor = ? WHERE SSN = ?");
                      
                      pstmt.setString(1, request.getParameter("COLLEGE"));
                      pstmt.setString(2, request.getParameter("MAJOR"));
                      pstmt.setString(3, request.getParameter("MINOR"));
                      pstmt.setInt(4, Integer.parseInt(request.getParameter("SSN")));
                      rowCount = pstmt.executeUpdate();
                    }





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
                        // DELETE the probation FROM the probation table.

              
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM probation WHERE SSN = ?");
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                         conn.setAutoCommit(true);

              // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the previous degree FROM the previous_degree table.

              
                        pstmt = conn.prepareStatement(
                            "DELETE FROM previous_degree WHERE SSN = ?");
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                         conn.setAutoCommit(true);

         // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the undergraduate FROM the undergraduate table.

              
                        pstmt = conn.prepareStatement(
                            "DELETE FROM undergraduate WHERE SSN = ?");
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                         conn.setAutoCommit(true);

         // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the graduate FROM the graduate table.

              
                        pstmt = conn.prepareStatement(
                            "DELETE FROM graduate WHERE SSN = ?");
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);

                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the graduate FROM the student table.

              
                        pstmt = conn.prepareStatement(
                            "DELETE FROM student WHERE SSN = ?");
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        rowCount = pstmt.executeUpdate();

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
                    ResultSet rs_student = statement.executeQuery("SELECT * FROM Student");
            

          
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>ID</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
                        <th>Origin</th>
                        <th>Enrolled</th>

                        <th>Isprobation</th>
                        
    
                        <th>Isgraduate</th>
                        <th>College</th>
                        <th>Major</th>
                        <th>Minor</th>
                        <th>Department</th>
                        <th>IsPHD</th>
                        <th>Candidacy</th>
                        <th>Fifthyear</th>

                        <th>Has previous degree</th>
                        <th>DegreeType</th>
                        <th>Institution</th>

                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="ID" size="10"></th>
                            <th><input value="" name="FIRSTNAME" size="15"></th>
                            <th><input value="" name="MIDDLENAME" size="15"></th>
                            <th><input value="" name="LASTNAME" size="15"></th>

                            <th><input type="radio"  value="CA"  name="ORIGIN" size="15">CA
                                <input type="radio"  value="non_CA"  name="ORIGIN" size="15">non_CA
                                <input type="radio"  value="Foreign"  name="ORIGIN" size="15">Foreign</th>
        

                            <th><input type="radio"  value="YES"  name="ENROLLED" size="15">YES
                                <input type="radio"  value="NO"  name="ENROLLED" size="15">NO</th>


                            <th><input type="radio"  value="YES"  name="ISPROBATION" size="15">YES
                                <input type="radio"  value="NO"  name="ISPROBATION" size="15">NO</th>

                            

                            <th><input type="radio"  value="YES"  name="ISGRADUATE" size="15">YES
                                <input type="radio"  value="NO"  name="ISGRADUATE" size="15">NO</th>

                            <th><input value="" name="COLLEGE" size="15"></th>
                            <th><input value="" name="MAJOR" size="15"></th>
                            <th><input value="" name="MINOR" size="15"></th>
                            <th><input value="" name="DEPARTMENT" size="15"></th>

                            <th><input type="radio" value="YES" name="ISPHD" size="15">YES
                                <input type="radio" value="NO" name="ISPHD" size="15">NO</th>

                            <th><input type="radio" value="YES" name="CANDIDACY" size="15">YES
                                <input type="radio" value="NO" name="CANDIDACY" size="15">NO</th>

                            <th><input type="radio" value="YES" name="FIFTHYEAR" size="15">YES
                                <input type="radio" value="NO" name="FIFTHYEAR" size="15">NO</th>
                            <th><input type="radio" value="YES" name="PREVIOUSDEGREE" size="15">YES
                                <input type="radio" value="NO" name="PREVIOUSDEGREE" size="15">NO</th>
                            <th><input value="" name="TYPE" size="15"></th>
                            <th><input value="" name="INSTITUTION" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while (rs_student.next()) {
                        int s = rs_student.getInt("SSN");
                        Statement statement1 = conn.createStatement();
                        ResultSet rs_prob = statement1.executeQuery
                        ("SELECT * FROM Probation WHERE SSN = " + s);
                        Statement statement2 = conn.createStatement();
                        ResultSet rs_grad = statement2.executeQuery
                        ("SELECT * FROM Graduate WHERE SSN = " + s);
                        Statement statement3 = conn.createStatement();
                        ResultSet rs_prevdegree = statement3.executeQuery
                        ("SELECT * FROM previous_degree WHERE SSN = " + s);
                        Statement statement4 = conn.createStatement();
                        ResultSet rs_ugrad = statement4.executeQuery
                        ("SELECT * FROM undergraduate WHERE SSN = " + s);

                        rs_prob.next();
                        rs_grad.next();
                        rs_prevdegree.next();
                        rs_ugrad.next();
        
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs_student.getInt("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs_student.getString("ID") %>" 
                                    name="ID" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs_student.getString("FIRSTNAME") %>"
                                    name="FIRSTNAME" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs_student.getString("MIDDLENAME") %>" 
                                    name="MIDDLENAME" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs_student.getString("LASTNAME") %>" 
                                    name="LASTNAME" size="15">
                            </td>

                            <%-- Get the ORIGIN --%>
                            <td>
                                <input value="<%= rs_student.getString("ORIGIN") %>" 
                                    name="ORIGIN" size="15">
                            </td>

                            <td>
                                <input value="<%= rs_student.getString("ENROLLED") %>" 
                                    name="ENROLLED" size="15">
                            </td>


                            <td>
                                <input value="<%= rs_student.getString("ISPROBATION") %>" 
                                    name="ISPROBATION" size="15">
                            </td>

                        


                            <td>
                                <input value="<%= rs_student.getString("ISGRADUATE") %>" 
                                    name="ISGRADUATE" size="15">
                            </td>


                            <%
                                if (rs_student.getString("ISGRADUATE").equals("NO")) {
                            %>


                            <td>
                                <input value="<%= rs_ugrad.getString("COLLEGE") %>" 
                                    name="COLLEGE" size="15">
                            </td>

                            <td>
                                <input value="<%= rs_ugrad.getString("MAJOR") %>" 
                                    name="MAJOR" size="15">
                            </td>

                            <td>
                                <input value="<%= rs_ugrad.getString("MINOR") %>" 
                                    name="MINOR" size="15">
                            </td>

                            <%
                                }else {
                            %>

                            <td>
                                <input value="" 
                                    name="COLLEGE" size="15">
                            </td>

                            <td>
                                <input value="" 
                                    name="MAJOR" size="15">
                            </td>

                            <td>
                                <input value="" 
                                    name="MINOR" size="15">
                            </td>

                            <%
                                }
                            %>

            
                          

                            <%
                                if (rs_student.getString("ISGRADUATE").equals("YES")) {
                            %>


                            <td>
                                <input value="<%= rs_grad.getString("DEPARTMENT") %>" 
                                    name="DEPARTMENT" size="15">
                            </td>

                            <td>
                                <input value="<%= rs_grad.getString("ISPHD") %>" 
                                    name="ISPHD" size="15">
                            </td>


                            <td>
                                <input value="<%= rs_grad.getString("CANDIDACY") %>" 
                                    name="CANDIDACY" size="15">
                            </td>

                            <td>
                                <input value="<%= rs_grad.getString("FIFTHYEAR") %>" 
                                    name="FIFTHYEAR" size="15">
                            </td>

                            <%
                                }else {
                            %>

                            <td>
                                <input value="" 
                                    name="DEPARTMENT" size="15">
                            </td>

                            <td>
                                <input value="" 
                                    name="ISPHD" size="15">
                            </td>


                            <td>
                                <input value="" 
                                    name="CANDIDACY" size="15">
                            </td>

                            <td>
                                <input value="" 
                                    name="FIFTHYEAR" size="15">
                            </td>

                            <%
                                }
                            %>






                            <td>
                                <input value="<%= rs_student.getString("HASPREVIOUSDEGREE") %>" 
                                    name="PREVIOUSDEGREE" size="15">
                            </td>


                            <%
                                if (rs_student.getString("HASPREVIOUSDEGREE").equals("YES")) {
                            %>

                            <td>
                                <input value="<%= rs_prevdegree.getString("DEGREE_TYPE") %>" 
                                    name="TYPE" size="15">
                            </td>

                            <td>
                                <input value="<%= rs_prevdegree.getString("INSTITUTION") %>" 
                                    name="INSTITUTION" size="15">
                            </td>


                            <%
                                }else {
                            %>

                            <td>
                                <input value="" 
                                    name="DEGREE_TYPE" size="15">
                            </td>

                            <td>
                                <input value="" 
                                    name="INSTITUTION" size="15">
                            </td>

                            <%
                                }
                            %>

    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs_student.getInt("SSN") %>" name="SSN">
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
                    rs_student.close();
    
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
