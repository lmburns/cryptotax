<?php
session_start();

$email = htmlspecialchars($_POST['username']);
$enteredPassword = htmlspecialchars($_POST['password']);


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
$sql = "SELECT pass FROM cryptoUsers WHERE email = '$email' LIMIT 1";
$result = mysqli_query($conn, $sql);
echo $sql . " <BR> ";
if (mysqli_num_rows($result) > 0) {
  // output data of each row
  while($row = mysqli_fetch_assoc($result)) {
      print_r($row);
    if($row["pass"] == $enteredPassword){
        //login!
        $_SESSION['loggedInCryptoEmail'] = $email;
    
        //redirect to upload
        header("Location: ./upload.php");
        
    }else{
        //redirect ERROR WRONG PASSWORD
    }
  }
} else {
  echo "0 results";
}



?>