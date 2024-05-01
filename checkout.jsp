<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="mvc.ProductModel" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <style>
    body{
    		background-color: #fff7de;
      background-size: cover;
      background-position: center;
    }
    h2{
    	text-align:center;
    	font-size: 36px;
    }
    p{
    	text-align:center;
    	
    }
        .card {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 10px;
            margin: 10px;
            width: 300px;
            display: inline-block;
            vertical-align: top;
            background-color: #f2f2f2;
        }

        .card img {
            width: 100%;
            border-radius: 8px;
        }

        .card-content {
            padding: 10px;
        }

        .order-details {
            border: 2px solid #4CAF50;
            border-radius: 8px;
            padding: 10px;
            margin-top: 20px;
            background-color: #f2f2f2;
        }

        .order-details h2 {
            color: black;
            font-size: 36px;
        }

        .order-details p {
            font-size: 24px;
            margin: 5px 0;
        }
        .back-to-cart {
            display: inline-block;
            padding: 10px 20px;
            margin-top:20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            text-align:center;
            margin-left:650px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            font-size: 20px;
        }

        .back-to-cart:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Thank you for Shopping!!! Visit Again</h2>
    
    <div>
        <% 
            List<mvc.ProductModel> cartItems = (List<mvc.ProductModel>) request.getSession().getAttribute("cartItems");
            double orderTotal = 1589.00;
            if (cartItems != null) {
                for (ProductModel item : cartItems) {
                    orderTotal += item.getProd_price();
        %>
        <div class="card">
            <div class="card-content">
                <h3><%= item.getProd_name() %></h3>
                <p>Product ID: <%= item.getProd_ID() %></p>
                <p>Price: <%= item.getProd_price() %></p>
            </div>
        </div>
        <% 
                }
            }
        %>
    </div>
    
    <div class="order-details">
        <h2>Order Details</h2>
        <p>Order Total: <%= orderTotal %></p><br>
        <p>Order Date: <%= getCurrentDate() %></p><br>
        <p>Order ID: <%= generateOrderID() %></p><br>
    </div>
    
    <a href="cart.jsp" class="back-to-cart">Back to Cart</a>
    
    <%!
        String generateOrderID() {
            // Generate a random order ID here (for demonstration purposes)
            return "ORD" + (int)(Math.random() * 1000);
        }

        String getCurrentDate() {
            // Get the current date and time
            Date currentDate = new Date();
            // Define the date format
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            // Format the date
            return dateFormat.format(currentDate);
        }
    %>
</body>
</html>