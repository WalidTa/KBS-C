<!-- de inhoud van dit bestand wordt bovenaan elke pagina geplaatst -->
<?php
include "database.php";

$databaseConnection = connectToDatabase();

function connectie() {
    mysqli_close($databaseConnection);
    $Connection = null;
    try {
        $Connection = mysqli_connect("localhost", "root", "", "nerdygadgets");
        mysqli_set_charset($Connection, 'latin1');
        $DatabaseAvailable = true;
    } catch (mysqli_sql_exception $e) {
        $DatabaseAvailable = false;
    }
    if (!$DatabaseAvailable) {
        ?><h2>Website wordt op dit moment onderhouden.</h2><?php
        die();
    }

    return $Connection;
}

?>

<!DOCTYPE html>
<html lang="en">
    <head>
    <link rel="shortcut icon" type="image/x-icon" href="Public/Favicon/ng.ico" />
    <title>NerdyGadgets</title>
        <!-- Javascript -->
        <script src="Public/JS/fontawesome.js"></script>
        <script src="Public/JS/jquery.min.js"></script>
        <script src="Public/JS/bootstrap.min.js"></script>
        <script src="Public/JS/popper.min.js"></script>
        <script src="Public/JS/resizer.js"></script>
        <!-- Style sheets-->
        <link rel="stylesheet" href="Public/CSS/style.css" type="text/css">
        <link rel="stylesheet" href="Public/CSS/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="Public/CSS/typekit.css">
    </head>
<body>
<div class="Background">
    <div class="row" id="Header">
        <div class="col-2"><a href="index.php" id="LogoA">
                <div id="LogoImage"><img src="Public/Img/logo.png"></div>
            </a></div>
        <div class="col-8" id="CategoriesBar">
            <ul id="ul-class">
                <?php
                $HeaderStockGroups = getHeaderStockGroups($databaseConnection);
                foreach ($HeaderStockGroups as $HeaderStockGroup) {
                    ?>
                    <li>
                        <a href="browse.php?category_id=<?php print $HeaderStockGroup['StockGroupID']; ?>"
                        class="HrefDecoration"><?php print $HeaderStockGroup['StockGroupName']; ?></a>
                    </li>
                    <?php
                }
                ?>
                <li>
                    <a href="categories.php" class="HrefDecoration">Alle categorieën</a>
                </li>
            </ul>
        </div>
<!-- code voor US3: zoeken + winkelwagen van sprint 3-->
<ul id="ul-class-navigation">
            <li>
                <a href="browse.php" class="HrefDecoration"><i class="fas fa-search search"></i> Zoeken</a>
            </li>
            <li>
                <style>
                    .cart {
                        color: white;
                        font-size: 20px;
                        background: url("Public/Img/cart3.png") no-repeat;
                        background-size: 20px;
                        padding: 0 0 0 25px;
                        font-family: pt-sans,sans-serif;
                    }
                    .cart:hover, .cart:active {
                    text-decoration: none;
                    color: #ccc;
                    }
                </style>	
                <a href="cart.php" class="cart" class="HrefDecoration"></i> Winkelwagen</a>
                <a href="inlog.php" class="HrefDecoration"><i class="fas fa-user user"></i> Inloggen</a>
            </li>
</ul>
<!-- einde code voor US3 zoeken + winkelwagen van sprint 3 -->
<a href="logout.php" class="HrefDecoration" style="position:absolute;margin-left:95.5%;margin-top:5px;font-size:15px;border-style:solid; border-radius:20px; border-color:white;border-width:2px;padding:3px"> Uitloggen</a>
<?php
$admin = isset($_SESSION["Admin"]) ? $_SESSION["Admin"] : "NEE";
if ($admin == "JA") {
    
    print("<a href=\"admin.php\" class=\"HrefDecoration\" style=\"position:absolute;margin-left:91.5%;margin-top:5px;font-size:15px;border-style:solid; border-radius:20px; border-color:white;border-width:2px;padding:3px\"> Admin</a>");
    
}
?>        

    </div>
    <div class="row" id="Content">
        <div class="col-12">
            <div id="SubContent">
                    
