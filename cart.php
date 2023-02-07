
<?php
include "cartfuncties.php";
include "header.php";


?>
<!DOCTYPE html>
<html lang="nl">
    <link rel="stylesheet" href="Public/CSS/style.css" type="text/css">
    <link rel="stylesheet" href="Public/CSS/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="Public/CSS/typekit.css">
<head>
    <meta charset="UTF-8">
    <title>Winkelwagen</title>
</head>
<body>
<h1>Inhoud Winkelwagen</h1>

<?php


$cart = getCart();

print("<br>");
$totaalprijs = 0;
$Artikel ="";
$Aantal2="";
foreach($cart as $item => $aantal){

    $Artikel = "$item, $Artikel";

    $Aantal2 = "$aantal, $Aantal2";

    $host = "localhost";
    $user = "root";
    $pass = "";
    $databasename = "nerdygadgets";
    $port = 3306;
    $connection = mysqli_connect($host, $user, $pass, $databasename, $port);

    if ($connection->connect_error){
        die("Connection failed: ". $connection->connect_error);
    }

    $sql = "SELECT * FROM stockitems WHERE StockItemID = $item";
    $sql2 = "SELECT * FROM stockitemimages WHERE StockItemID = $item";

    $result = $connection->query($sql);
    $result2 = $connection->query($sql2);

    if(!$result){
        die("Invalid quary: ". $connection->connect_error);
    }

    if(!$result2){
        die("Invalid quary: ". $connection->connect_error);
    }
          

    while($row = $result->fetch_assoc()) {
        print("Artikel: " . $row["StockItemName"] . "<br>");
        print("Prijs: €" . $row["RecommendedRetailPrice"] . "<br>");
        print("Aantal: " . $cart[$item] . "<br>");
        print("Totaal: €" . $row["RecommendedRetailPrice"] * $cart[$item] . "<br>");
        $totaalprijs = $totaalprijs + ($row["RecommendedRetailPrice"] * $cart[$item]);
        print("<form action='cart.php' method='post'>");
        print("<input type='hidden' name='StockItemID' value='" . $row['StockItemID'] . "'>");
        print("<button type='submit' name='remove' class='btn btn-danger'>Verwijder</button>");
        print("</form>");
        print("<form action='cart.php' method='post'>");
        print("<input type='hidden' name='StockItemID' value='" . $row['StockItemID'] . "'>");
        print("<input type='number' name='aantal' value='" . $cart[$item] . "' style='width: 4em;height: 2em'>");
        print("</form>");


        if(isset($_POST['remove'])){
            $item = $_POST['StockItemID'];
            unset($cart[$item]);
            saveCart($cart);
            echo "<meta http-equiv='refresh' content='0'>";
        }        

        if(isset($_POST['aantal'])){
            if($_POST['aantal'] == 0){
                $item = $_POST['StockItemID'];
                unset($cart[$item]);
                saveCart($cart);
                echo "<meta http-equiv='refresh' content='0'>";
            } else {
                $item = $_POST['StockItemID'];
                $aantal = $_POST['aantal'];
                $cart[$item] = $aantal;
                saveCart($cart);
                echo "<meta http-equiv='refresh' content='0'>";
        }




    }
}  
    $StockItemImage = getStockItemImage($item, $connection);
    
    while($row2 = $result2->fetch_assoc()) {
        print("<img src='Public/StockItemIMG/" . $row2["ImagePath"] . "' alt='StockGroupIMG' style=\"margin-top:-160px;margin-left:200px;width:150px;height:150px;\"");

    }
    print("<br>");
    print("<p><a href='view.php?id=". $item . "'>Naar artikelpagina van artikel ".$item."</a></p>");
    print("<br>");


    print("<hr size=\"8\" width=\"50%\" color=\"white\" style=\"margin-left:10px\">");  
    



    




    
    
    
$connection->close();
}

$student = '@student.windesheim.nl';
$studentkorting = isset($_POST["studentkorting"]) ? $_POST["studentkorting"] : "";
if (strpos($studentkorting, $student) !== false) {
    $totaalprijs = $totaalprijs * 0.90;
}

$kortingsCode = isset($_POST["kortingsCode"]) ? $_POST["kortingsCode"] : "";
if ($kortingsCode == "NerdyGadgetsLaunch") {
    $totaalprijs = $totaalprijs * 0.50;
}

if ($kortingsCode == "20procent") {
    $totaalprijs = $totaalprijs * 0.80;
}

if($kortingsCode == "15procent"){
    $totaalprijs = $totaalprijs * 0.85;
}





print("Totaalprijs: €" . round($totaalprijs, 2) . "<br>");

    

$verzendkosten = 5.95;
if ($totaalprijs >= 100 OR $totaalprijs == 0){
    $verzendkosten = 0;
} else {
    $verzendkosten = 5.95;
}

?>
<br>
<br>
<form action="cart.php" method="post">
    Studentenkorting  (jouw windesheim mailadres)<br> 
    <input type="text" name="studentkorting" style='width: 8em;height: 2em;'>
    <input type="submit" value="Controleren" style='border-radius:15px;color:white;width:7em;height:2em;background-color:rgba(255,255,255,0);border: 2px solid white;'>
</form>
<?php
$student = '@student.windesheim.nl';
if (strpos($studentkorting, $student) !== false) {
    print("Studenten e-mail is geldig! Jouw korting is: 10%");
}
?>
<br>
<br>
<form action="cart.php" method="post">
    Kortingscode  <br>
    <input type="text" name="kortingsCode" style='width: 8em;height: 2em;'>
    <input type="submit" value="Controleren" style='border-radius:15px;color:white;width:7em;height:2em;background-color:rgba(255,255,255,0);border: 2px solid white;'>
</form>
<?php
if ($kortingsCode == "NerdyGadgetsLaunch") {
    print("Kortingscode is geldig! Actieve kortingscode: NerdyGadgetsLaunch <br>");
}

if ($kortingsCode == "20procent") {
    print("Kortingscode is geldig! Actieve kortingscode: 20procent <br>");
}

if($kortingsCode == "15procent"){
    print("Kortingscode is geldig! Actieve kortingscode: 15procent <br>");
}


?>
<?php
$_SESSION["prijs"] = $totaalprijs;
$_SESSION["verzendkosten"] = $verzendkosten;
$_SESSION["totaalprijs"] = $totaalprijs + $verzendkosten;
$_SESSION["kortingsCode"] = $kortingsCode;
$_SESSION["Artikel"] = $Artikel;
$_SESSION["Aantal"] = $Aantal2;
$_SESSION["Cart"] = $cart;
?>

<br>
<form>
    <input type="button" value="Verder winkelen" onclick="window.location.href='index.php'" style='border-radius:15px;color:white;width:10em;height:2em;background-color:rgba(255,255,255,0);border: 2px solid white;'>
    <input type="button" value="Afrekenen" onclick="window.location.href='betalen.php'" style='border-radius:15px;color:white;width:10em;height:2em;background-color:rgba(255,0,0,1);border: 2px solid white;'>
</form>




<br>
<br>
<br>
</body>
</html>