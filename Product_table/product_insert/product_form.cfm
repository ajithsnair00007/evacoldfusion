  <html>
    <head>
        <link rel="stylesheet" href="/cssStyle/product_style.css">
        <script type="text/javascript" src="/jsfile/formValidation/product_form.js"></script>
        
    </head>
    <body>
        <div class="productform">
            <form id="form" action="./insert_products.cfm" method="post" onsubmit="return validProductForm();" enctype="multipart/form-data">
                    <h1>ADD PRODUCT</h1>

                   

                    <label for="prodname">ProductName:</label> 
                    <input id="prodname" type="text" placeholder="Enter a product" name="prodname"  class="prodname"></br>
                    <span>
                        <cfif isDefined('url.exist')>
                           <small id="pname_error" class="prodnameexist">ProductName already exists,please add a new product</small>
                        </cfif>
                    </span>
                    
                    <span id="prodname_error" style="color:red;" class="error"></span> <br>
                    

                    <label for="price">Price:</label> 
                    <input id="price" type="number" placeholder="price" name="price"  class='price'></br>
                    <span id="price_error" style="color:red;" class="error"></span> <br>
                    
                    <label for="productImage">Product Image:</label>
                    <input type="file" name="productImage" id="productImage"><br><br>
                    <span id="image_error" style="color:red;" class="error"></span> <br>

                    <label for="availability">AvailableStock:</label>
                    <input id="availability" type="number" placeholder="enter availablestocks" name="availability"></br>
                    <span id="availability_error" style="color:red;" class="error"></span> <br>
                    

                    <label for="is_active">Active:</label>
                    <input type="radio" name="is_active" value="1" checked>Yes</input>
                    <input type="radio" name="is_active" value="0">No</input><br></br>

                    <button type="submit">ADD PRODUCT</button>
                    
                </form>
            </div>
        </body>
    </html>

