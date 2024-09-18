<cfoutput>
        <cfset excelDown = expandPath("./assets/emptyTemplate.xlsx")>
        <cfset excelSet = queryNew("Title,FirstName,LastName,Gender,DateOfBirth,Profile,Address,Street,Email,PhoneNumber,Pincode", "varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar")>
        <cfspreadsheet action="update" filename="#excelDown#" query="excelSet" sheetname="TemplateFile">
        <cfheader name="Content-Disposition" value="attachment; filename=plainTemplate.xlsx">
        <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelDown#" deleteFile="true">
   
</cfoutput>
