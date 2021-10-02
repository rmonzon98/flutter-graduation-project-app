<?php

$connect = new mysqli("localhost","root","odbr21*","graduacion");
mysqli_set_charset($connect,"utf8");

if($connect){
	 
}else{
	echo "Fallo, revise ip o firewall";
	exit();
}