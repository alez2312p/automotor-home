<?php

$connect = mysqli_connect("localhost", "root", "", "automotor");
if (!$connect) {
	die("Connection failed: " .  mysqli_connect_error());
}

echo "Connected successfully ";
// Iniciar sesión
session_start();

// Obtener los datos
if (isset($_POST['username']) || isset($_POST['password'])) {
	$username = $_POST['username'];
	$password = $_POST['password'];
}else {
	$username = null;
	$password = null;
}

// Verificar usuario
$query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
$result = mysqli_query($connect, $query);
$num_rows = mysqli_num_rows($result);

if ($num_rows > 0) {
	$_SESSION['username'] = $username;
	echo "success";
} else {
	echo "failure";
}

mysqli_close($connect);