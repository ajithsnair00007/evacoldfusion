
<cfset userRegister = createObject("component", "cfc_folder/user_manage")> 

<cfset uname = form.uname>
<cfset email = form.email>
<cfset psw = form.psw>
<cfset userRegister.userSignup(uname,email,psw)>
