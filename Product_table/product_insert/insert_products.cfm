<cfset insertProduct = createObject("component", "cfc_folder/product")> 
<cfset prodname = form.prodname>
<cfset price = form.price>
<cfset availablestocks = form.availability>
<cfset is_active = form.is_active>
<cfset insertProduct.addProduct(prodname,price,availablestocks,is_active)>