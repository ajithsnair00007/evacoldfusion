<cfset regUser = createObject("component", "cfc_folder/ecomm_component")> 
<cfset uname = form.uname>
<cfset email = form.email>
<cfset psw = form.psw>
<cfset regUser.registerUser(uname,email,psw)>




