package mvc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve registration data from request parameters
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String location = request.getParameter("location");
		String dateOfBirth = request.getParameter("dateOfBirth");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		// Validate registration data (e.g., password matching, data format)

		// Check if password and confirm password match
		if (!password.equals(confirmPassword)) {
			// Handle password mismatch error
			// You can redirect back to the registration page with an error message
			response.sendRedirect("register.jsp?error=passwordMismatch");
			return;
		}
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			// Establish database connection
			DriverConnect dc = new DriverConnect();
			conn = dc.connect_to_db("PennantDB", "postgres", "pff123");
			String query = "INSERT INTO cust_det_05 (name, mobile, location,password) VALUES (?,?, ?, ?)";

			ResultSet rs = null;
			String res = null;

			// Create prepared statement
			stmt = conn.prepareStatement(query);

			// Set parameter values
			stmt.setString(1, name);
			stmt.setString(2, mobile);
			stmt.setString(3, location);
			stmt.setString(4, password);

			// Execute the query
			stmt.executeUpdate();

			// Redirect to a success page after registration
			response.sendRedirect("login.jsp");
		} catch (SQLException e) {
			// Handle database errors
			e.printStackTrace();
			response.sendRedirect("register.jsp?error=databaseError");
		} finally {
			// Close resources
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
