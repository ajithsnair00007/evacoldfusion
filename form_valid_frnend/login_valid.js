function validateform(){
    var email = document.getElementById("email");
    var password = document.getElementById("psw");
    

   if(email.value.trim()==''){
    document.getElementById('email_error').innerHTML="email values cannot be empty";
    email.style.border="solid red 1px";
    return false;
   }
   else if(password.value.trim()==''){
    document.getElementById('psw_error').innerHTML="password values cannot be empty";
    password.style.border="solid red 1px";
    return false;
   }
  
   else{
    return true;
   }
   
  }