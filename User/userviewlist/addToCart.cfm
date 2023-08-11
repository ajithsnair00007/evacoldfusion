<cfset cartItems = createObject("component", "cart")>

<cfset productId = form.productid>
<cfset productName = form.productname>
<!--- <cfset productimage = form.image> --->
<cfset price = form.price>



<cfset cartItems.addToCart(productId, productName,price)>


