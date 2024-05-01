<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <style>
        /* Center the form */
        #form-container {
            width: 350px;
            margin: 0 auto;
            margin-top: 100px;
            text-align: center;
            background-color: #f2f2f2;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            background-image: url('reg.jpg');
            background-size: cover;
            background-position: center;
        }

        form {
            text-align: left;
        }

        input[type="text"],
        input[type="password"],
        button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            margin-top: 5px;
        }
        body{
        	background-image: url('bg.png');
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body>
    <div id="form-container">
        <%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
        <%
            // Database connection parameters
            final String DB_URL = "jdbc:postgresql://192.168.110.48:5432/plf_training";
            final String DB_USER = "plf_training_admin";
            final String DB_PASSWORD = "pff123";
            
            try {
              
                Class.forName("org.postgresql.Driver");
                
                
                Connection conn = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training", "plf_training_admin", "pff123");
                
             
                if (request.getMethod().equalsIgnoreCase("post")) {
                    String name = request.getParameter("name");
                    String mobile = request.getParameter("mobile");
                    String location = request.getParameter("location");
                    String password = request.getParameter("password");
                    
                    // Inserting data into database
                    PreparedStatement stmt = conn.prepareStatement("INSERT INTO cust_det_05 (name, mobile, location, password) VALUES (?, ?, ?, ?)");
                    stmt.setString(1, name);
                    stmt.setString(2, mobile);
                    stmt.setString(3, location);
                    stmt.setString(4, password);
                    int rowsAffected = stmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        response.sendRedirect("login.html");
                    } else {
                        out.println("<p class='error-message'>Error occurred while registering!</p>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='error-message'>Please Register your Details before login</p>");
            }
        %>
        <h1 style = "text-align:center">Registration Form</h1>
        <br>
        <form id="regd-form" action="" method="post">
            <input type="text" id="name" name="name" placeholder="Name" required><br><br>
            <input type="text" id="mobile" name="mobile" placeholder="Mobile" required><br><br>
            <input type="text" id="location" name="location" placeholder="Location" required><br><br>
            <input type="password" id="password" name="password" placeholder="Password" required><br><br>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required><br><br>
            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>
