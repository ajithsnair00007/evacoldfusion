<link rel="stylesheet" href="styles.css">
<body>
<h1>User Details</h1>
<h3>Here we are listing the user details</h3>


<cfquery name="getData" datasource="product_list">
       SELECT * FROM admin_user
       WHERE admin_id = #Session.userid# 
</cfquery>


    <cfif getData.RECORDCOUNT>
    <div class="data">
        <cfoutput>
           <h4 style="color:violet;">Name : #getData.name#</h4>
           <h4 style="color:red;">Email : #getData.email#</h4>
        </cfoutput>
    </div>
    </cfif>
    </br></br>

<form action="logOut.cfm" method="post">
<button type="submit" name="logout">Logout</button>
</form>
</body>