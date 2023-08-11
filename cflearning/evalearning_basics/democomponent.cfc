<cfcomponent displayname="addcomponent">
  <cffunction  name="add">
     <cfargument  name="num1">
     <cfargument  name="num2">
     <cfset sum = arguments.num1+arguments.num2>
     <cfreturn sum>
  </cffunction>
      <cfoutput>
        #add(5,2)#
      </cfoutput>
</cfcomponent>