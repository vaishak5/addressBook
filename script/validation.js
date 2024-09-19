$(document).ready(function () {
  
  /*SIGN IN*/
  $("#submitClick").click(function () {
    var fullName = $("#fullName").val().trim();
    var emailId = $("#email").val().trim();
    var userName = $("#userName").val().trim();
    var password = $("#password").val().trim();
    var file = $("#myfile")[0].files[0];
    var formData = new FormData();
    formData.append("fullName", fullName);
    formData.append("emailId", emailId);
    formData.append("userName", userName);
    formData.append("password", password);
    formData.append("myfile", file);
    if (signValidation()) {
      $.ajax({
        type: "POST",
        url: "./component/addressBook.cfc?method=signUpload",
        processData: false,
        contentType: false,
        datatype: "text",
        data: formData,
        success: function (response) {
          if (response === "true") {
            console.log(response);
            alert("New User added Successfully");
            window.location.href = "./loginPage.cfm";
          } else if (response === "false") {
            console.log(response);
            alert("Email ID Already exists!");
          }
        },
        error: function (xhr, status, error) {
          console.error(error);
          alert("An error occurred while submitting the form. Please try again.");
        },
      });
    }
    return false;
  });


  /*LOGIN*/
  $("#loginSubmit").click(function () {
    var emailId = $("#email").val().trim();
    var password = $("#password").val().trim();
    if (emailId == "" || password == "") {
      alert("Please fill the field!!");
      return;
    } else {
      $.ajax({
        type: "POST",
        url: "./component/addressBook.cfc?method=checkLogin",
        datatype: "text",
        data: { emailId: emailId, password: password },
        success: function (response) {
          if (response === "true") {
            alert("Login Successfully!!!");
            window.location.href = "./listPage.cfm";
          } else {
            alert("User Not Found!!!");
          }
        },
        error: function (xhr, status, error) {
          console.error(error);
          alert("An error occurred while submitting the form. Please try again.");
        },
      });
    }
  });

  $("#createContactButton").click(function () {
    $("#myForm")[0].reset();
    $("#hiddenContactId").val("0");
  });

  $("#formClose").click(function (e) {
    e.preventDefault();
    $("#myForm").get(0).reset();
  });

  /*Create Contact(Entering new datas into the form)*/
  $("#dataCreating").click(function () {
    var hiddenContactId = $("#hiddenContactId").val().trim();
    var title = $("#titles").val().trim();
    var firstName = $("#firstName").val().trim();
    var lastName = $("#lastName").val().trim();
    var gender = $("#gender").val().trim();
    var dob=$("#dob").val().trim();
    var profile = $("#profile")[0].files[0];
    var address = $("#address").val().trim();
    var street = $("#street").val().trim();
    var phoneNum = $("#phoneNumber").val().trim();
    var email = $("#email").val().trim();
    var pincode = $("#pincode").val().trim();
    var formData = new FormData();
    formData.append("hiddenContactId", hiddenContactId);
    formData.append("title", title);
    formData.append("firstName", firstName);
    formData.append("lastName", lastName);
    formData.append("gender", gender);
    formData.append("dob", dob);
    formData.append("profile", profile); 
    formData.append("address", address);
    formData.append("street", street);
    formData.append("phoneNumber", phoneNum);
    formData.append("email", email);
    formData.append("pincode", pincode);
    if (formValidation()) {
      $.ajax({
        type: "POST",
        url: "./component/addressBook.cfc?method=dataUpload",
        contentType: false,
        processData: false,
        dataType: "text",
        data: formData,
        success: function (response) {
          console.log(response);
          if (response == "true") {
            window.location.href = "./listPage.cfm";
          } 
          else if(response == "false"){
            $("#errorMsg").html("Email ID already present!!").css("color", "red");
          }
        },
        error: function (xhr, status, error) {
          console.error(error);
          alert("An error occurred while submitting the form. Please try again.");
        },
      });
    }
  });

  /*Deleting Rows*/
  $(".delete").click(function () {
    var contactId = $(this).attr("data-id");
    var deleting = $(this);
    
    if (confirm("Are you sure you want to delete this record?")) {
      $.ajax({
        type: "POST",
        url: "./component/addressBook.cfc?method=deleteDatas",
        dataType: "text",
        data: { contactId: contactId },
        success: function (response) {
          alert("Data is deleted successfully!!");
          $(deleting).parents("tr").remove(); //remove parent element datas
        },
        error: function (xhr, status, error) {
          console.error(error);
          alert("Error deleting record.");
        },
      });
    }
  });

  /*View Full Data Row*/
  $(".view").click(function () {
    var contactId = $(this).attr("data-id");
    $.ajax({
      type: "POST",
      url: "./component/addressBook.cfc?method=viewDatas",
      dataType: "text",
      data: {
        contactId: contactId,
      },
      success: function (response) {
        var viewDetails = JSON.parse(response);
        console.log(viewDetails);
        $("#fullName").html(viewDetails.FULLNAME);
        $("#genders").html(viewDetails.GENDER);
        $("#dobSecond").html(viewDetails.DOB);
        $("#addressSecond").html(viewDetails.FULLADDRESS);
        $("#phoneNumberSecond").html(viewDetails.PHONENUMBER);
        $("#emailid").html(viewDetails.EMAIL);
        $("#pincodeSecond").html(viewDetails.PINCODE);
        $("#myImage").attr("src", "./assets/" + viewDetails.PROFILEPIC);
      },
      error: function (xhr, status, error) {
        console.error("Error:", status, error);
        alert("Failed to retrieve data.");
      },
    });
  });

  /*Select datas in the row(all input fields)*/
  $(".editBtn").click(function () {
    var contactId = $(this).attr("data-id");
    if (contactId > 0) {
      $.ajax({
        type: "POST",
        url: "./component/addressBook.cfc?method=selectDatas",
        dataType: "text",
        data: {
          contactId: contactId,
        },
        success: function (response) {
          console.log(response);
          $("#profile").attr("value", "./assets/" + response.profilePic)[0].files[0];
          var selectDetails = JSON.parse(response);
          var date = new Date(selectDetails.dob);
          var dateSet = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
          console.log(response);
          console.log(selectDetails.myFile);
          console.log(selectDetails);
          $("#hiddenContactId").val(selectDetails.contactId);
          $("#titles").val(selectDetails.title);
          $("#firstName").val(selectDetails.firstName);
          $("#lastName").val(selectDetails.lastName);
          $("#gender").val(selectDetails.gender);
          $("#dob").prop("value", dateSet);
          $("#address").val(selectDetails.address);
          $("#street").val(selectDetails.street);
          $("#phoneNumber").val(selectDetails.phoneNumber);
          $("#email").val(selectDetails.email);
          $("#pincode").val(selectDetails.pincode);
          $(".editImg").attr("src", "./assets/" + selectDetails.myFile);
        },
        error: function (xhr, status, error) {
          console.error("Error:", status, error);
          alert("Failed to retrieve data.");
        },
      });
    }
  });
  
  /*Print Details*/
  $("#printButton").on("click", function () {
    var printContent = $("#printableDiv").html();
    $('body').html(printContent);
    window.print();
    window.location.href = "./listPage.cfm";
  });
});

/*Plain Template*/
$(document).ready(function() {
  $("#uploadAddress").click(function(event) {
      event.preventDefault(); 
      var formData = new FormData($("#uploadForm")[0]); 
      $.ajax({
          url: './component/addressBook.cfc?method=uploadExcelDatas',
          method: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          dataType: "json", 
          success: function(response) {
              if (response.length > 0) {
                  response.forEach(function(item) {
                      alert(item.message);
                      window.location.href = "./listPage.cfm";
                  });
              }
          },
          error: function(xhr, status, error) {
              console.log("An error occurred: " + error);
              alert("An error occurred: " + error);
          }
      });
  });
});

 
/*SIGN UP*/

function signValidation() {
  var fullName = $("#fullName").val().trim();
  var file = $("#myfile").val().trim();
  var emailId = $("#email").val().trim();
  var userName = $("#userName").val().trim();
  var password = $("#password").val().trim();
  var confirmPassword = $("#confirmPassword").val().trim();
  $(".error").hide();
  var isValid = true;
  if (fullName == "" && file == "" && emailId == "" && userName == "" && password == "" && confirmPassword == "") {
    $("#fullNameError").html("This field is required. Please enter a value.").css("color", "red");
    $("#fullNameError").show();
    $("#fileError").html("This field is required. Please enter a value.").css("color", "red");
    $("#fileError").show();
    $("#emailError").html("This field is required. Please enter a value.").css("color", "red");
    $("#emailError").show();
    $("#usernameError").html("This field is required. Please enter a value.").css("color", "red");
    $("#usernameError").show();
    $("#passwordError").html("This field is required. Please enter a value.").css("color", "red");
    $("#passwordError").show();
    $("#confirmError").html("This field is required. Please enter a value.").css("color", "red");
    $("#confirmError").show();
    isValid = false;
  } 
  else {
    if (fullName == "" || /\d/.test(fullName)) {
      $("#fullNameError").html("Please enter a valid full name (non-numeric)").css("color", "red");
      $("#fullNameError").show();
      isValid = false;
    }
    if (file == "") {
      $("#fileError").html("Please fill the field").css("color", "red");
      $("#fileError").show();
      isValid = false;
    }
    if (!(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$/).test(emailId) || emailId == "") {
      $("#emailError").html("Please enter a valid Email ID.").css("color", "red");
      $("#emailError").show();
      isValid = false;
    }
    if (userName == "" || /\d/.test(userName)) {
      $("#usernameError").html("Please enter a valid User Name(non-numeric)").css("color", "red");
      $("#usernameError").show();
      isValid = false;
    }
    if (password == "") {
      $("#passwordError").html("Please enter the password").css("color", "red");
      $("#passwordError").show();
      isValid = false;
    } else if (!isValidPassword(password)) {
      $("#passwordError").html("Password contains 8 characters including uppercase,lowercase,special characters and digits").css("color", "red");
      $("#passwordError").show();
      isValid = false;
    }
    if (confirmPassword == "") {
      $("#confirmError").html("Please enter the correct password").css("color", "red");
      $("#confirmError").show();
    }
    if (password != confirmPassword) {
      $("#confirmError").html("Please enter correct password").css("color", "red");
      $("#confirmError").show();
      isValid = false;
    }
  }
  if (isValid) {
    return true;
  }
  return false;
}
/*VALIDATE PASSWORD*/

function isValidPassword(password) {
  var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
  return passwordRegex.test(password);
}

/*CREATE CONTACT*/

function formValidation() {
  var title = $("#titles").val().trim();
  var firstName = $("#firstName").val().trim();
  var lastName = $("#lastName").val().trim();
  var gender = $("#gender").val().trim();
  var d = new Date();
  var year = d.getFullYear();
  var month = String(d.getMonth() + 1).padStart(2, '0'); 
  var day = String(d.getDate()).padStart(2, '0'); 
  var strDate = year + "-" + month + "-" + day;
  console.log("Current Date:", strDate);
  var dob = $("#dob").val().trim();
  console.log("Date of Birth:", dob);
  var currentDate = new Date(strDate);
  var dobDate=new Date(dob);
  var profile = $("#profile").val().trim();
  var address = $("#address").val().trim();
  var street = $("#street").val().trim();
  var phoneNum = $("#phoneNumber").val().trim();
  var email = $("#email").val().trim();
  var pincode = $("#pincode").val().trim();
  var isValid = true;
  var errorMsg = [];
  var specialCharRegex = /[<>]/;

  if (title === "" || firstName === "" || lastName === "" || gender === "" || dobDate === "" || profile === "" || address === "" || street === "" || phoneNum === "" || email === "" || pincode === "" ) {
    errorMsg.push("All fields are required!");
    isValid = false;
  } 
  else {
    if (title === "") {
      errorMsg.push("Please select a title.");
      isValid = false;
    }
    if (firstName === "" || /\d/.test(firstName) || firstName.length > 20) {
      errorMsg.push("Please enter a valid first name.");
      isValid = false;
    }
    if (lastName === "" || /\d/.test(lastName) || lastName.length > 20) {
      errorMsg.push("Please enter a valid last name ");
      isValid = false;
    }
    if (gender === "") {
      errorMsg.push("Please select a gender.");
      isValid = false;
    }
    if (dob === "" || (dobDate > currentDate) ) {
      errorMsg.push("Please enter a proper DOB");
      isValid = false;
    }
    if (profile === "") {
      errorMsg.push("Please select a profile picture.");
      isValid = false;
    }
    if (address === "" || address.length > 100 || specialCharRegex.test(address) ) {
      errorMsg.push("Please enter a valid address");
      isValid = false;
    }
    if (street === "" || street.length > 50 || specialCharRegex.test(street)) {
      errorMsg.push("Please enter a valid street");
      isValid = false;
    }
    if (phoneNum === "" || !/^(?:\+91[\-\s]?)?\d{10}$/.test(phoneNum) ){
      errorMsg.push("Please enter a valid 10-digit phone number.");
      isValid = false;
    }
    if (email === "" || !(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$/).test(email)){
      errorMsg.push("Please enter a valid email address.");
      isValid = false;
    }
    if (pincode === "" || !/^\d{6}$/.test(pincode)) {
      errorMsg.push("Please enter a valid 6-digit pincode.");
      isValid = false;
    }
  }
  // Display the error message
  if (errorMsg.length > 0) {
    var errorMessages = errorMsg.join("<br>");
    $("#errorMsg").html(errorMessages).css("color", "red");
    return false;
  } else {
    $("#errorMsg").html("Data added successfully.").css("color", "green");
    return true;
  }
}

/*SSO*/
$(document).ready(function () {
	$('#googleIcon').on('click', function () {
		signIn();
	});
	let params = {};
	params={"http://127.0.0.1:8500/ColdFusion_Tasks/Address_Book/":"listPage.cfm"};
	let regex = /([^&=]+)=([^&]*)/g,m;
  while ((m = regex.exec(location.href)) !== null) {
		params[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
	}
  if (Object.keys(params).length > 0) {
		localStorage.setItem('authInfo', JSON.stringify(params));
    //hide the access token
		window.history.pushState({}, document.title, "");
	}
	let info = JSON.parse(localStorage.getItem('authInfo'));
  if (info)
 {
		$.ajax({
      //get all the information(the url will get access to the profile picture and email address)
			 url: "https://www.googleapis.com/oauth2/v3/userinfo",
			headers: {
				"Authorization": `Bearer ${info['access_token']}`
			}, 
			success: function (data) {
				var emailID = data.email;
				var name = data.name;
				var image = data.picture;
       
        $.ajax({
					url: './component/addressBook.cfc?method=googleLogin',
					type: 'post',
          dataType: "text",
					data: {
						emailID: emailID,
						name: name,
						image: image
					},
					
					success: function (response) {
						if (response) {
							window.location.href = "./listPage.cfm";
						}
					},
					error: function (xhr, status, error) {
						alert("An error occurred: " + error);
					}
				});
			}
		});
	} 
});

function signIn() {
	let oauth2Endpoint = "https://accounts.google.com/o/oauth2/v2/auth";
	let $form = $('<form>')
		.attr('method', 'GET')
		.attr('action', oauth2Endpoint);
	let params = {
		"client_id": "135401033169-7f5pu8kp94335rgg9hk1e1pcg2deaj6p.apps.googleusercontent.com",
		"redirect_uri": "http://127.0.0.1:8500/ColdFusion_Tasks/Address_Book/listPage.cfm",
		"response_type": "token",
		"scope": "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email",
		"include_granted_scopes": "true",
		"state": 'pass-through-value'
	};
	$.each(params, function (name, value) {
		$('<input>')
			.attr('type', 'hidden')
			.attr('name', name)
			.attr('value', value)
			.appendTo($form);
	});
	$form.appendTo('body').submit();
}
/*Plain Template*/
