<?php

$connect = mysqli_connect("localhost", "root", "", "automotor");
if (!$connect) {
    die("Connection failed: " .  mysqli_connect_error());
}

echo "Connected successfully <br/>Perras";

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

$insert = "INSERT INTO automotor (lugarIngreso, placaAutomotora, nPlacaAutomotora, ingresoAccidente, tipoAutomotor, tipoServicio, marca, color, inventario, foto1Evidencia, foto2Evidencia, foto3Evidencia, foto4Evidencia, observaciones, ingresoPropioPatio) 
        VALUES ('$lugarIngreso', '$placaAutomotora', '$nPlacaAutomotora', '$ingresoAccidente', '$tipoAutomotor', '$tipoServicio', '$marca', '$color', '$inventario', '$foto1Evidencia', '$foto2Evidencia', '$foto3Evidencia', '$foto4Evidencia', '$observaciones', '$ingresoPropioPatio')";

$result = mysqli_query($connect, $insert);

mysqli_close($connect);
