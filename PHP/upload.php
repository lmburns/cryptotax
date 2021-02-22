<style>

table,th, td{
    border: 1px solid black;
}
</style>



<?php
session_start();
//print_r($_SESSION);


if(isset($_SESSION['user_id'])){

$userid = $_SESSION['user_id'];
    $servername = "localhost";
    $serusername = "root";
    $serpassword = "pass";
    $dbname = "crypto";

    // Create connection
    $conn = new mysqli($servername, $serusername, $serpassword, $dbname);

    $sql = "SELECT * FROM documents WHERE user_id = '$userid'";
    $result = mysqli_query($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
      echo "<table id=uploadstable><tr><th>filename</th></tr>";
      while($row = mysqli_fetch_assoc($result)) {
          
            $thefilename = $row['filename'];
            echo "<tr><td><a href=\"uploads/$thefilename\">$thefilename</a></td></tr>";
            
            
        }
        echo "</table>";
      }




    
    if(isset($_FILES["fileToUpload"])){
        $target_dir = "uploads/";
        $target_file = $target_dir . date(DATE_RFC2822) . "---" .  basename($_FILES["fileToUpload"]["name"]);
        $uploadOk = 1;
        $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));


        // Check if file already exists
        if (file_exists($target_file)) {
          echo "Sorry, file already exists.";
          $uploadOk = 0;
        }

        // Check file size
        if ($_FILES["fileToUpload"]["size"] > 500000) {
          echo "Sorry, your file is too large.";
          $uploadOk = 0;
        }

        // Allow certain file formats
        if($imageFileType != "pdf") {
          echo "Sorry, only PDF files are allowed.";
          $uploadOk = 0;
        }

        // Check if $uploadOk is set to 0 by an error
        if ($uploadOk == 0) {
          echo "Sorry, your file was not uploaded.";
        // if everything is ok, try to upload file
        } else {
          if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
            echo "The file ". htmlspecialchars( basename( $_FILES["fileToUpload"]["name"])). " has been uploaded.";
                $servername = "localhost";
                $serusername = "root";
                $serpassword = "pass";
                $dbname = "crypto";
            $conn = new mysqli($servername, $serusername, $serpassword, $dbname);
            $stmt = $conn->prepare("INSERT INTO documents (user_id, exchange, filename, filesize) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("ssss", $p1, $p2, $p3, $p4);

            // set parameters and execute
            $p1 = $_SESSION['user_id'];
            $p2 = "COINBASE";
            $p3 = htmlspecialchars(basename($target_file));
            $p4 = htmlspecialchars(basename($_FILES['fileToUpload']['size']));
            
            $stmt->execute();
          
          
          
          } else {
            echo "Sorry, there was an error uploading your file.";
          }
        }
    }
    

    
    
    echo '<form action="upload.php" method="post" enctype="multipart/form-data">';
    echo 'Select image to upload:<br>';
    echo '<input type="file" name="fileToUpload" id="fileToUpload"><br>';
    echo '<input type="submit" value="Upload Image" name="submit">';
    echo '</form>';
    
    
}



?>

<a href="./index.php?logout=true">Log out</a>
