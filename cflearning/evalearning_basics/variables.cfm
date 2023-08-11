<cfset productname = 'S23 uLTRA'>
<cfoutput>
Product Name is #productname#
</cfoutput>

<cfset firstName="Barney">
<cfparam name="firstName" default="Ozzy">
<cfoutput>
Hello #firstname#
</cfoutput>

<cfif IsDefined("productname")>
<cfoutput>
 Hello  #productname#
</cfoutput>
 
<cfelse>
 <cfoutput>
 hello stranger
 </cfoutput>
  
</cfif>

<cfset Session.BodyType = "Perfect">
<cfoutput>
  Body Type: #Session.BodyType#
</cfoutput>

