<cfoutput>
<html>
<head>
    <link rel="stylesheet" href="/cssStyle/cart.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js" 
            integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" 
            crossorigin="anonymous">
    </script>
     
    <script>
    $(document).ready(function() {
       
        function updateProductQuantity(action, item) {
            $.ajax({
                type: "POST",
                url: "quantity.cfc",
                data: {
                    method: "updateProductQuantity",
                    action: action,
                    item: item
                },
                dataType: "json",
                success: function(response) {
                    // convert json into js object
                    var result = JSON.parse(response);
                    if (result.STATUS) {
                    console.log(typeof JSON.parse(response)); 
                    console.log(`DIS:${result.DISCOUNT}`);
                       
                        $(`##quantity${result.ID}`).text(result.QUANTITY) ;
                        console.log(`QTY :${result.QUANTITY}`)
                        $(`##total${result.ID}`).text(result.TOTAL);
                        $(`##subtotal${result.ID}`).text(result.TOTAL-Number($(`##discount${result.ID}`).text()));
                        var totalSUM = result.TOTALSUM;
                        var totalDiscount =result.TOTALDISCOUNT;
                        var currentTotalSum=parseInt($(`##totalsum`).text().split(':')[1]);
                        var newDiscount = Number($(`##discount${result.ID}`).text());
                        $(`##totalsum`).text(`TotalPrice: ${totalSUM - newDiscount}`);  
                    }else{
                        alert("Error:");
                    }  
                }
            });
        };

        // Managing product count
        $(".increaseqty").click(function(){
            const item = $(this).data("item");
            updateProductQuantity("plus", item);
        });

        $(".decreaseqty").click(function(){
            const item = $(this).data("item");
            updateProductQuantity("minus", item);
        });

        // checkout functionality
        $("##checkout").click(function(){
            $.ajax({
                type:'POST',
                url:"checkout.cfc?method=checkOut",
                success:function(response){
                   var result = JSON.parse(response);
                   if(result.status){
                      window.location.href="product_listing.cfm"; 
                   }   
                }
            });
         
         
        });

        // home action
        $(document).on('click','##gobackbtn',function(e){
            e.preventDefault();
             window.location.href="product_listing.cfm";
        });
        
        // purchase when cart is empty
        $('##purchaseItem').click(function(){
            window.location.href="product_listing.cfm";
            
        })

        // removing items from cart
        $(document).on('click', '.removeitem', function(){
            const id = $(this).data("id");

            $(this).addClass("loader");
            setTimeout(function(){
                $('##removeitem').removeClass("loader");
            },2000)

            $.ajax({
                type:'POST',
                url:'removeitem.cfc?method=removeItem',
                data:{
                    id:id
                },
                dataType: "json",
                success:function(response){
                     var result=JSON.parse(response);
                  
                    if(result.STATUS){

                        $(`##productrow${result.ID}`).remove();

                        currentTotalSum=parseInt($(`##totalsum`).text().split(':')[1]);
                        itemPrice = parseInt(result.PRICE);
                       
                        priceOfitem = parseInt(itemPrice = (result.PRICE));
                        updatedSum =parseInt(Number(currentTotalSum) - Number(itemPrice));
                        $(`##totalsum`).text(`TotalPrice: ${updatedSum}`);  

                        if(updatedSum==0){ 
                            $("table").hide(); 
                            $("##totalsum").hide();
                            $("##purchaseItem").show(); 
                            $("button.clearcart").hide(); 
                            $("button.checkout").hide();
                            $(".gobackbtn").hide();
                            $(".emptycartmsg").text("your cart is empty").css("visibility","visible");
                        }
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
              }
            });
        });

        // for globally declaring product id
        var proid;
        // select coupon action
        $(document).on("click", ".selectcp", function(){
        const id = $(this).data("id");
        // console.log(id)
        $.ajax({
            type:'POST',
            url:'../../Admin/Coupons/cfc/add_coupon.cfc?method=retrieveCoupon',
            data:{
                id:id
            },
            datatype:'json',
            success:function(couponDetails){
                var result =  JSON.parse(couponDetails) ;
                if (result) {
                    showCouponFormPopup(result,id);
                    proid = id; 
                } 
              }
           });
        });
         
        var appliedCoupons = [];
        function showCouponFormPopup(result,id) {
            var popupContent = '<div class="coupon-popup">';
            popupContent += '<form id="couponForm">';

            popupContent += '<div id="closeButton">&times</div>';

            popupContent += '<label for="couponOffer">Select Offer:</label>';
            popupContent += '<select>';
             $.each(result, function(index, value) {
                if (appliedCoupons.indexOf(value.COUPON_NAME) === -1){
                    popupContent += '<option value="' + value.COUPON_NAME + '">' + value.COUPON_NAME + '</option>';
                }
                
            });
            popupContent += '</select>';

            
            popupContent += '<button type=button id="applyCouponButton" style="background-color:green;color:white">Apply Coupon</button>';
            popupContent += '</form>';
            popupContent += '</div>';

            $('##couponPopup').html(popupContent);
            $('##couponPopup').show();
  
        }

        
        //apply coupon action
        var cartDiscount;
        var cartCouponId;
       
        $(document).on('click',"##applyCouponButton",function(){
            let id = proid;
            var selectedOffer =  $('##couponForm select').val();
            appliedCoupons.push(selectedOffer);
            // console.log(appliedCoupons)

            $.ajax({
                type:'POST',
                url:'../../Admin/Coupons/cfc/add_coupon.cfc?method=applyCoupon',
                data:{
                    selectedOffer:selectedOffer,
                    id:id,
                },
                datatype:'json',
                success:function(response){
                    let result=JSON.parse(response);
                    let totalprice = Number($('##total'+id).text());
                    let discount = result.COUPON_OFFER;
                    let percdiscount = discount*totalprice/100;
                    let couponID = result.COUPON_ID;
                    console.log(couponID)
                    
                    if(result.COUPON_TYPE == 'fixed'){
                        var currentTotalSum=parseInt($(`##totalsum`).text().split(':')[1]);
                        cartDiscount = discount;
                        cartCouponId = couponID;
                        $(`##discount${id}`).text(discount);
                        $(`##subtotal${id}`).text(totalprice-discount);
                        $(`##totalsum`).text(`TotalPrice: ${currentTotalSum-discount}`);
                    }else if(result.COUPON_TYPE =='percentage'){
                        var currentTotalSum=parseInt($(`##totalsum`).text().split(':')[1]);
                        cartDiscount = percdiscount;
                        cartCouponId = couponID;
                        $(`##discount${id}`).text(percdiscount);
                        $(`##subtotal${id}`).text(totalprice-percdiscount);
                        $(`##totalsum`).text(`TotalPrice: ${currentTotalSum-percdiscount}`);
                    }
                    if(result.COUPON_OFFER){
                      //create ajax to store cart discount
                      $.ajax({
                        type:'POST',
                        url:'../../Admin/Coupons/cfc/add_coupon.cfc?method=applyDiscountToCart',
                        data:{
                            cartDiscount : cartDiscount,
                            id : id
                        },
                        datatype:'json',
                        success:function(response){
                            let result = JSON.parse(response);
                            if(response){
                                console.log(`Discount is :${result.DISCOUNT}`);
                                
                            }
                          }
                        });
                       //create ajax to store coupon id in the cart
                      $.ajax({
                        type:'POST',
                        url:'../../Admin/Coupons/cfc/add_coupon.cfc?method=applyCouponIdToCart',
                        data:{
                            cartCouponId:cartCouponId,
                            id:id
                        },
                        datatype:'json',
                        success:function(response){
                            let result = JSON.parse(response);
                            if(result.COUPONID){
                                console.log(`couponid:${result.COUPONID}`);
                            }
                            if(result.COUPONDATE){
                                console.log(result.COUPONDATE);
                            }
                        }
                    });
                    }

                 
                    //for restricting no of coupon per day
                    $.ajax({
                        type:'POST',
                        url:"../../Admin/Coupons/cfc/add_coupon.cfc?method=restrictApplyCoupon",
                        data:{
                            id:id,
                            cartCouponId:cartCouponId
                        },
                        datatype:'json',
                        success:function(response){
                            var result = JSON.parse(response);
                            if(result.CURRENTDATE==result.CPAPPLIEDDATE){
                                console.log(result.CPAPPLIEDDATE);
                                console.log(result.CURRENTDATE);
                               alert('coupon already applied today');
                               $('.cprestrict').text('coupon already applied today').css("background-color", "red");
                            }
                        }
                    });

                    if(result.COUPON_OFFER){
                        $('##couponForm select option[value="' + selectedOffer + '"]').remove();
                     
                    $(`##applycp${id}`).replaceWith(`<button class="removeCoupon${id} remcoupon"  data-id="${id}">Remove Coupon</button>`);
                    $('.applycp').prop('disabled', true).css({
                          'pointer-events': 'none',
                          'opacity': '0.5'
                      });
                  
                    $(`##applycp${id}`).removeClass('selectcp');
                    
                    $('##couponPopup').hide();
                    }
                    else{
                        $('.applycp').prop('disabled', true)
                    }
                    $('##couponPopup').hide();
                } 
            }); 
        });
    
        // remove coupon action
        $(document).on('click', '.remcoupon', function(){
                            
                const id = $(this).data('id');
                var discountValue = Number($(`##discount${id}`).text());
                var subtotalValue = Number($(`##subtotal${id}`).text());
                var currentTotalSum=parseInt($(`##totalsum`).text().split(':')[1]);
                
                appliedCoupons.shift();
                appliedCoupons=[];
                
                $('.applycp').prop('disabled', false).css({
                    'pointer-events':'auto',
                    'opacity':'1'
                });
                 
                console.log(appliedCoupons);
                $(`##discount${id}`).text(discountValue-discountValue);
                $(`##subtotal${id}`).text(discountValue+subtotalValue);
                $(`##totalsum`).text(`TotalPrice: ${currentTotalSum+discountValue}`);

                $(`.removeCoupon${id}`).replaceWith(`<button class="applycp selectcp" id="applycp${id}" data-id="${id}">Select Coupon</button>`);

                $("##couponPopup").hide();
                //remove discount
                $.ajax({
                    type:'POST',
                    url:'../../Admin/Coupons/cfc/add_coupon.cfc?method=removeDiscountToCart',
                    data:{
                        id:id
                    },
                    datatype:'json',
                    success:function(response){

                    }
                });
                //remove couponid
                  $.ajax({
                    type:'POST',
                    url:'../../Admin/Coupons/cfc/add_coupon.cfc?method=removeCouponIdFromCart',
                    data:{
                        id:id
                    },
                    datatype:'json',
                    success:function(response){

                    }
                });

                //removing coupon applied date from cart
                  $.ajax({
                    type:'POST',
                    url:'../../Admin/Coupons/cfc/add_coupon.cfc?method=removeCouponDate',
                    data:{
                        id:id
                    },
                    datatype:'json',
                    success:function(response){

                    }
                });
                });  

        // close button of popup
        $(document).on('click', '##closeButton', function(){
            $('##couponPopup').hide();
        });  
    });
</script>
</head>
<body>
<!--- <cfdump  var="#Session.cart#"> --->
    <h1>Your Cart</h1>
    <button class="gobackbtn" id="gobackbtn">GoBack</button>
    <div class="popup" id="couponPopup"> 
        <h2>Coupon Details</h2>
    </div>
      <table>
        <tr>
            <th class="productname">Product Name</th>
            <th>Image</th>
            <th class="price">Price</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>CouponOffers</th>
            <th>Discount</th>
            <th>Subtotal</th>
            <th>Remove</th> 
        </tr>

        <cfset cart = {}>

        <cfif isDefined('Session.cart')>
           <cfset cart = Session.cart>
        </cfif>
         <cfset totalSum = 0> 
         <cfset currentdate = dateFormat(now(),"YYYY-MM-DD")>

         <cfquery name="retrievecouponapplieddate" datasource="product_list">
            SELECT * from orders
            where couponAppliedOn = <cfqueryparam value="#currentdate#" cfsqltype="cf_sql_date">
         </cfquery>

        <cfloop collection="#cart#" item="item">
            <cfset product = cart[item]>
<!---             <cfdump  var="#product#">  --->
              <cfset productid = product.productid>
             
          
            <tr id="productrow#product.productid#">
                <td class="productname">#product.productname#</td>
                <td><img src="#product.image#" alt="" width="100" height="100"></td> 
                <td class="price" id="price#product.productid#">#product.price#</td>
                <td>
                    <button class="increaseqty" type="button" data-item="#item#">+</button>
                    <span id ="quantity#product.productid#" class="productquantity">#product.quantity#</span>
                    <button class="decreaseqty" type="button" data-item="#item#">-</button>
                </td>
                <td id ="total#product.productid#" class="totalprice">#product.price * product.quantity#</td>
                <td>
                   <cfif StructKeyExists(product, 'couponid')>
                      <button class="removeCoupon#product.productid# remcoupon" 
                        data-id="#product.productid#">Remove Coupon</button>
                   <cfelseif retrievecouponapplieddate.RecordCount>
                            <div class="restcp">Today's coupon limit exceeds</div>
                   <cfelse>
                   <cfset response = false> 
                       <cfloop collection="#cart#" item="item">
                                <cfset cartItem = cart[item]>
                                <cfif StructKeyExists(cartItem, 'couponid')>
                                    <cfset response = true>
                                </cfif>
                       </cfloop>
                           <cfif response eq true>  
                              <button class="applycp selectcp" id="applycp#product.productid#" 
                                    data-id="#product.productid#" disabled style="pointer-events:none; opacity:0.5;">Select Coupon</button>
                           </cfif>
                           <cfif response eq false>
                               <button class="applycp selectcp" id="applycp#product.productid#" 
                                    data-id="#product.productid#" style="pointer-events:auto; opacity:1;
                                    ">Select Coupon</button>
                           </cfif> 

<!---                    <button class="applycp selectcp" id="applycp#product.productid#"   
                        data-id="#product.productid#" <cfloop collection="#cart#" item="item">
                                                           <cfset cartItem = cart[item]>
                                                           <cfif StructKeyExists(cartItem, 'couponid')>
                                                           disabled style="pointer-events:none"
                                                           </cfif>
                                                       </cfloop>>Select Coupon</button>--->
                   </cfif>
                </td>
                <td id="discount#product.productid#" class="discount">#product.discount#</td>
                <td id ="subtotal#product.productid#" class="totalprice">#product.price * product.quantity#</td>
                <td><button class="removeitem" id="removeitem" data-id="#product.productid#">RemoveItem</button></td> 
            </tr>
           <cfset totalSum = totalSum+(product.price * product.quantity)> 
        </cfloop>
      </table>

      <div id="totalsum" class="totalsum">TotalPrice : #totalSum#</div> 
      <button class="clearcart" id="clearCartBtn"><a href="clearCart.cfm">Clear Cart</a></button>
      <button class="checkout" id="checkout">Checkout</button>
      <button class="purchaseItem" id="purchaseItem">PurchaseItem</button>
      <span class="emptycartmsg" id="emptycartmsg"></span>

      <cfif structIsEmpty(cart)>
            <cfset message = "Your cart is empty!">
            <span class="emptycart">#message#</span>
            <script>
                $(document).ready(function() {
                    function hideButtons() {
                    $("table").hide();
                    $("##clearCartBtn").hide();
                    $("##checkout").hide();
                    $("##purchaseItem").show();
                    $("##totalsum").hide();
                    $(".gobackbtn").hide();
                }
                     hideButtons();
                });
            </script>
      <cfelse>
            <script>
                $(document).ready(function() {
                    function showButton() {
                    $("##purchaseItem").hide();
                }
                    showButton();
                });
            </script>    
      </cfif>
      <div class="cprestrict"></div>
    
</body>
</html>
</cfoutput>





















