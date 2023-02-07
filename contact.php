<!-- Contact pagina + Google maps -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Pagina</title>
    <link rel="stylesheet" href="Public/CSS/style.css">
    <link rel="stylesheet" href="Public/CSS/contact.css">

<form method="post" action="mailto:chesterbornhijm@gmail.com">
    <br>
    <h1>Contact Pagina</h1>
    <p>Heeft u vragen over een product? Dan helpen wij u graag verder. Vul hieronder het formulier in en wij mailen u zo snel mogelijk terug</p>
    <label for="name">Naam: </label><input type="text" name="message" id="name" placeholder="Jan Janssen"><br>
    <label for="email">E-mail: </label><input type="text" name="email" id="email" placeholder="janjanssen@gmail.com"><br>
    <label for="message">Bericht: </label><textarea type="text" name="message" id="message" placeholder="Uw bericht..."></textarea><br>
    <input type="submit" value="Verstuur" class="submit"><br>
</form>

<!-- google maps -->
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2435.9379356378536!2d5.216636216014126!3d52.37154537978629!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47c617fb7563a475%3A0xf0dd02fb37cb486!2sWindesheim%20in%20Almere%20locatie%20Circus!5e0!3m2!1snl!2snl!4v1669888842721!5m2!1snl!2snl" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe><br><br>

<?php
include "header.php";
//include "footer.php";
?>

</div>
</head>
</body>
</html>