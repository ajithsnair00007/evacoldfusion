Eg for index loop </br>

<cfloop from ="1" to ="51" index="i">
<cfoutput>
#i# </br>
</cfoutput>
</cfloop> <br/>



<cfset Name = 'Dhoni'>
<cfloop condition="Name eq 'Dhoni'">
    <cfoutput>
    captain is #Name# in #RandRange(2008,2018)#</br>
    </cfoutput>
    <cfif RandRange(2008,2018) eq 2018>
    <cfset Name = 'Kohli'>
    </cfif>
</cfloop>
<cfoutput>
Now captain is #Name#
</cfoutput> </br> </br>

<h4>List Loop</h4>

<cfloop list="ColdFusion HTML XML CFML" index="ListItem" delimiters=" ">
  <cfoutput>
   #ListItem#<br />
 </cfoutput>
</cfloop>
</br></br>

