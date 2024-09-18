<cfif structKeyExists(form, "excelFile")>
    <cfset local.filePath = expandPath("./Uploads/")>
    <cftry>
        <cffile action="upload" filefield="excelFile" destination="#local.filePath#" nameConflict="Overwrite">
        <cfset local.uploadedFile = local.filePath & cffile.serverFileName>
        <!--- Check if the file exists and read data --->
            <cfspreadsheet action="read" src="#local.uploadedFile#" query="excelData">
            <cfdump var="#excelData#" label="Excel Data">
            <!--- Loop through the Excel data and save to database --->
            <cfloop query="excelData">
                <cfset newContact = EntityNew("contactDetails")>
                <cfset newContact.setTitle(excelData.title)>
                <cfset newContact.setFirstName(excelData.firstName)>
                <cfset newContact.setLastName(excelData.larstName)>
                <cfset newContact.setGender(excelData.gender)>
                <cfset newContact.setDob(excelData.dob)>
                <cfset newContact.setProfilePic(excelData.profilePic)>
                <cfset newContact.setAddressField(excelData.addressField)>
                <cfset newContact.setStreet(excelData.street)>
                <cfset newContact.setPhoneNumber(excelData.phoneNumber)>
                <cfset newContact.setEmailID(excelData.emailID)>
                <cfset newContact.setPincode(excelData.pincode)>
                <cfset newContact.setUserId(session.userId)>
                <cfset EntitySave(newContact)>
            </cfloop>
        <cflocation url="listPage.cfm">
    <cfcatch type="any">
        <cfoutput>Error: #cfcatch.message#</cfoutput>
    </cfcatch>
    </cftry>
</cfif>
