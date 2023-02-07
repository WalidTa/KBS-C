<!DOCTYPE html>
<html lang="nl">
<head>
    <title>Admin pagina</title>
    <link rel="stylesheet" href="Public/CSS/style.css" type="text/css">
    <link rel="stylesheet" href="Public/CSS/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="Public/CSS/typekit.css">
</head>

<body style='margin-left:1%'>
    <h1>
        <a href="index.php" style="color:white">Admin functies</a>
    </h1>
    <?php
    session_start();

    $inlog = isset($_SESSION["Inlog"]) ? $_SESSION["Inlog"] : '';
    $admin = isset($_SESSION["Admin"]) ? $_SESSION["Admin"] : '';
    


    if ($inlog == "TRUE"){
        if ($admin == "JA") {
            print("Welkom admin! <br><br>");
            print("<a href=\"index.php\" class=\"HrefDecoration\" style=\"position:absolute;margin-left:20%;margin-top:-91px;font-size:15px;border-style:solid; border-radius:20px; border-color:white;border-width:2px;padding:3px\"> Home page</a>");
            
            print("Kortingscode toevoegen");
            print("<form action='admin.php' method='post' style='width:10em'>
                        <input type='text' name='Kortingscode' placeholder='Kortingscode' id='Kortingscode' required>
                        <input type='number' name='Korting' placeholder='Aantal %' id='Korting' required >
                        <input type='submit' name='Toevoegen' value='Toevoegen'>
                    </form>");
            
            
            if (isset($_POST["Toevoegen"])) {
                include("database.php");
                $Kortingscode = $_POST["Kortingscode"];
                $Korting = $_POST["Korting"];

                $host = "localhost";
                $user = "root";
                $pass = "";
                $databasename = "nerdygadgets";
                $port = 3306;
                $connection = mysqli_connect($host, $user, $pass, $databasename, $port);
        
                $query = "INSERT INTO kortingscodes (Kortingscode, Procentkorting) VALUES ('$Kortingscode', '$Korting')";
                $result = mysqli_query($connection, $query);
                if ($result) {
                    print("<p style='color: white'>Kortingscode toegevoegt!</p>");
                } else {
                    print(mysqli_error($connection));
                }
                $connection->close();
            }
            print("<br><br>");
            print("Kortingscode verwijderen");
            print("<form action='admin.php' method='post' style='width:10em'>
                        <input type='text' name='Kortingscode2' placeholder='Kortingscode' id='Kortingscode2'>
                        <input type='submit' name='Verwijderen' value='Verwijderen'>
                    </form>");


            if (isset($_POST["Verwijderen"])) {
                include("database.php");
                $Kortingscode2 = $_POST["Kortingscode2"];

                $host = "localhost";
                $user = "root";
                $pass = "";
                $databasename = "nerdygadgets";
                $port = 3306;
                $connection = mysqli_connect($host, $user, $pass, $databasename, $port);
        
                $query2 = "DELETE FROM kortingscodes WHERE Kortingscode = '$Kortingscode2'";
                $result = mysqli_query($connection, $query2);
                if ($result) {
                    print("<p style='color: white'>Kortingscode(s) verwijderd!</p>");
                } else {
                    print(mysqli_error($connection));
                }
                $connection->close();
            }
        
            
            print("<br><br>");
            print("Kortingscode wijzigen");
            print("<form action='admin.php' method='post' style='width:10em'>
                        <input type='text' name='OudeKortingscode' placeholder='Oude kortingscode' id='OudeKortingscode' required>
                        <input type='text' name='OudeKorting' placeholder='Oude % korting' id='OudeKorting' required>
                        <br>
                        <br>
                        <input type='text' name='NieuweKortingscode' placeholder='Nieuwe kortingscode' id='NieuweKortingscode' required>
                        <input type='text' name='NieuweKorting' placeholder='Nieuwe % korting' id='NieuweKorting' required>
                        <input type='submit' name='Wijzigen' value='Wijzigen'>
                    </form>");

            if (isset($_POST["Wijzigen"])) {
                include("database.php");
                $OudeKortingscode = $_POST["OudeKortingscode"];
                $OudeKorting = $_POST["OudeKorting"];
                $NieuweKortingscode = $_POST["NieuweKortingscode"];
                $NieuweKorting = $_POST["NieuweKorting"];
                
                $host = "localhost";
                $username = "root";
                $password = "";
                $databasename = "nerdygadgets";
                $port = 3306;
                $connection = mysqli_connect($host, $username, $password, $databasename, $port);

                $query3 = "UPDATE kortingscodes SET Kortingscode = '$NieuweKortingscode' , Procentkorting = '$NieuweKorting' WHERE Kortingscode = '$OudeKortingscode' AND Procentkorting = '$OudeKorting'";
                $result3 = mysqli_query($connection, $query3);
                if ($result3) {
                    print("Kortingscode gewijzigd!");
                } else {
                    print(mysqli_error($connection));
                }
                $connection->close();
            }


            $host = "localhost";
            $user = "root";
            $pass = "";
            $databasename = "nerdygadgets";
            $port = 3306;
            $connection = mysqli_connect($host, $user, $pass, $databasename, $port);

            $query4 = "SELECT * FROM kortingscodes";
            $result4 = mysqli_query($connection, $query4);
            if ($result4) {
                print("<table style='color:white;border-style:solid;border:width 2px;border-color:white;float:right;margin-right:40px;margin-top:-780px'>");
                print("<p style='float:right;margin-right:91px;margin-top:-802px'>Actieve Kortingscodes</p>");
                print("<tr><th>Kortingscode</th><th>Procentkorting</th></tr>");
                while ($row = mysqli_fetch_assoc($result4)) {
                    print("<tr><td>" . $row["Kortingscode"] . "</td><td>" . $row["Procentkorting"] . "</td></tr>");
                }
                print("</table>");
            } else {
                print(mysqli_error($connection));
            }
            $connection->close();
            print("<br><br><br><br>");	
        } else {
            print("U bent geen admin!");
        }
    } else {
        print("U bent niet ingelogd!");
    }


    ?>
</body>


</html>