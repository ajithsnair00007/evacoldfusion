<cfparam  name="url.id" default="">
 <cfquery name="updateproducts" datasource="product_list">
        SELECT product_id,product_name,price,no_of_availableStocks,is_active FROM product_table
        WHERE product_id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
 </cfquery>
 <cfset currentName = updateproducts.product_name>
 
  <html>
    <head>
         <link rel="stylesheet" href="/cssStyle/edit_style.css"> 
         <script type="text/javascript" src="/jsfile/formValidation/product_form.js"></script>
    </head>
    <body>
        <cfif updateproducts.RecordCount eq 0>
        <p>No data available</p>
        <cfelse>
            <cfoutput>
                <div class="updateform">
                    <form id="form" action="./update_products.cfm" method="post" onsubmit="return validProductForm()">
                        <h1>EDIT PRODUCT</h1>

                        <input id="prodid" type="hidden" name="prodid"  class="prodid" value="#updateproducts.product_id#"></br>

                        <label for="prodname">ProductName:</label> 
                        <input id="prodname" type="text"  name="prodname"  class="prodname" value="#currentName#"></br>
                        <span>
                            <cfif isDefined('url.exist')>
                                <small id="pname_error" class='error'>The product name already exists for another ID.</small>
                            </cfif>
                        </span>
                        <span id="prodname_error" style="color:red;" class="error"></span> <br>
                        
                        <label for="price">Price:</label> 
                        <input id="price" type="number" name="price"  class='price' value="#updateproducts.price#"></br>
                        <span id="price_error" style="color:red;" class="error"></span> <br>
                        
                        <label for="availability">AvailableStock:</label>
                        <input id="availability" type="number" name="availability" value="#updateproducts.no_of_availableStocks#"></br>
                        <span id="availability_error" style="color:red;" class="error"></span> <br>
                        
                        <label for="is_active">Active:</label>
                        <input type="radio" name="is_active" value="1" checked>Yes</input>
                        <input type="radio" name="is_active" value="0">No</input><br></br>

                        <button type="submit">EDIT PRODUCT</button>
                            
                    </form>
                </div>
            </cfoutput>
        </cfif>
    </body>
  </html>


    