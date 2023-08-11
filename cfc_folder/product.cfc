<cfcomponent>

<!--- function to insert products --->
<cffunction  name="addProduct" returnType="struct">
    <cfargument  name="prodname" type="string" required="true">
    <cfargument  name="price" type="numeric" required="true">
    <cfargument  name="availability" type="numeric" required="true">
    <cfargument  name="is_active" type="boolean" required="true">
    
    <cfif structKeyExists(form, "productImage")>
    <!--- Define the directory to store the uploaded images --->
    <cfset uploadDirectory ="D:/grocerapp/images">
 

    <!--- Upload the image to the server --->
    <cffile action="upload" filefield="productImage" destination="#uploadDirectory#" nameconflict="makeunique" result="uploadResult">
    <cfif uploadResult.fileWasSaved>


    <!--- checking if same product exist --->
    <cfquery name="prod_exist" datasource="product_list">
       SELECT product_name from product_table
       WHERE product_name = <cfqueryparam value="#arguments.prodname#" cfsqltype="cf_sql_varchar">
    </cfquery>
    
    <cfif prod_exist.RecordCount>
        <cflocation  url="product_form.cfm?exist=1">
    <cfelse>
    <cfquery name="insertProduct" datasource="product_list" result="result">
       INSERT INTO product_table(product_name,price,no_of_availableStocks,is_active,image_path)
       Values(<cfqueryparam value="#arguments.prodname#" cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#arguments.price#" cfsqltype="cf_sql_decimal">,
              <cfqueryparam value="#arguments.availability#" cfsqltype="cf_sql_decimal">,
              <cfqueryparam value="#arguments.is_active#" cfsqltype="cf_sql_bit">,
              <cfqueryparam value="/images/#uploadResult.serverFile#" cfsqltype="cf_sql_varchar" />
       )
    </cfquery>
   </cfif>
   </cfif>
      <cfif result.RECORDCOUNT eq 1>   
          <cflocation  url="product_details.cfm" >  
      <cfelse>
      </cfif>

    </cfif>
  </cffunction>
  
  <!---  function for product update  --->
  
  <cffunction name="updateProduct" access="public" returntype="struct">
      <cfargument name="prodid" type="numeric" required="true">
      <cfargument name="prodname" type="string" required="true">
      <cfargument name="price" type="numeric" required="true">
      <cfargument name="availability" type="numeric" required="true">
      <cfargument name="is_active" type="boolean" required="true">

      
      <cfset isAuthenticated = structKeyExists(Session, "userid")>
      
      <cfif isAuthenticated>
      <!--- Check for a duplicate product name with different ID --->
      <cfquery name="checkDuplicateName" datasource="product_list">
          SELECT product_id
          FROM product_table
          WHERE product_name = <cfqueryparam value="#arguments.prodname#" cfsqltype="cf_sql_varchar">
          AND NOT product_id = <cfqueryparam value="#arguments.prodid#" cfsqltype="cf_sql_integer">
      </cfquery>

      <!--- Check if a record with the same name and different ID was found --->
        <cfif checkDuplicateName.RecordCount>
            <cflocation  url="edit_products.cfm?exist=1&id=#arguments.prodid#">
        <cfelse>

        <cfquery name="updateProduct" datasource="product_list" result="result">

          UPDATE product_table
          SET product_name = <cfqueryparam value = "#arguments.prodname#" cfsqltype = "cf_sql_varchar">,
              price = <cfqueryparam value = "#arguments.price#" cfsqltype = "cf_sql_integer">,
              no_of_availableStocks = <cfqueryparam value = "#arguments.availability#" cfsqltype = "cf_sql_integer">,
              is_active = <cfqueryparam value = "#arguments.is_active#" cfsqltype = "cf_sql_bit">
          WHERE product_id = <cfqueryparam value = "#arguments.prodid#" cfsqltype = "cf_sql_integer">    

        </cfquery>

          <cfif result.RecordCount eq 1>
          <cflocation  url="product_details.cfm">
          </cfif>

        </cfif>
      <cfelse>
         <cflocation  url="/Admin/login.cfm">
      </cfif>
  </cffunction>
 
  <!--- function to activate state --->
  <cffunction  name="activateProduct" returntype="struct">
      <cfargument  name="prodid" type="numeric" required="true">
      <cfargument  name="toactivate" type="boolean" required="true">

      <cfset isAuthenticated = structKeyExists(Session, "userid")>
      <cfif isAuthenticated>

          <cfquery name="getProduct" datasource="product_list">
            SELECT product_name
            FROM product_table
            WHERE product_id = <cfqueryparam value="#arguments.prodid#" cfsqltype="cf_sql_integer">
          </cfquery>

          <cfif url.toactivate eq 1>
            <cfquery name="activateproduct" datasource="product_list" result="result">
                UPDATE product_table
                SET is_active = <cfqueryparam value="#arguments.toactivate#">
                WHERE product_id = <cfqueryparam value="#arguments.prodid#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfset successMessage = "#getProduct.product_name# has been successfully activated.">
          </cfif>

          <cfif url.toactivate eq 0>
            <cfquery name="activateproduct" datasource="product_list" result="result">
                UPDATE product_table
                SET is_active = <cfqueryparam value="#arguments.toactivate#">
                WHERE product_id = <cfqueryparam value="#arguments.prodid#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfset successMessage = "#getProduct.product_name# has been deactivated.">
          </cfif>


          <cfif result.RecordCount>
            <cflocation  url="product_details.cfm?successMessage=#successMessage#">
          </cfif>
      <cfelse>
         <cflocation  url="/Admin/login.cfm">
      </cfif>   

  </cffunction>

</cfcomponent>
