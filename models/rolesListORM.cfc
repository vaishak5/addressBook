component persistent="true" table="roleList" {
    property name="ids" fieldtype="id" generator="identity";
    property name="contactId" fieldtype="many-to-one" cfc="ORM_Create_Contact" fkcolumn="contactId";
    property name="roleid"  cfc="rolesTableORM" fkcolumn="roleid";
}