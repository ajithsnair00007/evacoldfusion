<cfcomponent>
    <cffunction name="removeItem" access="remote" returntype="string" returnformat="json">
        <cfargument  name="id" type="numeric" required='true'>
        <cfset var response = {}>

        
           <cfset var cart = Session.cart>
           <cfset product = Session.cart[arguments.id]>
        
           <cfset structDelete(cart, arguments.id)>
           <cfset response.STATUS = true>
           <cfset response.ID = product.productid>
           <cfset response.PRICE = product.price * product.quantity>


           <cfreturn serializeJSON(response)>
            
    </cffunction>
</cfcomponent>
