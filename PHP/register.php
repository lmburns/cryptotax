

<html>

<?php
session_start();
    
print_r($_SESSION);
function registerError($errorName){
    echo $errorName;
}
    
function registerUser($username,$firstName,$lastName,$email,$password){
    $servername = "localhost";
    $serusername = "root";
    $serpassword = "pass";
    $dbname = "crypto";

    // Create connection
    $conn = new mysqli($servername, $serusername, $serpassword, $dbname);
    $stmt = $conn->prepare("INSERT INTO cryptoUsers (username,firstName,lastName,email,pass,signedUp) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssss", $p1, $p2, $p3, $p4, $p5, $p6);

    // set parameters and execute
    $p1 = $username;
    $p2 = $firstName;
    $p3 = $lastName;
    $p4 = $email;
    $p5 = $password;
    $p6 = date(DATE_RFC3339);
    $stmt->execute();
    //mysql add to db
    
    //echo "Created account $email successfully!";
    
    $_SESSION['loggedInCryptoEmail'] = $email;
    
    //redirect to upload
    header("Location: ./upload.php");
}
    
//This creates a Database if we don't have one    
try {
        $dbh = new PDO("mysql:host=localhost", "root", "pass");

        $dbh->exec("CREATE DATABASE IF NOT EXISTS`crypto`;");
        //or die(print_r($dbh->errorInfo(), true));

    }
    catch (PDOException $e) {
        //die("DB ERROR: " . $e->getMessage());
    }
    
//This creates a Table if we don't have one
try {
     $db = new PDO("mysql:dbname=crypto;host=localhost", "root", "pass" );
     $db->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );//Error Handling
     $sql ="CREATE TABLE IF NOT EXISTS cryptoUsers(
     ID INT( 11 ) AUTO_INCREMENT PRIMARY KEY,
     username TEXT NOT NULL, 
     firstName TEXT NOT NULL,
     lastName TEXT NOT NULL, 
     email TEXT NOT NULL, 
     pass TEXT NOT NULL, 
     signedUp VARCHAR( 100 ) NOT NULL);" ;
     $db->exec($sql);
     

} catch(PDOException $e) {
    //echo $e->getMessage();
}  
    

    

$username = htmlspecialchars($_POST['username']);
$firstName = htmlspecialchars($_POST['firstName']);
$lastName = htmlspecialchars($_POST['lastName']);
$email = htmlspecialchars($_POST['email']);
$password = htmlspecialchars($_POST['password']);

    
$servername = "localhost";
$serusername = "root";
$serpassword = "pass";
$dbname = "crypto";

// Create connection
$conn = mysqli_connect($servername, $serusername, $serpassword, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}
$alreadyRegistered=0;
$sql = "SELECT * FROM cryptoUsers";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
  // output data of each row
  while($row = mysqli_fetch_assoc($result)) {
      
    if($row["email"] == $_POST["email"]){
        
        $alreadyRegistered = true;
    }
  }
} else {
  echo "0 results";
}

if(!$alreadyRegistered){
    registerUser($username,$firstName,$lastName,$email,$password);
}else{
    registerError("Email Address is already used!");
}


//check if email is already used
//do a select and limit 1

    ?>




</html>