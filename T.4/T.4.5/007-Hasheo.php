<?php

    $cadena = "Hola";
    echo $cadena;
    echo "<br>";

    // Hasheo con MD5

    $picadillo = md5($cadena);	
    echo $picadillo;
    echo "<br>";

    // Hasheo con SHA1
    $picadillo2 = sha1($cadena);
    echo $picadillo2;
    echo "<br>";
?>