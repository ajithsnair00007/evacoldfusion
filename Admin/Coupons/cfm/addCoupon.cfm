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
      
      <form>
      <cfif isDefined('message')>
         <div id="formsuccess_message" style="color:green;">
            <cfoutput>#url.message#
            </cfoutput>
         </div>
      </cfif>
       
         <h1>CREATE COUPON</h1>
         <label for="cpname">Coupon Name</label>
         <input name="cpname" type="text">
         <span id="cpname_error" style="color:red;"></span>

         <label for="cpcode">Coupon Code</label>
         <input name="cpcode" type="text">
         <span id="cpcode_error" style="color:red;"></span>
         
         <div id="form_message"></div>
        

         <label for="cptype">Coupon Type</label>
         <select id="type" name="cptype">
            <option value="percentage">percentage</option>
            <option value="fixed">fixed</option>
         </select>

         <label for="cpoffer">Coupon Offer</label>
         <input name="cpoffer" type="number">
         <span id="cpoffer_error" style="color:red;"></span><br>

         <label for="status">Status:</label>

         <label class="status">Active 
           <input type="radio" name="status" value= "1" checked>
         </label>
         <label class="status">inactive
           <input type="radio" name="status" value= "0">
         </label><br>

         <button type="button" class="createcoupon">Create Coupon</button>
      </form>

        <script>
            setTimeout(function() {
                  var formSuccessMessage = document.getElementById("formsuccess_message");
                  if (formSuccessMessage) {
                     formSuccessMessage.style.display = "none";
                  }
            }, 2000);
        </script>  
   </body>
</html>