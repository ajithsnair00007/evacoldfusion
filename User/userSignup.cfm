<html>
 <head>
    <link rel="stylesheet" href="/cssStyle/user_signup.css">
    <script type="text/javascript" src="/jsfile/formValidation/user_form.js"></script> 

 
 </head>
 <body>
  <div class="signupform">
    <h1>USER SIGN UP</h1>
    
    
    <form id="form" action="userReg.cfm" method="post" onsubmit="return validUserForm()">
    
          <label for="uname">Name:</label> 
          <input id="uname" type="text" placeholder="Enter name" name="uname"  class="uname"></br>
          <span id="uname_error" style="color:red;" class="error"></span> 
          </br>

          <label for="email">Email:</label> 
          <input id="email" type="email" placeholder="Enter email" name="email"  class='email'></br>
          <cfif isDefined('url.create')>
              <small id="email_exist_error" class="emailexist">this emailID already exists,please add a new email</small>
          </cfif>
          <span id="email_error" style="color:red;" class="error"></span> 
          </br>

          <label for="psw">Password:</label>
          <input id="psw" type="password" placeholder="Enter Password" name="psw"></br>
          <span id="psw_error" style="color:red;" class="error"></span> 
          </br>

          <button type="submit">Register</button>
          
    </form>
  </div>
 </body>
</html>