
<cfparam name="form.increase" default="">
<cfparam name="form.decrease" default="">

<cfif isDefined("form.increase")>
    
    <cfif StructKeyExists(Session.cart, form.increase)>
        <cfset Session.cart[form.increase].quantity = Session.cart[form.increase].quantity + 1>
    </cfif>
</cfif>

<cfif isDefined("form.decrease")>
    <cfif StructKeyExists(Session.cart, form.decrease)>
        <cfset Session.cart[form.decrease].quantity = Session.cart[form.decrease].quantity - 1>
         <cfif Session.cart[form.decrease].quantity lte 1>
            <cfset Session.cart[form.decrease].quantity = 1>
        </cfif>
    </cfif>
</cfif>

<cflocation url="displaycart.cfm">



