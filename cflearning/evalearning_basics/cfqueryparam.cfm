<h3>CF Params Example</h3>


<cfset id = url.SlNo>
<!--- <cfset id = '5'> --->
<!--- <cfdump  var="#id#"> --->
<cfquery name="tutor" datasource="fruitsshop">
  
  select * from tutors
  where SlNo = <cfqueryparam value="#id#"
        cfsqltype="CF_SQL_INTEGER"
        >
  
</cfquery>
<cfoutput query="tutor">
  Name:#Name#</br>
  Subject:#Subject#
</cfoutput>