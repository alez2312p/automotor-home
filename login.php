<?php
include 'conn.php';

$username = $_POST["username"] ?? "";



$password = $_POST["password"] ?? "";

$usuarios = ("SELECT * FROM usuarios WHERE username='" .$username."' and password='" .$password."'");

$queryResult = mysqli_query($connect, $usuarios);

$result=array();

while($fetchData=$queryResult->fetch_assoc()) {
    $result[]=$fetchData;
}

echo json_encode($result);

mysqli_close($connect);
?>