<cfcomponent>
   <cfset this.name = 'myApplication'>
   <cfset this.sessionManagement = true>

   
	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created.">

	    <cfreturn true />
    </cffunction>

    <cffunction
		name="OnSessionStart"
		access="public"
		output="false"
		hint="Fires when the session is first created.">

		<cfset passwordkey = ''>
		<cfquery name="keycheck" datasource="product_list">
		   SELECT passwordkey FROM keyStore
		</cfquery>

			<cfif keycheck.RecordCount>
				<cfset passwordkey = keycheck.passwordkey>
			<cfelse>
				<cfset pswkey = generateSecretKey("AES")>
				<cfquery name="keystore" datasource="product_list">
					INSERT INTO keyStore(passwordkey)
					VALUES (<cfqueryparam value="#pswkey#" cfsqltype="cf_sql_varchar">)
				</cfquery>
				<cfif keystore.RecordCount>
					<cfset passwordKey = keystore.passwordkey>
				</cfif>
			</cfif>

		<cflock scope="Session">
           <cfset Session.pswKey = passwordKey>
        </cflock>
     <cfreturn />
	 
    </cffunction>

</cfcomponent>



   
       

       
       
    

