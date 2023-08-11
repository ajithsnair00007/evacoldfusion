<cfset Activate = createObject('component','../cfc/add_coupon')>

<cfset couponid = url.cpid>
<cfset toactivate = url.toactivate>
<cfset Activate.activateCoupon(couponid,toactivate)>