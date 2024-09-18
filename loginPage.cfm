<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="./style/style.css">
    <link rel="stylesheet" href="./style/jquery-ui.css">
    <script src="./script/sourceFirst.js"></script>
    <script src="./script/sourceSecond.js"></script>
    <script src="./script/sourceThird.js"></script>
    <script src="./script/jquery.min.js"></script>
    <script src="./script/jquery-ui.min.js"></script>
    <script src="./script/validation.js"></script>
</head>
<body>
    <cfif session.login>
        <cflocation url="listPage.cfm">
    <cfelse>
        <div class="navbar">
            <div class="navbarFt">
                <img class="addressLogo" src="./assets/bodyBook.png" alt="img" width="30" height="30">
                <h2>ADDRESS BOOK</h2>
            </div>
            <div class="navbarSnd">
                <img class="signupLogo" src="./assets/contactLogo1.png" alt="img" width="20" height="20">
                <a href="signupPage.cfm">SignUp</a>
                <img class="loginLogo" src="./assets/login.png" alt="img" width="20" height="20">
                <a href="loginPage.cfm">Login</a>
            </div>
        </div>
        <div class="main">
            <div class="mainSection">
                <div class="mainBodyFt">
                    <img class="addressLogoImg" src="./assets/bodyBook.png" alt="img" width="75" height="75">
                </div>
                <div class="mainBodySnd">
                    <h1>LOGIN</h1>
                    <div class="mainBodySndCont">
                        <form class="inputConts">
                            <input type="email" class="inputs" placeholder="USER NAME" id="email">
                            <input type="password" class="inputs" placeholder="PASSWORD" id="password">
                        </form>
                        <div class="loginBtn">
                            <input type="button" class="submitBtnn" id="loginSubmit" value="Login">
                            <p class="singinTxt"> Or Sign In Using</p>
                        </div>
                        <div class="anotherAccess">
                            <img class="fb" src="./assets/fb.png" alt="img" width="40" height="40">
                            <img class="google" id="googleIcon" src="./assets/google1.png" alt="img" width="30" height="30" >
                        </div>
                        <div class="registerCont">
                            <p class="accountTxt">Don't have an account?</p>
                            <a href="signupPage.cfm" >Register Here</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfif>
</body>
</html>