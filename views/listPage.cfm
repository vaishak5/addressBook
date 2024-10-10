<cfoutput>
   <!DOCTYPE html>
   <html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>List Page</title>
      <link rel="stylesheet" href="../style/style.css">
      <link rel="stylesheet" href="../style/jquery-ui.css">
      <link rel="stylesheet" href="../style/bootstrap.min.css">
      <script src="../script/sourceFirst.js"></script>
      <script src="../script/sourceSecond.js"></script>
      <script src="../script/sourceThird.js"></script>
      <script src="../script/jquery.min.js"></script>
      <script src="../script/jquery-ui.min.js"></script>
      <script src="../script/validation.js"></script>
      <script src="../script/modalJS.js"></script>
      <script src="../script/reset.js"></script>
   </head>
   <body>
      <cfif session.sso>
         <cfset variables.image = session.imgProfile>
      <cfelse>
         <cfset variables.image = "../assets/" & session.imgFile>
      </cfif>
      <cfif session.login>
         <div class="navbar px-5">
            <div class="navbarFt">
               <img class="addressLogo" src="../assets/bodyBook.png" alt="img" width="30" height="30">
               <h3 class="mb-0">ADDRESS BOOK</h3>
            </div>
            <div class="navbarSndSet">
               <img class="loginLogo" src="../assets/logout.png" alt="img" width="20" height="20">
              <a href="../controllers/address.cfc?method=doLogout">Logout</a> 
            </div>
         </div>
         <div class="mainSett">
            <div class="body">
               <div class="bodyFt">
                  <div class="downloadSet">
                     <a href="listPdf.cfm"><img src="../assets/pdf.png" alt="img"></a>
                     <a href="listExcel.cfm"><img src="../assets/excel.png" alt="img"></a>
                     <img src="../assets/print.png" alt="img" id="printButton">
                  </div>
               </div>
            </div>
            <div>
            <div class="bodyConts">
               <div class="bodySnd">
                  <div class="d-flex flex-column  bg-light text-dark me-2 text-center rounded">
                     <div class="userProfile p-2">
                        <img src="#variables.image#" class="rounded-circle img-fluid" alt="img" width="100">
                     </div>
                     <div class="userName p-2 ">#session.fullName#</div>
                        <div class="p-2 ">
                           <button type="button" id="createContactButton" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="##exampleModal" >
                           Create Contact
                           </button>
                           <!-- Modal -->
                           <div class="modal bd-example-modal-lg fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                              <div class="modal-dialog modal-lg p-1">
                                 <div class="modal-content">
                                    <div class="fullBody d-flex">
                                       <div class="firstBody">
                                          <div class="modalContent bg-white px-5">
                                             <div class="headings">
                                                <div class="heading d-flex justify-content-center w-100">
                                                   <h3 class="creating px-4 w-100">CREATE CONTACT</h3>
                                                </div>
                                                <div class="nextHeading mt-3 w-100 d-flex justify-content-center">
                                                   <h5 class="personal w-100 d-flex py-1">Personal Contact</h5>
                                                </div>
                                             </div>
                                             <div class="inputFields">
                                                <form class="formField" method="post" action="" id="myForm">
                                                   <input type="hidden" id="hiddenContactId" value="0">
                                                   <table class="table">
                                                      <tbody>
                                                         <!-- First Input -->
                                                         <tr class="rowAlign">
                                                            <td class="itemsAlign">
                                                               <label for="title" class="displayItems">Title*</label>
                                                               <select name="title" id="titles" required>
                                                                  <option value selected="selected"></option>
                                                                  <option value="MR.">Mr.</option>
                                                                  <option value="MRS.">Mrs.</option>
                                                                  <option value="MS.">Ms.</option>
                                                               </select>
                                                            </td>
                                                            <td class="itemsAlign">
                                                               <label for="fname" class="displayItems">First Name*</label>
                                                               <input type="text" name="fname" placeholder="Your First Name" id="firstName" required>
                                                            </td>
                                                            <td class="itemsAlign">
                                                               <label for="lname" class="displayItems">Last Name*</label>
                                                               <input type="text" name="lname" placeholder="Your Last Name" id="lastName" required>
                                                            </td>
                                                         </tr>
                                                         <!-- Second Input -->
                                                         <tr class="rowAlign2">
                                                            <td class="itemsAlign">
                                                               <label for="gender" class="displayItems">Gender*</label>
                                                               <select name="gender" id="gender" required>
                                                                  <option value selected="selected"></option>
                                                                  <option value="Male">Male</option>
                                                                  <option value="Female">Female</option>
                                                               </select>
                                                            </td>
                                                            <td class="itemsAlign">
                                                               <label for="dob" class="displayItems">Date Of Birth*:</label>
                                                               <input type="date" id="dob" name="dob" required>
                                                            </td>
                                                         </tr>
                                                         <tr class="rowAlign">
                                                            <td class="itemsAlign">
                                                               <label for="profile" class="displayItems">Upload Photo*</label>
                                                               <input type="file" id="profile" name="profile" required>
                                                            </td>
                                                         </tr>
                                                         <!-- Heading2 -->
                                                         <tr>
                                                            <td colspan="3" class="details text-center">
                                                               <h5 class="personal w-100 d-flex py-1">Contact Details</h5>
                                                            </td>
                                                         </tr>
                                                         <!-- Fourth Input -->
                                                         <tr class="rowAlign">
                                                            <td class="itemsAlign">
                                                               <label for="address" class="displayItems">Address*</label>
                                                               <input type="text" name="address" id="address" required>
                                                            </td>
                                                            <td class="itemsAlign">
                                                               <label for="street" class="displayItems">Street*</label>
                                                               <input type="text" name="street" id="street" required>
                                                            </td>
                                                         </tr>
                                                         <!-- Fifth Input -->
                                                         <tr class="rowAlign">
                                                            <td class="itemsAlign">
                                                               <label for="phoneNumber" class="displayItems">Phone Number*</label>
                                                               <input type="text" name="phoneNumber" id="phoneNumber" required>
                                                            </td>
                                                            <td class="itemsAlign">
                                                               <label for="email" class="displayItems">Email*</label>
                                                               <input type="email" name="email" id="email" class="emailCont" required>
                                                            </td>
                                                         </tr>
                                                         <!-- Sixth Input -->
                                                         <tr class="rowAlign">
                                                            <td class="itemsAlign">
                                                               <label for="pincode" class="displayItems">Pincode*</label>
                                                               <input type="text" name="pincode" id="pincode" required>
                                                            </td>
                                                         </tr>
                                                         <!-- Roles -->
                                                         <tr class="rowAlign">
                                                            <td colspan="3" class="itemsAlign">
                                                               <label for="roles" class="displayItems" >Roles</label>
                                                               <select class="rolesSet" id="rolesSet" name="roles" multiple>
                                                               </select> 
                                                            </td>
                                                         </tr>
                                                      </tbody>
                                                   </table>
                                                   <span id="errorMsg" class="errorTxt"></span>
                                                   <div class="footer col-8 py-3 gap-3">
                                                      <button type="button" class="btn btn-primary" id="dataCreating">Submit</button>
                                                      <button type="button" class="btn btn-secondary" id="formClose" data-bs-dismiss="modal" aria-bs-label="Close" onclick="myFunction()">Close</button>
                                                   </div>
                                                </form>
                                             </div>
                                          </div>
                                       </div>
                                       <div class="secondMain col-4">
                                          <div class="dummyImg">
                                             <img id="listImage" src="../assets/bodyBook.png" alt="image" class="editImg">
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <!---Excel Modal--->
                        <div class="excelModal">
                           <button type="button" id="uploadTemplate" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="##exampleModalCenter" >
                              Upload Excel
                           </button>
                           <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                              <div class="modal-dialog modal-dialog-centered" role="document">
                                 <div class="modal-content">
                                    <div class="modal-body">
                                       <div class="heading">
                                          <h4 class="head py-2 text-center">Upload Excel</h4>
                                       </div>
                                       <form id="uploadForm" action="" method="post" enctype="multipart/form-data">
                                          <input type="file" name="excelFile" id="excelFile" required>
                                          <div class="modal-footer">
                                             <button type="submit" class="btn btn-primary" id="uploadAddress">Upload</button>
                                             <button type="button" class="btn btn-secondary" id="formClose" data-bs-dismiss="modal" aria-bs-label="Close" onclick="myFunction()">Close</button>
                                          </div>
                                       </form>
                                       <div class="addfile py-2">
                                          <a href="listExcel.cfm"><button type="button" class="btn btn-primary">Template with Data</button></a>
                                          <a href="emptyexcel.cfm"><button type="button" class="btn btn-primary" >Plain Template</button></a>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="bodyThd" id="printableDiv">
                     <div class="tableStyle d-flex align-items-center justify-content-center" >
                        <table class="table table-hover" >
                           <thead class="col-12">
                              <tr class="col-12">
                                 <th class="titleValues"  scope="col-3">
                                    <h6><b></b></h6>
                                 </th>
                                 <th class="titleValues" scope="col-3">
                                    <h6><b>NAME</b></h6>
                                 </th>
                                 <th class="titleValues" scope="col">
                                    <h6><b>EMAIL ID</b></h6>
                                 </th>
                                 <th class="titleValues" scope="col">
                                    <h6><b>MOBILE NUMBER</b></h6>
                                 </th>
                                 <th class="titleValues" scope="col">
                                    <h6><b></b></h6>
                                 </th>
                                 <th class="titleValues" scope="col">
                                    <h6><b></b></h6>
                                 </th>
                                 <th class="titleValues" scope="col">
                                    <h6><b></b></h6>
                                 </th>
                              </tr>
                           </thead>
                           <tbody>
                              <cfset variables.contacts = EntityLoad("ORM_Create_Contact",{userID=session.userID})>
                              <cfloop array="#variables.contacts#" index="contact">
                                 <tr>
                                    <td><img src="../assets/#contact.getprofilePic()#" class="profilePhoto" alt="profile"></td>
                                    <td class="nameList">#contact.getfirstName()# #contact.getlarstName()#</td>
                                    <td class="emailList">#contact.getemailID()#</td>
                                    <td class="phoneList">#contact.getphoneNumber()#</td>
                                    <td><button type="submit" class="btn btn-primary editBtn" data-bs-toggle="modal" data-bs-target="##exampleModal" data-id="#contact.getContactId()#">Edit</button></td>
                                    <td><button type="submit" class="btn btn-primary delete"  data-id="#contact.getContactId()#">Delete</button></td>
                                    <td><button type="button" class="btn btn-primary view" data-bs-toggle="modal" data-bs-target="##exampleModal2"  data-id="#contact.getContactId()#">View</button></td>
                                    <!--View Modal -->
                                    <div class="modal bd-example-modal-lg fade" id="exampleModal2" tabindex="-1"  aria-hidden="true">
                                       <div class="modal-dialog modal-lg p-1">
                                          <div class="wholeSection d-flex">
                                             <div class="modalContent bg-white col-9">
                                                <div class="heading d-flex justify-content-center col-9">
                                                   <h3 class="creating px-4">CONTACT DETAILS</h3>
                                                </div>
                                                <div class="displayItems d-flex align-items-baseline px-5 py-3">
                                                   <div class="displayDetails d-flex flex-column col-12">
                                                      <div class="nameSet d-flex">
                                                         <p class="set col-3">Name:</p>
                                                         <p class="name" id="fullName"></p>
                                                      </div>
                                                      <div class="genderSet d-flex">
                                                         <p class="set col-3">Gender:</p>
                                                         <p class="gender" id="genders"></p>
                                                      </div>
                                                      <div class="dobSet d-flex">
                                                         <p class="set col-3">Date of Birth:</p>
                                                         <p class="date" id="dobSecond"></p>
                                                      </div>
                                                      <div class="addressSet d-flex">
                                                         <p class="set col-3">Full Address:</p>
                                                         <p class="address" id="addressSecond"></p>
                                                      </div>
                                                      <div class="phoneSet d-flex">
                                                         <p class="set col-3">Phone Number:</p>
                                                         <p class="phone" id="phoneNumberSecond"></p>
                                                      </div>
                                                      <div class="emailSet d-flex">
                                                         <p class="set col-3">Email:</p>
                                                         <p class="email" id="emailid"></p>
                                                      </div>
                                                      <div class="pincodeSet d-flex">
                                                         <p class="set col-3">Pincode:</p>
                                                         <p class="pin" id="pincodeSecond"></p>
                                                      </div>
                                                      <div class="roleSet d-flex">
                                                         <p class="set col-3">Roles:</p>
                                                         <p class="role" id="rolesDatas"></p>
                                                      </div>
                                                   </div>
                                                </div>
                                                <div class="footerSet py-3 d-flex justify-content-center">
                                                   <button type="button" class="btn btn-primary" id="closeBtn"  data-bs-dismiss="modal" aria-bs-label="Close" onclick="myFunction()">Close</button>
                                                </div>
                                             </div>
                                             <div class="imgSetContss col-3">
                                                <div class="placeImg">
                                                   <img id="myImage" src="" alt="image" class="editImg">
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </tr>
                              </cfloop>
                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      <cfelse>
         <cflocation  url="loginPage.cfm">
      </cfif>
   </body>
   </html>
</cfoutput>