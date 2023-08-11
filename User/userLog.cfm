<cfset logUser = createObject("component", "cfc_folder/user_manage")> 
<cfset email = form.email>
<cfset psw = form.psw>

<cfset isAuthenticated = logUser.userLogin(email,psw)> 

<cfif isAuthenticated eq true>
  <cflocation  url="/User/userviewlist/product_listing.cfm">
<cfelse>
  <cflocation  url="userLogin.cfm?error=1">
</cfif>