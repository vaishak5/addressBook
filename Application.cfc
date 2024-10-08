component output="false"
{
    this.applicationTimeout = createTimeSpan(0, 0, 0, 60);
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 2, 0, 0);
    this.datasource = "DESKTOP-8VHOQ47";
    this.ormEnabled = true; 
    public boolean function onSessionStart() {
        session.login = false;
        session.userID = "";
        session.fullName = "";
        session.imgFile = "";
        session.imgProfile="";
        session.sso=false;
        return true;
    }
    public boolean function onRequestStart() {
        this.ormSettings = {
        dbcreate = "update", 
        logsql = true 
        };
        ormReload();
        return true;
    }
}
