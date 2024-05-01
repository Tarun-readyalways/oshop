<%@ page import="mvc.ProductModel" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	.navbar-brand img {
  		width: 50px; /* Adjust as needed */
  		height: auto;
  		margin-right: 10px; /* Space between logo and text */
	}

	.navbar-text {
  		flex-grow: 1; /* Take remaining space */
  		text-align: center;
  		padding-left:220px;
	}

.navbar-nav .nav-link {
  margin-right: 10px; /* Space between buttons */
}
 
        
    table {
        border-collapse: collapse;
        width: 80%; /* Reduced width */
        margin: 0 auto; /* Centering the table */
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px; /* Increased padding for better spacing */
        text-align: center;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    th {
        background-color: white;
        color: black;
    }
    .custom-width {
  		width: 180px; /* Adjust the width as needed */
	}
	.container mt-3{
		display: flex;
  		align-items: center;
	}
	body {
      background-color: #fff7de;
      background-size: cover;
      background-position: center;
    }
    button {
            padding: 10px 20px;
            cursor: pointer;
            background-color: #3d85c6;
            color: white;
            border: none;
            border-radius: 5px;
            margin-right: 10px;
        }
        .container-fluid{
        	background-color: #009dff;
      background-size: cover;
      background-position: center;
        }
        h3{
        	text-align: center;
        }
</style>
<title>Home page</title>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <!-- Left side: Logo -->
    <a class="navbar-brand" href="#"><img src="sc.jpg" alt="ShoppingSite Logo" style="width:80px; height: 60px"></a>
    
    <!-- Middle: Shopping Site Heading -->
    <div class="navbar-text" ><h1>Shopping Site</h1></div>
    
    <!-- Right side: View Cart, Login, and Register Buttons -->
    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <button onclick="viewCart()" class="btn btn-outline-dark me-2" style="background-color: #8fce00; font-weight:bold">View Cart</button>
        </li>
        <li class="nav-item">
          <a href="login.html" class="btn btn-outline-dark me-2" style="background-color: #8fce00; font-weight:bold">Login</a>
        </li>
        <li class="nav-item">
          <button type="button" class="btn btn-outline-dark me-2" style="background-color: #8fce00; font-weight:bold">Signup/Register</button>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Below the header: Categories Dropdown and Sort By Button -->
<div class="container mt-3">
  <form class="d-flex" method="GET">
  	<label for="category" style="font-weight :bold; padding-top:3px; font-size:20px; margin-right:5px">Categories : </label>
    <select class="form-select custom-width" name="category">
      <option value="">Select Category</option>
      <option value="1001">Electronics</option>
      <option value="1002">Clothing</option>
      <option value="1003">Footwear</option>
    </select>
    <input style="background-color: #8fce00; font-weight:bold" class="btn btn-outline-dark" type="submit" value="Sort by">
  </form>
</div>
<h3>Product List</h3>
    <table border="1">
        <tr>
            <th>Product ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>HSN Code</th>
            <th>Image</th>
            <th>Category ID</th>
            <th></th>
        </tr>
        
        <% 
        List<mvc.ProductModel> products = (List<mvc.ProductModel>) request.getAttribute("products");
        //out.println("");            
        if (products != null) {
                for (ProductModel product : products) {
        %>
        <tr>
        
            <td><%= product.getProd_ID() %></td>
            <td><%= product.getProd_name() %></td>
            <td><%= product.getProd_price() %></td>
            <td><%= product.getProd_hsn() %></td>
            <td><img src="<%= product.getProd_img() %>" width="50" height="55"></td>
            <td><%= product.getProd_cate_ID() %></td>
            <td><button onclick="addItemToCart('<%= product.getProd_ID() %>', '<%= product.getProd_name() %>', '<%= product.getProd_price() %>')" >Add to Cart</button></td>
        </tr>
        <% 
                }
            }
        %>
    </table>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <script>
function addItemToCart(id, name, price) {
    var data = {
        productId: id,
        productName: name,
        productPrice: price
    };

    $.ajax({
        type: "POST",
        url: "CartController",
        data: data,
        success: function(response) {
            alert("Item added to cart");
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            alert("Error adding item to cart");
        }
    });
}
</script>
<script>
function viewCart() {
    window.location.href = "/Online_shopping/CartController";
}
</script>
</body>
</html>
