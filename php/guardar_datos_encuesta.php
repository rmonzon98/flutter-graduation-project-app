<?php

    include 'conexion.php';
	$intervalo = $_POST['intervalo'];
	$minimo = $_POST['minimo'];
	$maximo = $_POST['maximo'];
	
	$sql = "INSERT INTO user_testing (intervalo,minimo, maximo) VALUES ('$intervalo', '$minimo', '$maximo')";
	
	$response = array();
	$temp =array();
	
	if ($connect->query($sql) === TRUE) {
	  $temp['status'] = "exito";
	} else {
	  $temp['status'] = "error";
	}
	
	$response[]=$temp;
	echo json_encode($response);

    ?>