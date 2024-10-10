<cfcomponent>
    <!---Email Checking --->
    <cffunction name="isEmailUnique" access="remote" returnFormat="plain">
        <cfargument name="emailId" required="true">
        <cfargument  name="id" required="false">
        <cfset var emailExists = false>
        <!--- JOIN BOTH THE TABLES --->
        <cfif arguments.id gt 0> <!---For edit--->
            <cfquery name="checkEmail" datasource="DESKTOP-8VHOQ47">
                SELECT COUNT(*) AS EmailCount
                FROM (
                    SELECT emailId FROM register WHERE emailId = <cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">
                    UNION ALL
                    SELECT emailID FROM contactDetails WHERE emailID = <cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">
                    AND contactId NOT IN (<cfqueryparam value="#arguments.id#" cfsqltype="CF_SQL_INTEGER">)
                ) AS CombinedResults
            </cfquery>
            <cfif checkEmail.EmailCount GT 0>
                <cfset emailExists = true>
            </cfif>
            <cfreturn emailExists>
        <cfelseif arguments.id eq 0> <!---For Add--->
            <cfquery name="checkEmail" datasource="DESKTOP-8VHOQ47">
                SELECT COUNT(*) AS EmailCount
                FROM (
                    SELECT emailId FROM register WHERE emailId = <cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">
                    UNION ALL
                    SELECT emailID FROM contactDetails WHERE emailID = <cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">
                ) AS CombinedResults
            </cfquery>
            <cfif checkEmail.EmailCount GT 0>
                <cfset emailExists = true>
            </cfif>
            <cfreturn emailExists>
        </cfif>
    </cffunction> 
    
    <!---Sign Up--->
    <cffunction name="signUpload" access="remote" returnFormat="plain">
        <cfargument  name="fullName" required="true">
        <cfargument  name="emailId" required="true">
        <cfargument  name="userName" required="true">
        <cfargument  name="password" required="true">
        <cfargument  name="myfile" required="true">
        <cfset local.imgPath = ExpandPath("../assets/")>
        <cfset local.img = "">
        <cffile action = "upload"  filefield="myfile" destination="#local.imgPath#" nameconflict="makeunique" >
        <cfset local.img =  cffile.serverFile>
        <cfset local.hashedPassword = Hash(arguments.password, "SHA-256")>
       <cfquery name="checEmail" datasource="DESKTOP-8VHOQ47">
            select emailId from register
            WHERE emailId = <cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">
       </cfquery>
       <cfif checEmail.RecordCount>
            <cfreturn "false">
        <cfelse>
            <cfquery name="insertValues"  datasource="DESKTOP-8VHOQ47">
                INSERT INTO register (fullName,  emailId, password, imgFile, userName)
                VALUES (
                    <cfqueryparam value="#arguments.fullName#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#local.hashedPassword#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#local.img#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#arguments.userName#" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfquery>  
            <cfreturn "true">
        </cfif>
    </cffunction> 

    <!---LOG IN--->
    <cffunction name="checkLogin" access="remote" returnFormat="plain">
        <cfargument name="emailId" required="true">
        <cfargument name="password" required="true">
        <cfset local.hashPassword=Hash(arguments.password,"SHA-256")>
        <cfquery name="checkuserId" datasource="DESKTOP-8VHOQ47">
            SELECT userId,fullName,imgFile FROM register
            WHERE emailId=<cfqueryparam value="#arguments.emailId#" cfsqltype="CF_SQL_VARCHAR">
            AND password=<cfqueryparam value="#local.hashPassword#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif checkuserId.recordCount>
            <cfset session.userId=checkuserId.userId>
            <cfset session.fullName=checkuserId.fullName>
            <cfset session.imgFile = checkuserId.imgFile>
            <cfset session.login=true>
            <cfset session.sso=false>
            <cfreturn "true">
        <cfelse>
            <cfset session.login=false>
            <cfreturn "false">
        </cfif>
    </cffunction>

    <!---Adding new datas to the field--->
    <cffunction name="dataUpload" access="remote" returnFormat="plain">
        <cfargument name="hiddenContactId" required="true"> 
        <cfargument name="title" required="true"> 
        <cfargument name="firstName" required="true">
        <cfargument name="lastName" required="true">
        <cfargument name="gender" required="true">
        <cfargument name="dob" required="true">
        <cfargument name="address" required="true">
        <cfargument name="street" required="true">
        <cfargument name="phoneNumber" required="true">
        <cfargument name="email" required="true">
        <cfargument name="pincode" required="true">
        <cfargument name="rolesSet"> 
        <cfset var emailUnique = isEmailUnique(arguments.email,arguments.hiddenContactId)>
        <cfif arguments.hiddenContactId GT 0>
            <!---Update records(edit set)--->
            <cfif not emailUnique>
                <cfset local.imgPath = ExpandPath("../assets/")>
                <cfset local.img = "">
                <cffile action="upload" filefield="profile" destination="#local.imgPath#" nameconflict="makeunique">
                <cfset local.img =  cffile.serverFile>
                <cfquery name="selectInputs" datasource="DESKTOP-8VHOQ47" result ="editDatassResult">
                    UPDATE contactDetails 
                    SET firstName=<cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
                    larstName=<cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
                    gender=<cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
                    dob=<cfqueryparam value="#arguments.dob#" cfsqltype="cf_sql_varchar">,
                    addressField=<cfqueryparam value="#arguments.address#" cfsqltype="cf_sql_varchar">,
                    street=<cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                    phoneNumber=<cfqueryparam value="#arguments.phoneNumber#" cfsqltype="cf_sql_varchar">,
                    emailID=<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                    pincode=<cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_varchar">,
                    profilePic=<cfqueryparam value="#local.img#" cfsqltype="CF_SQL_VARCHAR">
                    WHERE contactId = <cfqueryparam value="#arguments.hiddenContactId#" cfsqltype="cf_sql_integer">
                </cfquery>
                 <!--- Update roles directly --->
                <cfset local.rolesArray = listToArray(arguments.rolesSet)>
                <cfquery name="deleteroles" datasource="DESKTOP-8VHOQ47">
                    delete from roleList WHERE contactId = <cfqueryparam value="#arguments.hiddenContactId#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfloop array="#local.rolesArray#" index="roles">
                    <cfquery name="addroles" datasource="DESKTOP-8VHOQ47">
                        INSERT INTO roleList (contactId, roleid)
                        VALUES (
                            <cfqueryparam value="#arguments.hiddenContactId#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#roles#" cfsqltype="cf_sql_integer">
                        )
                    </cfquery>
                </cfloop>
                <cfreturn true>
                <cfelse>
                    <cfreturn false>
            </cfif>
        <cfelse>   
            <!--- Insert new record --->
            <cfif not emailUnique>
                <cfset local.imgPath = ExpandPath("../assets/")>
                <cfset local.img = "">
                <cffile action="upload" filefield="profile" destination="#local.imgPath#" nameconflict="makeunique">
                <cfset local.img = cffile.serverFile>
                <cfquery name="insertQuery" datasource="DESKTOP-8VHOQ47" result="newContactResult">
                    INSERT INTO contactDetails (title, firstName, larstName, gender, dob, profilePic, addressField, street, phoneNumber, emailID, pincode, userId)
                    VALUES (
                        <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.dob#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#local.img#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.address#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.phoneNumber#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <!---select emailid,userid for inserting  roles--->
                <cfquery name="selectNewContact" datasource="DESKTOP-8VHOQ47">
                    SELECT * FROM contactDetails 
                    WHERE emailID = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar"> 
                    AND userId = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
                </cfquery>
                
                <!--- Insert roles --->
                <cfset local.rolesArray = listToArray(arguments.rolesSet)>
                <cfloop array="#local.rolesArray#" index="setroles">
                    <cfquery name="addroles" datasource="DESKTOP-8VHOQ47">
                        INSERT INTO roleList (contactId, roleid)
                        VALUES (
                            <cfqueryparam value="#selectNewContact.contactId#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#setroles#" cfsqltype="cf_sql_integer">
                        )
                    </cfquery>
                </cfloop>
            
                <cfreturn true>
            <cfelse>
                <cfreturn false>
            </cfif>
        </cfif>
    </cffunction> 

    <!---Deleting Particular Row--->
    <cffunction name="deleteDatas" access="remote" returnFormat="plain">
        <cfargument name="contactId" required="true">
        <cfquery name="deleteQuery" datasource="DESKTOP-8VHOQ47">
            SELECT contactId FROM contactDetails 
            WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif deleteQuery.recordCount>
            <cfquery name="deleteItems" datasource="DESKTOP-8VHOQ47">
                delete from contactDetails
                WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
            <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>

    <!---Viewing Particular Row(View Datas)--->
    <cffunction name="viewDatas" access="remote" returnformat="plain">
        <cfargument name="contactId" type="numeric" required="true">
        <cfquery name="contactSet" datasource="DESKTOP-8VHOQ47">
            SELECT contactId,title,firstName,larstName,gender,dob,profilePic,addressField,street,phoneNumber,emailID,pincode
            FROM contactDetails
            WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset local.contact = {}>
        <cfif contactSet.recordCount GT 0>
            <cfset local.contact.fullName = contactSet.title & " " & contactSet.firstName & " " & contactSet.larstName>
            <cfset local.contact.gender = contactSet.gender>
            <cfset local.contact.dob = contactSet.dob>
            <cfset local.contact.fullAddress = contactSet.addressField & ","&contactSet.street>
            <cfset local.contact.phoneNumber=contactSet.phoneNumber>
            <cfset local.contact.email=contactSet.emailID>
            <cfset local.contact.pincode=contactSet.pincode>
            <cfset local.contact.profilePic=contactSet.profilePic>
            <cfquery name="selectAddress" datasource="DESKTOP-8VHOQ47">
                SELECT * FROM contactDetails
                WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
            </cfquery>
             <cfquery name="selectroles" datasource="DESKTOP-8VHOQ47">
                SELECT r.rolesList 
                    FROM roles AS r
                    INNER JOIN roleList AS rl ON rl.roleid = r.roleid
                    WHERE rl.contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfset local.rolesArray = []>
            <cfloop query="selectroles">
                <cfset arrayAppend(local.rolesArray, selectroles.rolesList)>
            </cfloop>
            <cfset local.contact.roles = local.rolesArray>
        </cfif>
        <cfset serializedContact = serializeJSON(local.contact)>
        <cfreturn serializedContact>
    </cffunction>

    <!---Edit Datas--->
    <cffunction name="selectDatas" access="remote" returnformat="PLAIN">
        <cfargument name="contactId" required="true">
        <cfquery name="selectInputs" datasource="DESKTOP-8VHOQ47">
            SELECT contactId,title,firstName,larstName,gender,dob,profilePic,addressField,street,phoneNumber,emailID,pincode
            FROM contactDetails 
            WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset  local.result = {}>
        <cfif selectInputs.recordCount>
            <cfset local.result['contactId'] = selectInputs.contactId>
            <cfset local.result['title'] = selectInputs.title>
            <cfset local.result['firstName'] = selectInputs.firstName>
            <cfset local.result['lastName'] = selectInputs.larstName> 
            <cfset local.result['gender'] = selectInputs.gender>
            <cfset local.result["dob"] = selectInputs.dob>
            <cfset local.result['address'] = selectInputs.addressField>
            <cfset local.result['street']= selectInputs.street>
            <cfset local.result['phoneNumber']= selectInputs.phoneNumber>
            <cfset local.result['email']=selectInputs.emailID>
            <cfset local.result['pincode']=selectInputs.pincode>
            <cfset local.result['myFile'] = selectInputs.profilePic>
            <!---Update roles--->
            <cfquery name="selectroles" datasource="DESKTOP-8VHOQ47">
                SELECT roleid 
                FROM roleList 
                WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfset local.rolesArray = []>
            <cfloop query="selectroles">
                <cfset arrayAppend(local.rolesArray, selectroles.roleid)>
            </cfloop>
            <cfset local.result['rolesSet'] = local.rolesArray>
        </cfif>
        <cfset serializedContact = serializeJSON(local.result)>
        <cfreturn serializedContact>
    </cffunction>
    <!---Log out--->
    <cffunction  name="doLogout" returntype="any" access="remote">
        <cfset session.login=false>
        <cfset session.fullName = "">
        <cfset session.imgProfile = "">
        <cfset session.userId = "">
        <cfset session.sso=false>
        <cflocation url="../loginPage.cfm" addtoken="false">
    </cffunction>

    <!---SSO--->
    <cffunction name="googleLogin" access="remote" returnFormat="PLAIN">
        <cfargument name="emailID" required="true">
        <cfargument name="name" required="true">
        <cfargument name="image" required="true">
        <cfset var result = createObject("component", "addressBook") >
        <cfset var ssoLogin = {} >
        <cfset var saveSSO = {} >
        <cfset var response = "">
        <cfset ssoLogin = result.ssoLogin(arguments.emailID, arguments.name, arguments.image) ><!--- Check if user already exists in Google login --->
        <cfif ssoLogin.recordCount>
            <cfset session.login = true>             
            <cfset session.sso = true>
            <cfset session.fullName = ssoLogin.fullName>
            <cfset session.imgProfile = ssoLogin.imgFile>
            <cfset session.userId = ssoLogin.userId>
            <cfset response = true>
        <cfelse>
            <cfset saveSSO = result.saveSSO(arguments.emailID, arguments.name, arguments.image)> <!--- Save user in SSO --->
            <cfif saveSSO>
                <cfset ssoLogin = result.ssoLogin(arguments.emailID)>
                <cfif ssoLogin.recordCount>
                    <cfset session.login = true>
                    <cfset session.sso = true> 
                    <cfset session.fullName = ssoLogin.fullName>
                    <cfset session.imgProfile = ssoLogin.imgFile>
                    <cfset session.userId = ssoLogin.userId>
                </cfif>
                <cfset response = true>
            </cfif>
        </cfif>
        <cfreturn response >
    </cffunction>
    <!---SSO Items--->
    <cffunction name="ssoLogin" access="remote" returnformat="plain">
        <cfargument name="emailID" required="true">
        <cfquery name="checkSSOLogin" datasource="DESKTOP-8VHOQ47">
            SELECT userId, fullName, emailId, imgFile
            FROM register
            WHERE emailId = <cfqueryparam value="#arguments.emailID#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn checkSSOLogin >
    </cffunction>
    <!---Save SSO Items--->
    <cffunction  name="saveSSO" access="remote"  returnformat="Plain">
        <cfargument name = "emailID" required="true">
        <cfargument name = "name" required="true">
        <cfargument name = "image" required="true">
        <cfquery name="saveSSO" datasource="DESKTOP-8VHOQ47">
            INSERT INTO register (fullName,emailId,imgFile)
            values(
                <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.emailID#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.image#" cfsqltype="cf_sql_varchar">
            ) 
        </cfquery>
        <cfreturn true>
    </cffunction>

    <!---Upload Excel--->
    <cffunction name="uploadExcelDatas" access="remote" returnformat="JSON">
        <cfargument name="excelFile" type="any" required="true">
        <cfargument name="hiddenContactId" type="any" > 
        <cfargument name="emailID" type="any"> 
        <cfset var local = {}>
        <cfset local.response = []>
        <cfset local.excelUpload = expandPath("../Uploads/")>
        <cffile action="upload" fileField="excelFile" destination="#local.excelUpload#" nameConflict="makeunique">
        <cfset local.uploadedFile = cffile.serverFile>
        <cfset local.filePath = "#local.excelUpload##local.uploadedFile#">
        <cfspreadsheet action="read" src="#local.filePath#" query="local.excelValues" sheet="1">
        <cfset local.mapping = {
            title: "col_1",
            firstName: "col_2",
            lastName: "col_3",   
            gender: "col_4",
            dob: "col_5",
            profilePic: "col_6",
            addressField: "col_7",
            street: "col_8",
            phoneNumber: "col_10",
            emailID: "col_9",
            pincode: "col_11",
            roles:"col_12"
        }>
        <cfset local.totalInserted = 0>
        <cfset local.totalUpdated = 0>
        <cfloop query="local.excelValues" startRow=2>
            <cfset local.email = local.excelValues[local.mapping.emailID]>
            <cfquery name='checkExcelEmail' datasource="DESKTOP-8VHOQ47">
                SELECT emailID,contactId FROM contactDetails
                WHERE emailID = <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">
                and userId=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_varchar">
            </cfquery>
            <cfset local.recordData = {
                title: local.excelValues[local.mapping.title],
                firstName: local.excelValues[local.mapping.firstName],
                lastName: local.excelValues[local.mapping.lastName], 
                gender: local.excelValues[local.mapping.gender],
                dob: local.excelValues[local.mapping.dob],
                profilePic: local.excelValues[local.mapping.profilePic],
                addressField: local.excelValues[local.mapping.addressField],
                street: local.excelValues[local.mapping.street],
                phoneNumber: local.excelValues[local.mapping.phoneNumber],
                emailID: local.excelValues[local.mapping.emailID],
                pincode: local.excelValues[local.mapping.pincode],
                roles: local.excelValues[local.mapping.roles]
            }>
            <cfif checkExcelEmail.recordCount gt 0>
                <cfset local.contactId = checkExcelEmail.contactId>
                <cfquery name="UpdateExcel" datasource="DESKTOP-8VHOQ47">
                    UPDATE contactDetails 
                    SET 
                        title = <cfqueryparam value="#(local.recordData.title)#" cfsqltype="cf_sql_varchar">,
                        firstName = <cfqueryparam value="#(local.recordData.firstName)#" cfsqltype="cf_sql_varchar">,
                        larstName = <cfqueryparam value="#(local.recordData.lastName)#" cfsqltype="cf_sql_varchar">,
                        gender = <cfqueryparam value="#(local.recordData.gender)#" cfsqltype="cf_sql_varchar">,
                        dob = <cfqueryparam value="#(local.recordData.dob)#" cfsqltype="cf_sql_varchar">,
                        addressField = <cfqueryparam value="#(local.recordData.addressField)#" cfsqltype="cf_sql_varchar">,
                        street = <cfqueryparam value="#(local.recordData.street)#" cfsqltype="cf_sql_varchar">,
                        phoneNumber = <cfqueryparam value="#(local.recordData.phoneNumber)#" cfsqltype="cf_sql_varchar">,
                        pincode = <cfqueryparam value="#(local.recordData.pincode)#" cfsqltype="cf_sql_varchar">
                    WHERE emailID = <cfqueryparam value="#(local.recordData.emailID)#" cfsqltype="cf_sql_varchar">
                    and userId=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <cfset local.rolesArray = listToArray(local.recordData.roles)>
                <cfquery name="selectNewContact" datasource="DESKTOP-8VHOQ47">
                    SELECT * FROM contactDetails 
                    WHERE emailID = <cfqueryparam value="#local.recordData.emailID#" cfsqltype="cf_sql_varchar"> 
                    AND userId = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <cfquery name="deleteroles" datasource="DESKTOP-8VHOQ47">
                    DELETE FROM roleList WHERE contactId = <cfqueryparam value="#local.contactId#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfloop array="#local.rolesArray#" index="rolesSet">
                    <cfset local.roleId = "">
                    <cfquery name="getRoleId" datasource="DESKTOP-8VHOQ47">
                        SELECT roleid FROM roles 
                        WHERE rolesList = <cfqueryparam value="#rolesSet#" cfsqltype="cf_sql_varchar">
                    </cfquery>
    
                    <cfif getRoleId.recordCount NEQ 0>
                        <cfset local.roleId = getRoleId.roleId>
                        <cfquery name="insertRoleId" datasource="DESKTOP-8VHOQ47">
                            INSERT INTO roleList(contactId, roleid)
                            VALUES(
                                <cfqueryparam value="#selectNewContact.contactId#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.roleId#" cfsqltype="cf_sql_varchar">
                                
                            )
                        </cfquery>
                    </cfif>
                </cfloop>
                <cfset local.totalUpdated = local.totalUpdated + 1>
            <cfelse>
                <cfquery name="insertQuery" datasource="DESKTOP-8VHOQ47">
                    INSERT INTO contactDetails (title, firstName, larstName, gender, dob, profilePic, addressField, street, phoneNumber, emailID, pincode, userId)
                    VALUES (
                        <cfqueryparam value="#(local.recordData.title)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.firstName)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.lastName)#" cfsqltype="cf_sql_varchar">,  
                        <cfqueryparam value="#(local.recordData.gender)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.dob)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.profilePic)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.addressField)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.street)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.phoneNumber)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.emailID)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#(local.recordData.pincode)#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_varchar">
                        
                    )
                </cfquery>
                <!---select emailid,userid for insert roles--->
                <cfset local.rolesArray = listToArray(local.recordData.roles)>
                <cfquery name="selectNewContact" datasource="DESKTOP-8VHOQ47">
                    SELECT * FROM contactDetails 
                    WHERE emailID = <cfqueryparam value="#local.recordData.emailID#" cfsqltype="cf_sql_varchar"> 
                    AND userId = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <!---Insert roles--->
                <cfloop array="#local.rolesArray#" index="rolesSet">
                    <cfset local.roleId = "">
                    <cfquery name="getRoleId" datasource="DESKTOP-8VHOQ47">
                        SELECT roleid FROM roles 
                        WHERE rolesList = <cfqueryparam value="#rolesSet#" cfsqltype="cf_sql_varchar">
                    </cfquery>
    
                    <cfif getRoleId.recordCount NEQ 0>
                        <cfset local.roleId = getRoleId.roleId>
                        <cfquery name="insertRoleId" datasource="DESKTOP-8VHOQ47">
                            INSERT INTO roleList(contactId, roleid)
                            VALUES(
                                <cfqueryparam value="#selectNewContact.contactId#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.roleId#" cfsqltype="cf_sql_varchar">
                                
                            )
                        </cfquery>
                    </cfif>
                </cfloop>

                <cfset local.totalInserted = local.totalInserted + 1>
            </cfif>
        </cfloop>
        <!--- Check whether the records are inserted or updated --->
        <cfif local.totalInserted gt 0 AND local.totalUpdated gt 0>
            <cfset local.response= {"success": true, "message": "Excel Updated and Inserted."}>
        <cfelseif local.totalInserted gt 0>
            <cfset local.response = {"success": true, "message": "Excel Uploaded Successfully with new records."}>
        <cfelseif local.totalUpdated gt 0>
            <cfset local.response = {"success": true, "message":  "Already Excel Uploaded  so plz update the records."}>
        </cfif>
        <cfset local.result  = serializeJSON(local.response)>
        <cfreturn local.result>
    </cffunction> 

    <!---Set Roles in the input field--->
    <cffunction name="getRoles" access="remote" returnFormat="json">
        <cfquery name="rolesTable" datasource="DESKTOP-8VHOQ47">
            SELECT roleid, rolesList
            FROM roles
        </cfquery>
        <cfset values = []>
        <cfloop query="rolesTable">
            <cfset arrayAppend(values, '<option value="#rolesTable.roleid#">#rolesTable.rolesList#</option>')>
        </cfloop>
        <cfreturn serializeJSON(arrayToList(values))>
    </cffunction>
</cfcomponent>