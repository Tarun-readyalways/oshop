package mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String user = req.getParameter("user");
		String pwd = req.getParameter("pwd");
		String isValid = validateUser(user, pwd);
		res.setContentType("text/plain");
		PrintWriter pw = res.getWriter();
		pw.print(isValid);
	}

	private String validateUser(String un, String p) {
		DriverConnect dc = new DriverConnect();
		Connection conn = dc.connect_to_db("plf_training", "plf_training_admin", "pff123");
		String query = "SELECT * from cust_det_05 where name=?";
		PreparedStatement st = null;
		ResultSet rs = null;
		String res = null;
		try {
			st = conn.prepareStatement(query);
			st.setString(1, un);
			rs = st.executeQuery();
			if (rs.next()) {
				String e_pass = rs.getString("password");
				if (p.equals(e_pass)) {
					res = "success";
				}
			}
		} catch (Exception e) {

		}
		return res;
	}

}
