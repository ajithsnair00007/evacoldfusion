<cfcomponent>

  <cffunction  name="userSignup" returntype="void">
     <cfargument  name="username" type="string" required="true">
     <cfargument  name="useremail" type="string" required="true">
     <cfargument  name="userpassword" type="string" required="true">
     
      <cfquery name="existingEmail" datasource="product_list">
        SELECT user_email FROM user
        WHERE user_email = <cfqueryparam value="#arguments.useremail#" cfsqltype="cf_sql_varchar">
      </cfquery>

       <cfif existingEmail.RECORDCOUNT>
         <cflocation  url="userSignup.cfm?create=1" >
       </cfif>

     <cfset passKey = Session.pswKey>
     <cfset encryptedpassword = encrypt(arguments.userpassword,passKey,'AES','BASE64')>

     <cfquery name="adduser" datasource="product_list" result="result">
       INSERT INTO user(user_name,user_email,user_password)
       VALUES(
         <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
         <cfqueryparam value="#arguments.useremail#" cfsqltype="cf_sql_varchar">,
         <cfqueryparam value="#encryptedpassword#" cfsqltype="cf_sql_varchar">
       )
     </cfquery>

     <cfif result.RecordCount>
        <cflocation  url="userLogin.cfm?success=1">
     </cfif>
  </cffunction>

  <cffunction  name="userLogin">
      <cfargument  name="useremail" type="string" required="true">
      <cfargument  name="userpassword" type="string" required="true">

      <cfset loginpassword = ''>
      <cfset passKey = Session.pswKey>

      <cfquery name="getpassword" datasource="product_list">
         SELECT user_password,user_id FROM user 
         WHERE user_email = <cfqueryparam value="#arguments.useremail#" cfsqltype="cf_sql_varchar">
      </cfquery>

      <cfif getpassword.RecordCount>
         <cfset loginpassword = decrypt(getpassword.user_password,passKey,"AES",'BASE64')>
      </cfif>

      <cfset isAuthenticated = false>
      <cfif loginpassword eq arguments.userpassword> 
          <cfset isAuthenticated = true> 
            <cfset userLogID = getPassword.user_id>
                <cflock scope="Session">
                    <cfset Session.userLogid = userLogID>
                </cflock>
      <cfelse>
          <cfset isAuthenticated = false> 
      </cfif> 
      <cfreturn isAuthenticated>
  </cffunction>

</cfcomponent>

