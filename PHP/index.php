<html>

<style>
    #masterScreen{
    margin:auto;
        width: 30%;
        padding:100px 0;
        text-align: center;
        
    }    
    
    #submitButton {
        background: #0066A2;
        color: white;
        border-style: outset;
        border-color: #0066A2;
        height: 50px;
        width: 100px;
        font: bold 15px arial, sans-serif;
        text-shadow:none;
        margin: 10px 10px 10px 10px;

    }
    
    #enterUserData{
        width: 100%;
        padding: 12px 20px;
        margin: 8px 0;
        box-sizing: border-box;
    }
    
    #enteruserDataNames{
        width:100%;
        padding: 12px 20px;
        margin: 8px 0;
        
        border: 0px 0px 0px 0px;
    }
    

    
</style>
    
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
    <div id=masterScreen style="min-width:200px;">
        
    <div id=loginForm>
        <h2> Login to [xxxxxx]</h2>
        <form action="login.php" method="post" id = loginFormSubmit>
            <input type=text id=enterUserData name=email placeholder="Enter your email..."><br>
            <input type=pass  id=enterUserData name=password placeholder="Enter your password..."><br>
            <input type=Submit id=submitButton name=submitLogin><button type="button" id=submitButton onclick=showRegister()>Register</button>
        </form>
        
        
        
        
    </div>
        
        
        
        
        
    <div id=registerForm style="display:none;">
        <h2>Register</h2>
        <form action="register.php" method="post" id = registerFormSubmit>
            
            <div style="display:flex;">
                <div style="width:100%;margin:0 4 0 0;">
                <input type=text id=enterUserDataNames  name=firstName placeholder="First Name">
            
                </div>
                
                <div style="width:100%;margin:0 0 0 4;">
                <input type=text id=enterUserDataNames  name=lastName placeholder="Last Name"><br>
            
                </div>
            </div>
            
            <input type=text id=enterUserData  name=email placeholder="Email"><br>
            <input type=pass id=enterUserData  name=password placeholder="Password"><br>
            <input type=Submit id=submitButton name=submitRegister><button type="button" id=submitButton onclick=showLogin()>Login</button>
        </form>
        
        
    </div>
        
        
    </div>
    
    
    <?php
    
} 
    
    
try {
     $db = new PDO("mysql:dbname=crypto;host=localhost", "root", "pass" );
     $db->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );//Error Handling
     $sql ="CREATE TABLE crypto.mega (
  user_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  pass VARCHAR(255) NOT NULL,
  date_created TIMESTAMP DEFAULT NOW(),
  ip_addr VARCHAR(32) NOT NULL
);" ;
     $db->exec($sql);
     

} catch(PDOException $e) {
    //echo $e->getMessage();
}      
    
try {
     $db = new PDO("mysql:dbname=crypto;host=localhost", "root", "pass" );
     $db->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );//Error Handling
     $sql ="CREATE TABLE crypto.transactions(
  trans_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  doc_id INTEGER NOT NULL,
  exchange VARCHAR(255),
  trans_date DATETIME,
  trans_type VARCHAR(50),
  asset VARCHAR(10),
  quantity DECIMAL(16,10),
  cost_basis DECIMAL(16,8),
  subtotal DECIMAL(12,3),
  total DECIMAL(12,3),
  currency VARCHAR(255),
  amount_left INTEGER
  /* amount_left DECIMAL(16, 10), */
);" ;
     $db->exec($sql);
     

} catch(PDOException $e) {
    //echo $e->getMessage();
}  
    
    
    
    
    
    
try {
     $db = new PDO("mysql:dbname=crypto;host=localhost", "root", "pass" );
     $db->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );//Error Handling
     $sql ="CREATE TABLE crypto.documents(
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  exchange VARCHAR(255) NOT NULL,
  date_uploaded TIMESTAMP DEFAULT NOW(),
  filename VARCHAR(255) NOT NULL,
  filesize DECIMAL(10,2) NOT NULL
);" ;
     $db->exec($sql);
     

} catch(PDOException $e) {
    //echo $e->getMessage();
}      
    
    ?>

</html>
