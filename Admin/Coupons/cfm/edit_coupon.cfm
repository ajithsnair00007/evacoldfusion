<cfparam  name="url.id" default="">
<cfquery name="updatecoupon" datasource="product_list">
   SELECT coupon_id,coupon_name,coupon_code,coupon_type,coupon_offer,is_active FROM
   coupons WHERE coupon_id=<cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
</cfquery>

<html>
   <head>
       <link rel="stylesheet" href="../css/coupon.css">
       <script src="https://code.jquery.com/jquery-3.7.0.js" 
            integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" 
            crossorigin="anonymous">
       </script>
       <script type="text/javascript" src="../js/addcoupon.js"></script>
       
   </head>
   <body>
      <cfif updatecoupon.RecordCount eq 0>
        <p>No data available</p>
      <cfelse>
      <cfoutput>
        <form>
            <h1>EDIT COUPON</h1>

            <input type="hidden" name="cpid" value="#updatecoupon.coupon_id#">
            <label for="cpname">Coupon Name</label>
            <input name="cpname" type="text" value="#updatecoupon.coupon_name#">
            <span id="cpname_error" style="color:red;"></span>

            <label for="cpcode">Coupon Code</label>
            <input name="cpcode" type="text" value="#updatecoupon.coupon_code#">
            <span id="cpcode_error" style="color:red;"></span>
            
            <div id="form_message"></div>
            

            <label for="cptype">Coupon Type</label>
            <select id="type" name="cptype">
                <option value="percentage">percentage</option>
                <option value="fixed">fixed</option>
            </select>

            <label for="cpoffer">Coupon Offer</label>
            <input name="cpoffer" type="number" value="#updatecoupon.coupon_offer#">
            <span id="cpoffer_error" style="color:red;"></span><br>

            <label for="status">Status:</label>

            <label class="status">Active 
            <input type="radio" name="status" value= "1" checked>
            </label>
            <label class="status">inactive
            <input type="radio" name="status" value= "0">
            </label><br>

            <button type="button" class="updatecoupon">Update Coupon</button>
        </form>
      </cfoutput>
      </cfif>
   </body>
</html>