<?php

$connect = mysqli_connect("localhost", "root", "", "automotor");
if (!$connect) {
    die("Connection failed: " .  mysqli_connect_error());
}

echo "Connected successfully";
