<cfset logUser = createObject("component", "cfc_folder/ecomm_component")> 
<cfset email = form.email>
<cfset psw = form.psw>

<cfset isAuthenticated = logUser.loginUser(email,psw)> 

<cfif isAuthenticated eq true>
  <cflocation  url="../Product_table/product_insert/product_details.cfm">
<cfelse>
  <cflocation  url="login.cfm?error=1">
</cfif>