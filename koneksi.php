<?php
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'kinarasdb';
$conn = mysqli_connect($host, $user, $pass, $db);
if($conn){
    // echo'Success Connect to database';
}
mysqli_select_db($conn, $db);
?>