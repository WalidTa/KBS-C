<!DOCTYPE html>
<html lang="nl">
<head>
    <title>Inlog pagina</title>
    <link rel="stylesheet" href="inlog.css">
</head>
<?php
//include "header.php";
include "database.php";
session_start();
?>
<body style="background-color:rgb(35, 35, 47);text-align: center;">

<a href="index.php">
    <img src="Public/img/logo.png">
</a>
<br>
 <form, .register style="text-align: center;">


<p style="color: white">Login</p>

<form action="inlog.php" method="POST">

    <input type="text" id="user" name="email" placeholder="Email"style='width: 8em;height: 1.5em' required/><br
    ><br>
    <input type="password" id="pass" name="wachtwoord" placeholder="Wachtwoord" style='width: 8em;height: 1.5em' required/><br
    ><br>
    <button type="submit" id="btn" name="login" default>login</button>

</form>

<br>

<div class="register">
    <a href="register.php" style="color: white">Registreer hier!</a>
</div>
<?php


$email = isset($_POST['email']) ? $_POST['email'] : '';
$wachtwoord = isset($_POST['wachtwoord']) ? $_POST['wachtwoord'] : '';
$conn = connectToDatabase();

if (isset($_POST['login'])) {
    $sql = "SELECT * FROM inloggegevens WHERE email = '$email' AND wachtwoord = '$wachtwoord'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $inlogID = $row['InlogID'];
            $email = $row['Email'];
            $wachtwoord = $row['Wachtwoord'];
            $voornaam = $row['Voornaam'];
            $tussenvoegsel = $row['Tussenvoegsel'];
            $achternaam = $row['Achternaam'];
            $woonplaats = $row['Woonplaats'];
            $postcode = $row['Postcode'];
            $straat = $row['Straat'];
            $huisnummer = $row['Huisnummer'];
            $land = $row['Land'];
            $admin = $row['Admin'];
            $inlog = "TRUE";
                if ($admin == "JA") {
                    header('location: admin.php');
                } else {
                    header('location: index.php');
                }
                
        }
             
    } else {
            echo "Gebruikersnaam of wachtwoord is onjuist";
    }
}
$_SESSION["InlogID"] = isset($inlogID) ? $inlogID : '';
$_SESSION["Email"] = isset($email) ? $email : '';
$_SESSION["Wachtwoord"] = isset($wachtwoord) ? $wachtwoord : '';
$_SESSION["Voornaam"] = isset($voornaam) ? $voornaam : '';
$_SESSION["Tussenvoegsel"] = isset($tussenvoegsel) ? $tussenvoegsel : '';
$_SESSION["Achternaam"] = isset($achternaam) ? $achternaam : '';
$_SESSION["Woonplaats"] = isset($woonplaats) ? $woonplaats : '';
$_SESSION["Postcode"] = isset($postcode) ? $postcode : '';
$_SESSION["Straat"] = isset($straat) ? $straat : '';
$_SESSION["Huisnummer"] = isset($huisnummer) ? $huisnummer : '';
$_SESSION["Land"] = isset($land) ? $land : '';
$_SESSION["Admin"] = isset($admin) ? $admin : '';
$_SESSION["Inlog"] = isset($inlog) ? $inlog : '';







?>


</body>
</html>

