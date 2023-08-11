<html>
<head>
    <title>Coupon Details</title>
        <link rel="stylesheet" href="../css/display.css">
</head>
<body>
    <div class="successMessage">
    
    <cfparam name="url.successMessage" default="">
        <cfif isDefined("url.successMessage")>
        <span style="color:green;">
            <cfoutput>
              #url.successMessage#
            </cfoutput>
        </span>
        </cfif>
    </div> </br>
    

        <div class="couponlisting">
        <table>
            <tr>
                <th class='slno'>SlNo</th>
                <th>Coupon Name</th>
                <th class='cpcode'>Coupon Code</th>
                <th>Coupon Type</th>
                <th class='cpcode'>Offer</th>
                <th class='cpcode'>Active</th>
                <th class='cpcode'>Edit</th>
                <th class='cpcode'>Deactivate</th>
            </tr>
            <cfquery name="getcoupons" datasource="product_list">
                SELECT coupon_id,coupon_name,coupon_code,coupon_type,coupon_offer,is_active
                FROM coupons;
            </cfquery>
            <cfset rowNumber = 1>
            <cfoutput query="getcoupons">
                <tr>
                    <td class='slno'>#rowNumber#</td>
                    <td>#coupon_name#</td>
                    <td class='cpcode'>#coupon_code#</td>
                    <td>#coupon_type#</td>
                    <td class='cpcode'>#coupon_offer#</td>
                    <td class='cpcode'>
                        <cfif (is_active)>
                            Active
                        <cfelse>
                            Inactive
                        </cfif>
                    </td>

                    <td class='cpcode'><button class="edit"><a href="edit_coupon.cfm?id=#coupon_id#">Edit</a></button></td>
                    <td class='cpcode'>
                       <cfif is_active>
                          <button type="button" class="deactivate">
                             <a href="activate_coupon.cfm?cpid=#coupon_id#&toactivate=0">Deactivate</a>
                          </button>
                       <cfelse>
                          <button type="button" class="activate" >
                             <a href="activate_coupon.cfm?cpid=#coupon_id#&toactivate=1">Activate</a>
                          </button>
                       </cfif>
                    </td>
                </tr>
                <cfset rowNumber = rowNumber+1>
            </cfoutput>
        </table>

        <button class="goback_button" type="submit" name="logout">
            <a href="../../../Product_table/product_insert/product_details.cfm">Go to product details</a>
        </button>

        <button class='create_coupon'><a href="../cfm/addCoupon.cfm">Create coupon</a></button>
        
    </div>
    
</body>
</html>