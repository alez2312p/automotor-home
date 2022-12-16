<?php

$connect = mysqli_connect("localhost", "root", "", "automotor");
if (!$connect) {
    die("Connection failed: " .  mysqli_connect_error());
}

echo "Connected successfully <br>";
// Iniciar sesión
session_start();

if (isset($_POST["lugarIngreso"]) || isset($_POST["placaAutomotor"]) || isset($_POST["nPlacaAutomotor"]) || isset($_POST["ingresoAccidente"]) || isset($_POST["tipoAutomotor"]) || isset($_POST["tipoServicio"]) || isset($_POST["marca"]) || isset($_POST["color"]) || isset($_POST["inventario"]) || isset($_POST["foto1Evidencia"]) || isset($_POST["foto2Evidencia"]) || isset($_POST["foto3Evidencia"]) || isset($_POST["foto4Evidencia"]) || isset($_POST["observaciones"]) || isset($_POST["ingresoPropioPatio"])) {
    $lugarIngreso = $_POST["lugarIngreso"];
    $placaAutomotora = $_POST["placaAutomotora"];
    $nPlacaAutomotora = $_POST["nPlacaAutomotora"];
    $ingresoAccidente = $_POST["ingresoAccidente"];
    $tipoAutomotor = $_POST["tipoAutomotor"];
    $tipoServicio = $_POST["tipoServicio"];
    $marca = $_POST["marca"];
    $color = $_POST["color"];
    $inventario = $_POST["inventario"];
    $foto1Evidencia = $_POST["foto1Evidencia"];
    $foto2Evidencia = $_POST["foto2Evidencia"];
    $foto3Evidencia = $_POST["foto3Evidencia"];
    $foto4Evidencia = $_POST["foto4Evidencia"];
    $observaciones = $_POST["observaciones"];
    $ingresoPropioPatio = $_POST["ingresoPropioPatio"];
} else {
    $lugarIngreso = null;
    $placaAutomotora = null;
    $nPlacaAutomotora = null;
    $ingresoAccidente = null;
    $tipoAutomotor = null;
    $tipoServicio = null;
    $marca = null;
    $color = null;
    $inventario = null;
    $foto1Evidencia = null;
    $foto2Evidencia = null;
    $foto3Evidencia = null;
    $foto4Evidencia = null;
    $observaciones = null;
    $ingresoPropioPatio = null;
}

$insert = "INSERT INTO automotor (lugarIngreso, placaAutomotora, nPlacaAutomotora, ingresoAccidente, tipoAutomotor, tipoServicio, marca, color, inventario, foto1Evidencia, foto2Evidencia, foto3Evidencia, foto4Evidencia, observaciones, ingresoPropioPatio) 
        VALUES ('$lugarIngreso', '$placaAutomotora', '$nPlacaAutomotora', '$ingresoAccidente', '$tipoAutomotor', '$tipoServicio', '$marca', '$color', '$inventario', '$foto1Evidencia', '$foto2Evidencia', '$foto3Evidencia', '$foto4Evidencia', '$observaciones', '$ingresoPropioPatio')";

$result = mysqli_query($connect, $insert);

echo ("placaAutomotora: $placaAutomotora");

mysqli_close($connect);
