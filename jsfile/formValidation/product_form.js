function validProductForm(){
    let prodname = document.getElementById("prodname");
    let price = document.getElementById("price");
    let availability = document.getElementById("availability");
    let image = document.getElementById("productImage");

    let isValid =true;
   

   if(document.getElementById("pname_error").innerHTML ){
       document.getElementById("pname_error").innerHTML=""
   }
   
   if(prodname.value.trim()==''){
    document.getElementById("prodname_error").innerHTML="productname cannot be empty";
    prodname.style.border="solid red 1px";
    isValid=false;
   }
   else {
    document.getElementById("prodname_error").innerHTML = "";
    prodname.style.border = "solid green 1px";
   }
  

   if(price.value.trim()==''){
    document.getElementById("price_error").innerHTML="price cannot be empty";
    price.style.border="solid red 1px";
    isValid=false;
   }
   else if(price.value < 100){
    document.getElementById("price_error").innerHTML="price must be start from 100";
    price.style.border="solid red 1px";
    isValid=false;
   }
   else {
    document.getElementById("price_error").innerHTML = "";
    price.style.border = "solid green 1px";
   }
   
   if(availability.value.trim()==''){
    document.getElementById("availability_error").innerHTML="availability cannot be empty";
    availability.style.border="solid red 1px";
    isValid=false;
   }
   else if(availability.value <= 0){
    document.getElementById("availability_error").innerHTML="atleast one product must be available";
    price.style.border="solid red 1px";
    isValid=false;
   }
   else {
    document.getElementById("availability_error").innerHTML = "";
    availability.style.border = "solid green 1px";
   }
   
   if(image.value.trim()==''){
    document.getElementById("image_error").innerHTML="add product image";
    image.style.border="solid red 1px";
    isValid=false;
   }
   else {
    document.getElementById("image_error").innerHTML = "";
    image.style.border = "solid green 1px";
   }
   console.log(isValid);
   
  return isValid;
   

}
   