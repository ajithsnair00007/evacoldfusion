<cfset name = 'Ajith'>
<cfif name eq 'Aji'>
Name selected is wrong!
<cfelseif name eq 'Ajith'>
Correct Name selected
<cfelse>
Please select correct name
</cfif></br>

<cfset product = 'mobile'>
<cfif product neq 'mobil'>
you are wrong
<cfelse>
you are right
</cfif></br>

<cfset number = 100>
<cfif number lt 10>
Number is lower
<cfelseif number gt 100>
number is greater
<cfelse >
number is equal or greater
</cfif>