<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <title>Registreer</title>

    <link rel="stylesheet" href="register.css">

</head>

<body style="background-color:rgb(35, 35, 47);text-align: center;">

<a href="index.php">
    <img src="Public/img/logo.png">
</a>
 
<p style="color: white">Registeer!</p>

<form method="POST">
    <input type="text" id="email" name="email" placeholder="Email" style='width: 11em;height: 1.5em' require><br
><br>
    <input type="password" id="pass" name="password" placeholder="Wachtwoord" style='width: 11em;height: 1.5em' require/><br
><br>
    <input type="text" id="voornaam" name="voornaam" placeholder="Voornaam" style='width: 11em;height: 1.5em' require/><br
><br>
    <input type="text" id="tussenvoeg" name="tussenvoegsel" placeholder="Tussenvoegsel" style='width: 11em;height: 1.5em'/><br
><br>
    <input type="text" id="achter" name="achternaam" placeholder="Achternaam" style='width: 11em;height: 1.5em' require/><br
><br>
    <input type="text" id="woon" name="woonplaats" placeholder="Woonplaats" style='width: 11em;height: 1.5em' require/><br
><br>
    <input type="text" id="post" name="postcode" placeholder="Postcode" style='width: 11em;height: 1.5em' require/><br
><br>
    <input type="text" id="straat" name="straat" placeholder="Straat" style='width: 11em;height: 1.5em' require/><br
><br>
    <input type="text" id="huisnm" name="huisnummer" placeholder="Huisnummer" style='width: 11em;height: 1.5em' require/><br
><br>
    <input type="text" id="land" name="land" placeholder="Land" style='width: 11em;height: 1.5em' require/><br
><br>
    <button type="submit" id="btn" name="register" style='width: 8em;height: 2em' default>register</button><br>
</form>


<?php

    if (isset($_POST['register'])) {
        include("database.php");
        $email = $_POST['email'];
        $password = $_POST['password'];
        $voornaam = $_POST['voornaam'];
        $tussenvoegsel = $_POST['tussenvoegsel'];
        $achternaam = $_POST['achternaam'];
        $woonplaats = $_POST['woonplaats'];
        $postcode = $_POST['postcode'];
        $straat = $_POST['straat'];
        $huisnummer = $_POST['huisnummer'];
        $land = $_POST['land'];

        $host = "localhost";
        $user = "root";
        $pass = "";
        $databasename = "nerdygadgets";
        $port = 3306;
        $connection = mysqli_connect($host, $user, $pass, $databasename, $port);

        $query = "INSERT INTO inloggegevens (email, wachtwoord, voornaam, tussenvoegsel, achternaam, woonplaats, postcode, straat, huisnummer, land) VALUES ('$email', '$password', '$voornaam', '$tussenvoegsel', '$achternaam', '$woonplaats', '$postcode', '$straat', '$huisnummer', '$land')";
        $result = mysqli_query($connection, $query);
        if ($result) {
            echo "<p style='color: white'>Account created!</p>";
        } else {
            echo mysqli_error($connection);
        }
    }
?>

<br>

<a href="inlog.php" style="color: white;">Log in!</a>
</body>
</html>