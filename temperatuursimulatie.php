<?php

$host = 'localhost';
$user = 'root';
$pass = '';
$database = 'nerdygadgets';
$port = 3306;
$connection = mysqli_connect($host, $user, $pass, $database, $port);


if (isset($_POST['Aan/uit'])) {
    $sql3 = "SELECT * FROM aan_uit_temperatuur";
    $result = mysqli_query($connection, $sql3);
    $row = mysqli_fetch_assoc($result);
    $aanUit = $row['aan_uit'];
    if ($aanUit == 0) {
        $sql5 = "UPDATE aan_uit_temperatuur SET aan_uit = 1";
        $result = mysqli_query($connection, $sql5);
    }
    if ($aanUit == 1) {
        $sql4 = "UPDATE aan_uit_temperatuur SET aan_uit = 0";
        $result = mysqli_query($connection, $sql4);
    }
}



$sql1 = "SELECT * FROM aan_uit_temperatuur";
$result1 = mysqli_query($connection, $sql1);
$row1 = mysqli_fetch_assoc($result1);
$aan_uit = $row1['aan_uit'];


if($aan_uit==1){
    while ($aan_uit == 1){
        $sql8 = "SELECT * FROM aan_uit_temperatuur";
        $result8 = mysqli_query($connection, $sql8);
        $row8 = mysqli_fetch_assoc($result8);
        $aan_uit = $row8['aan_uit'];

        if($aan_uit != 0 AND $aan_uit == 1){
            $temp = rand(20,25) . "." . rand(0,99);
            $randomTemp = $temp. "°C";
            $metingDatum = date("Y-m-d H:i:s");

            $sql2 = "INSERT INTO temperatuurmeting (Temperatuurmeting, Metingdatum) VALUES ('$randomTemp', '$metingDatum')";
            $result2 = mysqli_query($connection, $sql2);

            sleep(3);

        }

    }
} else {
    echo "Temperatuur wordt niet gemeten!";
}

$connection->close();

?>