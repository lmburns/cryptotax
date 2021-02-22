

<html>

<?php
session_start();
    
print_r($_SESSION);
function registerError($errorName){
    echo $errorName;
}
    
function registerUser($firstName,$lastName,$email,$password){
    
    $servername = "localhost";
    $serusername = "root";
    $serpassword = "pass";
    $dbname = "crypto";

    // Create connection
    $conn = new mysqli($servername, $serusername, $serpassword, $dbname);
    $stmt = $conn->prepare("INSERT INTO mega (email,first_name,last_name,pass,ip_addr) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $p1, $p2, $p3, $p4, $p5);

    // set parameters and execute
    $p1 = $email;
    $p2 = $firstName;
    $p3 = $lastName;
    $p4 = $password;
    $p5 = $_SERVER['REMOTE_ADDR'];
    
    $stmt->execute();
    //mysql add to db
    
    //echo "Created account $email successfully!";
    
    
        $sql = "SELECT user_id FROM mega WHERE email = '$email' LIMIT 1";
        $result = mysqli_query($conn, $sql);
        if (mysqli_num_rows($result) > 0) {
          
          while($row = mysqli_fetch_assoc($result)) {
              
                
                $_SESSION['loggedInCryptoEmail'] = $email;
                $_SESSION['user_id'] = $row["user_id"];
                
                
            }
          }
        
    
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
$sql = "SELECT * FROM mega";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
  // output data of each row
  while($row = mysqli_fetch_assoc($result)) {
      
    if($row["email"] == $_POST["email"]){
        echo "already registered";
        $alreadyRegistered = true;
    }
  }
} else {
  echo "0 results";
}

if(!$alreadyRegistered){
    if($firstName!=""&&$lastName!=""&&$email!=""&&$password!=""){
    registerUser($firstName,$lastName,$email,$password);
    }else{
        echo "NO";
    }
    
    
}else{
    registerError("Email Address is already used!");
}


//check if email is already used
//do a select and limit 1

    ?>




</html>
