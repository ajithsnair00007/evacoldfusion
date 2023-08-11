<cfset faq = ArrayNew(1)>
<cfset ArrayAppend(faq, "Where are you from?")>
<cfset ArrayAppend(faq, "I am from trivandrum")>
<cfset ArrayAppend(faq, "What is your name?")>
<cfset ArrayAppend(faq, "I am Ajith")>
<cfset ArrayPrepend(faq, "Hello how are you?")>
<cfset ArrayInsertAt(faq,3,"hello world")>

<cfoutput>
#serialize(faq)#</br>
#faq[1]# </br>
#faq[3]#
</cfoutput></br></br>

<cfloop array="#faq#" index="index">
<cfoutput>
#index#</br>
</cfoutput>
</cfloop> </br> </br>

<cfloop array="#faq#" item="item">
<cfoutput>
#item#</br>
</cfoutput>
</cfloop>

