<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.ProductModel" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <style>
    body{
    	background-color: #fff7de;
      background-size: cover;
      background-position: center;
    }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        th {
            background-color: white;
            color: black;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .btn {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            
            cursor: pointer;
            border-radius: 8px;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .btn-view-cart {
            background-color: #008CBA;
            
        }

        .btn-view-cart:hover {
            background-color: #0077A3;
        }
        h1{
        	text-align:center;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <h1>Shopping Cart</h1>
        <br>
        <table>
            <tr>
                <th>Product ID</th>
                <th>Name</th>
                <th>Price</th>
                <th></th>
            </tr>
            <% 
            List<ProductModel> cartItems = (List<ProductModel>) request.getAttribute("cartItems");
            if (cartItems != null) {
                for (ProductModel item : cartItems) {
            %>
            <tr>
                <td><%= item.getProd_ID() %></td>
                <td><%= item.getProd_name() %></td>
                <td><%= item.getProd_price() %></td>
                <td><%= item.getProd_price() %></td>
                  <td><button class="btn btn-view-cart" onclick="removeItem('<%= item.getProd_ID() %>')">remove</button></td>
            </tr>
            <% 
                }
            }
            %>
        </table>
        <a style="margin-left:170px;" href="ProductController" class="btn">Continue Shopping</a>
        <a style="margin-left:170px;" href="#" class="btn btn-view-cart" onclick="checkout()">Checkout</a>
    </div>
    <script>
    function checkout() {
        // Check if the user is logged in (you can use a session attribute to store login status)
    	window.location.href = "checkout.jsp"; 
    }
</script>
     <script>
        function removeItem(productId) {
            fetch('CartController?productId=' + productId, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    
                    window.location.reload();
                } else {
                    console.error('Failed to remove item from cart');
                }
            })
            .catch(error => {
                console.error('Error removing item from cart:', error);
            });
        }
    </script>
</body>
</html>