<?php
include 'conn.php';

$id = $_POST["id"] ?? "";
$password = $_POST["password"] ?? "";

$usuario = ("SELECT * FROM usuarios WHERE id='$id' AND password='$password'");

$result = mysqli_query($connect, $usuario);

$count= mysqli_num_rows($result);

if ($count == 1) {
    echo json_encode("Success");
}else{
    echo json_encode("Error");
}