<html>
   <head>
      <title>Order details</title>
      <link rel="stylesheet" href="/cssStyle/cart.css">
      <script></script>
   </head>
   <body>
      <table>
         <tr>
            <th>Sl No</th>
            <th>ProductName</th>
            <th>UnitPrice</th>
            <th>Quantity</th>
            <th>TotalPrice</th>
            <th>Discount</th>
            <th>FinalPrice</th>
         </tr>

        <cfquery name="orderdetails" datasource="product_list">
            SELECT product_table.product_name,product_table.price,orders.total_amount,orders.quantity,orders.discount,orders.subtotal
            FROM product_table
            RIGHT JOIN orders
            ON product_table.product_id = orders.productID;
        </cfquery>

        <cfset slNo = 1>
        <cfoutput query = "orderdetails">
         <tr>
            <td>#slNo#</td>
            <td>#product_name#</td>
            <td>#price#</td>
            <td>#quantity#</td>
            <td>#total_amount#</td>
            <td>#discount#</td>
            <td>#subtotal#</td>
         </tr>
         <cfset slNo = slNo+1>
        </cfoutput>
      </table>
   </body>
</html>
