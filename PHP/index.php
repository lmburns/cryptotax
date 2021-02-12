<html>


    
<?php
session_start();    
    
if(isset($_GET['logout'])){
    if($_GET['logout'] == "true"){
        unset($_SESSION);
    }
    
}
    
if(isset($_SESSION['loggedInCryptoEmail'])){
 //upload file    
    echo 'User: ' . $_SESSION['loggedInCryptoEmail'] . "<br>";
    echo '<form action="upload.php" method="post" enctype="multipart/form-data">';
    echo 'Select image to upload:<br>';
    echo '<input type="file" name="fileToUpload" id="fileToUpload"><br>';
    echo '<input type="submit" value="Upload Image" name="submit">';
    echo '</form>';
    echo '<a href="./index.php?logout=true">Log out</a>';
    
    
}else{
 //show log in/ register screen
    ?>
    <script>
        
    function showLogin(){
	document.getElementById("registerForm").style.display = "none";
	document.getElementById("loginForm").style.display = "block";
    }
        
        function showRegister(){
	document.getElementById("registerForm").style.display = "block";
	document.getElementById("loginForm").style.display = "none";
    }

    
    
    </script>
    <div id=masterScreen>
        
    <div id=loginForm>
        
        <form action="login.php" method="post" id = loginFormSubmit>
            Username: <input type=text name=username><br>
            Password: <input type=pass  name=password><br>
            <input type=Submit nam=submitLogin>
        </form>
        
        <div onclick=showRegister()>Register</div>
        
    </div>
        
        
        
        
        
    <div id=registerForm style="display:none;">
        
        <form action="register.php" method="post" id = registerFormSubmit>
            Username: <input type=text name=username><br>
            First Name: <input type=text  name=firstName><br>
            Last Name: <input type=text  name=lastName><br>
            Email: <input type=text  name=email><br>
            Password: <input type=pass  name=password><br>
            <input type=Submit nam=submitRegister>
        </form>
        
        <div onclick=showLogin()>Login</div>
    </div>
        
        
    </div>
    
    
    <?php
    
} 
    
    
    
    
    
    
    
    ?>

</html>