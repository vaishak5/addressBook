component persistent="true" table="roles" {
    property name="roleid" fieldtype="id" generator="identity";
    property name="rolesList";
     property name="ORM_Create_Contact" fieldtype="many-to-one" cfc="ORM_Create_Contact" fkcolumn="contactId";
}