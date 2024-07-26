<?php
include "koneksi.php";

$ids = mysqli_real_escape_string($conn, $_POST['bag_id']);
$queri = "DELETE FROM bag WHERE bag_id = '$ids';";
$sql3 = mysqli_query($conn, $queri);
if($sql3){
    echo '<script>
        setTimeout(function(){
            window.location.href = "cartlist.php";
        }, 400);
    </script>';
}else{
    echo mysqli_error($conn);
}

mysqli_close($conn);
?>