
<html>
<head>
    <title>Product Listing</title>
    <link rel="stylesheet" href="/cssStyle/productlist.css">
    <script type="text/javascript" src=""></script>

</head>
<body>
    <cfset isAuthenticated = structKeyExists(Session, "userid")>
    <cfif isAuthenticated>
       <button class="managecp"><a href="../../Admin/Coupons/cfm/coupon_display.cfm">Manage Coupon</a></button>
    </cfif>
    
    <div class="successMessage">
    
    <cfparam name="url.successMessage" default="">
        <cfif isDefined("url.successMessage")>
        <span>
            <cfoutput>
              #url.successMessage#
            </cfoutput>
        </span>
        </cfif>
    </div> </br>
    
        <button class="create_button"><a href="product_form.cfm">ADD NEW PRODUCT</a></button>
        <div class="productlisting">
        <table>
            <tr>
                <th class="product_name">SlNo</th>
                <th class="product_name">Product Name</th>
                <th>Price</th>
                <th>Available Stocks</th>
                <th>Status</th>
                <th>Image</th>
                <th>Edit</th>
                <th>Deactivate</th>
            </tr>
            <cfquery name="getProducts" datasource="product_list">
                SELECT product_id,product_name, price, no_of_availableStocks, is_active,image_path
                FROM product_table;
            </cfquery>
            <cfset rowNumber = 1>
            <cfoutput query="getProducts">
                <tr>
                    <td class="product_name">#rowNumber#</td>
                    <td class="product_name">#product_name#</td>
                    <td>#price#</td>
                    <td>#no_of_availableStocks#</td>
                    <td>
                        <cfif (is_active)>
                            Active
                        <cfelse>
                            Inactive
                        </cfif>
                    </td>
                    <td><img src="#image_path#" alt="" width="100" height="100"></td>    
                    <td><button class="edit_button"><a href="edit_products.cfm?id=#product_id#">Edit</a></button></td>
                    <td>
                       <cfif is_active>
                          <button type="button" class="deactivate_button"><a href="activate_product.cfm?pid=#product_id#&toactivate=0">Deactivate</a></button>
                       <cfelse>
                          <button type="button" class="activate_button"><a href="activate_product.cfm?pid=#product_id#&toactivate=1">Activate</a></button>
                       </cfif>
                       
                    </td>
                </tr>
                <cfset rowNumber = rowNumber+1>
            </cfoutput>
        </table>
        <form action="/Admin/logOut.cfm" method="post">
            <button class="logout_button" type="submit" name="logout">Logout</button>
        </form>
    </div>
    
</body>
</html>
