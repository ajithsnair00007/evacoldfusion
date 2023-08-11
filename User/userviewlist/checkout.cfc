<cfcomponent>
    <cffunction  name="checkOut" access="remote" returntype="string" returnformat="json">
         
        <cfset response = {}>
        <cfset userid = Session.userLogid>
        <cfset cart = Session.cart>
        
          <cfloop collection="#cart#" item="item">
             <cfset products = cart[item]>
             <cfset productid = products.productid>
             <cfif StructKeyExists(products, 'couponid')>
              <cfset couponid = products.couponid>
             </cfif>
             <cfset quantity = products.quantity>
             <cfset totalamount = products.quantity * products.price>
             <cfset discount = products.discount>
             <cfset subtotal = totalamount - discount>

             <cfquery name="checkout" datasource="product_list" result="result">
              <cfif StructKeyExists(products, 'couponid')>
                 INSERT INTO orders(productID,userID,couponID,quantity,total_amount,subtotal,discount)
                 VALUES(#productid#,#userid#,#couponid#,#quantity#,#totalamount#,#subtotal#,#discount#);
              <cfelse>
                 INSERT INTO orders(productID,userID,quantity,total_amount,subtotal,discount)
                 VALUES(#productid#,#userid#,#quantity#,#totalamount#,#subtotal#,#discount#);
              </cfif>
             </cfquery>

             <cfquery name="updateNoOfStocks" datasource="product_list">
                UPDATE product_table
                set no_of_availableStocks = no_of_availableStocks - #quantity#
                WHERE product_id = #productid#
             </cfquery>
          </cfloop>
        
        <cfset StructClear(Session.cart)>
        <cfset response['status'] = true>
        
          <!--- Return response as JSON --->
        <cfreturn serializeJSON(response)>
    </cffunction>
    
    <cffunction  name="restrictApplyCoupon" access="remote" returntype="string" returnformat="json">
      <cfargument  name="id" type="numeric" required="true">
      <cfargument  name="cartCouponId" type="numeric" required="true">

      <cfset response = {}>
      <cfset currentDate = now()>
      <cfset dateOfToday = dateFormat(currentDate)>
      <cfset response['DATE'] = dateOfToday>
      <cfreturn serializeJSON(response)>
   </cffunction>
</cfcomponent>