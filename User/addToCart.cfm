 <cfparam  name="url.cartid" default=""> 
 <cfset productid = url.cartid>
   <cflock scope="Session">
      <cfset Session.cartid = productid>
   </cflock>
<!---
<cfparam name="session.cart" default="#{}#">

<cfif isDefined('url.cartid')>
</cfif>
<!---     <cfset product_id = form.product_id> --->
    <cflock scope="Session">
       <cfset Session.cartid = url.cartid>
    </cflock>--->
    <!--- Check if the product is already in the cart --->
<!---     <cfif structKeyExists(Session, 'cartid')>
        <!--- Increment the quantity if the product is already in the cart --->
        <cfset Session.cart[Session.cartid] = Session.cart[Session.cartid] + 1>
    <cfelse>
        <!--- Add the product to the cart with quantity 1 --->
        <cfset session.cart[Session.cartid] = 1>
    </cfif> --->






<cfparam name="session.cart" default="#{}#">

<html>
   <head>
     <link rel="stylesheet" href="/cssStyle/userproductlist.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
                integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" 
                crossorigin="anonymous" referrerpolicy="no-referrer" />
   </head>

   <body>
      <h1>Your Shopping Cart</h1>
      <!---<cfif structIsEmpty(session.cart)>
         <p>Your cart is empty.</p>
      <cfelse>--->
         <table>
            <tr>
               <th>Product Name</th>
               <th>Price</th>
               
            </tr>
        
               <cfquery name="selectedProduct" datasource="product_list">
                  SELECT product_name, price
                  FROM product_table
                  WHERE product_id = <cfqueryparam value="#productid#" cfsqltype="cf_sql_integer">
               </cfquery>
               <cfoutput query="selectedProduct">
               
               <tr>
                  <td>#product_name#</td>
                  <td>#price#</td>
               </tr>
               </cfoutput>
            
         </table>
<!---       </cfif> --->
<!---       <cflocation url="/User/userviewlist/product_listing.cfm"> --->
   </body>
</html>


