package mvc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
	private final String DB_URL = "jdbc:postgresql://192.168.110.48:5432/plf_training";
	private final String DB_USER = "plf_training_admin";
	private final String DB_PASSWORD = "pff123";

	public List<ProductModel> getAllProducts() throws SQLException {
		List<ProductModel> products = new ArrayList<>();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		String query = "SELECT *FROM tarun199";
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.prepareStatement(query);
			rs = stmt.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("prod_id");
				String name = rs.getString("prod_name");
				double price = rs.getDouble("prod_price");
				String HSNCode = rs.getString("hsn_code");
				String img = rs.getString("prod_img");
				int category = rs.getInt("cat_id");
				ProductModel product = new ProductModel();
				product.setProd_ID(id);
				product.setProd_name(name);
				product.setProd_price(price);
				product.setProd_hsn(HSNCode);
				product.setProd_img(img);
				product.setProd_cate_ID(category);
				products.add(product);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}

	public List<ProductModel> getProductsByCategoryId(int categoryId) throws SQLException {
		List<ProductModel> products = new ArrayList<>();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		String query = "SELECT * FROM products_tab_05 WHERE cat_id = ?"; // Adjust query as per your database schema
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, categoryId);
			rs = stmt.executeQuery();

			while (rs.next()) {

				ProductModel product = new ProductModel();
				product.setProd_ID(rs.getInt("prod_id"));
				product.setProd_name(rs.getString("prod_name"));
				product.setProd_price(rs.getDouble("prod_price"));
				product.setProd_hsn(rs.getString("hsn_code"));
				product.setProd_img(rs.getString("prod_img"));
				product.setProd_cate_ID(rs.getInt("cat_id"));
				products.add(product);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			// Handle exceptions appropriately
		} finally {

			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return products;
	}

}
