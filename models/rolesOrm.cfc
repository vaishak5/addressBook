<cfscript>
    component persistent="true" table="rolesTable" {
        property name="roleid" fieldtype="id" generator="identity"; 
        property name="contactId"; 
        property name="roles"; 
    }
</cfscript>