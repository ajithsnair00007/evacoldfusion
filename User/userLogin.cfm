<link rel="stylesheet" href="/cssStyle/userLogin.css">
<script type="text/javascript" src="/jsfile/formValidation/user_log.js"></script> 
       
  </script>
<body>
  

    <!------>
   <div class="loginform">
     <cfif isDefined('url.success')>
        <p class="success">User created successfully, now you can login</p>
     <cfelseif isDefined('error')> 
        <p class="errormsg">recheck email and password</p>
     </cfif>
     <h1>USER LOGIN</h1>
    
     <form action="userLog.cfm" method="post" onsubmit="return validUserForm()">
        
        <label for="email">Email</label>
        <input id="email" type="email" placeholder="Enter email" name="email"></br>
        <span id="email_error" style="color:red; margin-left:0%" class="error"></span></br>
        
        <label for="psw">Password</label>
        <input id="psw" type="password" placeholder="Enter Password" name="psw"></br>
        <span id="psw_error" style="color:red; margin-left:0%" class="error"></span> 
        </br>

        <button type="submit" name="login">Login</button>

     </form>
     <a href="userSignup.cfm">Register NewUser</a>
   </div>
    
       
</body>