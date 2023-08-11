function validateform(){
    
    var uname = document.getElementById("uname");
    var email = document.getElementById("email");
    var password = document.getElementById("psw");
    
   if(uname.value.trim()==''){
    document.getElementById("uname_error").innerHTML="username cannot be empty";
    uname.style.border="solid red 1px";
    return false;
   }
   else if(email.value.trim()==''){
    document.getElementById('email_error').innerHTML="email cannot be empty";
    email.style.border="solid red 1px";
    return false;
   }
   else if(password.value.trim()==''){
    document.getElementById('psw_error').innerHTML="password cannot be empty";
    password.style.border="solid red 1px";
    return false;
   }
   else if(password.value.trim().length<6){
    document.getElementById('psw_error').innerHTML="password should contain more than 6 letters";
    return false;
   }
   else{
    return true;
   }
   
  }