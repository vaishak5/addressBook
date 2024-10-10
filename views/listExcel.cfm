<cfoutput>
    <cfif session.login>
        <cfset contacts = EntityLoad("ORM_CREATE_CONTACT",{userId=session.userID})>
        <cfset excelSet=queryNew("Title,FirstName,LastName,Gender,DateOfBirth,Profile,Address,Street,Email,PhoneNumber,Pincode,Roles","varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar")>
        <cfloop array="#contacts#" index="contact">
            <cfset local.title = contact.gettitle()>
            <cfset local.firstName = contact.getfirstName()>
            <cfset local.lastName =   contact.getlarstName()>
            <cfset local.gender = contact.getgender()>
            <cfset local.dob = contact.getdob()>
            <cfset local.profile = contact.getprofilePic()>
            <cfset local.address = contact.getaddressField()>
            <cfset local.street = contact.getstreet()>
            <cfset local.email = contact.getemailID()>
            <cfset local.phone = contact.getphoneNumber()>
            <cfset local.pincode = contact.getpincode()>
            <cfset local.rolesList = "">
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
                <cfset arrayAppend(local.rolesArray, selectroles.rolesList)>
            </cfloop>
            <cfset local.rolesList = arrayToList(local.rolesArray)>
            <cfset queryAddRow(excelSet ,1)>
            <cfset querySetCell(excelSet, "Title", local.title)>
            <cfset querySetCell(excelSet, "FirstName", local.firstName)>
            <cfset querySetCell(excelSet, "LastName", local.lastName)>
            <cfset querySetCell(excelSet, "Gender", local.gender)>
            <cfset querySetCell(excelSet, "DateOfBirth", local.dob)>
            <cfset querySetCell(excelSet, "Profile", local.profile)>
            <cfset querySetCell(excelSet, "Address", local.address)>
            <cfset querySetCell(excelSet, "Street",local.street)>
            <cfset querySetCell(excelSet, "Email", local.email)>
            <cfset querySetCell(excelSet, "PhoneNumber", local.phone)>
            <cfset querySetCell(excelSet, "Pincode", local.pincode)>
            <cfset querySetCell(excelSet,"Roles",local.rolesList)>
        </cfloop>
        <cfset excelDown=expandPath("../assets/contacts.xlsx")>
        <cfspreadsheet action="write" filename="#excelDown#" query="excelSet" sheetname="contacts">
        <cfheader name="Content-Disposition" value="attachment; filename=contacts.xlsx">
        <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelDown#" deleteFile="true">
    </cfif>
</cfoutput>