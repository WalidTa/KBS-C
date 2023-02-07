<!-- Over Ons pagina -->
<?php
include 'header.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Over ons</title>
    <link rel="stylesheet" href="Public/CSS/style.css">
    <link rel="stylesheet" href="Public/CSS/overons.css">
</head>
<body>
    <h1> Klik op een naam om meer te weten te komen over de persoon</h1>
    <nav>
        <p1> Bedrijf</p1> <br> <br>
        <button onclick="nerdy()">Nerdygadgets</button><br> <br>
        <p3> Opdracht gevers </p3><br> <br>
        <button onclick="vanessa()">Vanessa</button>
        <button onclick="bram()">Bram</button> <br> <br>
        <p2> Directeuren</p2><br> <br>
        <button onclick="jasper()">Jasper</button>
        <button onclick="chester()">Chester</button>
        <button onclick="walid()">Walid</button>
    </nav>
    <main>
        <div id="persoon"></div>
    </main>
    <script src="Public/JS/overons.js"></script>
    <br> <br>

</body>
</head>
</html>

