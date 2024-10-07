<cfscript>
    component persistent="true" table="contactDetails" {
    property name="contactId" fieldtype="id" generator="identity";
    property name="title";
    property name="firstName";
    property name="larstName";
    property name="gender";
    property name="dob";
    property name="profilePic";
    property name="addressField";
    property name="street";
    property name="phoneNumber";
    property name="emailID";
    property name="pincode";
    property name="userId";
}
</cfscript>