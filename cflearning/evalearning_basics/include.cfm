<link rel="stylesheet" href="styles.css">

<h1>Below contents are actually contents of syntaxt files</h1>
<cfinclude  template="syntaxt.cfm">
<cfset currentDateAndTime = now()>
<cfset td = dateFormat(currentDateAndTime)>
<cfoutput>
   # currentDateAndTime#
   #td#
</cfoutput>


