<?php

$connect = mysqli_connect("localhost", "root", "", "prueba1");
if (!$connect) {
    die("Connection failed: " .  mysqli_connect_error());
}

echo "Connected successfully";
