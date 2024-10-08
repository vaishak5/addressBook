<cffunction name="doLogout" returntype="any" access="remote">
    <cfset session.login = false>
    <cfset session.fullName = "">
    <cfset session.imgProfile = "">
    <cfset session.userId = "">
    <cfset session.sso = false>
    <cflocation url="../views/loginPage.cfm" addtoken="false"> 
</cffunction>