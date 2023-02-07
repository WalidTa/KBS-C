<?php
include "cartfuncties.php";
include "header.php";


?>
<!DOCTYPE html>
<html lang="nl">
<head>
    <title>Betalen</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<p style="position:absolute;border-width:3px; border-style:solid; border-radius:20px; border-color:white; padding: 1em; width: 400px; height: 480px; margin-top:0px;margin-left:33%;px;">

<?php
$totaalprijs = $_SESSION["totaalprijs"];
$verzendkosten = $_SESSION["verzendkosten"];
$prijs = $_SESSION["prijs"];
$cart = isset($_SESSION["cart"]) ? $_SESSION["cart"] : "";




print("Prijs: €" . round($prijs, 2) . "<br>");
print("Verzendkosten: €" . $verzendkosten . "<br>");
print("Totaalprijs: €" . round($totaalprijs, 2) . "<br>");

?>
<?php
$voornaam = isset($_POST["Voornaam"]) ? $_POST["Voornaam"] : "";
$achternaam = isset($_POST["Achternaam"]) ? $_POST["Achternaam"] : "";
$tussenvoegsel = isset($_POST["Tussenvoegsel"]) ? $_POST["Tussenvoegsel"] : "";
$email = isset($_POST["Email"]) ? $_POST["Email"] : "";
$woonplaats = isset($_POST["Woonplaats"]) ? $_POST["Woonplaats"] : "";
$postcode = isset($_POST["Postcode"]) ? $_POST["Postcode"] : "";
$straat = isset($_POST["Straat"]) ? $_POST["Straat"] : "";
$huisnummer = isset($_POST["Huisnummer"]) ? $_POST["Huisnummer"] : "";
$land = isset($_POST["Land"]) ? $_POST["Land"] : "";

$inlog = isset($_SESSION["Inlog"]) ? $_SESSION["Inlog"] : "";
$voornaam = isset($_SESSION["Voornaam"]) ? $_SESSION["Voornaam"] : "";
$achternaam = isset($_SESSION["Achternaam"]) ? $_SESSION["Achternaam"] : "";
$tussenvoegsel = isset($_SESSION["Tussenvoegsel"]) ? $_SESSION["Tussenvoegsel"] : "";
$email = isset($_SESSION["Email"]) ? $_SESSION["Email"] : "";
$woonplaats = isset($_SESSION["Woonplaats"]) ? $_SESSION["Woonplaats"] : "";
$postcode = isset($_SESSION["Postcode"]) ? $_SESSION["Postcode"] : "";
$straat = isset($_SESSION["Straat"]) ? $_SESSION["Straat"] : "";
$huisnummer = isset($_SESSION["Huisnummer"]) ? $_SESSION["Huisnummer"] : "";
$land = isset($_SESSION["Land"]) ? $_SESSION["Land"] : "";


?>

<form action="betalen.php" method="post" style="margin-left:34%;margin-top:100px;position:absolute;">
    <input type="text" name="Voornaam" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($voornaam);} ?> > Voornaam<br>
    <input type="text" name="Achternaam" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($achternaam);} ?> > Achternaam<br>
    <input type="text" name="TussenVoegsel" style='width: 8em;height: 1.5em' value= <?php if($inlog == "TRUE"){print($tussenvoegsel);} ?> > Tussenvoegsel<br>
    <input type="text" name="Email" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($email);} ?> > Email<br>
    <br>
    <input type="text" name="Woonplaats" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($woonplaats);} ?>> Woonplaats<br>
    <input type="text" name="Postcode" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($postcode);} ?>> Postcode<br>
    <input type="text" name="Straat" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($straat);} ?>> Straat<br>
    <input type="text" name="Huisnummer" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($huisnummer);} ?>> Huisnummer<br>
    <input type="text" name="Land" style='width: 8em;height: 1.5em' required value= <?php if($inlog == "TRUE"){print($land);} ?>> Land<br> 
    <br>
    <select name="bank" id="bank" style="width:7.5em;height:2em;background: url(Public/Img/Dropdown-icon.png) 96% / 30px no-repeat #EEE;">
        <option value="ING" selected>ING</option>
        <option value="ANB AMRO">ANB AMRO</option>
        <option value="Rabo bank">Rabo bank</option>
    </select>
    <br>
    <br>
    <input type="submit" name="bestellen" value="Bestellen" style='width: 7em;height: 2em'>
</form>



<?php


if (isset($_POST["bestellen"])) {
    $voornaam = $_POST["Voornaam"];
    $achternaam = $_POST["Achternaam"];
    $tussenvoegsel = $_POST["TussenVoegsel"];
    $email = $_POST["Email"];
    $woonplaats = $_POST["Woonplaats"];
    $postcode = $_POST["Postcode"];
    $straat = $_POST["Straat"];
    $huisnummer = $_POST["Huisnummer"];
    $land = $_POST["Land"];
    $bank = $_POST["bank"];
    $prijs = $_SESSION["totaalprijs"];
    $Artikel = $_SESSION["Artikel"];
    $Aantal = $_SESSION["Aantal"];

    $conn = mysqli_connect("localhost", "root", "", "nerdygadgets");
    $sqlBestellingID = "SELECT MAX(BestellingID) AS BestellingID FROM bestelling";
    $resultBestellingID = mysqli_query($conn, $sqlBestellingID);
    $rowBestellingID = mysqli_fetch_assoc($resultBestellingID);
    $BestellingID = $rowBestellingID["BestellingID"] + 1;

    $sqlKlantID = "SELECT MAX(KlantID) AS KlantID FROM klanten";
    $resultKlantID = mysqli_query($conn, $sqlKlantID);
    $rowKlantID = mysqli_fetch_assoc($resultKlantID);
    $KlantID = $rowKlantID["KlantID"] + 1;
    
    $sql = "INSERT INTO Bestelling (Voornaam, Achternaam, Tussenvoegsel, Email, Woonplaats, Postcode, Straat, Huisnummer, Land, Bankvorm, Prijs, Artikel, Aantal) VALUES ('$voornaam', '$achternaam', '$tussenvoegsel', '$email','$woonplaats', '$postcode', '$straat', '$huisnummer', '$land', '$bank', '$prijs', '$Artikel', '$Aantal')";
    $result = mysqli_query($conn, $sql);
    if ($result) {
        print("Bestelling is geplaatst.<br>");
    }

    foreach ($cart as $item => $aantal){
        $sql2 = "UPDATE stockitemholdings SET QuantityOnHand = QuantityOnHand - $aantal WHERE StockitemID = $item";
        $result2 = mysqli_query($conn, $sql2);

    }

    $sql3 = "SELECT * FROM Klanten WHERE Voornaam = '$voornaam' AND Achternaam = '$achternaam' AND Tussenvoegsel = '$tussenvoegsel' AND Email = '$email' AND Woonplaats = '$woonplaats' AND Postcode = '$postcode' AND Straat = '$straat' AND Huisnummer = '$huisnummer' AND Land = '$land'";
    $result3 = mysqli_query($conn, $sql3);

    if($result3->num_rows == 0){  
        $sql4 = "INSERT INTO Klanten (Voornaam, Achternaam, Tussenvoegsel, Email, Woonplaats, Postcode, Straat, Huisnummer, Land) VALUES ('$voornaam', '$achternaam', '$tussenvoegsel', '$email', '$woonplaats', '$postcode', '$straat', '$huisnummer', '$land')";
        $result4 = mysqli_query($conn, $sql4);
        print("Klant is toegevoegd.<br>");
    }

    $sqlKlantID2 = "SELECT KlantID FROM Klanten WHERE Voornaam = '$voornaam' AND Achternaam = '$achternaam' AND Tussenvoegsel = '$tussenvoegsel' AND Email = '$email' AND Woonplaats = '$woonplaats' AND Postcode = '$postcode' AND Straat = '$straat' AND Huisnummer = '$huisnummer' AND Land = '$land'";
    $resultKlantID2 = mysqli_query($conn, $sqlKlantID2);
    $rowKlantID2 = mysqli_fetch_assoc($resultKlantID2);
    $KlantID2 = $rowKlantID2["KlantID"];

    $sqlBestellingID2 = "SELECT MAX(BestellingID) AS BestellingID FROM bestelling";
    $resultBestellingID2 = mysqli_query($conn, $sqlBestellingID2);
    $rowBestellingID2 = mysqli_fetch_assoc($resultBestellingID2);
    $BestellingID2 = $rowBestellingID2["BestellingID"];

    $sql5 = "INSERT INTO klantbestelling (KlantID, BestellingID) VALUES ('$KlantID2','$BestellingID2')";
    $result5 = mysqli_query($conn, $sql5);

    mysqli_close($conn);
}



?>
</p>
</body>
</html>