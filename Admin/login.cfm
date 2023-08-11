<link rel="stylesheet" href="/cssStyle/userLogin.css">
 <script type="text/javascript" src="/form_valid_frnend/login_valid.js">
       
  </script>
<body>


   <div class="loginform">
   <cfif isDefined('create')>
        <p class="success" style="color:green;">User created successfully, now you can login</p>
    <cfelseif isDefined('error')> 
        <p class="errormsg" style="color:red;">recheck email and password</p>
    </cfif>

    <cfif isDefined('message')>
         <div id="formsuccess_message" style="color:red;">
            <cfoutput>#url.message#
            </cfoutput>
         </div>
   </cfif>
   
   <h1>LOGIN</h1>
     <form action="logUser.cfm" method="post" onsubmit="return validateform()">
        
        <label for="email">Email</label>
        <input id="email" type="email" placeholder="Enter email" name="email"></br>
        <span id="email_error" style="color:red; margin-left:0%" class="error"></span></br>
        

        <label for="psw">Password</label>
        <input id="psw" type="password" placeholder="Enter Password" name="psw"></br>
        <span id="psw_error" style="color:red; margin-left:0%" class="error"></span> 
        </br>

        <button type="submit" name="login">Login</button>

     </form>
     <a href="signup.cfm">Create NewUser</a>
   </div>
    
       
</body>