
<cfset updateProduct = createObject('component',"cfc_folder/product")>
<cfset prodid = form.prodid>
<cfset prodname = form.prodname>
<cfset price = form.price>
<cfset availablestocks = form.availability>
<cfset is_active = form.is_active>

<cfset updateProduct.updateProduct(prodid,prodname,price,availablestocks,is_active)>