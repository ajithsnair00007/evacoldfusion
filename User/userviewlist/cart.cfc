 <cfcomponent> 
   <cffunction name="addToCart" access="remote" returntype="string">
      <cfargument name="productid" type="numeric" required="true">
      <cfargument name="productname" type="string" required="true">
      <cfargument name="image" type="string" required="true">
      <cfargument name="price" type="numeric" required="true">
     
      <cfset response = {}>
      
      <cflock scope="Session">

        <cfif not isDefined('cart')> 
           <cfset cart = {}>
        </cfif>
        
         <cfif not structKeyExists(Session, "cart")> 
            <cfset Session.cart = {}>
        <cfelse>
            <cfset cart = Session.cart>
            <cfif structKeyExists(cart,arguments.productid)>
            <cfset cart[arguments.productid].quantity+=1>
            
         <cfelse>
         
         <!--- Adding the product in the cart --->
         <cfset cart[arguments.productid] = {
            productid = "#arguments.productid#",
            productname= "#arguments.productname#",
            image="#arguments.image#",
            price = "#arguments.price#",
            quantity = 1,
            discount = 0,
         }>
        
         </cfif>
        </cfif>  
         <cfset Session.cart = cart>
      </cflock>

      <!---success response--->
        <cfset response['status'] = true>
        <cfset response['message'] = "Product added to cart!">
        <cfset response['ID'] = arguments.productid>
        
        <!--- Return response as JSON --->
        <cfreturn serializeJSON(response)>

      <cflocation  url="product_listing.cfm">
   </cffunction>
</cfcomponent>



