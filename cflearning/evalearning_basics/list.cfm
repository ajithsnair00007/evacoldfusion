<cfset my_friends_list = "Sreenath,Vipin,Mukhil,Vishnu">
<cfloop list="#my_friends_list#" index="i" delimiters = ",">
    <cfoutput>
    #i#</br>
    </cfoutput>
</cfloop>

<cfoutput>
Length of the above list is #listLen(my_friends_list)#
</cfoutput> </br>

<cfset my_friends_list = listAppend(my_friends_list, "Abhishek")>
<cfoutput>
#my_friends_list#
</cfoutput></br>

<cfset my_friends_list = listPrepend(my_friends_list, "Abhijith")>
<cfoutput>
#my_friends_list#
</cfoutput></br>

<cfset my_friends_list = listInsertAt(my_friends_list, "3","Amal")>
<cfoutput>
#my_friends_list#
</cfoutput></br>

<cfset my_friends_list = listPrepend(my_friends_list, 2)>
<cfoutput>
#my_friends_list#
</cfoutput></br>

<cfset my_friends_list = listContainsNoCase(my_friends_list, "mukhil")>
<cfoutput>
#my_friends_list#
</cfoutput></br>




