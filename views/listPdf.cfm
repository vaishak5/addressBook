
<cfoutput>
<cfif session.login>
        <cfhtmltopdf>
            <div class="displayPdfDatas d-flex" id="pdfSet">
                <div class="col-12">
                    <table class="tableSet">
                        <thead>
                            <tr>
                                <th class="titleValues" scope="col-3">
                                    <h5><b>IMAGE</b></h5>
                                 </th>
                               <th class="titleValues" scope="col-3">
                                    <h5><b>NAME</b></h5>
                                 </th>
                                <th class="titleValues" scope="col-3">
                                    <h5><b>EMAIL ID</b></h5>
                                 </th>
                                <th class="titleValues" scope="col-3">
                                    <h5><b>PHONE NUMBER</b></h5>
                                 </th>
                               <th class="titleValues" scope="col-3">
                                    <h5><b>GENDER</b></h5>
                                 </th>
                                <th class="titleValues" scope="col-4">
                                    <h5><b>DOB</b></h5>
                                 </th>
                                <th class="titleValues" scope="col-3">
                                    <h5><b>ADDRESS</b></h5>
                                 </th>
                                <th class="titleValues" scope="col-3">
                                    <h5><b>PINCODE</b></h5>
                                 </th>
                                 <th class="titleValues" scope="col-3">
                                    <h5><b>HOBBIES</b></h5>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfset rolesList = "">
                            <cfset contacts = EntityLoad("ORM_CREATE_CONTACT",{userID=session.userID})>
                            <cfloop array="#contacts#" index="contact">
                                <cfquery name="selectAddress" datasource="DESKTOP-8VHOQ47">
                                    SELECT * FROM contactDetails
                                    WHERE contactId = <cfqueryparam value="#contact.getcontactId()#" cfsqltype="cf_sql_integer">
                                </cfquery>
                                <cfquery name="selectroles" datasource="DESKTOP-8VHOQ47">
                                    SELECT r.rolesList 
                                    FROM roleList AS rl
                                    INNER JOIN roles AS r ON rl.roleid = r.roleid
                                    WHERE rl.contactId = <cfqueryparam value="#contact.getcontactId()#" cfsqltype="cf_sql_integer">
                                </cfquery>
                                <cfset local.rolesArray = []>
                                <cfloop query="selectroles">
                                    <cfset arrayAppend(local.rolesArray, "#rolesList#")>
                                </cfloop>
                                <cfset rolesList = arrayToList(local.rolesArray)>
                                <tr class="tableRow">
                                    <td><img src="../assets/#contact.getprofilePic()#" class="profilePhoto" alt="profile" width="20" height="20"></td>
                                    <td class="">#contact.getfirstName()# #contact.getlarstName()#</td>
                                    <td class="">#contact.getemailID()#</td>
                                    <td class="">#contact.getphoneNumber()#</td>
                                    <td class="">#contact.getgender()#</td>
                                    <td class="">#contact.getdob()#</td>
                                    <td class="">#contact.getaddressField()#,#contact.getstreet()#</td>
                                    <td class="">#contact.getpincode()#</td>
                                    <td class="">#rolesList#</td>
                                </tr>
                                <cfset rolesList = "">
                            </cfloop> 
                        </tbody>
                    </table>
                </div>
            </div>
            <cfheader name="Content-Disposition" value="attachment; filename=list.pdf">
            <cfheader name="Content-Type" value="application/pdf">
        </cfhtmltopdf>
    </cfif>
</cfoutput>