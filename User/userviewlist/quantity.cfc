 <cfcomponent> 

  <cffunction name="updateProductQuantity" access="remote" returntype="string" returnformat="json">
    <cfargument name="action" type="string" required="true">
    <cfargument name="item" type="string" required="true">

    <cfset  response = {}>
    
    <cfset  product = session.cart[arguments.item]>

    <cfif arguments.action EQ "plus">
      <cfset product.quantity = product.quantity + 1>
    <cfelseif product.quantity gt 1>
      <cfset product.quantity = product.quantity - 1>
    </cfif>

    <cfset  total = product.price * product.quantity>
    <cfset subtotal = total-product.discount>
    

    <cfset response.STATUS = true>
    <cfset response.QUANTITY = product.quantity>
    <cfset response.DISCOUNT = product.discount>
    <cfset response.TOTAL = total>
    <cfset response.ID = product.productid>
    <cfset response.SUBTOTAL = subtotal>
    <cfset totalSum = 0> 
  
        <cfloop collection="#Session.cart#" item="cartItem"> 
            <cfset var cartProduct = session.cart[cartItem]>
            <cfset totalSum += (cartProduct.price * cartProduct.quantity)>
        </cfloop>
        <cfset response.TOTALSUM = totalSum>
    
   <!---  to convert to json data  --->
    <cfreturn serializeJSON(response)>
  </cffunction>

</cfcomponent> 











