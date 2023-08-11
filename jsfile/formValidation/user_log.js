function validUserForm(){
    let useremail = document.getElementById("email");
    let userpassword = document.getElementById("psw");

    let isValid =true;
  
    // if(document.getElementById("success").innerHTML){
    //     document.getElementById("success").innerHTML=""; 
    // }
    

   if(useremail.value.trim()==''){
    document.getElementById("email_error").innerHTML="email cannot be empty";
    useremail.style.border="solid red 1px";
    isValid=false;
   }
   else {
    document.getElementById("email_error").innerHTML = "";
    useremail.style.border = "solid green 1px";
   }

   if(userpassword.value.trim()==''){
    document.getElementById("psw_error").innerHTML="password cannot be empty";
    userpassword.style.border="solid red 1px";
    isValid=false;
   }
   else {
    document.getElementById("psw_error").innerHTML = "";
    userpassword.style.border = "solid green 1px";
   }
   return isValid;
   

}