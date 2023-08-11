
<cfset Activate = createObject('component','cfc_folder/product')>
<cfset prodid = url.pid>
<cfset toactivate = url.toactivate>
<cfset Activate.activateProduct(prodid,toactivate)>