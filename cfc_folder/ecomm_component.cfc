<cfcomponent>
  <cffunction  name="registerUser" returnType="struct">
    <cfargument  name="uname" type="string" required="true">
    <cfargument  name="email" type="string" required="true">
    <cfargument  name="psw" type="string" required="true">
  
    <cfset resultdata = {}>

    <cfquery name="existingEmail" datasource="product_list">
        SELECT email FROM admin_user
        WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
    </cfquery>

       <cfif existingEmail.RECORDCOUNT>
         <cflocation  url="signup.cfm?create=1" >
       </cfif>

  
<!---     <cfset pswkey = generateSecretKey("AES")>  --->

    <cfset mykey = Session.pswKey> 
    <cfset encryptedpsw = encrypt(arguments.psw, mykey,"AES","Base64")>

    <cfquery name="admin" datasource="product_list" result="result">
       INSERT INTO admin_user(Name,Email,Password)
       Values(<cfqueryparam value="#arguments.uname#" cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#encryptedpsw#" cfsqltype="cf_sql_varchar">
       )

    </cfquery>

    <cfif result.RECORDCOUNT eq 1>  
        
        <cflocation  url="login.cfm?create=1" >
        
    <cfelse>
        
        <cflocation  url="signup.cfm?create=0">
        </cfif>
   
  </cffunction>

  <!--- function for login --->

  <cffunction  name="loginUser">
   

    <cfargument  name="email" type="string">
    <cfargument  name="psw" type="string">
    
    <cfset loginpassword = "">
    <cfset mykey = Session.pswKey> 
<!---     <cfset passwordkey = Session.pswKey>  --->
    <cfquery name="getPassword" datasource="product_list">
       SELECT password,admin_id FROM admin_user
       WHERE email = <cfqueryparam value = "#arguments.email#" cfsqltype="cf_sql_varchar">
    </cfquery>
      
      <cfif getPassword.RECORDCOUNT>
         <cfset loginpassword = decrypt(getPassword.password,mykey,"AES","Base64")>
      </cfif>

        <cfset isAuthenticated = false>


        <cfif loginpassword eq arguments.psw> 
           <cfset isAuthenticated = true> 
              <cfset userID = getPassword.admin_id>
              <cfdump  var="#userID#">
                  <cflock scope="Session">
                      <cfset Session.userid = userID>
                  </cflock>
              <cfdump  var="#Session#">
        <cfelse>
           <cfset isAuthenticated = false> 
        </cfif> 
        <cfreturn isAuthenticated>
  
  </cffunction>

  <cffunction  name="logOut">
     <cflock scope="Session">
         <cfset StructDelete(Session,"userid")>
     </cflock>
  </cffunction>


</cfcomponent>

