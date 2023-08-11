<html>
 <head>
    <link rel="stylesheet" href="/cssStyle/user_signup.css">
    <script type="text/javascript" src="/form_valid_frnend/signup_valid.js">
    </script>
 </head>
 <body>
  <div class="signupform">
    <h1>SIGN UP</h1>
     <cfif isDefined('create')>
        <p class="emailexist">email already exists,please provide another email</p>
     </cfif>

    <form id="form" action="regUser.cfm" method="post" onsubmit="return validateform()">
    
          <label for="uname">Name:</label> 
          <input id="uname" type="text" placeholder="Enter name" name="uname"  class="uname" value=""></br>
          <span id="uname_error" style="color:red;" class="error"></span> 
          </br></br>

          <label for="email">Email:</label> 
          <input id="email" type="email" placeholder="Enter email" name="email"  class='email' value=""></br>
          <span id="email_error" style="color:red;" class="error"></span> 
          </br></br>

          <label for="psw">Password:</label>
          <input id="psw" type="password" placeholder="Enter Password" name="psw" value=""></br>
          <span id="psw_error" style="color:red;" class="error"></span> 
          </br></br>

          <button type="submit">Register</button>
          
    </form>
  </div>
 </body>
</html>