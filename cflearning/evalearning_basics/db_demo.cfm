<cfquery name="tutor" datasource ="fruitsshop" timeout="30">
 select * 
 from tutors
</cfquery>
<cfloop query="tutor">
<cfoutput>
   #Name# : #Subject#</br>
</cfoutput>
</cfloop>