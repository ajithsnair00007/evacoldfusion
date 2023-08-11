$(document).ready(function() {
    $(document).on('click', '.createcoupon', function() {
       if (validateForm()) {
          var cpname = $('[name="cpname"]').val();
          var cpcode = $('[name="cpcode"]').val();
          var cptype = $('[name="cptype"]').val();
          var cpoffer = $('[name="cpoffer"]').val();
          var cpstatus = $('[name="status"]:checked').val();
        
          $.ajax({
             type: 'POST',
             url: '../cfc/add_coupon.cfc?method=addCoupon',
             data: {
                cpname: cpname,
                cpcode: cpcode,
                cptype: cptype,
                cpoffer: cpoffer,
                cpstatus:cpstatus,
                
             },
             dataType: 'json',
             success: function(response) {
                console.log(response);
                
                var result = JSON.parse(response);
                
                if (result.exist) {
                    var message ="The coupon code already exists."
                    $('#form_message').html('<span style="color:red;">' + message + '</span>');
                } else if (result.succ) {
                    alert(result.succ);
                    var successmessage='coupon created successfully add more'
                    // window.location.href="../cfm/addCoupon.cfm?message="+successmessage;
                    window.location.href="../cfm/coupon_display.cfm"
                }
             },
             error: function(response) {
                
                alert('An error occurred while adding the coupon.');
             }
          });
       }
    });

    $(document).on('click','.updatecoupon',function(){
        if(validateForm()){
            var cpid = $('[name="cpid"]').val();
            var cpnewname = $('[name="cpname"]').val();
            var cpnewcode = $('[name="cpcode"]').val();
            var cpnewtype = $('[name="cptype"]').val();
            var cpnewoffer = $('[name="cpoffer"]').val();
            var cpnewstatus = $('[name="status"]:checked').val(); 
            
            $.ajax({
                type:'POST',
                url:'../cfc/add_coupon.cfc?method=editCoupon',
                data:{
                    cpid:cpid,
                    cpnewname:cpnewname,
                    cpnewcode:cpnewcode,
                    cpnewtype:cpnewtype,
                    cpnewoffer:cpnewoffer,
                    cpnewstatus:cpnewstatus
                },
                datatype:'json',
                success:function(response){
                  var result=JSON.parse(response)

                  if(result.exist){
                    var message = "coupon code already exists"
                    $('#form_message').html('<span style="color:red;>'+message+'</span>')
                  }else if(result.notAutheticated){
                    var message='Login to continue'
                    window.location.href="../../login.cfm?message="+message
                  }else if(result.succ){
                    window.location.href="../cfm/coupon_display.cfm";
                  }
                }
            });
        }
    });
});
 
 function validateForm() {
    var cpname = $('[name="cpname"]').val();
    var cpcode = $('[name="cpcode"]').val();
    var cpoffer = $('[name="cpoffer"]').val();

    isvalid=true
    if(document.getElementById("form_message").innerHTML ){
        document.getElementById("form_message").innerHTML=""
    }
    if(cpname.trim()==""){
        document.getElementById("cpname_error").innerHTML="coupon name cannot be empty";
        isvalid = false;
    }
    else {
        document.getElementById("cpname_error").innerHTML = "";
       }
    if(cpcode.trim()==""){
        document.getElementById("cpcode_error").innerHTML="coupon code cannot be empty";
        isvalid = false;
    }
    else {
        document.getElementById("cpcode_error").innerHTML = "";
       }
    if(cpoffer.trim()==""){
        document.getElementById("cpoffer_error").innerHTML="coupon offer cannot be empty";
        isvalid = false;
    }
    else if(cpoffer<1){
        document.getElementById("cpoffer_error").innerHTML="offer must be atleast one";
        isvalid = false;
    }
    else {
        document.getElementById("cpoffer_error").innerHTML = "";
       }
 
    return isvalid;
 }
 