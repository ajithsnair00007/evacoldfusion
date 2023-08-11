
     <cflock scope="Session">
         <cfset StructClear(Session.cart)>
     </cflock>
     <cflocation  url="product_listing.cfm">
  