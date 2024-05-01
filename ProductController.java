package mvc;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		String categoryId = request.getParameter("category");
		ProductDAO productDAO = new ProductDAO();
		try {
			List<ProductModel> products = new ArrayList<>();
			if (categoryId != null && !categoryId.isEmpty()) {
				int categoryIdInt = Integer.parseInt(categoryId);
				products = productDAO.getProductsByCategoryId(categoryIdInt);
			} else if (categoryId == null) {
				// If no category is selected, fetch all products
				products = productDAO.getAllProducts();
			}
			request.setAttribute("products", products);
		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"An error occurred while fetching products.");
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}

}